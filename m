Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076A41B1409
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654581; cv=none; b=knxapTYdz4MPrh65oeq3Q3S+uGJQc2def8t7qRKcJ501KlW8G97WCW4SQu4CeEzHTP1ahCz2WCIZa/8m/tWGvATzPCO1uoU5uscvLHAyLHVrOFEBSo55LoeXj9OyQdYHxjsJjAWYRp9UtFJHoxVQwCOEuFnv2ou9nT5kiGh/ECU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654581; c=relaxed/simple;
	bh=ZIqCpa0zBZ26DCpY+z87zqWil7PgFWTKTEuhH9O1V2I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bi1PxyD/GAZXnJhQf/+zyfsBuGabOGXQQhVvxETbbaUjlzU7nBZfdXA0TMVACSUh1cWvI2Jgojmh1InuW300kL/86BLLxNGc1JbaijgUzX3Wy+TQjGzge/KmsyiRIVJseru5yFA3/BRyO7I2ZF2r/JLmKs82U6Mtd7WlqpG6GHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wgRhb1HK; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wgRhb1HK"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 733172961C;
	Wed, 14 Aug 2024 12:56:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZIqCpa0zBZ26DCpY+z87zqWil7PgFWTKTEuhH9
	O1V2I=; b=wgRhb1HKobi/xDE3WiPHBg0oyCKFMU/Y0UZvMx/irCvQGhuvntmPUn
	YPm+k+CMVchd5BcOwhZhbgOfqY9bQB+95OMeOa1OLojHIA1/fjIHU4KNvsRxpLas
	i0D7Go7D2d7WwOch1MEWBq7+EYjaQNr32/fMQ1G4Jlrnn5MuVzcl4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6B5C52961B;
	Wed, 14 Aug 2024 12:56:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CF5932961A;
	Wed, 14 Aug 2024 12:56:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org,  Jacob Keller <jacob.keller@gmail.com>,  Konstantin
 Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH v2 1/3] t90001-send-email.sh: fix quoting for mailrc
 --dump-aliases test
In-Reply-To: <20240813-jk-translate-alias-send-email-v2-1-912db4eb6846@gmail.com>
	(Jacob Keller's message of "Tue, 13 Aug 2024 17:05:09 -0700")
References: <20240813-jk-translate-alias-send-email-v2-0-912db4eb6846@gmail.com>
	<20240813-jk-translate-alias-send-email-v2-1-912db4eb6846@gmail.com>
Date: Wed, 14 Aug 2024 09:56:14 -0700
Message-ID: <xmqqy14zyrf5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1E9A6506-5A5E-11EF-A461-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> The .mailrc alias file format documents that multiple addresses are
> separated by spaces. The alias file used in the t9001 --dump-aliases
> mailrc test have addresses which include both a name and email. These
> are unquoted, so git send-email will parse this as an alias that
> translates to multiple independent addresses.
>
> The existing test does not care about this, as --dump-aliases only dumps
> the alias and not the address. However, it is incorrect for a future
> where --dump-aliases could also dump the mail addresses.
>
> Fix the test to quote the aliases properly, so that they translate to a
> single address.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>  t/t9001-send-email.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Makes sense.  I'll amend the excess "0" out of the title while
queuing.

Thanks.

>
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 64a4ab3736ef..aa36ace393b7 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -2084,9 +2084,9 @@ test_dump_aliases '--dump-aliases mailrc format' \
>  	'bob' \
>  	'chloe' \
>  	'eve' <<-\EOF
> -	alias alice   Alice W Land <awol@example.com>
> -	alias eve     Eve <eve@example.com>
> -	alias bob     Robert Bobbyton <bob@example.com>
> +	alias alice   "Alice W Land <awol@example.com>"
> +	alias eve     "Eve <eve@example.com>"
> +	alias bob     "Robert Bobbyton <bob@example.com>"
>  	alias chloe   chloe@example.com
>  	EOF
