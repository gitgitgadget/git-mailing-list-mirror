From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Add a "fix" command to "rebase --interactive"
Date: Tue, 08 Dec 2009 01:24:50 -0800
Message-ID: <7viqchhl7h.fsf@alter.siamese.dyndns.org>
References: <cover.1259934977.git.mhagger@alum.mit.edu>
 <4B192701.4000308@drmicha.warpmail.net> <vpqfx7qocwl.fsf@bauges.imag.fr>
 <7vws12r5v2.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0912041945161.21557@intel-tinevez-2-302>
 <20091205062708.6117@nanako3.lavabit.com>
 <7vd42t6f9i.fsf@alter.siamese.dyndns.org>
 <20091208121314.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 10:25:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHwJr-0003qL-ES
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 10:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452AbZLHJZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 04:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752233AbZLHJZF
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 04:25:05 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44633 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbZLHJZB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 04:25:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 85A30A525A;
	Tue,  8 Dec 2009 04:25:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OxX9LZCTPrsYsstEhxU40T9GOvI=; b=Qd5ihz
	dU5dnts+6/+kplt/OKnGalJ6O14XuozMhco+8E2MG6J4WoKkdJLruqwRsZT20Vzo
	3oWtrvmzl12+kz0LLZtOVZhr3pWLecTmg7BM/moYr/QcanOx+X4QpZYvai5jDo0w
	2RrfP25z30hsVAkdsjb45eSfcSTPtfE1KZu18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pyY6hWKzqFFeHIvfaKDyGgAnKIdmemaI
	4h5hIinrGd2l6Q15iWCvZmNaxmr0/wuAm6/0HpVsJHgTKdeeiUYOHcWNWb8VjHOS
	l8QuC3d85OGapr97/lxKePKrwPlTFAjHMOGHz7okCkEsYtXjwzk16ilkQYjM6Dee
	3Sha/r5KLmw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 27100A5259;
	Tue,  8 Dec 2009 04:25:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 08F52A5258; Tue,  8 Dec 2009
 04:24:51 -0500 (EST)
In-Reply-To: <20091208121314.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Tue\, 08 Dec 2009 12\:13\:14 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8ED209BE-E3DB-11DE-B21A-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134845>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> @@ -519,6 +521,43 @@ get_saved_options () {
>  	test -f "$DOTEST"/rebase-root && REBASE_ROOT=t
>  }
>  
> +# Rearrange the todo list that has both "pick sha1 msg" and
> +# "pick sha1 !fixup/!squash msg" appears in it so that the latter
> +# comes immediately after the former, and change "pick" to
> +# "fixup"/"squash".
> +rearrange_squash () {
> +	sed -n -e 's/^pick \([0-9a-f]*\) !\(squash\) /\1 \2 /p' \
> +		-e 's/^pick \([0-9a-f]*\) !\(fixup\) /\1 \2 /p' \
> +		"$1" >"$1.sq"
> +	test -s "$1.sq" || return
> +
> +	sed -e '/^pick [0-9a-f]* !squash /d' \
> +		-e '/^pick [0-9a-f]* !fixup /d' \
> +		"$1" |
> +	(
> +		used=
> +		while read pick sha1 message
> +		do
> +	...
> +		done >"$1.rearranged"
> +	)
> +	cat "$1.rearranged" >"$1"
> +	rm -f "$1.sq"
> +}

The logic to move the lines seem to have been improved since the last
round, which is good.  I've amended this to remove "$1.rearranged" as well.

Unlike the very initial round, but like the second round, this feature is
controlled by an explicit command line option, so it should be reasonably
safe.

I hate bikeshedding but somehow

    git commit -m "fixup! commit with this message"

feels much more natural than having to write

    git commit -m "!fixup commit with this message".
