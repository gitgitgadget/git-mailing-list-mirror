Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432B715E5CF
	for <git@vger.kernel.org>; Mon, 27 May 2024 12:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814768; cv=none; b=WAlxr5tH3my3o1mA1wnKE/jhlze088n4v/YwCx+tGcbXAkPIFgxM8YIOOllnN7t3WMwjuQHn/HBIR4IzPG012rhW7Ebg192gbJ2e7xzredQkn84ULrPBC3Tr3r/jv08BogxOXKmPUg8wzcR8AB2dA2ylB+7q1HcJNNd6hC8UL/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814768; c=relaxed/simple;
	bh=tpy851VHlhNaPsunTRm09cZ9jeM8MYVcL8mUTlWM7sI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=JLmIbJoo+bd875VByjQ4O5CzMOfiN+6CiRGgd+PecFgnJUyebI/GJS1pUSidYFJW7cQmSB+Pqn2Z9ia9P3OoLfzQI7uO+avhMu1BgJhCmkW2qbG5d1vBXDl0XUQ9HVcFfZI++0CIOWkRo/s7qcL5LjnRu1Ccgv3AYVub3qNAVTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=W4z0mtc2; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="W4z0mtc2"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716814762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5xKwwJEUr3GRthX1CkDNTBRAnix6vbM8GDaHoMGAHY=;
	b=W4z0mtc22QpsgB1yvkpsaiTw+mptTuVp4skm5HaEZ0/Z9PZh6fNLA0kEF7F27lTO2dxymX
	XDEPujbrdiw5gpSvMu7+2bw+M4pV6jCJMLWTQ+TQe6LNeteWQIJySvWAoPskJ1b95DeRlZ
	36Ut1yGwj4wqQJBxwU/l/5+cHpQrdbGQBulY1HFhvpJ3JOswJ+QyrznnvFcft5krJJqm7y
	iGq73uve0gqbqfcX1kWPy807usiARbtnyZFM6W989kFaoKNp8gMkajk2EHhw+Y7gITiHhs
	O9m4Bf3uPDkXCxC2bIWzBzfvdtAxMqUqJqZTdxvN3TRQ60kvQYsa6Zss4tGP6Q==
Date: Mon, 27 May 2024 14:59:21 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] format-patch: move range/inter diff at the end of a
 single patch output
In-Reply-To: <ZlQX0FmIsz2eFgsC@tanuki>
References: <20240523225007.2871766-1-gitster@pobox.com>
 <20240523225007.2871766-3-gitster@pobox.com> <ZlB2g5bTuBFz5m5_@tanuki>
 <xmqqo78ukhmk.fsf@gitster.g> <ZlQX0FmIsz2eFgsC@tanuki>
Message-ID: <a4f6cf69b5fb189a80f69dcf6d5a8731@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-27 07:19, Patrick Steinhardt wrote:
> On Fri, May 24, 2024 at 02:46:43PM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > On Thu, May 23, 2024 at 03:50:07PM -0700, Junio C Hamano wrote:
>> > I also think that there's a bug here. The output from the above command
>> > is:
>> > ...
>> >     --- a/blorp
>> >     +++ b/blorp
>> >     @@ -1 +1 @@
>> >     -fnorp
>> >     +fleep
>> >     Interdiff against v1:
>> >       diff --git a/blorp b/blorp
>> > ...
>> >
>> > The diff is before the separator for the signature, and there is no
>> > clear delimiter between the actual diff and the interdiff.
>> 
>> Earlier Eric expressed concern about writing this out _after_ the
>> mail signature mark "-- ", so the output deliberately goes before
>> it.  There is no need for any marker after the last line of the
>> patch.  "Interdiff against ..." is a clear enough delimiter.
>> 
>> FWIW, the parsing of patches has always paid attention to the
>> lengths recorded in @@ ... @@ hunk headers, and the parser notices
>> where the run of ("diff --git a/... b/..." followed by a patch) ends
>> and stops without problems.  On the other hand, if you remove the
>> line "+fleep" in the above example and try to feed it to "git
>> apply", it would correctly notice that it failed to see the expected
>> one line of postimage and complains (because it sees "Interdiff
>> against..."  when it expects to see a line that begins with a plus).
>> 
>> So, I do not see any problem with the output from this cocde at all.
>> 
>> Thanks for careful reading.
> 
> The machine can cope alright. But I think that it's way harder to parse
> for a human if there is no clear visual delimiter between the diff and
> the interdiff. And "Interdiff" isn't quite ideal in my opinion because
> it is text, only, and may be quite easy to miss if it follows a long
> diff.
> 
> The signature mark may not be ideal here as an indicator. Mail readers
> may hide signatures, color them differently or other stuff. But I think
> there should be some indicator here that visually highlights the fact
> that one section is ending and another section is starting. This could
> either be a newline, or the triple-dashes as we use in other places.

I agree about the need for having a distinctive separator.
