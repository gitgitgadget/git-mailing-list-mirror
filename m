Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7372E495CB
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 21:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712611301; cv=none; b=AC1S+RMp0yQehnWSRH85wtIeKQNpM8N/WExsEOUtHlRaPuWqP5wnb/leN/ZW1c1vbY2E2QQNk95st51zzZUlsElN1xo3/sxtbEPFhyE7psIJvgeefOmm88dgAz7k4Bg706SG8uZaUskNQ5mmID/6ttO0fYTH5y5ERMBKLUvynjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712611301; c=relaxed/simple;
	bh=TEcfnEQ1w9V2XEsTzzbnvUixM04Be2MX9Affpk5m9UI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SOwXrzFrE+luJwtuVkb8mgsJJEE9ILex+DpvcQqMbQ5gHMbgSO/8bk611lMJWR7NK7v62Tpy9R0xlm/tg+MpyuD8qyXuAW3EP1ve5UafR/6mW2yBFX8rjiYZnlzrNlybUTPwPuogE8RNn2iVNiPVymRwLmbRWsHfItYicR3Wxkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Uw7oOQiq; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Uw7oOQiq"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 30A631DC211;
	Mon,  8 Apr 2024 17:21:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TEcfnEQ1w9V2XEsTzzbnvUixM04Be2MX9Affpk
	5m9UI=; b=Uw7oOQiqpN/muoFp+iava6JK9uNh6aShHpKVBM65uCxV2xPEAdvf35
	URr4TrnlBHash0HvPCwxIJ8HWQPJ+UgEYatfSnmFuiI2nY25v3ndAs0nrDPhYWwk
	jvu51OkgVYZeX7mMODGfTXSZ9iSZ8a5p7rXQoMhZ8XGx4w85k6pME=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 292631DC210;
	Mon,  8 Apr 2024 17:21:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 90B021DC20F;
	Mon,  8 Apr 2024 17:21:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  code@khaugsbakk.name
Subject: Re: [PATCH v5 3/3] send-email: separate the confirmation prompts
 from the messages
In-Reply-To: <7b99e5c7c0b0c8d3d7eaaae169e650ebe81964a1.1712486910.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Sun, 7 Apr 2024 12:48:52 +0200")
References: <cover.1712486910.git.dsimic@manjaro.org>
	<7b99e5c7c0b0c8d3d7eaaae169e650ebe81964a1.1712486910.git.dsimic@manjaro.org>
Date: Mon, 08 Apr 2024 14:21:36 -0700
Message-ID: <xmqq1q7fa6u7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FBD47DC4-F5ED-11EE-97A4-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Emit additional vertical whitespace after the "Send this email [y/n/...]?"
> confirmation prompts, more specifically after each confirmed email is sent,
> but before the subsequent messages are emitted, to make the produced output
> more readable.  The subsequent produced messages were bunched together with
> the confirmation prompts, as visible in the sample output excerpt below,
> which made discerning the outputs unnecessarily harder.
>
>     ...
>     Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll): y
>     OK. Log says:
>     ...

What comes before "send this email" prompt needs to be shown to make
the argument more convincing, but with "..." there is no cue to decide
if the output is hard to read.

>  sub send_message {
>  	my ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header) = gen_header();
>  	my @recipients = @$recipients_ref;
> +	my $prompt_separator = 0;
>  
>  	my @sendmail_parameters = ('-i', @recipients);
>  	my $raw_from = $sender;
> @@ -1556,6 +1557,7 @@ sub send_message {
>  			$confirm = 'never';
>  			$needs_separator = 1;
>  		}
> +		$prompt_separator = 1;
>  	} else {
>  		$needs_separator = 1;
>  	}
> @@ -1665,6 +1667,7 @@ sub send_message {
>  		$smtp->dataend() or die $smtp->message;
>  		$smtp->code =~ /250|200/ or die sprintf(__("Failed to send %s\n"), $subject).$smtp->message;
>  	}
> +	print "\n" if ($prompt_separator);

"prompt separator" sounds more like a separator that separates
prompts, but that is not what is going on, no?

Do we even need that new varible in the first place?  I am wondering
if you can just do the print "\n" right where you assign to that
variable.

When $confirm is set to 'never', you have both $needs_separtor and
$prompt_separator set.  Would it mean you'd have two extra blank
lines for that message?

All these questions you should have been able to avoided with a bit
more helpful explanation in the proposed log message, I hope.

Thanks.

>  	if ($quiet) {
>  		printf($dry_run ? __("Dry-Sent %s\n") : __("Sent %s\n"), $subject);
>  	} else {
