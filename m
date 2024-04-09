Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2907854794
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 03:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633138; cv=none; b=jrVtNKYZi7R4G7J38xBoZrV+iOfbBZ3wY3qdFf+OO7XfAt4PIrNP7SQl1D01oR8btdekC6VPzRKTU0hkbgBF81M1OqhI/BLZDzEHMlCbAORrGlC4F1SRg64r1+VFiUyte46bHIrWI/LHNPzB7thX/KEnX9CYcDiC14/xpSaiyx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633138; c=relaxed/simple;
	bh=RQl1Bi33Ev6mWMip8ja2NEoklUZItjRzcFR2PbcJ9WQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=eFPUbqOoEbC6PAjQPHSW47VLmykibM2ph6MyAdLnhSq255E9edkUyZlUwvOAPXVAECRqAZGIGfWgDAzP+sGKVSH1GZwszSEHzf/k8fXbIZI5ipkkVdLdmhUcFlQmtGzLbi0BY1SguTv/eeAVMiARmPs7r6/ta2zKxyI1TnzKkqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=lECZg/Te; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="lECZg/Te"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712633132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dBIQb61mczGCa9ueWohk44ff+YxBevenCZEj4cvDwe8=;
	b=lECZg/TevIIlOE5LlHOFAnZYnkN8/stAJFxoEwbhLlLa09Q95OBTpXtTxcfHchBlynxoC8
	fbadQ/wy7QYc5Oc0aY/Z9Ix+LPnyDXQ+Lxgq2emVYuZ3u1VRv20PR3XLBxZLHKxEKbySvK
	lu7Zu7ZhEqcv8gNcxapjNuDGAe4xaSU5TufY5boyK+47eeVYxz7h6PiQj6YfqRqgNTJ1of
	GiwPrk8uJscXQbkAtpBNVWUwVeMOx7xX9k/QoUp35mL2FBCB5dMsAg4HhPojZCeVXgnpdq
	IbJtOQrM+crS5rkh0ldDH3O/eodMzn9wGcY3Fg1d15tzYojzCZqJLKt3z9E8dA==
Date: Tue, 09 Apr 2024 05:25:32 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, code@khaugsbakk.name
Subject: Re: [PATCH v5 3/3] send-email: separate the confirmation prompts from
 the messages
In-Reply-To: <xmqq1q7fa6u7.fsf@gitster.g>
References: <cover.1712486910.git.dsimic@manjaro.org>
 <7b99e5c7c0b0c8d3d7eaaae169e650ebe81964a1.1712486910.git.dsimic@manjaro.org>
 <xmqq1q7fa6u7.fsf@gitster.g>
Message-ID: <bc3998b1c9bbdbc75287735b42013f52@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Junio,

On 2024-04-08 23:21, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> Emit additional vertical whitespace after the "Send this email 
>> [y/n/...]?"
>> confirmation prompts, more specifically after each confirmed email is 
>> sent,
>> but before the subsequent messages are emitted, to make the produced 
>> output
>> more readable.  The subsequent produced messages were bunched together 
>> with
>> the confirmation prompts, as visible in the sample output excerpt 
>> below,
>> which made discerning the outputs unnecessarily harder.
>> 
>>     ...
>>     Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll): y
>>     OK. Log says:
>>     ...
> 
> What comes before "send this email" prompt needs to be shown to make
> the argument more convincing, but with "..." there is no cue to decide
> if the output is hard to read.

Believe it or not, I also saw the provided sample excerpt as
too short.  However, when I tried to make it longer and more
obvious, it turned out that simply too many lines needed to be
included.  I'll give it some more though, and possibly delete
the sample entirely.

>>  sub send_message {
>>  	my ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header) 
>> = gen_header();
>>  	my @recipients = @$recipients_ref;
>> +	my $prompt_separator = 0;
>> 
>>  	my @sendmail_parameters = ('-i', @recipients);
>>  	my $raw_from = $sender;
>> @@ -1556,6 +1557,7 @@ sub send_message {
>>  			$confirm = 'never';
>>  			$needs_separator = 1;
>>  		}
>> +		$prompt_separator = 1;
>>  	} else {
>>  		$needs_separator = 1;
>>  	}
>> @@ -1665,6 +1667,7 @@ sub send_message {
>>  		$smtp->dataend() or die $smtp->message;
>>  		$smtp->code =~ /250|200/ or die sprintf(__("Failed to send %s\n"), 
>> $subject).$smtp->message;
>>  	}
>> +	print "\n" if ($prompt_separator);
> 
> "prompt separator" sounds more like a separator that separates
> prompts, but that is not what is going on, no?

Yup, I already wanted to rename that variable, because its name
isn't really great, but I didn't do that because it went as such
in earlier versions of the patch.  Will rename it in the v6.

> Do we even need that new varible in the first place?  I am wondering
> if you can just do the print "\n" right where you assign to that
> variable.

The reason why the newline isn't emitted right away is because
sending the message takes some time, and if we print it right
away, there's an additional empty line staring at the user while
they wait for the message to be sent.  If we emit the newline
a bit later, using that variable, it gets displayed together
with the printed message, making the displaying of the output
much smoother.

I already tried to describe that behavior in the patch description.
I'll try to improve that description in the v6.

> When $confirm is set to 'never', you have both $needs_separtor and
> $prompt_separator set.  Would it mean you'd have two extra blank
> lines for that message?

Actually, there are no unneeded blank lines in that case, which
I've also tested before sending the patches.  One of the blank
lines (the one for $needs_separator) goes after the patch messages,
and the other one (the one for $prompt_separator) goes after the
prompt, which is displayed before the patch messages.

> All these questions you should have been able to avoided with a bit
> more helpful explanation in the proposed log message, I hope.

I already tried to do that, but it seems it needed more detailed
explanations in the patch description.  Will be improved in the v6.

>>  	if ($quiet) {
>>  		printf($dry_run ? __("Dry-Sent %s\n") : __("Sent %s\n"), $subject);
>>  	} else {
