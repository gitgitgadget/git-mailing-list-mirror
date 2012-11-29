From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/2] reset: learn to reset to tree
Date: Thu, 29 Nov 2012 10:47:00 -0800
Message-ID: <7v4nk8qmaj.fsf@alter.siamese.dyndns.org>
References: <CANiSa6isDKAgxHWqh5XiQ-adT3-ASFtvAshp028DTcotjQxzmQ@mail.gmail.com>
 <1354213975-17866-1-git-send-email-martinvonz@gmail.com>
 <1354213975-17866-2-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 19:47:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te98r-0006fI-R9
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 19:47:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550Ab2K2SrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 13:47:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43450 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752747Ab2K2SrE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 13:47:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 613FF97D2;
	Thu, 29 Nov 2012 13:47:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qQCkdCpPz9dM4A4SECEj/WNLsH4=; b=Y9/WTQ
	VWhZ9E4YmmGVs8vaHfC26eVUlaECgXOHEHy3VZoSClrs1ET2x5uIE/ZvtE7v0gnp
	UNxz5vHjwtuqP5CL3zzuTfOxYDCuVyDK542FHohssUtGVOmtArwMxV6orFvJZon+
	vowxx9NJAkGGz0U2qVv7hcvxOdLMfUl5IsH+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FKUYxXEQfRkxnXMXcm5HXJpBLy15fk1/
	S3CLKeTgT1mfUmCWtULlWBdGkBShnKnURDOQtLTD6dZUH4MhxRoTeAoFroD3jJdU
	WNmj4QY3nMUzl0XsJDcNMlPpPVnyTjX91fxsjsVLO5hiRjTXvRdHn+0BsRNAGRas
	Qte1qSnj3Ts=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DFAC97D1;
	Thu, 29 Nov 2012 13:47:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1D5497CD; Thu, 29 Nov 2012
 13:47:01 -0500 (EST)
In-Reply-To: <1354213975-17866-2-git-send-email-martinvonz@gmail.com> (Martin
 von Zweigbergk's message of "Thu, 29 Nov 2012 10:32:54 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2989096C-3A55-11E2-AA7F-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210858>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> In cases where HEAD is not supposed to be updated, there is no reason
> that "git reset" should require a commit, a tree should be enough. So
> make "git reset $rev^{tree}" work just like "git reset $rev", except
> that the former will not update HEAD (since there is no commit to
> point it to).

That is a horrible design I have to nack, unless you require
pathspec.  You cannot tell what "git reset $sha1" would do without
checking the type of the object $sha1 refers to.  If you do this
only when pathspec is present, then the design is very reasonable.

> Disallow --soft with trees, since that is about updating only HEAD.

Likewise.
