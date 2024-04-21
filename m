Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F16C79FD
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713728257; cv=none; b=l43OLQajlIJ32E2IUCywWauTSPmipdTRWdU/XjEfPGWjxAqDBrOgEQnjjD1EnGn6vYRr6iRRHKMuwmBpKMn/iQbRzBeCoExEHn3s7whzWCGlnhNXj+lWZdNiU1L6407KJgqLgyzBYGdYxWxpOUYDaupdTeuOnjhy6xAgOXlWyTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713728257; c=relaxed/simple;
	bh=zHZWSa3yyLSbuGOTZPQe6rzvQTvypKETBqY31V0b2Fo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=YYlw1wxXRiWMAAK/khuYfUSzIcjK+z6dR0HnuSWt4fNMMZ8bpdhw3faMemnyj/kOhok1oYNbU9VK4NdJRgc/+QFCEr8GJA9fOv0/whYVCDHa848juYJfKoFM8qT9qkqRH7H3JlRfJXQKrRaaFqbaf4qSFrtQIqn/0yZT8OBcMKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Px11XpI6; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Px11XpI6"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713728252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+I6V+/4BDf7wSbj/8sDr0/X9LbL8J2u1soGb18HRPOM=;
	b=Px11XpI6lWYf+55Ee/hE+ewMi0Yc+KrnczDzx9NIrnmNam3OZpIRVDZfJPFMelwLhCdfsP
	cQ87EiaxPbd7oMmAbJS8mweDg2o2pfI5++j3oxXh0yfj1+H/+zIRR/7u022CgKLoUNC274
	PCQGUpx2DCJ5WUpVyxxB46FAW5Gd2EWpWDKGs/TTtLM7p/gdw13CVXeVMtylrxharxGypv
	LqU38eJ1J19KA6Lk0WxWbBKVOp9Tp00hD46JlM0KSY/WoS06dnilceH7jDzSoH+uukHQKt
	kmTVJSQxf2xupKNbqmMb8ZbOZXS2z+VxBcgKlfs6NxusUYARF17ZmZJ+nVQJJg==
Date: Sun, 21 Apr 2024 21:37:32 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 2/2] format-patch: "--rfc=-(WIP)" appends to produce
 [PATCH (WIP)]
In-Reply-To: <20240421185915.1031590-3-gitster@pobox.com>
References: <xmqqy1993tc1.fsf@gitster.g>
 <20240421185915.1031590-1-gitster@pobox.com>
 <20240421185915.1031590-3-gitster@pobox.com>
Message-ID: <f9aae9692493e4b722ce9f38de73c810@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Junio,

On 2024-04-21 20:59, Junio C Hamano wrote:
> In the previous step, the "--rfc" option of "format-patch" learned
> to take an optional string value to prepend to the subject prefix,
> so that --rfc=WIP can give "[WIP PATCH]".  This commit shows that
> the mechanism can be extended easily to allow "--rfc=-(WIP)" [*1*]
> to signal that the extra string is to be appended instead of getting
> prepended, resulting in "[PATCH (WIP)]".
> 
> Having worked on the patch, I am personally not 100% on board with
> this part of the feature myself, and that is why this update is a
> separate step from the main "--rfc takes an optional string value"
> step.
> 
> If a way to prepend an arbitrary adornment is added to the system,
> and people can now say "--rfc=RESEND" to produce "[RESEND PATCH]",
> those who used to use "[PATCH RESEND]" by tweaking the subject
> prefix in other ways [*2*] would do one of three things:

There are even more issues, such as the grammar-related ones.  Let
me explain, please, as accurately as I can do that as a non-native
English speaker who spent many years studying English grammar.

Writing "RFC PATCH" puts "RFC" into the role of an adjective, which
is fine.  The same obviously applies to "WIP PATCH".  On the other
hand, writing "RESEND PATCH" puts "RESEND" into its only possible
role, which is transitive verb, and results in "RESEND PATCH" that
serves as a very simple sentence in imperative mood.  I'm not sure
that, strictly technically speaking, having simple sentences as the
prefixes is the desired outcome.

Technically, we should use "RE-SENT PATCH" to be on the correct side
from the grammar perspective, with "RE-SENT" serving as an adjective.
Before you ask, no, we can't use "RESENT" there, because its meaning
is completely different.  However, nobody uses "RE-SENT PATCH", or
at least I haven't seen it used yet.

When it comes to "PATCH RESEND", "RESEND" remains in its transitive
verb role, but "PATCH", as a noun, becomes a modifier of the verb.
Thus, the resulting meaning of "PATCH RESEND" becomes something like
"resend an item that's a patch", but not written in form of a simple
(or less simple) sentence.  Strictly technically, a noun should only
modify another noun, but bending English grammar a bit this way is
much better than actually having a simple sentence as a prefix.

With all this in mind, I think that allowing the "--rfc=-<string>"
form is the way to go.  Computer lingo often bends English grammar
to a certain degree, to achieve compactness, but bending and dumbing
it down more that it's actually necessary isn't something that we
should embrace.

I hope all this makes sense.

>  (1) keep using their existing ways and keep sending their message
>      with the "[RESEND PATCH]" prefix.
> 
>  (2) rejoice in the new automation, switch to use "--rfc=RESEND",
>      and start sending their messages with "[RESEND PATCH]" prefix
>      instead of "[PATCH RESEND]" prefix.
> 
>  (3) complain and demand a way to append instead of prepend so that
>      they can use an automation to produce "[PATCH RESEND]" prefix.
> 
> I do not believe in adding slightly different ways that allow users
> to be "original" when such differences do not make the world better
> in meaningful ways [*3*], and I expect there are many more folks who
> share that sentiment and go to route (2) than those who go to route
> (3).  If my expectation is true, it means that this patch goes in a
> wrong direction, and I would be happy to drop it.
> 
> 
> [Footnote]
> 
>  *1* The syntax takes inspiration from Perl's three-arg open syntax
>      that uses pipes "open fh, '|-', 'cmd'", where the dash signals
>      "the other stuff comes here".
> 
>  *2* ... because "--rfc" in released versions does not even take any
>      string value to prepend, let alone append, to begin with.
> 
>  *3* 
> https://lore.kernel.org/git/b4d2b3faaf2914b7083327d5a4be3905@manjaro.org/
>      gathered some stats to observe that "[RFC PATCH]" is more
>      common than "[PATCH RFC]" by a wide margin, while trying to see
>      how common "[RESEND PATCH]" (or "[PATCH RESED]") were used (the
>      answer: much less common).  But it wouldn't have needed to
>      count "[PATCH RFC]" and "[RFC PATCH]" separately if using a
>      prefix and not a suffix (or vice versa) were established more
>      firmly as the standard practice.
> 
>      It is a fine example that useless diversity making needless
>      work.
