From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am: don't ignore --keep (-k) option
Date: Fri, 27 Nov 2009 12:03:10 -0800
Message-ID: <7vy6lrka69.fsf@alter.siamese.dyndns.org>
References: <874ookp4u8.fsf@meyering.net>
 <7vmy2b76ji.fsf@alter.siamese.dyndns.org> <87638zm38r.fsf_-_@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Fri Nov 27 21:03:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE72K-0008O4-01
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 21:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274AbZK0UDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 15:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752133AbZK0UDM
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 15:03:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56349 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbZK0UDM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 15:03:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BD39383A25;
	Fri, 27 Nov 2009 15:03:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nfnlIr2bsDRRNz+ROAWvOdBdLqs=; b=Gpsghp
	KBVsfzf29smntHH8A0BBhcuXR2vQMh3WpBJclF0qQX5PpCci2rZyd65xJpxn+6ny
	YM/6hGtGdjXRDd+y7ACs1E8xiolgkDSMhSrQ0BCs/TxXyENQ72W1t+QMqCeJfJPn
	meK+qslud79plgqDmZB4eml6QHyEkCxDApQJY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k7LZIg/hHeJnyBMnFCGOFAcyVjRuKNGl
	idbfB2+6usLvPZZH6f/z/WrpCp3+eWHMojnlMndyAFJi/zI0SZhcJpSQ9rdLB78t
	ejoPigdCT8jAb5gDwzgeKtw1LPS5B+7nb1l9tOjn4tnBRgx6AFaIVtQcCT0p/jQZ
	j7mT9AvJKQA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 97F9483A23;
	Fri, 27 Nov 2009 15:03:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5EF583A20; Fri, 27 Nov
 2009 15:03:11 -0500 (EST)
In-Reply-To: <87638zm38r.fsf_-_@meyering.net> (Jim Meyering's message of
 "Wed\, 25 Nov 2009 09\:13\:08 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E58ECD86-DB8F-11DE-A17D-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133929>

Jim Meyering <jim@meyering.net> writes:

> I started looking at git-am.sh and spotted what appears to be a typo.
> There is only that one use of $keep_subject, so its value currently
> comes from the environment.
>
> From 02f7e6433b5db8b18a4cccf58c302159c2f54fa5 Mon Sep 17 00:00:00 2001
> From: Jim Meyering <meyering@redhat.com>
> Date: Wed, 25 Nov 2009 09:10:46 +0100
> Subject: [PATCH] git-am: don't ignore --keep (-k) option
>
> Fix typo in variable name: s/keep_subject/keep/.
>
> Signed-off-by: Jim Meyering <meyering@redhat.com>

At the level of "what does each line of the code do", this is a fix, but
as we do a lot more than just stripping "[PATCH] " from the beginning of
the Subject: line these days, I think we are better off declaring defeat
in this particular codepath and not doing anything here.

Adding "[PATCH] " is no longer "keeping the original subject" anyway.  It
is "without knowing what we already stripped, adding one random string
that could have been what we removed".

I also have to wonder why $dotest/info does not have the [PATCH] or
whatever prefix that we were told not to strip in this codepath.  After
all, we are running "git mailinfo" with $keep option to produce that file,
so if that part is working correctly, we shouldn't even have to have this
"add [PATCH] back" trick to begin with.

What am I missing???

> ---
>  git-am.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-am.sh b/git-am.sh
> index 151512a..f353e73 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -578,7 +578,7 @@ do
>  			sed -e '1,/^$/d' >"$dotest/msg-clean"
>  		else
>  			SUBJECT="$(sed -n '/^Subject/ s/Subject: //p' "$dotest/info")"
> -			case "$keep_subject" in -k)  SUBJECT="[PATCH] $SUBJECT" ;; esac
> +			case "$keep" in -k)  SUBJECT="[PATCH] $SUBJECT" ;; esac
>
>  			(printf '%s\n\n' "$SUBJECT"; cat "$dotest/msg") |
>  				git stripspace > "$dotest/msg-clean"
> --
> 1.6.6.rc0.236.ge0b94
