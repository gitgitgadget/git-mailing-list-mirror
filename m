From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] submodule update: Don't fetch when the submodule
 commit is already present
Date: Wed, 23 Feb 2011 15:23:15 -0800
Message-ID: <7v62sa5o9o.fsf@alter.siamese.dyndns.org>
References: <4D656F25.5090007@web.de> <4D656FDF.5050400@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Kevin Ballard <kevin@sb.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Feb 24 00:23:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsO3U-0003U7-LO
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 00:23:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678Ab1BWXXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 18:23:32 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48843 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754619Ab1BWXXb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 18:23:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B6D00444F;
	Wed, 23 Feb 2011 18:24:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vsWkqb47jAlBSaPsz0RXg4Tt7Pg=; b=SsUAup
	CJbh3tZTycSP+udmuaCAAv3Xv/EZa8kJ+QOvuOmd1VDKJek2FZqx23f47mN5Z9Eb
	j6ZddtAuWiS/NqkGf8nr13SnzIQ5D9agrkpFgywZVYTunZCb3lAYYn0iBjBS4wJH
	MjZ91nRhcT2K8uopRdGuuHRm40JzaGTfNT7ZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FjpgXJb7GLpQj5Cy31ko95CqzQfl6yZV
	rrCMdNjUShMtEw32oLh5Wcgool/ucxf5TqlQVX+sTPW3AP5rVixCKIePuz1qTRko
	FRhuzzrDXRD5wxJcEGK2edruu0Dgsm54uQerO6G5TqOQH7IEUHeSz68F7k5o8T2M
	uFBKn47PeB4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5414C444A;
	Wed, 23 Feb 2011 18:24:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 41F784449; Wed, 23 Feb 2011
 18:24:29 -0500 (EST)
In-Reply-To: <4D656FDF.5050400@web.de> (Jens Lehmann's message of "Wed\, 23
 Feb 2011 21\:36\:47 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 148C7862-3FA4-11E0-8190-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167741>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 8b90589..ea49760 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -465,7 +465,7 @@ cmd_update()
>  			if test -z "$nofetch"
>  			then
>  				(clear_local_git_env; cd "$path" &&
> -					git-fetch) ||
> +					(git rev-parse --verify $sha1 >/dev/null || git-fetch)) ||

Exactly the same comment as the one for [5/6] applies here.
