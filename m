Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2C56F510
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 22:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712271158; cv=none; b=HbDZ4jbfyEs5oyQ9DS7yQgwWkCXt/h/gR/WNVIfcKijrc0S2GeyM/VT2A6BGeKFuXqSfdovAn6HSXGK6D8WTNaRheP+aO37O2CuylwOIIas4RzRRqNG/Yk+gYWFkO/qwrQNaXjX6CBh1EqriU3LFUpY0+2JKi/ZKW4j3UH1X8pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712271158; c=relaxed/simple;
	bh=MZisWWMSjEqZpb74t8MoJAVdNaNZXOovuvTgQgB2Cb8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PdoeztsPdZEG+P4ddAG0EyP62e+jUD30w0cOnPn5f2/pK36M6h9/TOUyMHDxdOKdM7DGfdjKcV+aSfuoThGkuvVfoxNp7Lm25dwBesXombpmV9fka/2Jmrv2NrP/Y9QPA00WU/YUPJfW0U1xP/OuUyZMkLcJLdR9SycpqGnh2co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CjLBKWGb; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CjLBKWGb"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 73E691E7AA;
	Thu,  4 Apr 2024 18:52:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MZisWWMSjEqZpb74t8MoJAVdNaNZXOovuvTgQg
	B2Cb8=; b=CjLBKWGbSXVAQ0TUGl0bvex2DCYBfJiHFSoaWRvlQ40Boes7uJF0uW
	QvRGV2sg99UPH7G6651zegaqLHcFh7abz8VYFdzJffMRGAFm7VLgiK8iqi4kf6g0
	6nvP9o+/HV53bprRZ0FRgQst4nMlCVv6Dw6ngd+i9Eq+cbqUf5dz8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6D6AF1E7A9;
	Thu,  4 Apr 2024 18:52:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EAF2E1E7A8;
	Thu,  4 Apr 2024 18:52:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] send-email: make it easy to discern the messages for
 each patch
In-Reply-To: <0e087ed992def0746f3d437253248904c2126464.1712262791.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Thu, 4 Apr 2024 22:34:28 +0200")
References: <0e087ed992def0746f3d437253248904c2126464.1712262791.git.dsimic@manjaro.org>
Date: Thu, 04 Apr 2024 15:52:31 -0700
Message-ID: <xmqqzfu8yc40.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 05D40558-F2D6-11EE-BD9F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

>  		if ($smtp) {
>  			print __("Result: "), $smtp->code, ' ',
> -				($smtp->message =~ /\n([^\n]+\n)$/s), "\n";
> +				($smtp->message =~ /\n([^\n]+\n)$/s);
>  		} else {
> -			print __("Result: OK\n");
> +			print __("Result: OK");
>  		}
> +		# Make it easy to discern the messages for each patch

I do not think we want this comment.  

Before printing the "Result: OK" line, we do not give an obvious and
pointless comment e.g., "# Report success".  What this comment says
something similarly obvious.  Both choices in the preceding if/else
emit an incomplete line, hence it is clear that we need to terminate
the line here, and this is the last line of output about the message
we just processed.

>  	}
>  
>  	return 1;

You didn't ran t9001 before sending this version (or any of the
previous rounds) out, did you?  Among ~200 tests 10 of them now fail
with this patch applied.

Do we know when we are sending either the first or the last message
of a sequence at this point in the code?  It would be superb if you
can make this extra blank line a separator, not a terminator [*], as
there needs no extra blank line after emitting the last message.

    [Side note]

     * When showing a list of 3 things A B C, you can separate them by
       inserting a gap between A and B, and another gap between B and C,
       and you are using the "separator" (this is similar to how "git
       log --pretty=format:..." works).  But you can be lazy and instead
       append a gap after each element, in which case you are using the
       "terminator" (similar to how "git log --pretty=tformat:..."
       works).

But it is harder to do separator correctly if the output is
conditional (e.g., you have 5 input messages, but you may somehow
skip some messages depending on conditions---now your code to decide
if you emit an extra newline needs to take it into account.  After
sending the 4th message and showing an extra newline, because you
expect that there is another message to be sent and it needs a gap
before, you may realize that some logic causes you to drop 5th and
final message but then it is too late for you to take that extra
blank line back), and obviously a buggy separator implementation is
worse than a terminator implementation.

Here is my attempt on top of your patch to implement the separator
semantics.  After showing a message, we remember that fact, and
before showing the next message, we emit an extra blank line.  With
it, all tests in t9001 pass, but you may want to double check how
different ways to leave send_message() would affect the output.  I
just randomly decided that there needs no extra blank line before
emitting the message that was edited and that is why in the
following patch, I assign 0 to $want_separator_before_send_message
in that case, but it may not be the right choice (I never "edit"
inside send-email myself, so I would be a wrong person to decide
without second opinion), for example.


 git-send-email.perl | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git c/git-send-email.perl w/git-send-email.perl
index ac0c691d3a..d4bbc73f1f 100755
--- c/git-send-email.perl
+++ w/git-send-email.perl
@@ -1689,8 +1689,7 @@ sub send_message {
 		} else {
 			print __("Result: OK");
 		}
-		# Make it easy to discern the messages for each patch
-		print "\n\n";
+		print "\n";
 	}
 
 	return 1;
@@ -1918,16 +1917,21 @@ sub pre_process_file {
 # Prepares the email, prompts the user, and sends it out
 # Returns 0 if an edit was done and the function should be called again, or 1
 # on the email being successfully sent out.
+my $want_separator_before_send_message = 0;
+
 sub process_file {
 	my ($t) = @_;
 
         pre_process_file($t, $quiet);
 
+	print "\n" if ($want_separator_before_send_message);
 	my $message_was_sent = send_message();
 	if ($message_was_sent == -1) {
 		do_edit($t);
+		$want_separator_before_send_message = 0;
 		return 0;
 	}
+	$want_separator_before_send_message = $message_was_sent;
 
 	# set up for the next message
 	if ($thread) {
