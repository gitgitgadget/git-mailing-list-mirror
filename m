Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45ED1E379F
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059559; cv=none; b=hcNGIj0T60urJhUAmg4rQeAx5MfGfky6hNtmtHrh4jwGEg3z1mIxVLejQV0ixKx2EToGUFK95+XzmXC8Y3GlM1RjZv/Vcwahh2fL1Ejp3Px9y/3CHPcx8YMKGuQUFhu9ZPP7u8z/Ni4oyjCU2LiNGo24vk/fcgng2sS6QEolOmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059559; c=relaxed/simple;
	bh=Bokj72L2NKqy1hmDVFLpKdBKaUTmcVzMLa6vmEsvVmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jaVWIqEGhDyOneGksEln+FgOL07VtfzbCfN/O/RZ9Ynovtr3UaO8pG5qBY4FFa/IqrpSwKqXfVWd8ZWbjUc7ZiTBI87i/1DIxOciwBNB8X9H1YPqWEfQKMT4rkQXHEIhPss8QkRX1sjOt9LKZtofUxDuPVn7ebcAErTQPTbVoyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=oOJEk0Kn; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="oOJEk0Kn"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id wlE9sFFmExilewlEAs5T9L; Fri, 04 Oct 2024 17:32:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1728059547; bh=uWpOuKRuW49uIanFEIaAyZTxP0kWPXHS8R2a1/Yhp2E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oOJEk0KnoWk9/7MnHZL1DVtJkIHyvHNjGg6B3e84rm229hlzVP/41sEHR2htglaVR
	 tKmYjU7VvKjUg4a1oTgB5JbxmTWVCpfDnUuGBgx2ct0inKUflMdG3qikS/11QyaRWU
	 HN+fXFzDwpYPdVszSnwug1xQij1EIArRPHTaAllj3xBT5V0c1guCc/OMoeBWqLLyQB
	 EPC8lXyud4uE9jwQkoAvKbAeY/9bzfDeuEFg2akY95aPky8s7eI984GSHdCPrQDeFN
	 qsi9gO0kz3lBKuCgJe49PiS6RfJtLpLSZyh4AeASP13PGzE+N059d4mDEpm5XvKhmA
	 Eri+LwkYSgRAA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=VaJUP0p9 c=1 sm=1 tr=0 ts=6700189b
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=tv7U4_ptFJJ3pCSlPq0A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <7bf0db35-e8a2-4c06-844b-5b3a1af3c4a4@ramsayjones.plus.com>
Date: Fri, 4 Oct 2024 17:32:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] t0610: work around flaky test with concurrent writers
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jeff King <peff@peff.net>,
 Josh Steadmon <steadmon@google.com>
References: <b1b5fb40-f6c2-4621-b58c-9b7c8c64cc01@ramsayjones.plus.com>
 <f3874c7e923846e453499e89f00dd4f8862e4c40.1728055880.git.ps@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <f3874c7e923846e453499e89f00dd4f8862e4c40.1728055880.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGN1mYFjqUmq8UMPQPLORAxM9PIET4MgQCZCfNTpCtX3WoW96UJmm7VZdH4XRkLiTmI8JItjthcUBecTwpzNsa5KTjiheAYHkX890fPGFYE/z3fv81LI
 UnSCdCJc0YPeO4WB3DMPRElsU+PW0J+yRi9i69L+QxDGHc6iVYHjeUdu9qzNAj/KBm4HUTYRpkAPbnwt50ncqm6VoSHbdyNgXYs=

Hi Patrick,

On 04/10/2024 16:32, Patrick Steinhardt wrote:
> In 6241ce2170 (refs/reftable: reload locked stack when preparing
> transaction, 2024-09-24) we have introduced a new test that exercises
> how the reftable backend behaves with many concurrent writers all racing
> with each other. This test was introduced after a couple of fixes in
> this context that should make concurrent writes behave gracefully. As it
> turns out though, Windows systems do not yet handle concurrent writes
> properly, as we've got two reports for Cygwin and MinGW failing in this
> newly added test.
> 
> The root cause of this is how we update the "tables.list" file: when
> writing a new stack of tables we first write the data into a lockfile
> and then rename that file into place. But Windows forbids us from doing
> that rename when the target path is open for reading by another process.
> And as the test races both readers and writers with each other we are
> quite likely to hit this edge case.
> 
> This is not a regression: the logic didn't work before the mentioned
> commit, and after the commit it performs well on Linux and macOS, and
> the situation on Windows should have at least improved a bit. But the
> test shows that we need to put more thought into how to make this work
> properly there.
> 
> Work around the issue by disabling the test on Windows for now. While at
> it, increase the locking timeout to address reported timeouts when using
> either the address or memory sanitizer, which also tend to significantly
> extend the runtime of this test.
> 
> This should be revisited after Git v2.47 is out.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t0610-reftable-basics.sh | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> index 2d951c8ceb..babec7993e 100755
> --- a/t/t0610-reftable-basics.sh
> +++ b/t/t0610-reftable-basics.sh
> @@ -450,15 +450,22 @@ test_expect_success 'ref transaction: retry acquiring tables.list lock' '
>  	)
>  '
>  
> -test_expect_success 'ref transaction: many concurrent writers' '
> +# This test fails most of the time on Windows systems. The root cause is
> +# that Windows does not allow us to rename the "tables.list.lock" file into
> +# place when "tables.list" is open for reading by a concurrent process.
> +test_expect_success !WINDOWS 'ref transaction: many concurrent writers' '
>  	test_when_finished "rm -rf repo" &&
>  	git init repo &&
>  	(
>  		cd repo &&
> -		# Set a high timeout such that a busy CI machine will not abort
> -		# early. 10 seconds should hopefully be ample of time to make
> -		# this non-flaky.
> -		git config set reftable.lockTimeout 10000 &&
> +		# Set a high timeout. While a couple of seconds should be
> +		# plenty, using the address sanitizer will significantly slow
> +		# us down here. So we are aiming way higher than you would ever
> +		# think is necessary just to keep us from flaking. We could
> +		# also lock indefinitely by passing -1, but that could
> +		# potentially block CI jobs indefinitely if there was a bug
> +		# here.
> +		git config set reftable.lockTimeout 300000 &&
>  		test_commit --no-tag initial &&
>  
>  		head=$(git rev-parse HEAD) &&

I did apply this patch and (unsurprising) it now passes just fine! :)

ATB,
Ramsay Jones

