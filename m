Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0067B15B54C
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973965; cv=none; b=cvpDTEeb71nHrEslftAU4dMLRagyEU9YyKmqYpW1M70pQTDnfgeHFxQ4KvcgLVgTwdp1bXDs0+9TL6a+4ZPP1L744pbIVVvEO2JWgYBEVSuyOkCCAiW/j4RKUY7AXzKUyFv8ThvqPCyL5vguThUZ3or63FOti8bPiOidj98Ut0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973965; c=relaxed/simple;
	bh=EAv7ZAH33dhy9HvCKw35xJ6SIKN7bnTEg9ah8sTWUSo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=J13U3hH6vw8RFaCxQPLsDB9+0x9OlJrCKbpgq4A3Z05uoxYBIl9OvnkOO/b6Fg0FPOZ2wNIfbCQWng9JPf7JQSoJThxZx5099sBn/RIMAa9txPtgDQIN88XJ0s85/oAgMdJD+dxDI/JjWwYuDjpZOZzErIQyuwgwQv541oS2H6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=W0JaNegS; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="W0JaNegS"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713973959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sdNjYU6rudl/q2vtmKwQ3LymfbXdxSMQ85Af3kpCqws=;
	b=W0JaNegSqNRBbKxi9J+jUl1x6sJVd/fVv30Za2a4gQ6d1o1jQSElurLOxk3j+urMw7kuLg
	cSay6fRlwOTRYphdDOQ1LwPvn1nK/Yn/ut3ZomP4B/2nz1+P45koLmazTqJ6+f1IOZAJsr
	9281Nnll0VOVsU3Ns5g7hqaygn+UBw6jXlrioyQnUbKXYtKnLfM37Bz9HXkzXHEsZ26oMV
	wWfZamO8DRqN165ZTu03z4pkw5ZBpSgbiJ9t70m9XT6wBa0s3fZd7Ibm2ERPUjvILKJASM
	R3SdnXD+PJ0rhi9lRj2wjCPqj1kZmXlUKqLAbBhZIw/TwPTqPiL9BXL/YnbqPA==
Date: Wed, 24 Apr 2024 17:52:39 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] format-patch: "--rfc=-(WIP)" appends to produce
 [PATCH (WIP)]
In-Reply-To: <e4206b6d-13bb-4332-93b3-09721c1b4152@gmail.com>
References: <xmqqy1993tc1.fsf@gitster.g>
 <20240421185915.1031590-1-gitster@pobox.com>
 <20240421185915.1031590-3-gitster@pobox.com>
 <f9aae9692493e4b722ce9f38de73c810@manjaro.org>
 <e4206b6d-13bb-4332-93b3-09721c1b4152@gmail.com>
Message-ID: <115acd1529d9529ef5bb095c074ad83d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Phillip,

On 2024-04-24 12:17, Phillip Wood wrote:
> On 21/04/2024 20:37, Dragan Simic wrote:
>> On 2024-04-21 20:59, Junio C Hamano wrote:
>>> In the previous step, the "--rfc" option of "format-patch" learned
>>> to take an optional string value to prepend to the subject prefix,
>>> so that --rfc=WIP can give "[WIP PATCH]".  This commit shows that
>>> the mechanism can be extended easily to allow "--rfc=-(WIP)" [*1*]
>>> to signal that the extra string is to be appended instead of getting
>>> prepended, resulting in "[PATCH (WIP)]".
>>> 
>>> Having worked on the patch, I am personally not 100% on board with
>>> this part of the feature myself, and that is why this update is a
>>> separate step from the main "--rfc takes an optional string value"
>>> step.
>>> 
>>> If a way to prepend an arbitrary adornment is added to the system,
>>> and people can now say "--rfc=RESEND" to produce "[RESEND PATCH]",
>>> those who used to use "[PATCH RESEND]" by tweaking the subject
>>> prefix in other ways [*2*] would do one of three things:
>> 
>> There are even more issues, such as the grammar-related ones.
> 
> I think it is best to view the subject prefix as a list of space
> separated labels or keywords rather than part of a grammatically
> correct sentence.

