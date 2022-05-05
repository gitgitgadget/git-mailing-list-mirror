Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCACC433F5
	for <git@archiver.kernel.org>; Thu,  5 May 2022 14:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiEEOfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 10:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380669AbiEEOfs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 10:35:48 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE225A2C4
        for <git@vger.kernel.org>; Thu,  5 May 2022 07:32:08 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v12so6354312wrv.10
        for <git@vger.kernel.org>; Thu, 05 May 2022 07:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uj60SbuHcFqQ1e68BvrA373Pob3CSGAP0qbeeJp/Fkk=;
        b=p9srb242Z29yy0jV5XIv9FokbXzVUGr7L5ub9RZIekYvkOTAmau1qVK1nTRs9++z2p
         B1FKWIR00RCrAhBACV8PhkjasTk8Si2U6MtNDCFRo7WAvGGRlOr4zEbhdy9pf4TpuRDK
         gUgnPd6mKLW4JWFN0lHKu4V85+EWXOlLJdlFyeNmmaio/HRiTEkJiOGwy78jeKUuqq7q
         Belo3jOWuVGhQE21clbz1hesmfsHvZ1x1j2IMPXvafamuvEAEAl+2oANSQVRzoFoqbFi
         2A18g29cuUC2FIAR7uBSowdSVOBXHioZ2Zs171rJyJRbGgCvga76tVRcjoxKjZVva6V7
         s6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uj60SbuHcFqQ1e68BvrA373Pob3CSGAP0qbeeJp/Fkk=;
        b=UAR+TkbMBttt8JnmbXymTh8SnfJNTSlyeGhNu15WcLHYEJitfzyj2gOH+/rdD3SIFN
         XMAjFCq5woCqYLLm3kjb9uRRD+mJaXbCaVgzYHs/8iUoFzsbyJctSn/qH0TmzvZSwR1B
         f9tY8/1nbbWkq7JZYSpJoO9nnDbWkCUA/v+YFiGA2ED4Ea0scFa+tcf+oqpeoCXarURS
         KzERXhHYgEbjei3FHf6eMqyn1RAe/iCYlzNxZdUpK+A1HToXN4SXGLVZtTmsbTCHjcUy
         vVrDg+K1CBh5gardU0WBWbEh7QyS97bjD8LT9dcefIuGe6oq7q33swiV8WAfJQHeds4K
         XMsA==
X-Gm-Message-State: AOAM5302WLsG49vOB7/UjRHTafj0qEcBsZiA5tJRKm1aLxPZXBRUs6pq
        FJU+V+KxcnAod2V/BCqf6m0=
X-Google-Smtp-Source: ABdhPJy96RXsFMo2v3OoiHdaYAJzk2ncd2MMrJe/Sl+e2pNwYXXoGzSVLaYKPL4xwxPqjq9QgizoiQ==
X-Received: by 2002:a5d:60d1:0:b0:20a:e22f:b31a with SMTP id x17-20020a5d60d1000000b0020ae22fb31amr20815346wrt.680.1651761127134;
        Thu, 05 May 2022 07:32:07 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id k21-20020adfb355000000b0020c5253d905sm1692421wrd.81.2022.05.05.07.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 07:32:06 -0700 (PDT)
Message-ID: <c9fc0fc6-c688-022d-9476-aaa87c66d295@gmail.com>
Date:   Thu, 5 May 2022 15:32:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/3] git-compat-util: avoid failing dir ownership
 checks if running privileged
Content-Language: en-GB-large
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, bagasdotme@gmail.com,
        Guy Maurel <guy.j@maurel.de>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
References: <20220428105852.94449-1-carenas@gmail.com>
 <20220503065442.95699-1-carenas@gmail.com>
 <20220503065442.95699-3-carenas@gmail.com>
 <nycvar.QRO.7.76.6.2205051545370.355@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <nycvar.QRO.7.76.6.2205051545370.355@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 05/05/2022 15:01, Johannes Schindelin wrote:
> [...]
>> +
>> +/*
>> + * this helper function overrides a ROOT_UID with the one provided by
>> + * an environment variable, do not use unless the original user is
>> + * root
>> + */
>> +static inline void extract_id_from_env(const char *env, uid_t *id)
>> +{
>> +	const char *real_uid = getenv(env);
>> +
>> +	/* discard any empty values */
>> +	if (real_uid && *real_uid) {
>> +		char *endptr;
>> +		unsigned long env_id;
>> +		int saved_errno = errno;
>> +
>> +		errno = 0;
>> +		env_id = strtoul(real_uid, &endptr, 10);
>> +		if (!errno && !*endptr && env_id <= (uid_t)-1)
> 
> We should not look at `errno` here unless the return value of `strtoul()`
> indicates that there might have been an error (i.e. when it is
> `ULONG_MAX`). >
> Likewise, we need to either initialize `endptr` or only look at it when
> `strtoul()` succeeded.

I don't think we need to do either of those, and indeed the function you 
suggest below does not do them. The standard guarantees that endptr is 
always set and there is no harm in unconditionally checking errno.

> We could side-step all of this, of course, if we simply did this:
> 
> 	euid = getuid();
> 	if (euid == ROOT_UID)
> 		euid = git_env_ulong("SUDO_UID", euid);

That's a nice suggestion, I didn't know that function existed. It means 
we would die() if we could not parse SUDO_UID which I think is 
reasonable (we'd also accept a units suffix an the uid)

Best Wishes

Phillip
