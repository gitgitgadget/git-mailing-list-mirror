From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] {fetch,upload}-pack: allow --depth=0 for infinite
 depth
Date: Fri, 20 Aug 2010 17:27:27 -0700
Message-ID: <7vr5hs95e8.fsf@alter.siamese.dyndns.org>
References: <1282269067-5527-1-git-send-email-pclouds@gmail.com>
 <1282269067-5527-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, mikachu@gmail.com,
	computerdruid@gmail.com, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 02:27:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ombw7-0003NZ-RX
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 02:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242Ab0HUA1t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Aug 2010 20:27:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64158 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003Ab0HUA1m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Aug 2010 20:27:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 446F2CF300;
	Fri, 20 Aug 2010 20:27:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=lm2UBe+FUJksH3C2IvmQY8kvg
	sY=; b=pU9GqdQ5X0BWmYJa9D4GmewfiQn7U54CCf/2IqG+cF/FPJtjGVnCPVszD
	Gs2khCz+xzw9CpPsE4eVnc9XT6MCDfMxYcQrYbGpMw6LXfk95uRUC3x/Mmakv+vt
	on26lsuwT1o/e4sYBBazHHPtJyIueZ60aQHV0fkjx65vxBcLuA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=EbasfC8aMgjy/RSG4qv
	FhcDByTckmwdnjok0DxWtyA3gx7ZYozsYvxBWwVAs/8gQ2aMjiAQErHEzS6TyFnO
	bWpnnCHb7f/rzRHMSYars5sAQXDvtSQ/9vXSiDl0guFW5F9UU7+GNZ/L4C5II0gr
	Q5/wFIT+tsBARl7ZuPjby1jg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DFC97CF2FD;
	Fri, 20 Aug 2010 20:27:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A0F9CF2FB; Fri, 20 Aug
 2010 20:27:29 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E61C2760-ACBA-11DF-88E5-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154086>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-op=
tions.txt
> index 9333c42..a22d839 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -10,7 +10,8 @@
>  --depth=3D<depth>::
>  	Deepen the history of a 'shallow' repository created by
>  	`git clone` with `--depth=3D<depth>` option (see linkgit:git-clone[=
1])
> -	by the specified number of commits.
> +	by the specified number of commits. Specify "inf" for
> +	infinite depth.
> =20
>  ifndef::git-pull[]
>  --dry-run::
> diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fet=
ch-pack.txt
> index 4a8487c..75e4669 100644
> --- a/Documentation/git-fetch-pack.txt
> +++ b/Documentation/git-fetch-pack.txt
> @@ -70,6 +70,7 @@ OPTIONS
> =20
>  --depth=3D<n>::
>  	Limit fetching to ancestor-chains not longer than n.
> +	Specify 0 for infinite depth.
> =20

Should we force users to remember which one is which?

> diff --git a/transport.c b/transport.c
> index cf7030b..9303aef 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -475,7 +475,7 @@ static int set_git_option(struct git_transport_op=
tions *opts,
>  			opts->shallow =3D 0;
>  		}
>  		else {
> -			opts->depth =3D atoi(value);
> +			opts->depth =3D !strcmp(value, "inf") ? 0 : atoi(value);

Doesn't atoi("inf") give you 0 anyway ;-)?
