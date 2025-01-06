Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B591DF725
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 23:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736204608; cv=none; b=eTbNLWZOdiqtN9ip7YVziy96YgRlm0JfHRas5oSQF3UsYXwvMKEg2UFsOZthIXrZPd5DEfJOvTfo+aUiJCPv5qgQhdoEdaVqdi9k0d6hvBqKHI1wRzCJ0750sZTMFLpT7eITeIh5qp6u8WQwj5I4C2d41InJG9OaVMc/jx1ivfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736204608; c=relaxed/simple;
	bh=bBLcCaQuolWVe06jY/PDPZ5dVs1y8PjIc2fw6HwaJAo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nMZw8/DhzdYHoCCEmqlJHifV27kqoXaDMDeMR2tbc2ged3giScLHXGMolsYjq9gEzIcZ/PkgNBfYCRcqbr6shaJgoqFBMwNMS6lt7EICtkYMBZxu/Kycn/ehQkso3mr2OrcAiKOtW7S/dGF92Uv/blMcthedXIJoiwzbgjF56Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4YRqGV5BZTz1s88m;
	Mon,  6 Jan 2025 23:53:22 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4YRqGV4Pvrz1qqlS;
	Mon,  6 Jan 2025 23:53:22 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id IWZ81aFmqbmn; Mon,  6 Jan 2025 23:53:21 +0100 (CET)
X-Auth-Info: wn8is9PQLh9E8NV9Lt6eLlXY9H1eIYEQBamvWXfcFU405FFv/nq6kIQRfr1Q1Z78
Received: from igel.home (aftr-82-135-83-33.dynamic.mnet-online.de [82.135.83.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Mon,  6 Jan 2025 23:53:21 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 868A52C19F2; Mon,  6 Jan 2025 23:53:21 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org,  gitster@pobox.com,  phillip.wood123@gmail.com,
  ps@pks.im,  =?utf-8?Q?S=C3=B6ren?= Krecker <soekkle@freenet.de>
Subject: Re: [PATCHv2 2/4] date.c: Fix type missmatch warings from msvc
In-Reply-To: <CAPig+cR0GgZQ+XCyAh=xHRfjfsAdTzC2uyML1vnoM_fXv1Bxew@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 6 Jan 2025 17:22:06 -0500")
References: <20250106190855.3098-1-soekkle@freenet.de>
	<20250106190855.3098-3-soekkle@freenet.de>
	<CAPig+cR0GgZQ+XCyAh=xHRfjfsAdTzC2uyML1vnoM_fXv1Bxew@mail.gmail.com>
Date: Mon, 06 Jan 2025 23:53:21 +0100
Message-ID: <87sepvpna6.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Jan 06 2025, Eric Sunshine wrote:

> On Mon, Jan 6, 2025 at 2:14 PM Sören Krecker <soekkle@freenet.de> wrote:
>> Fix compiler warings from msvc in date.c for value truncation from 64
>> bit to 32 bit integers.
>
> s/warings/warnings/
>
>> Also switch from int to size_t for all variables with result of strlen()
>> which cannot become negative.
>>
>> Signed-off-by: Sören Krecker <soekkle@freenet.de>
>> ---
>> diff --git a/date.c b/date.c
>> @@ -1270,7 +1270,7 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
>>         tl = typelen;
>>         while (tl->type) {
>> -               int len = strlen(tl->type);
>> +               size_t len = strlen(tl->type);
>>                 if (match_string(date, tl->type) >= len-1) {
>
> This change looks scary and potentially wrong considering that the
> expression in the `if` statement subtracts 1 from `len`. If `len`
> happens to be zero, then `len-1` will wrap around to a very large
> number, thus potentially changing the meaning of the `if` condition.
>
> Now, admittedly, I haven't delved into this code or thought about it
> much, so I may be entirely wrong about this; perhaps it is impossible
> for `len` to ever be zero in this context or perhaps the meaning of
> the `if` condition doesn't change even if it wraps around.

It can be made more robust by moving the constant to the other side:

                if (match_string(date, tl->type)+1 >= len) {

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
