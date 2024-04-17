Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFBE657C3
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 06:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713336986; cv=none; b=EphWimn9gspzBGhuVhytJ4o8nD5nr5K691ZPYwmkvRARlKDOKPKntAkWis4yU4utQE8RF7WxC5DQEN7yPEPD7+7GFbnrJK+stp8+V7tu8U4Yt1qJVzinxZTwsT3nm3Y/vMVK8jSdKTPzSbq+ffZv6l2pIYoxhSp4A65zH55jSrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713336986; c=relaxed/simple;
	bh=VUdQruqzUrdh233H+f2U75q2sACRmltPL1rpsdxtTcQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=s1OEMJmLUV1DqOKyZgYHH6jgqtfSQKm7KEjyrmAWph0YJYeCxCEe6Ej4tGP7DHglX7f2ujAdoHh3lwmsNS8SoLfEn5QpQ8C5u+bmnSaaFoabEN7HqdjEXUdHeL1Wbo05JNrikCf7zPdEeN6DjeHhyiafEQKoxbbsBq7lo7V9x40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=y8gaToXP; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="y8gaToXP"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713336983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T9qXCLnyKbhj9vXM8CsuSczxocutkJ3kbPvdcN6NDqY=;
	b=y8gaToXP3Jnwyt1b4FjUcYxVJOuinhYZaxR2w2UFeDaVypXMl4CPv10oKRwjWKJ5LBngNA
	8Sl7/WfgH3jizWiZ30Kv9+rsFJa6Gq8BbCItRwxacVdg7VUT7Cwn1/DsMeSy3xnwrwySpI
	v/vtbCYLUMZhND8gqzwGM8TDK6XSGcYv69jLdP93ve4l6dI1NnRhobRBwOdn0q8eBxe2/S
	9mFd5sKBWQohGJQHRwdndc8+HEke9oX5VQQ0d/TkDJGoaYkiwRQTaOrBTnlQbLRS/4ziqI
	rU1mzshbOveJ0fFtfTflGQC1M0bb7sCFn/lCizX5gPthntdbvJZQtHkVu2ndRQ==
Date: Wed, 17 Apr 2024 08:56:22 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] format-patch: fix a bug in option exclusivity and add
 a test to t4014
In-Reply-To: <Zh9r1K2_T5wvVJVC@tanuki>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <c975f961779b4a7b10c0743b4b8b3ad8c89cb617.1713324598.git.dsimic@manjaro.org>
 <Zh9r1K2_T5wvVJVC@tanuki>
Message-ID: <47ac35d45693aa5b9fa061e85da6e176@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Patrick,

On 2024-04-17 08:27, Patrick Steinhardt wrote:
> On Wed, Apr 17, 2024 at 05:32:42AM +0200, Dragan Simic wrote:
>> Fix a bug that allows --rfc and -k options to be specified together 
>> when
>> executing "git format-patch".  This bug was introduced back in the 
>> commit
>> e0d7db7423a9 ("format-patch: --rfc honors what --subject-prefix 
>> sets"),
>> about eight months ago, but it has remained undetected so far, 
>> presumably
>> because of no associated test coverage.
>> 
>> Add a new test to the t4014 that covers the mutual exclusivity of the 
>> --rfc
>> and -k command-line options for "git format-patch", for future 
>> coverage.
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>  builtin/log.c           | 5 ++++-
>>  t/t4014-format-patch.sh | 4 ++++
>>  2 files changed, 8 insertions(+), 1 deletion(-)
>> 
>> diff --git a/builtin/log.c b/builtin/log.c
>> index c0a8bb95e983..e5a238f1cf2c 100644
>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -2050,8 +2050,11 @@ int cmd_format_patch(int argc, const char 
>> **argv, const char *prefix)
>>  	if (cover_from_description_arg)
>>  		cover_from_description_mode = 
>> parse_cover_from_description(cover_from_description_arg);
>> 
>> -	if (rfc)
>> +	/* Also mark the subject prefix as modified, for later checks */
>> +	if (rfc) {
>>  		strbuf_insertstr(&sprefix, 0, "RFC ");
>> +		subject_prefix = 1;
>> +	}
> 
> As an alternative fix, can we drop `subject_prefix` and replace it with
> `sprefix.len` instead? It seems to merely be a proxy value for that
> anyway, and if we didn't have that variable then the bug would not have
> been possible to begin with.

Thanks for your feedback!

I'll think about it, and I'll come back a bit later with an update.

>>  	if (reroll_count) {
>>  		strbuf_addf(&sprefix, " v%s", reroll_count);
>> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
>> index e37a1411ee24..e22c4ac34e6e 100755
>> --- a/t/t4014-format-patch.sh
>> +++ b/t/t4014-format-patch.sh
>> @@ -1397,6 +1397,10 @@ test_expect_success '--rfc is argument order 
>> independent' '
>>  	test_cmp expect actual
>>  '
>> 
>> +test_expect_success '--rfc and -k cannot be used together' '
>> +	test_must_fail git format-patch -1 --stdout --rfc -k >patch
>> +'
>> +
>>  test_expect_success '--from=ident notices bogus ident' '
>>  	test_must_fail git format-patch -1 --stdout --from=foo >patch
>>  '
>> 
