Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455DA15A4BB
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 09:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713431550; cv=none; b=k22/xbA6ekI8rXNrIRNuGmo9Ksda2/okLlah0smJ9rGP/KxCDmTafNulBe0ANTldignEjiDtXLneJmzUUTXXtycnY6c5EVqMuVbVd8vTJxNTn9p2yqsq8ICViJe6agaubJStM/i65niHy2AUAFYVfZVyyy7IePBC6j6tpJVHp4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713431550; c=relaxed/simple;
	bh=8d984NX80g8XUXXbXoqeW6XmaW/ffS1SBCi9sXAq+Lo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fZLwMj//5tJsm2iLGqdwo0zfiFTg0LvR1po5zt6IVIy5p7Rm9cwLKm1NlA0qGFAmjcPBDdqbfQpBbi6Pj92jqrDo2Vg5i9RIGJ/BI54TAhpMN2jqSeHH4A1JH26OYUl2xieFhsfq8SygYAleRwJndGD4I7y21xRzwX5hZ3yvR0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=pbUb5cp2; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="pbUb5cp2"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713431546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Og6DdWkMURLktnIpRxdHX39dNl4Z7VyhcRpLcF+mkSk=;
	b=pbUb5cp2EqSJN9ErwKcqao2AAAAHknuRgMacTkqJ5RNn6WV3W0vbj5hPgLkJno/q9JsAM1
	Af5EaZB7+z4f7EMxlT2yoEF4Aoo5N1Vhg3ap3lxJzwDWri0U7tg8pclmHr3/S/z4GqOdEL
	A7YiWdisX0AxdZ5tIfMu/wvhIoGxv0FudanmL1jjh6PuYlsz+ziqY3vsWI/+WlMnhqRcLB
	ZgF7n5zCKbgYf6OLH1MQMV272954BQqMA5G19tHNGSF6KJLPU2rKbEVY6IWkEh6YsPl7qx
	mNO7PCqbHGzmlFSIZR7BKboKHtEJ5xJ/pqDP6TPNvZrThq9u4diienP4zkg/TQ==
Date: Thu, 18 Apr 2024 11:12:26 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] format-patch: fix a bug in option exclusivity and add
 a test to t4014
In-Reply-To: <47ac35d45693aa5b9fa061e85da6e176@manjaro.org>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <c975f961779b4a7b10c0743b4b8b3ad8c89cb617.1713324598.git.dsimic@manjaro.org>
 <Zh9r1K2_T5wvVJVC@tanuki> <47ac35d45693aa5b9fa061e85da6e176@manjaro.org>
Message-ID: <fa2532fdfd57944c7dd915b0ecc9ce15@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Patrick,

On 2024-04-17 08:56, Dragan Simic wrote:
> On 2024-04-17 08:27, Patrick Steinhardt wrote:
>> On Wed, Apr 17, 2024 at 05:32:42AM +0200, Dragan Simic wrote:
>>> Fix a bug that allows --rfc and -k options to be specified together 
>>> when
>>> executing "git format-patch".  This bug was introduced back in the 
>>> commit
>>> e0d7db7423a9 ("format-patch: --rfc honors what --subject-prefix 
>>> sets"),
>>> about eight months ago, but it has remained undetected so far, 
>>> presumably
>>> because of no associated test coverage.
>>> 
>>> Add a new test to the t4014 that covers the mutual exclusivity of the 
>>> --rfc
>>> and -k command-line options for "git format-patch", for future 
>>> coverage.
>>> 
>>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>>> ---
>>>  builtin/log.c           | 5 ++++-
>>>  t/t4014-format-patch.sh | 4 ++++
>>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/builtin/log.c b/builtin/log.c
>>> index c0a8bb95e983..e5a238f1cf2c 100644
>>> --- a/builtin/log.c
>>> +++ b/builtin/log.c
>>> @@ -2050,8 +2050,11 @@ int cmd_format_patch(int argc, const char 
>>> **argv, const char *prefix)
>>>  	if (cover_from_description_arg)
>>>  		cover_from_description_mode = 
>>> parse_cover_from_description(cover_from_description_arg);
>>> 
>>> -	if (rfc)
>>> +	/* Also mark the subject prefix as modified, for later checks */
>>> +	if (rfc) {
>>>  		strbuf_insertstr(&sprefix, 0, "RFC ");
>>> +		subject_prefix = 1;
>>> +	}
>> 
>> As an alternative fix, can we drop `subject_prefix` and replace it 
>> with
>> `sprefix.len` instead? It seems to merely be a proxy value for that
>> anyway, and if we didn't have that variable then the bug would not 
>> have
>> been possible to begin with.
> 
> Thanks for your feedback!
> 
> I'll think about it, and I'll come back a bit later with an update.

Unfortunately, we can't use sprefix.len instead, because it can
still be zero even if the --subject-prefix option was present, more
specifically if we receive --subject-prefix="" on the command line.

The checks that use subject_prefix need to check if --subject-prefix
was specified at all as an option, instead of checking if the actual
subject prefix is of non-zero length.

As you already noted, if sprefix.len was used instead of the separate
subject_prefix variable, the '--rfc -k' bug wouldn't be possible, but
the new '--subject-prefix="" -k' bug would be possible instead.

>>>  	if (reroll_count) {
>>>  		strbuf_addf(&sprefix, " v%s", reroll_count);
>>> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
>>> index e37a1411ee24..e22c4ac34e6e 100755
>>> --- a/t/t4014-format-patch.sh
>>> +++ b/t/t4014-format-patch.sh
>>> @@ -1397,6 +1397,10 @@ test_expect_success '--rfc is argument order 
>>> independent' '
>>>  	test_cmp expect actual
>>>  '
>>> 
>>> +test_expect_success '--rfc and -k cannot be used together' '
>>> +	test_must_fail git format-patch -1 --stdout --rfc -k >patch
>>> +'
>>> +
>>>  test_expect_success '--from=ident notices bogus ident' '
>>>  	test_must_fail git format-patch -1 --stdout --from=foo >patch
>>>  '
