From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] mergetools/p4merge: Honor $TMPDIR for the /dev/null
 placeholder
Date: Fri, 21 Dec 2012 08:08:47 -0800
Message-ID: <7v4njf2xrk.fsf@alter.siamese.dyndns.org>
References: <1356073023-15376-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeremy Morton <admin@game-point.net>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 17:09:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm59v-0001I1-HQ
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 17:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889Ab2LUQI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 11:08:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52560 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751885Ab2LUQI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 11:08:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61CE69114;
	Fri, 21 Dec 2012 11:08:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HSJNFStBzqdR9fVzLCg645rirNc=; b=yka6G3
	HOFLIhlvd2Mw0XKkSVRcQxlENR+YsSA7uDy4GMfQhNYoBriizZDwEKSojNF4RrEJ
	+xzCOhZhR5zhoF1yZA0KfaX/262y9Lu3SHZYMVZuf//31M3c7E2pnJIrwFYM1HN0
	GcZPoRdjbrJjbs+ubY2/t6zMHraki2PdheXrk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L48/lJc/pqCQwuIbit+34/XNSN2mei9I
	PQIzviYI9UK5ulze5xqLBpmmddnvWehs01zPR4J61wfLsUXNwp94mXW11RAIfVg1
	Ew+kpt3bZVkgBNKxIhVt3EusbHcSKY/TIlpncrnVKmwY+MHTGaMZqxc9e83nlbeQ
	skfclWRxTCg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E1799113;
	Fri, 21 Dec 2012 11:08:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B0A309110; Fri, 21 Dec 2012
 11:08:55 -0500 (EST)
In-Reply-To: <1356073023-15376-1-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Thu, 20 Dec 2012 22:57:03 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B87C3A38-4B88-11E2-AFFB-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211980>

David Aguilar <davvid@gmail.com> writes:

> Use $TMPDIR when creating the /dev/null placeholder for p4merge.
> This keeps it out of the current directory.

The usual $REMOTE "this is theirs" and $LOCAL "this is ours" are
still created in the current directory, no?  It is unclear why this
"this side does not exist" case wants to be outside of the current
directory in the first place.

In other words, "This keeps it out of the current directory" only
explains what this patch changes, without explaining why it is a
good thing to do in the first place.

> +create_empty_file () {
> +	empty_file="${TMPDIR:-/tmp}/git-difftool-p4merge-empty-file.$$"
> +	>"$empty_file"
> +
> +	printf "$empty_file"
> +}

Assuming that it makes sense to create only the "this side doe not
exist, and here is a placeholder empty file" in $TMPDIR, I think
this is probably sufficient.

By the way, who is going to remove this temporary file once the
command is done?