With all due respect, I strongly disagree.  Viewing it that way and
letting "[RESEND PATCH]" be accepted as correct (and even enforced
a bit) is exactly what I below referred to as embracing the bending
of English grammar beyond what's actually necessary.

Please, let me remind you that I spent more than a couple of years
on English Wikipedia, writing new and expanding already existing
computing-related articles, during which time I participated in more
than a few grammar-related discussions.  All that makes me more
"sensitive" to breaking the English grammar rules when that actually
isn't necessary or beneficial.

>  Let
>> me explain, please, as accurately as I can do that as a non-native
>> English speaker who spent many years studying English grammar.
>> 
>> Writing "RFC PATCH" puts "RFC" into the role of an adjective, which
>> is fine.  The same obviously applies to "WIP PATCH".  On the other
>> hand, writing "RESEND PATCH" puts "RESEND" into its only possible
>> role, which is transitive verb, and results in "RESEND PATCH" that
>> serves as a very simple sentence in imperative mood.  I'm not sure
>> that, strictly technically speaking, having simple sentences as the
>> prefixes is the desired outcome.
>> 
>> Technically, we should use "RE-SENT PATCH" to be on the correct side
>> from the grammar perspective, with "RE-SENT" serving as an adjective.
>> Before you ask, no, we can't use "RESENT" there, because its meaning
>> is completely different.  However, nobody uses "RE-SENT PATCH", or
>> at least I haven't seen it used yet.
>> 
>> When it comes to "PATCH RESEND", "RESEND" remains in its transitive
>> verb role, but "PATCH", as a noun, becomes a modifier of the verb.
>> Thus, the resulting meaning of "PATCH RESEND" becomes something like
>> "resend an item that's a patch", but not written in form of a simple
>> (or less simple) sentence.  Strictly technically, a noun should only
>> modify another noun, but bending English grammar a bit this way is
>> much better than actually having a simple sentence as a prefix.
>> 
>> With all this in mind, I think that allowing the "--rfc=-<string>"
>> form is the way to go.  Computer lingo often bends English grammar
>> to a certain degree, to achieve compactness, but bending and dumbing
>> it down more that it's actually necessary isn't something that we
>> should embrace.
>> 
>> I hope all this makes sense.
>> 
>>>  (1) keep using their existing ways and keep sending their message
>>>      with the "[RESEND PATCH]" prefix.
>>> 
>>>  (2) rejoice in the new automation, switch to use "--rfc=RESEND",
>>>      and start sending their messages with "[RESEND PATCH]" prefix
>>>      instead of "[PATCH RESEND]" prefix.
>>> 
>>>  (3) complain and demand a way to append instead of prepend so that
>>>      they can use an automation to produce "[PATCH RESEND]" prefix.
>>> 
>>> I do not believe in adding slightly different ways that allow users
>>> to be "original" when such differences do not make the world better
>>> in meaningful ways [*3*], and I expect there are many more folks who
>>> share that sentiment and go to route (2) than those who go to route
>>> (3).  If my expectation is true, it means that this patch goes in a
>>> wrong direction, and I would be happy to drop it.
>>> 
>>> 
>>> [Footnote]
>>> 
>>>  *1* The syntax takes inspiration from Perl's three-arg open syntax
>>>      that uses pipes "open fh, '|-', 'cmd'", where the dash signals
>>>      "the other stuff comes here".
>>> 
>>>  *2* ... because "--rfc" in released versions does not even take any
>>>      string value to prepend, let alone append, to begin with.
>>> 
>>>  *3* 
>>> https://lore.kernel.org/git/b4d2b3faaf2914b7083327d5a4be3905@manjaro.org/
>>>      gathered some stats to observe that "[RFC PATCH]" is more
>>>      common than "[PATCH RFC]" by a wide margin, while trying to see
>>>      how common "[RESEND PATCH]" (or "[PATCH RESED]") were used (the
>>>      answer: much less common).  But it wouldn't have needed to
>>>      count "[PATCH RFC]" and "[RFC PATCH]" separately if using a
>>>      prefix and not a suffix (or vice versa) were established more
>>>      firmly as the standard practice.
>>> 
>>>      It is a fine example that useless diversity making needless
>>>      work.
