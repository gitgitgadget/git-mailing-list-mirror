Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5746112
	for <git@vger.kernel.org>; Sun, 17 Mar 2024 04:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710648967; cv=none; b=bafrHwN+HLQsVa8NlYn5/5kjaI3uXvohkvMPcn4fSOCe8nzpBMadCu4kzdfD1jc6sqWjIipDSlxPpdnX+xiO/SC0JaXYST3oD+o2fQsn/hUKYZ8KE73vIXLvz+92ECWCT96HpFsq4nTBQRSxm+5Lhpiu3npty+hz4Mp528C1Z04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710648967; c=relaxed/simple;
	bh=uGY5LGjyvalaMkGM7eM7jhlJXETDPBU1yavAdMJ3+zM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=b5yrTvrREWv4P1HQ9kMzJRTLAxcL5odB1BaE1Z9qe/PmpC3xO8AZDvYb6YWBrAhFa4LyxaioPg8UMeAeIu04p0AGKsfW4Gx53vQWGRkV37S8i5U2JFV6k9/asqweRCr/1frCuUdFbiJR9ysEqYoFwzoMZK84fFY9LXnFzPtxMCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=oVFg9whm; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="oVFg9whm"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710648962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EShaBLuubbE4Cceqrq3NIcn8J53Hbqbp3uN0tb42D8k=;
	b=oVFg9whm+SbJxTjh+ods/niWDN7q7hfI2dXhFtwhYRv4V79OMLQVu4Je5H7g6B9gYb9rUn
	U3rHAD1+uguwnuE0QNqz2s41eyqsi9z7hWCZ02kwUIHhVbigLtOl7WFp1rTf1bisP8AZrk
	ijAESkYwBSQEioGyNG8sFbwnXM1P8CEueeQw0jzr89iKnzccE135QpMcxybdPxuHH3T5Gv
	z3O4ZeewgGlNByX2gvYA9gVmIt62d67L+zfpZhb+LPy6ynQzBURQ/7S971BuY9GmiYWmTm
	ytqg14twKrs6xY5vbd2iz7JM6cg5SvRpdFiEcwjUyFcgB0Br2DxVvfFVDpokwQ==
Date: Sun, 17 Mar 2024 05:16:02 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, gitster@pobox.com, rsbecker@nexbridge.com,
 github@seichter.de
Subject: Re: [PATCH v2 3/5] test: introduce new x_to_tab() helper function
In-Reply-To: <CAPig+cSLb+Rsy81itvw9Tfvqv9vvKSPgO_ER9fWL04XZrgFvwg@mail.gmail.com>
References: <cover.1710646998.git.dsimic@manjaro.org>
 <480b46f2db82ea9c6cd9bbc2423923f81f2d36f5.1710646998.git.dsimic@manjaro.org>
 <CAPig+cSLb+Rsy81itvw9Tfvqv9vvKSPgO_ER9fWL04XZrgFvwg@mail.gmail.com>
Message-ID: <514d832b0399ccdbc354675068477fea@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Eric,

Thanks for responding so quickly.  Please, see my comments below.

On 2024-03-17 05:03, Eric Sunshine wrote:
> On Sat, Mar 16, 2024 at 11:48 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> There's nothing wrong with the already existing q_to_tab() function, 
>> except
>> when it's used on strings that contain uppercase letter "Q" in its 
>> literal
>> meaning, which, for example, can happen with git configurations that 
>> contain
>> "*.*Quoted" as the names of their configuration variables.
>> 
>> Thus, let's introduce new x_to_tab() helper function that does pretty 
>> much
>> the same job as the already existing q_to_tab() helper function, 
>> except for
>> replacing "X" with a horizontal tab (HT), instead of replacing "Q".
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
>> @@ -107,6 +107,10 @@ q_to_tab () {
>> +x_to_tab () {
>> +       tr X '\011'
>> +}
> 
> I'd like to push back on this change since it may lead to an explosion
> of new almost-identical functions. For such a one-off case where
> q_to_tab() isn't appropriate, it's perfectly fine to simply use `tr X
> `\011'` directly in your test:
> 
>     test_expect_success 'foo' '
>         tr X "\011" >expect <<-\EOF
>         some Q stuff
>         whitespaceXhere
>         EOF
>         ...
>     '

Agreed, I'll take this approach in the v3.

> However, if you really insist upon using a library function, then
> either add a general-purpose function which accepts the special
> character as an argument, or just retrofit q_to_tab() to optionally
> accept the special character:
> 
>     # t/test-lib-functions.sh
> 
>     # usage: q_to_tab [<needle-char>]
>     # replace <needle-char> with TAB in stdin
>     q_to_tab () {
>         local c=$1
>         test -n "$c" || c=Q
>         tr "$c" '\011'
>     }
> 
> But this is probably overkill for a one-off case.

As far as I can see after doing a few really quick greps in the "t"
subdirectory, such an approach might actually make sense, but it would
require further work, to make some other already existing tests use
the enhanced q_to_tab() function, and to warrant the whole thing.

That might be an interesting #leftover for someone else to pick it up
at some point.
