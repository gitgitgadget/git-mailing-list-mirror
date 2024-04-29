Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE42E71727
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714413301; cv=none; b=RAkQ2CWVcHBKdCUz19CGmebuLz2UhhPB5En1hXs+kq85m4iIRmZJO0Fr7GKwU15UPdQoJzH8lkttdPuWbocYOz/QqkyeO3U2gXHF5nRFXnxXD+jRYNzCG2pYz8wXKh14qluRIFGAv2Y1uRrysKNH7esFubRA66W3h05BrIfKPRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714413301; c=relaxed/simple;
	bh=XZRQKdR9XULpD3aE3FC1gNuRofVQGoEzaMXqt5PgUtM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=aHirCuTnOP+ecmXUhoRmaIdduC3iBIJWzWVAe14840TpqHE+rRG8+lNL9ZpCc/zJKpBbf7ubFCb2+dtgH9UZFJcZMUb5ndXYgl9U7DuDzQE2fa8eH7c0Rp+x5HYGbitlFji+d8t01sTSbEKcho6Ws+K8b9Dn9YNlO03QgavjRog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=xC+ciRgZ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="xC+ciRgZ"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714413295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vk7mza1QlcUiJ4xDvol9FEMCAKQ2Dm+s8Su1hv1h36s=;
	b=xC+ciRgZNO45I7/E44vk3fy7GF5chnDuDXn2iMR+eM2yHvs5GoWvM4x3WUlkrkKdkTJJBA
	iqC3UghpieOxyu2Yme2sr48tiDfbmvuoCUucpggoC9eY3TRHwhOuZRj5T5Fx21UQ7PnFO5
	gPZeHrh36AV1wqk8E+4djPu5n058akMvXU0JD6YT2yN0tfi8E83xI1E3i5fLYHm/tjXJ+P
	dvbz2WVFS6tXhqHbXha1iSewWasQTo3SxXJUR2lIKMnzADR6UD9bskmV/YZKb3ZSMnEZIB
	Jyj1oO1H7gAHKh8B07fypzUUku/+TLD/NQ1rmszisp+YJWg6GSLJCgubInTnbg==
Date: Mon, 29 Apr 2024 19:54:55 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Cc: James Liu <james@jamesliu.io>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] advice: add --no-advice global option
In-Reply-To: <57b6c818-343a-450a-8183-2802abf1c62f@gmail.com>
References: <20240424035857.84583-1-james@jamesliu.io>
 <20240429010925.93205-1-james@jamesliu.io>
 <20240429010925.93205-2-james@jamesliu.io>
 <57b6c818-343a-450a-8183-2802abf1c62f@gmail.com>
Message-ID: <d2d3e3b6b428e7384b701efba47c5dc1@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org



On 2024-04-29 19:05, Rubén Justo wrote:
> On Mon, Apr 29, 2024 at 11:09:25AM +1000, James Liu wrote:
> 
>>  int advice_enabled(enum advice_type type)
>>  {
>> -	int enabled = advice_setting[type].level != ADVICE_LEVEL_DISABLED;
>> +	int enabled;
>> +
>> +	if (getenv(GIT_NO_ADVICE))
>> +		return 0;
>> +
>> +	enabled = advice_setting[type].level != ADVICE_LEVEL_DISABLED;
>> 
> 
> All hints are set to a default visibility value: "none", which means
> implicitly enabled.  Maybe we can get this "no-advice" knob by making
> this default value configurable:

Please note that the new environment variable isn't supposed
to be used externally, [1] i.e. it isn't meant to be set by
the users in their ~/.bash_profile files (or any other shell
configuration files), so I think that extending the scope of
this patch into such a direction isn't something we should
aim at.

[1] https://lore.kernel.org/git/xmqqh6fk1dmq.fsf@gitster.g/

> diff --git a/advice.c b/advice.c
> index 75111191ad..bc67b99ba7 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -39,6 +39,8 @@ enum advice_level {
>         ADVICE_LEVEL_ENABLED,
>  };
> 
> +static enum advice_level advice_default_level;
> +
>  static struct {
>         const char *key;
>         enum advice_level level;
> @@ -126,7 +128,19 @@ void advise(const char *advice, ...)
> 
>  int advice_enabled(enum advice_type type)
>  {
> -       int enabled = advice_setting[type].level != 
> ADVICE_LEVEL_DISABLED;
> +       static int once = 0;
> +       int enabled;
> +
> +       if (!once++) {
> +               const char* level = getenv("GIT_ADVICE_LEVEL");
> +
> +               if (level && !strcmp(level, "disable"))
> +                       advice_default_level = ADVICE_LEVEL_DISABLED;
> +       }
> +
> +       enabled = (advice_setting[type].level
> +                  ? advice_setting[type].level
> +                  : advice_default_level) != ADVICE_LEVEL_DISABLED;
> 
>         if (type == ADVICE_PUSH_UPDATE_REJECTED)
>                 return enabled &&
