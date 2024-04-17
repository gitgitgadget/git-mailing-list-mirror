Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83C9657C3
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 06:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713336901; cv=none; b=WYGxcR4h1mR6e6bwR4FRXgeVai5yMuAi2eQRvVcDkTRPX2gyrbpCmPCKkGANK63KEa8reodrccOpOjXgxr2ltmyN3iXfa4ORWmK7hpfE7wXc8x4jxLy15mm5RMf9Y9LLrIyNHbKxGo1rdB8G9Bhgj4jQSSch40ZgxEl+qTAx/54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713336901; c=relaxed/simple;
	bh=UStnlM4LnxJWWMt/bX9nP9Ba4zeDrPyX6lXt6hCe3/w=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=uIMxcl0YfTgajCFChOp729nLFnFhq7DBzT+qzoI2vp72hGq4p3vgrNzIxMTbwktzHi1BCfS/sxthyuTQ+4VUlCZQuU2pBdCPQ5AU2OakCnceX3XkxMyaWaUtdLYjc05Tefg8FYNyv2nMWWnDpyCwMXxxQP4ZeXG//R6CsZyFhEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=JeVFGduP; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="JeVFGduP"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713336897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CLjWhUS8xVHE4jtiRNc3e3ZBb4f9f75dQGcqPlPZdcc=;
	b=JeVFGduPazkoZJlpyyqsxDJiuPoOwTFw99EqCqdh9Jc7B7Ro52ravH/mK6HWc0HcvbM5IN
	4NVGrJ20l4YW82oGUZbfixGWpNSg7J1S2oGT+XKS2rdR1gih7nT9fgiCPmt43RSv/Gvsew
	xnvdYGxjisEGnxQLAClMfuDAVTfrQVKhoub5h0mUtXrRULfWgaP+f7fxnicpzwo1iv77Qs
	PZPeIilZzyqulC4jAcV9LASk+6riS5ZOH5358v2hT7XjoYkQ+NX+joXv2h0vmGiL6crDtI
	w8RZweOvrHtbdG/+LCrzMHmwJs9v4Y9Jsl7s1nxBVhLzQ0dOI6CgE/F3sZUZYQ==
Date: Wed, 17 Apr 2024 08:54:57 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] format-patch: fix a bug in option exclusivity and add
 a test to t4014
In-Reply-To: <e4aa5235-c6ad-45c7-930e-de991cc375f2@app.fastmail.com>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <c975f961779b4a7b10c0743b4b8b3ad8c89cb617.1713324598.git.dsimic@manjaro.org>
 <e4aa5235-c6ad-45c7-930e-de991cc375f2@app.fastmail.com>
Message-ID: <78a7b4ab2fe94a45d71c2114a503629c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-17 08:33, Kristoffer Haugsbakk wrote:
> It could be useful to Cc the author of that commit since it’s so
> recent. Like an FYI.

Good point.  Will do that in the v2.

> On Wed, Apr 17, 2024, at 05:32, Dragan Simic wrote:
>> Fix a bug that allows --rfc and -k options to be specified together 
>> when
>> executing "git format-patch".  This bug was introduced back in the 
>> commit
>> e0d7db7423a9 ("format-patch: --rfc honors what --subject-prefix 
>> sets"),
>> about eight months ago, but it has remained undetected so far, 
>> presumably
>> because of no associated test coverage.
> 
> I don’t think speculating on why the bug is still there improves the
> commit message.

Perhaps you're right, but perhaps I'm also right with that speculation. 
:)

> This paragraph could perhaps be rewritten to
> 
>   “ Fix a bug from e0d7db7423a (format-patch: --rfc honors what
>     --subject-prefix sets, 2023-08-30) that allows --rfc and -k options
>     to be specified together when executing "git format-patch".
> 
> The extra sentence in the original doesn’t really explain anything more
> about the commit. Except the “eight months ago”, but here I’ve used the
> “reference” style (not the Linux-style) which contains the date.

I'm fine with that.  Though, I just tried to explain it all in prose,
which may actually be helpful to the people going through the repository
history later.

>> Add a new test to the t4014 that covers the mutual exclusivity of the 
>> --rfc
>> and -k command-line options for "git format-patch", for future 
>> coverage.
> 
> I.e. add a regression test. Pretty standard.

Yes, pretty standard, but again, it obviously wasn't that standard
to the other authors, who missed to include such a test.

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
> 
> I think the code speaks for itself in this case.

Alright, two votes so far, so this comments gets deleted in the v2. :)
I'm perfectly fine with that.

>> +	if (rfc) {
>>  		strbuf_insertstr(&sprefix, 0, "RFC ");
>> +		subject_prefix = 1;
>> +	}
>> 
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
> 
> I don’t understand why you redirect to `patch` if you only check the
> exit code. (I don’t expect any stdout since it will fail.)

You're right, but who knows what might actually happen in the
future, i.e. while someone in the future makes some changes to
the code and runs this test?  It's better to stay on the safe
side and prevent some output from appearing somewhere.

> Although it would be nice with a text comparison or grep on the stderr
> output to make sure that the command died for the expected reason. But 
> I
> haven’t read the associated code.

Yes, it would be nice, and the same thoughts actually already
crossed my mind while working on this patch, but there are already
more similar tests that don't validate such stderr outputs.  Thus,
perhaps it would be better to improve such tests, including this one,
in a separate follow-up series.

>> +'
>> +
>>  test_expect_success '--from=ident notices bogus ident' '
>>  	test_must_fail git format-patch -1 --stdout --from=foo >patch
>>  '
