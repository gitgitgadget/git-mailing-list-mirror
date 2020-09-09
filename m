Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7647C433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 09:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63BA82087C
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 09:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bo6ZZylY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgIIJkI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgIIJkG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 05:40:06 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71438C061573
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 02:40:06 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z4so2206202wrr.4
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 02:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T7+IV0hVkKT7FI4C1Pe372LbEj52eqbfcnoWhjrV1eg=;
        b=bo6ZZylYWcOM0ItGmDIFK94erv7agRV9UVAZHXgV9cgnYOtoMwgD2XfCU882QAaTjp
         hIHlJ/LvRqCdFYUVs4MQCU/2Fhvpps0DkvhfYNFXxfX16ab6C9XzBKD8S3cprpgVDfCr
         qAW1o4vX6ZjIi9075USOtpXbTktosetZ4K8ccbKYN9/hvQqZvxoY64Kj3KN+w1I3rC5m
         liqQ2nhI0+t+xcKp4Hrjtt/GIoJKMB39h+EemRJrXITivJ/rTOaG/Un64IJPRpZTnXYZ
         aUv/zoHBLsG6mWbVO11CvENrT/4okbzdx7kGjRZk1DjT9uoFRIv1PxXqIJc2qmBxXv9m
         27rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T7+IV0hVkKT7FI4C1Pe372LbEj52eqbfcnoWhjrV1eg=;
        b=LK1Wvxdyxtth0YQtmlfsM413A9fTFL0yYjoTbbRNA1e5BaVge/QlS1c03WNHVrR3Sg
         lKdB6XpSFP4KyPR8yrhM0EqGCpY9gSgtr3DWVYuDg38XTZNUArTUAJkX4VzF5OTRfMFx
         GVi3IW3VoScQ/O/Sve9U8yli9QmfoexBPwykYKijdC0RVSn9meRWk1rcgVNPsFV+W1Jk
         p7hzGI9w0T/J0AjqA4Mun4czue1QqRZ0FLDtBMUjxmRezEBqsGpZKduYsv9tRH5wSzPk
         /mzZW4P3upgWwJnEjJ8sZcVD921WfP+Nc6clr3H6Lm7bO8MUAvP0S84Vl+3HPvxRN7gr
         Lc8A==
X-Gm-Message-State: AOAM5309ACQ3FFvFYaPS4bibz9o3L8HjareQerUGNz9surBhHPpI8iGy
        HuGOZbWQCJGVfHkVyb110v/pFEXIvNs=
X-Google-Smtp-Source: ABdhPJxZCW5qoYjEbl2/ZdvCJzHLAoRS9oDY8Qb4LMrc5yPX7JDxeFi+p/64enjqgQ12VIUNauEPmw==
X-Received: by 2002:adf:f88b:: with SMTP id u11mr2812860wrp.376.1599644404936;
        Wed, 09 Sep 2020 02:40:04 -0700 (PDT)
Received: from [192.168.1.201] (151.252.189.80.dyn.plus.net. [80.189.252.151])
        by smtp.googlemail.com with ESMTPSA id p9sm2922686wma.42.2020.09.09.02.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 02:40:04 -0700 (PDT)
Subject: Re: git add intent-to-add then git add patch no longer allows edit
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "Raymond E. Pasco" <ray@ameretat.dev>, phillip.wood@dunelm.org.uk,
        Thomas Sullivan <tom@msbit.com.au>, git@vger.kernel.org
References: <C55J4YTSBL48.171K3FSJLUQOA@ziyou.local>
 <1071d841-a030-30c2-e50e-6d97eb494fea@gmail.com>
 <nycvar.QRO.7.76.6.2009040831570.56@tvgsbejvaqbjf.bet>
 <xmqqd02y7rwj.fsf@gitster.c.googlers.com>
 <a8099cb4-97e0-5596-72a1-10402762015b@gmail.com>
 <xmqqsgbsz22t.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2009082151520.54@tvgsbejvaqbjf.bet>
 <xmqq363sx71g.fsf@gitster.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <b0e42884-0d12-d78d-a34b-d6bc9c69ca5d@gmail.com>
Date:   Wed, 9 Sep 2020 10:40:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqq363sx71g.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/09/2020 23:00, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>>> Like this?  If the more specific one is specifically set, we do not
>>> look at experimental bit, but otherwise we use the built-in version.
>>
>> Looks fine to me,
>> Dscho
> 
> Thanks, with the proposed log message this time...
> 
> -- >8 --
> Subject: [PATCH] add -i: use the built-in version when feature.experimental is set
> 
> We have had parallel implementations of "add -i/-p" since 2.25 and
> have been using them from various codepaths since 2.26 days, but
> never made the built-in version the default.
> 
> We have found and fixed a handful of corner case bugs in the
> built-in version, and it may be a good time to start switching over
> the user base from the scripted version to the built-in version.
> Let's enable the built-in version for those who opt into the
> feature.experimental guinea-pig program to give wider exposure.
> 
> Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/add.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/add.c b/builtin/add.c
> index b36a99eb7c..26b6ced09e 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -192,9 +192,15 @@ int run_add_interactive(const char *revision, const char *patch_mode,
>  	int use_builtin_add_i =
>  		git_env_bool("GIT_TEST_ADD_I_USE_BUILTIN", -1);
>  
> -	if (use_builtin_add_i < 0)
> -		git_config_get_bool("add.interactive.usebuiltin",
> -				    &use_builtin_add_i);
> +	if (use_builtin_add_i < 0) {
> +		int experimental;
> +		if (!git_config_get_bool("add.interactive.usebuiltin",
> +					 &use_builtin_add_i))
> +			; /* ok */
> +		else if (!git_config_get_bool("feature.experimental", &experimental) &&
> +			 experimental)
> +			use_builtin_add_i = 1;
> +	}
>  
>  	if (use_builtin_add_i == 1) {
>  		enum add_p_mode mode;
> 

Looks good to me as well, Thanks

Phillip
