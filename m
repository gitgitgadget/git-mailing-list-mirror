Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3138D39AFE
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 22:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706739375; cv=none; b=TwVpA3kBeo9kUfJtjRWwHrCX1liRRAqEJ3ZU21tZyxZ4/ejoZY4wno2vbpquZZGE2o8QzECYAQi2E+sYvq8gR1PAG8v5GMaMSCDXALQBqVeTgQ6CFPKUFfBnCXM3gEPHsQUhSaTHh+6XuXc7nnBPky/SIdad21pa4PUKzeIST1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706739375; c=relaxed/simple;
	bh=ESsplwUD6lwJAY0MqKu5ogAe0Rb0a1Zau/LgHUu8HKk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LOx0i2hmfu80C2vQ2zah5PhZlVU+OpEG8KZKo+HyBgPmGv2gw0X5Iz/SY/WF+LtfQVjDcdCv9C3mJluvhaBXh39Y4v3On/lghFjZrIfKhuqrXlL9cRg9WtWs970wXUZ5s8lNHwH1f4Qjiwvq19a1p+r0mm91l0jxODXisUHsFTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OvEAmliA; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OvEAmliA"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 72AE834684;
	Wed, 31 Jan 2024 17:16:13 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ESsplwUD6lwJAY0MqKu5ogAe0Rb0a1Zau/LgHU
	u8HKk=; b=OvEAmliAHr6cva8h244VxNNybixLkp552AwDJxQBfUnLa5hF4EyREU
	0nDihpa7+ABHKgfbTLZWhgkm1oPpFgd9iQklfGwvT3keBXRmHlIUbwvYkoRehVKp
	4byM140dD3DrmOSEkhAVhmwEwt6sSU5vzFJmLIXI/fvH7bVk+tyfY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6ABA534683;
	Wed, 31 Jan 2024 17:16:13 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9B5AC34682;
	Wed, 31 Jan 2024 17:16:09 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Linus Arver
 <linusa@google.com>
Subject: Re: [PATCH v3 03/10] trailer: unify trailer formatting machinery
In-Reply-To: <xmqqy1c545y0.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	31 Jan 2024 12:13:27 -0800")
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
	<pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<5c7a2354df0f4a29841f9ab8294ead0e1c3b9cf5.1706664145.git.gitgitgadget@gmail.com>
	<xmqqy1c545y0.fsf@gitster.g>
Date: Wed, 31 Jan 2024 14:16:07 -0800
Message-ID: <xmqqa5ol409k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 56074332-C086-11EE-8565-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> +				if (opts->unfold)
>> +					unfold_value(&val);
>
> So, ... how would this affect an invocation of
>
>     $ git interpret-trailers --unfold
>
> which would have set opts.unfold to true in cmd_interpret_trailers()
> and eventually called process_trailers() with it, which eventually
> called print_all(), which conditionally called print_tok_val() but
> never gave the val to unfold_value()?
>
>  ... goes and digs a bit more ...
>
> Ahhhh, original process_trailers() did this by calling
> parse_trailers() that munged the value.  So its print_all()
> codepath only had to print what has already been munged.
>
> But then in this new code, do we unfold only here?  I thought that
> in the new code you moved around, the caller, whose name is now
> interpret_trailers(), still calls parse_trailers() and that calls
> the unfold_value().  So, are we doing redundant work that may merely
> be unneeded (if we are lucky) or could be harmful (if things, other
> than the unfold thing I just noticed, that are done both in
> parse_trailers() and this function are not idempotent)?

I was too confused by the code flow and resorted to tracing what
happens when "git interpret-trailers --unfold" is run in a way
similar to how t7513 does in gdb.  Shame shame.

In any case, the updated code does try to call unfold_value() in
format_trailers() on "val" that has already been unfolded in
parse_trailers().  This may not produce an incorrect result if
unfold_value() is truly idempotent (I do not know), but even if it
is correct for its handling of .unfold bit, this episode lowered my
confidence level on the new code significantly, as I do not know
what unintended effects [*] all the other new things done in this
function have, or if none of these unintended effects are
error-free.

> It could be that a bit more preparatory refactoring would clarify.
> I dunno.

Thanks.

[Footnote] 

 * I am assuming that calling unfold twice on the same value and
   relying for its idempotent-ness for correctness was not your
   intention.
