From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/5] format-patch: pick up branch description when no
 ref is specified
Date: Thu, 03 Jan 2013 07:49:41 -0800
Message-ID: <7v7gnuxo4q.fsf@alter.siamese.dyndns.org>
References: <1357221791-7496-1-git-send-email-pclouds@gmail.com>
 <1357221791-7496-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 16:50:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tqn3T-0005km-OT
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 16:50:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419Ab3ACPtp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jan 2013 10:49:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56971 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753206Ab3ACPtn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jan 2013 10:49:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B8ACA15D;
	Thu,  3 Jan 2013 10:49:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ee2k/cd+Tx+a
	s8a0IEsT0sHHFOg=; b=OrhxOfavuhOi6BYVmrEKwwSInLXOFUAJ22RXNhld5u/X
	5BehPNjQHkHNQ2+1wNzwEI+wuNxGIE349JyjRTQ/tocn8gWiJtlE49cTix+4uqIe
	JzSvIlNLrMlNjV99OAXyQmSxZKnn1PH1IXfydpOFdpAjPVhQqKM8nGVxNU33X8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XEpkJv
	/os8wsZCrr69L2qGiZMdNfoxAmXWwFSFbEmpmw7VXZYiHKaD6KQUifmXHbswg1GC
	w1cNXfOUh0oALLaNjeZWfEHBS7zcNRotbdHxcDMoGR/ieCJgwUfdYqaCAriCC8FL
	hTHXQXpkgF2vkqD/QHsvTfR6umX2lGdYGjvAo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C1CDA15C;
	Thu,  3 Jan 2013 10:49:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3E8CA15B; Thu,  3 Jan 2013
 10:49:42 -0500 (EST)
In-Reply-To: <1357221791-7496-6-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 3 Jan
 2013 21:03:11 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3094FBC0-55BD-11E2-8389-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212592>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> We only try to get branch name in "format-patch origin" case or
> similar and not "format-patch -22" where HEAD is automatically
> added. Without correct branch name, branch description cannot be
> added. Make sure we always get branch name.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/log.c           | 16 +++++++++++++---
>  t/t4014-format-patch.sh |  7 +++++++
>  2 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 039bf67..81683f6 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1027,12 +1027,22 @@ static char *find_branch_name(struct rev_info=
 *rev)
>  		else
>  			return NULL;
>  	}
> -	if (positive < 0)
> +	if (positive >=3D 0)
> +		ref =3D rev->cmdline.rev[positive].name;
> +	else if (!rev->cmdline.nr && rev->pending.nr =3D=3D 1 &&
> +		 !strcmp(rev->pending.objects[0].name, "HEAD"))
> +		/*
> +		 * No actual ref from command line, but "HEAD" from
> +		 * rev->def was added in setup_revisions()
> +		 * e.g. format-patch --cover-letter -12
> +		 */
> +		ref =3D "HEAD";
> +	else
>  		return NULL;
> -	ref =3D rev->cmdline.rev[positive].name;
>  	if (dwim_ref(ref, strlen(ref), branch_sha1, &full_ref) &&
>  	    !prefixcmp(full_ref, "refs/heads/") &&
> -	    !hashcmp(rev->cmdline.rev[positive].item->sha1, branch_sha1))
> +	    (positive < 0 ||
> +	     !hashcmp(rev->cmdline.rev[positive].item->sha1, branch_sha1)))

This hashcmp() is to make sure that the tip we _guessed_ with
dwim_ref() that the user meant matches what we are going to use, so
I do not think disabling the check is a good idea.

You could (and I think you should) do something like this:

	if (0 <=3D positive) {
        	ref =3D rev->cmdline.rev[positive].name;
                tip_sha1 =3D rev->cmdline.rev[positive].item->sha1;
	} else if (... defaulted to implied HEAD? ...) {
		ref =3D "HEAD";
                tip_sha1 =3D rev->pending.objects[0].item->sha1;
	} else {
		return NULL;
	}

        if (dwim_ref(...) && !prefixcmp(full_ref, "refs/heads/") &&
            !hashcmp(tip_sha1, branch_sha1))

to preserve that safety instead.
