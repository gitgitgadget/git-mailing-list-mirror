Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C93B172BAE
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 23:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725061894; cv=none; b=XPGK2Zi09GuOKN1aBZ2wbBgqfeCui5mgeXIb+aw7DeT6z3rXdr5c0qeD6pBn2/uZYnH1rOzrSZsEqRBsWpvPR1j2Z5n/m9PfSf0GiGWlEMHJMKV3GI2/prP3cZvaC030gqtCZyU850ECxwiIW5H8bAma3ALBTu/VDv3C14LWnu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725061894; c=relaxed/simple;
	bh=i9n0g2FbB2Afha4t/OKfCJyNQT9OK8cBGJUh93eonkI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IpHe6Ph/5jG/xjGBBYVQ5Omy9gpa7wk9sGzB8Oy62GB6P82w0pRH6l9dqSNxUVwbWQJ1Hp0r5swgx21MB6SyaDV3dpvJanV5ZZ+OeNn9ybT0aWxokPH7U0BTZNHQAXf+D9/j7EQBHE+9SRK1qrBupGA4YcHcI6QLtkw87wg2PPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hTk1Nlol; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hTk1Nlol"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D72E23A22;
	Fri, 30 Aug 2024 19:51:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=i9n0g2FbB2Afha4t/OKfCJyNQT9OK8cBGJUh93
	eonkI=; b=hTk1NlolAKes77C7OjH9mKrql0c/1xmYSTZEAj+er2JlFJDwVRbny7
	LHGD8mq5ShJSfTZ7BXHVx17+4Sxui8ZB6/ITatKPSNosrudtJaY7xq0lq2gdQdW0
	FDIi+22vcc1wxvmmFobUBVfnmzqUaE3FtvDX6KXi5CtAmJv2B5NZM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 25F6923A21;
	Fri, 30 Aug 2024 19:51:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8EA9523A20;
	Fri, 30 Aug 2024 19:51:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Eric Sunshine <ericsunshine@charter.net>,  git@vger.kernel.org,  Jeff
 King <peff@peff.net>
Subject: Re: [PATCH 2/2] chainlint: reduce annotation noise-factor
In-Reply-To: <CAPig+cSZ8Sot9oq+rmzBTmQU-Fnay92roTO=Mk0uT+-JUzMcXw@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 30 Aug 2024 19:30:09 -0400")
References: <20240829091625.41297-1-ericsunshine@charter.net>
	<20240829091625.41297-3-ericsunshine@charter.net>
	<xmqqv7zjwcgq.fsf@gitster.g>
	<CAPig+cSZ8Sot9oq+rmzBTmQU-Fnay92roTO=Mk0uT+-JUzMcXw@mail.gmail.com>
Date: Fri, 30 Aug 2024 16:51:30 -0700
Message-ID: <xmqqle0dpo1p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C8265836-672A-11EF-A4E8-9B0F950A682E-77302942!pb-smtp2.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> It may be possible to do something like this instead (untested), but
> I'm not sure it's worth the complexity:
>
>     $checked .= substr($body, $start, $pos - $start);
>     $checked .= ' ' unless $checked =~ /\s$/;
>     $checked .= "$erropenERR $err$errclose";
>     $checked .= ' ' unless $pos + 1 >= length($body) ||
>         substr($body, $pos + 1, 1) =~ /\s/;

I think the complexity you mention is the updates to existing code
to get to the above end state?  Using some setup like ...

	($erropen, errclose) = 
		$colored_output ? ("?!", "?!") : ("<RED>", "<RESET>");

... and then using a code like the above would be quite
straightforward and the end result cannot become simpler than that
;-)

> As first implemented, there was no structured "problem description".
> chainlint originally just output a stream of raw parse tokens (not the
> original test text), and when a problem was discovered the "?!...?!"
> annotations were embedded directly in the output stream. This was
> still the case even when colored output was implemented[1]; in fact,
> the annotations were colored after-the-fact by searching for "?!...?!"
> in the output stream. It was only when chainlint was taught to output
> the original test text verbatim[2] that problem descriptions became
> structured data.

Exactly.

Thanks.
