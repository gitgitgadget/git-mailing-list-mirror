From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] lib-rebase.sh: fake-editor.sh: Allow checking of
 commit header(s) in $GIT_EDITOR
Date: Sun, 11 Jul 2010 23:08:24 -0700
Message-ID: <7v7hl1fd0n.fsf@alter.siamese.dyndns.org>
References: <1278764821-32647-1-git-send-email-ayiehere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 08:08:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYCC2-0001NB-LH
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 08:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926Ab0GLGIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 02:08:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35878 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab0GLGIh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 02:08:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C763C36F1;
	Mon, 12 Jul 2010 02:08:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Uar7rffRLKr7ROTbCphsoAgvrm0=; b=r4DG5z
	Bb+hDZTxJyTfYhuoedDG0sSSdtWY4fvkhMXqXHn24WEFU9Dj3Oy/XSe7xFL+Oy4a
	1emvnwaR15GoSAOxASeNr3hqt04QGgl97LekLbPYzeLWHohznn4L3ScqwK+AHqHC
	VXsOK7I8NtkV4Jzi1ecGDCbq3YAcpErA0KNho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EVf/qsNp9oMHx9Tu5UN2g275MelKoujG
	6pAbI8AxajOxdflg65Xq01Hejlq9gmY0rHZrbLiT9C8PIAJr8aF57bm7CLvTUlM8
	STvaSJLh3dpl8fYKmvO2nOUuGnHsR5R5Ept2yQrvEcce5XeacOc10P/iIsMVWDem
	cFqyVpINtIE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2962AC36EE;
	Mon, 12 Jul 2010 02:08:31 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 112F2C36EB; Mon, 12 Jul
 2010 02:08:26 -0400 (EDT)
In-Reply-To: <1278764821-32647-1-git-send-email-ayiehere@gmail.com> (Nazri
 Ramliy's message of "Sat\, 10 Jul 2010 20\:27\:00 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E54053F6-8D7B-11DF-B887-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150795>

Nazri Ramliy <ayiehere@gmail.com> writes:

> +test -z "$EXPECT_HEADER" ||
> +	(
> +		grep '^pick' < "$1" | cut -d' ' -f3- > commit_headers.$$ &&

Sending output from grep to cut does not sound very cool; wouldn't a
single "sed" invocation more appropriate?

> +		diff "$EXPECT_HEADER" commit_headers.$$ > /dev/null

Is "test_cmp" inappropriate here for some reason?

> +	) ||

Do you need a subshell for this, or just a grouping {} sufficient?

> +	exit
