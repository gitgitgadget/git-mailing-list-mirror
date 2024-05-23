Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918912628D
	for <git@vger.kernel.org>; Thu, 23 May 2024 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716487160; cv=none; b=CtpRn2EdLf4kgSIV8/qCjM4p6Nao6lcOmMwqNnfEtDAkk5zL/B1+6hUhFS/M8kV8pr/de+LV14MdpSPWuVLKumURXqxPSIztNkQR/WK/WxZE73Hb0taMIgOxNntHz33m4O758cWJ6R44s1SbMmpcZcmJ1Fbtwp7rFh3Z09sqkhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716487160; c=relaxed/simple;
	bh=RWvNs+YqEkvic81sypdiVI1yON3UySmtXnUviXKfv1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EBNbutWX5QUBAKtTxgu3/9DsY4+bpknabZQt2oP6cZLmCHCPhSet350RNedsWzHX4BPNVbdcDVMzxfrcH87lHDtAoW+hv8TxeuusQ1pvBUBt3QKufo6vc11gsYjBuCiHxp/ijFTA8FXZdBrWXhtw/UHKBWQTAOPBfcHCF3ICJHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ViIG2h7x; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ViIG2h7x"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 09412219BE;
	Thu, 23 May 2024 13:59:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=RWvNs+YqEkvic81sypdiVI1yON3UySmtXnUviX
	Kfv1Y=; b=ViIG2h7xMaBajM3r88o145Qh1AICT+KRE8GO6bVwhn4JCIG/YEY6xH
	Y8Heh63t5zo2/jGIB9wrNU/VfJKHaDY3n1gNKQfOGbJ5REYbQcV94VNbXa/jcTcY
	ErbKfjXJym7Ae7/rfLV6UfnVfNzRgsLBHlgtkD8pDEnN8eQ8HuRbo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 01FA3219BD;
	Thu, 23 May 2024 13:59:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A0A3C219BC;
	Thu, 23 May 2024 13:59:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Marcel Telka <marcel@telka.sk>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t/t9902-completion.sh: backslashes in echo
In-Reply-To: <Zkdk7R9GIfsyQjkc@telcontar> (Marcel Telka's message of "Fri, 17
	May 2024 16:08:45 +0200")
References: <Zkdk7R9GIfsyQjkc@telcontar>
Date: Thu, 23 May 2024 10:59:13 -0700
Message-ID: <xmqqsey8tnny.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2AA9716E-192E-11EF-AD14-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Marcel Telka <marcel@telka.sk> writes:

> The usage of backslashes in echo is not portable.  Since some tests
> tries to output strings containing '\b' it is safer to use printf
> here.  The usage of printf instead of echo is also preferred by POSIX.
>
> Signed-off-by: Marcel Telka <marcel@telka.sk>
> ---
>  t/t9902-completion.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 963f865f27..ed3d03367e 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -73,7 +73,7 @@ _get_comp_words_by_ref ()
>  print_comp ()
>  {
>  	local IFS=$'\n'
> -	echo "${COMPREPLY[*]}" > out
> +	printf '%s\n' "${COMPREPLY[*]}" > out
>  }

This has cooked in 'next' for some time already, and I'll merge this
down to 'master' anyway, but this being a script very much speicific
to bash whose built-in echo we are using, the portability argument
of "echo" made in the proposed log message does not quite apply to
this patch.

Thanks.
