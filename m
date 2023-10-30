Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C8D19BA8
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 18:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="HwEKpre8"
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22C0F3
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 11:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1698690149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCGrp6DGUAEto4G4V1vGrOHwOObmn1rl1HTIOyxCHN4=;
	b=HwEKpre8rbzZUq9GCHow5qBNK8udDISO5KYADbpGbYoFlJkfF4A1gWy95aumpUWTGV/7Mv
	b1gjLsV4HejkMnKGFEDNAPYX0oZEqtEo9XmFhwpsvvMAQ24YWJUqf/z4JRP2uomXuLvd12
	QluDiWHhKldoCGULeidbVLaUna2X0XfJIigICKnaU+mU28LJqnuK5UrBuzVxcUBJ7De0jq
	CGDN1bGF6gf/7rSfKBLYTjsaPFjcFTcK4veg/3eDfX/hk9dlWMzh7nMgiCZgFk/Wmq6Aaa
	Uc+rjXC825pNfzDP3ao7bxubkx9I89GS3vFhMTF01HskI7Ud3GxP+hAzQSnfGA==
Date: Mon, 30 Oct 2023 19:22:23 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Junio C Hamano
 <gitster@pobox.com>, Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [PATCH v3 5/8] ci: unify setup of some environment variables
In-Reply-To: <87430c6c-91c0-4be1-b89d-bf442b3f018b@gmail.com>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698667545.git.ps@pks.im>
 <6af0075fd875f176e7fdf6c219e7117dac5cd71c.1698667545.git.ps@pks.im>
 <87430c6c-91c0-4be1-b89d-bf442b3f018b@gmail.com>
Message-ID: <1365af33315c501db15778bc1ecf3852@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-30 16:09, Phillip Wood wrote:
> On 30/10/2023 12:15, Patrick Steinhardt wrote:
>> Both GitHub Actions and Azue Pipelines set up the environment 
>> variables
>> GIT_TEST_OPTS, GIT_PROVE_OPTS and MAKEFLAGS. And while most values are
>> actually the same, the setup is completely duplicate. With the 
>> upcoming
>> support for GitLab CI this duplication would only extend even further.
>> 
>> Unify the setup of those environment variables so that only the 
>> uncommon
>> parts are separated. While at it, we also perform some additional 
>> small
>> improvements:
>> 
>>      - We use nproc instead of a hardcoded count of jobs for make and
>>        prove. This ensures that the number of concurrent processes 
>> adapts
>>        to the host automatically.
> 
> Sadly this makes the Windows and MacOS jobs fail on GitHub Actions as
> nproc is not installed[1]. Perhaps we could do
> 
> 	--jobs="$(nproc || echo 2)"

It would be better to use the following, to also suppress any error 
messages:

         --jobs=$(nproc 2> /dev/null || echo 2)

Having the quotation marks is also pretty much redundant.

> instead. (Maybe 2 is a bit low but the current value of 10 seems
> pretty high for the number of cores on the runners that we use)
