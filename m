From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/2] merge-recursive: use "up-to-date" instead of
 "uptodate" in error message for consistency
Date: Fri, 09 Jul 2010 17:39:17 -0700
Message-ID: <7vwrt4goga.fsf@alter.siamese.dyndns.org>
References: <7vd3uystsh.fsf@alter.siamese.dyndns.org>
 <f5c54a4e27321b4ffb0f1f8542530281ef7841eb.1278707023.git.nicolas.s.dev@gmx.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Wincent Colaiuta <win@wincent.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Sat Jul 10 02:39:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXO6Q-0006jq-CK
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 02:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755544Ab0GJAj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 20:39:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58958 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653Ab0GJAj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 20:39:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 28274C3C2E;
	Fri,  9 Jul 2010 20:39:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=fDG3XIwEDCcENpGuloPISfng0sI=; b=dxX2Caodwuq2b+Pxr9tClNO
	D0djpkUhamTiGMp15ERzO/CvI7NzhMGLzGgpiDgUK4UMXE30pucLl86bJj1J9L1X
	LMS3ptQY0YWgwnxlzD8TyoAIE4lZ5J7XUPhgtGg03Zg6F9TXivrFLTvh0NoO3APS
	H1/mSGsZHe6BHJX+Y/x0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=AUtD4MEMulp5cjPEyEW8geSh8vco/vv89HP+gbL57DcuiP0Du
	K9kjtfjh6QfOA+V5yogcw5XGg57s9AdIeKB3IsqaB1L1af/nq4bI6TDbJgwOhZ3W
	ietxXl1JlebXmBvklR8/K5Se7JfXM/DFkGjphMWDQoh07JOwwBagCK8g+o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D418FC3C2D;
	Fri,  9 Jul 2010 20:39:23 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E1868C3C2C; Fri,  9 Jul
 2010 20:39:18 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 96227144-8BBB-11DF-982D-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150701>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

> Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
> ---
>  merge-recursive.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 856e98c..fb6aa4a 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1214,7 +1214,7 @@ int merge_trees(struct merge_options *o,
>  	}
>  
>  	if (sha_eq(common->object.sha1, merge->object.sha1)) {
> -		output(o, 0, "Already uptodate!");
> +		output(o, 0, "Already up-to-date!");
>  		*result = head;
>  		return 1;
>  	}

Sorry, but the pros-and-cons is not good enough for me to support this
change.  It will break users who have been parsing output with scripts.

We do strongly warn people against relying on Porcelain output, but that
does not mean we are free to change them without having a good reason or
two.  The new spelling won't help the next reader who will find the
message confusing the same way you did a few days ago.

IOW, if we are touching this line anyway, I'd like to make sure we made an
effort to make it less confusing, not just spelled correctly, while we
still have our memory of confusion fresh ;-)
