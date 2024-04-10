Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E981013D885
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 16:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712766497; cv=none; b=mye784Oy+jseQXAsyVpJbtWcrs8gCt5hBpm/Pzdd3Z+yLdNSWs/czAAo5JKKhRnvGhFaoY64TgD5ItT8nClLxZY64oJsS2UD3GwddJzWno5iNS0n82B6w7gIllLdyjX0P0hbPfggFLVYNkw+eV4CZiD/hyabNbXFQH5fGsjSRU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712766497; c=relaxed/simple;
	bh=MMhiDNjEUcHKzgQyc7fsCbVXszW//BLpD8hn3GXsPWM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i670BswHhn+jSIZmVNKnti4L0zJkKguHutb/dvInFOxBUaER1Y445EzuX3xbJFjCpcx0jgDmEauXAILpT90x9MMuEvTiJNgXoTvVQ6cRI/h1RD8pcFAgS2hhO8BZQ5PJjRd4o2aqdxubJ6vwnGef565GsKLuBz+3lynDG1TU8s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BQ1Ftaqb; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BQ1Ftaqb"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C284A1EDAE8;
	Wed, 10 Apr 2024 12:28:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MMhiDNjEUcHKzgQyc7fsCbVXszW//BLpD8hn3G
	XsPWM=; b=BQ1FtaqbRPCEWfLETPm4tXdgXTN0o/7Q/5dvM92bR4Jt7FpsM8HZXT
	M/YTlqonMRIZJQRu5E4e8iRXhZrx/7YErBi0cAokBgSKc5OIxbRvMIRcdQwg4xKh
	Zf3I1yJJaFCXqOGQPwRM9bfNwIez66kHaFDIobaIZbBaPNWjkiGDo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B19B81EDAE7;
	Wed, 10 Apr 2024 12:28:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8155E1EDAA4;
	Wed, 10 Apr 2024 12:28:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  code@khaugsbakk.name
Subject: Re: [PATCH v6 2/2] send-email: make it easy to discern the messages
 for each patch
In-Reply-To: <c78b043b5a6cf0de712d36e6e000804bd6e1316d.1712732383.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Wed, 10 Apr 2024 09:01:30 +0200")
References: <cover.1712732383.git.dsimic@manjaro.org>
	<c78b043b5a6cf0de712d36e6e000804bd6e1316d.1712732383.git.dsimic@manjaro.org>
Date: Wed, 10 Apr 2024 09:28:04 -0700
Message-ID: <xmqqh6g9w5bf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 504644CC-F757-11EE-8DD2-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> When sending one or multiple patches at once, the displayed result statuses
> for each patch and the "Send this email [y/n/a/...]?" confirmation prompts
> become bunched together with the messages produced for the subsequent patch,
> or with the produced SMTP trace, respectively.
>
> This makes reading the outputs unnecessarily harder, as visible in a couple
> of excerpts from a sample output below:

It is unclear where the boundaries between the messages in the
example are, though.

>     ...
>     MIME-Version: 1.0
>     Content-Transfer-Encoding: 8bit
>
>     Result: 250

Is this where one message ends, and the next line "OK. Log says:" is
the beginning of the next message?

>     OK. Log says:
>     Server: smtp.example.com
>     MAIL FROM:<test@example.com>
>     ...
>
>     ...
>     MIME-Version: 1.0
>     Content-Transfer-Encoding: 8bit

Is the above about a single (i.e. the second) message ...

>     Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll): y

... and the user is asked about that message?

>     OK. Log says:
>     Server: smtp.example.com
>     MAIL FROM:<test@example.com>
>     ...

And is this about a separate (i.e. the third) message?  Without
making these clear, it is hard to agree or disagree with the claim
that the current presentation is hard to read.

>     MIME-Version: 1.0
>     Content-Transfer-Encoding: 8bit
>
>     Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll): y
>
>     OK. Log says:
>     Server: smtp.example.com
>     MAIL FROM:<test@example.com>
>     ...

This is obviously in the realm of subjective preference, but I find
that the prompt line is distinct enough among all other output that
we do not need an extra blank line to locate them.

> diff --git a/git-send-email.perl b/git-send-email.perl
> index f0be4b4560f7..1d6712a44e95 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1361,7 +1361,6 @@ sub smtp_host_string {
>  
>  # Returns 1 if authentication succeeded or was not necessary
>  # (smtp_user was not specified), and 0 otherwise.
> -
>  sub smtp_auth_maybe {
>  	if (!defined $smtp_authuser || $auth || (defined $smtp_auth && $smtp_auth eq "none")) {
>  		return 1;
> @@ -1510,6 +1509,7 @@ sub gen_header {
>  sub send_message {
>  	my ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header) = gen_header();
>  	my @recipients = @$recipients_ref;
> +	my $confirm_shown = 0;
>  
>  	my @sendmail_parameters = ('-i', @recipients);
>  	my $raw_from = $sender;
> @@ -1555,6 +1555,7 @@ sub send_message {
>  		} elsif (/^a/i) {
>  			$confirm = 'never';
>  		}
> +		$confirm_shown = 1;
>  	}
>  
>  	unshift (@sendmail_parameters, @smtp_server_options);
> @@ -1576,7 +1577,6 @@ sub send_message {
>  		print $sm "$header\n$message";
>  		close $sm or die $!;
>  	} else {
> -
>  		if (!defined $smtp_server) {
>  			die __("The required SMTP server is not properly defined.")
>  		}
> @@ -1664,9 +1664,11 @@ sub send_message {
>  		$smtp->code =~ /250|200/ or die sprintf(__("Failed to send %s\n"), $subject).$smtp->message;
>  	}
>  	if ($quiet) {
> +		print "\n" if ($confirm_shown);
>  		printf($dry_run ? __("Dry-Sent %s") : __("Sent %s"), $subject);
>  		print "\n";
>  	} else {
> +		print "\n";
>  		print($dry_run ? __("Dry-OK. Log says:") : __("OK. Log says:"));
>  		print "\n";
>  		if (!defined $sendmail_cmd && !file_name_is_absolute($smtp_server)) {
> @@ -1923,7 +1925,7 @@ sub pre_process_file {
>  sub process_file {
>  	my ($t) = @_;
>  
> -        pre_process_file($t, $quiet);
> +	pre_process_file($t, $quiet);
>  
>  	my $message_was_sent = send_message();
>  	if ($message_was_sent == -1) {

I'll let others comment as the "blank around prompt" smells quite
subjective and do not want to be the sole reviewer on it.

Thanks, will queue.
