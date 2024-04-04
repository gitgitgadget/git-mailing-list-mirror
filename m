Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF813130E57
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 23:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712274288; cv=none; b=PSGlyeElxalSCaxikerohnrdg2pUkhtjEuwGMkUpj1lADGR7IkG0pjPLttM/7Fx2DMlbayLfw+031LSA488ntVgrqTpNHk7du9iRsm6xfBRMNEyhRujIK/aZhhu6fB6aVhKEkXxbr0fRXX9Vv0MSrNMq6wyYRiGG9TJ/EpP7I2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712274288; c=relaxed/simple;
	bh=5buQlDeJjL1t2valBUI6GsRiedbmU1zLibbH8Is4O9U=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=IprMT6cWDFM5j4MRSUnXcqgA3ihtL/gBfZwWwehP/5LwACwxjMHb+gSfbgaFWDA/li1PWj+VPwyT4AUDFefOQeD2p0em0X2otsDxNo/V8uKic9Fy9n5XCg1/e9BcoFm9VtJPK3sv0e4Rf+3ufP4THNckY+zf/fqMgzmNnd30DEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=JyOISIR/; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="JyOISIR/"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712274282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8sgWTzdWcSYBIzH+u3QtpVRaUPn+4nYdcK3R3BF71A=;
	b=JyOISIR/40FX1sb8Z5w1cHwTp36EyHDM7XbzGk5QA0dHYYeoS5tt7zwRffZKvwIe4+tEq+
	u/HGIankR4HhMEO+ysPX/5y0h06DnJEqnDlbWa593QjiJ+pXlN73zb1SiWoLEOpc7K6sSG
	0gHQLnz6OMvHKbUN0/ioWXrks3DWW+LXAwM+LBm8xiiYFy3ElTAETHETuFldzdDHH9zA1Z
	5flrHKBv7HpX8ldxChOzHp2c0NBkNUI5Q1uF+KERw+UAIltuSYdxEvTWkyCqqrl++gI082
	rgeJcVc/zTo80Jos9GHJiMnBFT1mHeConUCQWX6pm9hxDR9Jl8yJK6u0WkAY4g==
Date: Fri, 05 Apr 2024 01:44:42 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] send-email: make it easy to discern the messages for
 each patch
In-Reply-To: <xmqqzfu8yc40.fsf@gitster.g>
References: <0e087ed992def0746f3d437253248904c2126464.1712262791.git.dsimic@manjaro.org>
 <xmqqzfu8yc40.fsf@gitster.g>
Message-ID: <8d47bd687f2ad80bbc1e1c86ae337327@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-05 00:52, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>>  		if ($smtp) {
>>  			print __("Result: "), $smtp->code, ' ',
>> -				($smtp->message =~ /\n([^\n]+\n)$/s), "\n";
>> +				($smtp->message =~ /\n([^\n]+\n)$/s);
>>  		} else {
>> -			print __("Result: OK\n");
>> +			print __("Result: OK");
>>  		}
>> +		# Make it easy to discern the messages for each patch
> 
> I do not think we want this comment.
> 
> Before printing the "Result: OK" line, we do not give an obvious and
> pointless comment e.g., "# Report success".  What this comment says
> something similarly obvious.  Both choices in the preceding if/else
> emit an incomplete line, hence it is clear that we need to terminate
> the line here, and this is the last line of output about the message
> we just processed.

Hmm, I thought that including this comment might actually be helpful
to someone reading the code later, but with your explanation above,
I agree that it doesn't fit very well.

>>  	}
>> 
>>  	return 1;
> 
> You didn't ran t9001 before sending this version (or any of the
> previous rounds) out, did you?  Among ~200 tests 10 of them now fail
> with this patch applied.

My bad, sorry.  I totally missed that test. :(

> Do we know when we are sending either the first or the last message
> of a sequence at this point in the code?  It would be superb if you
> can make this extra blank line a separator, not a terminator [*], as
> there needs no extra blank line after emitting the last message.
> 
>     [Side note]
> 
>      * When showing a list of 3 things A B C, you can separate them by
>        inserting a gap between A and B, and another gap between B and 
> C,
>        and you are using the "separator" (this is similar to how "git
>        log --pretty=format:..." works).  But you can be lazy and 
> instead
>        append a gap after each element, in which case you are using the
>        "terminator" (similar to how "git log --pretty=tformat:..."
>        works).

Well, I actually wasn't lazy, but instead I wanted to give this patch
better chances to be accepted, by introducing as a small amount of
changes to the code as possible.  This was a lesson not to take that
route, but to do "the right thing" instead.

> But it is harder to do separator correctly if the output is
> conditional (e.g., you have 5 input messages, but you may somehow
> skip some messages depending on conditions---now your code to decide
> if you emit an extra newline needs to take it into account.  After
> sending the 4th message and showing an extra newline, because you
> expect that there is another message to be sent and it needs a gap
> before, you may realize that some logic causes you to drop 5th and
> final message but then it is too late for you to take that extra
> blank line back), and obviously a buggy separator implementation is
> worse than a terminator implementation.

Yup, it's tricky to do it right.

> Here is my attempt on top of your patch to implement the separator
> semantics.  After showing a message, we remember that fact, and
> before showing the next message, we emit an extra blank line.  With
> it, all tests in t9001 pass, but you may want to double check how
> different ways to leave send_message() would affect the output.  I
> just randomly decided that there needs no extra blank line before
> emitting the message that was edited and that is why in the
> following patch, I assign 0 to $want_separator_before_send_message
> in that case, but it may not be the right choice (I never "edit"
> inside send-email myself, so I would be a wrong person to decide
> without second opinion), for example.
> 
> 
>  git-send-email.perl | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git c/git-send-email.perl w/git-send-email.perl
> index ac0c691d3a..d4bbc73f1f 100755
> --- c/git-send-email.perl
> +++ w/git-send-email.perl
> @@ -1689,8 +1689,7 @@ sub send_message {
>  		} else {
>  			print __("Result: OK");
>  		}
> -		# Make it easy to discern the messages for each patch
> -		print "\n\n";
> +		print "\n";
>  	}
> 
>  	return 1;
> @@ -1918,16 +1917,21 @@ sub pre_process_file {
>  # Prepares the email, prompts the user, and sends it out
>  # Returns 0 if an edit was done and the function should be called 
> again, or 1
>  # on the email being successfully sent out.
> +my $want_separator_before_send_message = 0;
> +
>  sub process_file {
>  	my ($t) = @_;
> 
>          pre_process_file($t, $quiet);
> 
> +	print "\n" if ($want_separator_before_send_message);
>  	my $message_was_sent = send_message();
>  	if ($message_was_sent == -1) {
>  		do_edit($t);
> +		$want_separator_before_send_message = 0;
>  		return 0;
>  	}
> +	$want_separator_before_send_message = $message_was_sent;
> 
>  	# set up for the next message
>  	if ($thread) {

Thanks for this patch, I'll go through it, and make sure that it works
as expected.  I'll see also to correct the current lack of vertical
separation between the "send the message [y/n/q/a/...]" prompt and the
subsequent output, which also unnecessarily makes the output a bit hard
to parse by humans.

There's also seemingly something wrong with the typeface highlighting
selected for the above-mentioned prompt.  In my environment, it ends up
being displayed as underlined bold text, which looks a bit ugly and,
more importantly, a bit hard on the eyes.
