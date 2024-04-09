Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AE454743
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 03:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633869; cv=none; b=jJYmfB/4DvQFsgrkFCs+V1QUy+1nZ78s60Dj2/zm8sulWkMA5vKyFlw7M7n/8IKjA7E69Ba/AfVWkpwpVuseERBmNsOy/ECu5DHydgYlrG2ZNfbygWFm7j/0z2sRVaXPjvTg1hoavQ/wBDzKE3kQTnf/UEkk2NJBM5N2GCqbkXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633869; c=relaxed/simple;
	bh=aq9TVOEN6u9RU3w4VY/WColFKwbJV563RA+6wXR9ywg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=r8PnfZ9byTE+gCDK0tuNqSNfuED+P/cv5uGUqpzf7gHhFre81EvJzmnN0xo6VpFhujCtri8qhjYS/FmSxKRkJ0TrkFw9/B307jR3IK/BFOpFMGeIFoUdTTEo+e/n8GP0rg+h9OzsKF2OPmFBh8bg98GI51RdLVkglHHyP5WOadY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=OrBgDvBG; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="OrBgDvBG"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712633864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wUzEklmF0XTYa8pWh7Rvg4zpcSDTk1apOERZyL7Ag1o=;
	b=OrBgDvBGfzUHwQzmXrJroEH9lqqCV/P05SYFBs0WHITGZeE+G5GmP2f1lDE2W35yPKLgU4
	edpx5eR6NBm6u+Ypw3hPf8G4CCukhB6OFWthcr4WMWtzAdAcHpE3eB2y8TW9efDglexZZK
	oK0QTzKQyrfO5nkiFbhlgBHO6UAvVEvWYXdqLiF98bIj80lR4wvJeBttTvL20KA2I3MQNd
	UQMx6UDdLphmvkn3gwGaYPUse/FmoCt8kFEHIm8/EzzJ0Zf60xEwH2OhZ/oa7Cz5eNxYNq
	0HqR/aPs/j7ccWX4gn5qAMxVXfPiIJO3FvxfsYKFkY9D0fNGh4b8Na4B+QZh4Q==
Date: Tue, 09 Apr 2024 05:37:43 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, code@khaugsbakk.name
Subject: Re: [PATCH v5 2/3] send-email: make it easy to discern the messages
 for each patch
In-Reply-To: <xmqq7ch7a7gt.fsf@gitster.g>
References: <cover.1712486910.git.dsimic@manjaro.org>
 <7f87383089011a98b0347d885b3b9d76cfddb91d.1712486910.git.dsimic@manjaro.org>
 <xmqq7ch7a7gt.fsf@gitster.g>
Message-ID: <2b24b9e8f0fcb4f6df595c1b0be06359@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-08 23:08, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> ...  To make the produced outputs more readable, add vertical
>> whitespace (more precisely, a newline) between the displayed result 
>> statuses
>> and the subsequent messages, as visible in ...
> 
> The above feels a bit roundabout way to say "the logic is that we
> need to add a gap before showing the next message, if we did things
> that cause the smtp traces to be shown", but OK.

Yeah, the wording I used isn't perfect, but I think it's still
understandable.  I'll see to possibly improve it in the v6.

>> These changes don't emit additional vertical whitespace after the 
>> result
>> status produced for the last processed patch, i.e. the vertical 
>> whitespace
>> is treated as a separator between the groups of produced messages, not 
>> as
>> their terminator.  This follows the Git's general approach of not 
>> wasting
>> the vertical screen space whenever reasonably possible.
> 
> I do not see this paragraph is relevant to the target audience.  It
> may be a good advice to give to a reader who attempts to solve the
> problem this patch solved themselves, botches the attempt and ends
> up with a code with the terminator semantics.  But for other readers
> of "git log" and reviewers of the patch, "I did not make a silly
> mistake, and instead correctly chose to use the separator semantics"
> is not something worth boasting about.

Makes sense, will delete that paragraph in the v6.

>> While there, remove a couple of spotted stray newlines in the source 
>> code
>> and convert one indentation from spaces to tabs, for consistency.
>> 
>> The associated test, t9001, requires no updates to cover these 
>> changes.
> 
> These are worth recording.

Thanks.

>> @@ -1554,7 +1554,10 @@ sub send_message {
>>  			exit(0);
>>  		} elsif (/^a/i) {
>>  			$confirm = 'never';
>> +			$needs_separator = 1;
>>  		}
>> +	} else {
>> +		$needs_separator = 1;
>>  	}
> 
> If you do not add this "else" clause to the outer "are we doing
> confirmation?" if statement, and instead just set $needs_separator
> *after* it, it would make it even more obvious what is going on.
> The codeflow would become
> 
> 	sub send_message {
> 		do bunch of things that do not yet send e-mail
> 	        and possibly return or die
> 
> 		$needs_separator = 1;
> 
> 		do things that cause the smtp exchange and trace
> 		to be emitted
> 	}
> 
> That makes it obvious that the purpose of $needs_separator is to
> record the fact that "this" message has already been sent and we
> need to add a "gap" before attempting to send the "next" message.

Very good point, thanks!  I've somehow managed to miss that while
iterating through a few code variants and the associated testing.
Will be improved in the v6.

> Other than the above points, very well done.

Thank you! :)

>>  	unshift (@sendmail_parameters, @smtp_server_options);
>> @@ -1576,7 +1579,6 @@ sub send_message {
>>  		print $sm "$header\n$message";
>>  		close $sm or die $!;
>>  	} else {
>> -
>>  		if (!defined $smtp_server) {
>>  			die __("The required SMTP server is not properly defined.")
>>  		}
>> @@ -1921,7 +1923,8 @@ sub pre_process_file {
>>  sub process_file {
>>  	my ($t) = @_;
>> 
>> -        pre_process_file($t, $quiet);
>> +	pre_process_file($t, $quiet);
> 
> nice ;-)

It had to be fixed, IMHO. :)

>> +	print "\n" if ($needs_separator);
>> 
>>  	my $message_was_sent = send_message();
>>  	if ($message_was_sent == -1) {
