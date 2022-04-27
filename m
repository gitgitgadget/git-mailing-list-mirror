Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338F1C433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 12:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbiD0MeH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 08:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbiD0MeE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 08:34:04 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613C9BE32
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 05:30:53 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u3so2302367wrg.3
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 05:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=jAel2xhFZz6jH5q3g0YqOjv9krvPqlYhWbO9Ld5tunk=;
        b=YbGtMiG8rN9YaFc80TbjyZHlGJ+Umpagpjb/IB3KgwFbF26qEe8mwBXw7AvFS4aocB
         DT6EYeCMWr/+ZkdvQ8UjjdzWc94Nm8iwUjgaeTwVC4x1CU1qX7zqIpAWRO1sMvvvWtpI
         G8n2ipbXcYoRuee7eJbea9C3AGiexx0JhZr4E8mNmWdSnHpof6AKd9INybcHB7Z0ig2c
         l2DKhHKMZoIaRnItnYx+Ilqr9ejtRFzfiFRUde2ZKunX78SSZbKNx8yC6wJLcT968aD7
         KfxIPonBtJKsaZtIRHzc1wgRoC5NRRX56rCi4eN0nUu7bZTkT/0MUs5G+q+trdSg+Qdl
         yoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=jAel2xhFZz6jH5q3g0YqOjv9krvPqlYhWbO9Ld5tunk=;
        b=hQidK8ZTQpgfCOANLIWuTUjr6D4SC3hN5XoPDNdUb2MwPYS6qAnnRU8ZBZcrGPEYIV
         OSFg/cPmVfbA1Z/lYRcFj90Zn1bYLtov7IuLJJRODyh0hGCE+9PxF8WeaYwYnxGRxMme
         re3TA7i5d398ok3X1b880l0MtdieelvfNH2pBgtgHAGBN00r/Pr/1rJDybltUCmqwu+t
         rtxem6490TqQITYtlF8iI3VcpGU/vFpjKUaWLpCZGMglFzhqRSdRgR8J9P0Esf3Y8/Aa
         naz6Cjnvz2oYdP3Tk/vFWz4myUjXcqaBrT7+vbs+GEGdeKBPULxXJutrC/sd1VFWlgYP
         sBJg==
X-Gm-Message-State: AOAM531J74pvgh0hQzMmMa5Tija7WZxuZRSnsZWR4p/ZHrkQ5uGJO5dV
        GFNqEiByICj5JbkUkkZpszY=
X-Google-Smtp-Source: ABdhPJyTQgzhVnAtXhckPXWcrYwkw4H4Avg8h4pylOIgpBIVsoEWUMBnQhnAVi67NS5wwIq65OogKQ==
X-Received: by 2002:adf:fb48:0:b0:203:f986:874a with SMTP id c8-20020adffb48000000b00203f986874amr22079953wrs.614.1651062651890;
        Wed, 27 Apr 2022 05:30:51 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id o6-20020adfca06000000b0020ae96f6ba8sm2927443wrh.65.2022.04.27.05.30.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 05:30:51 -0700 (PDT)
Message-ID: <fcd26e80-daee-2d66-cbdc-b004c478357d@gmail.com>
Date:   Wed, 27 Apr 2022 13:30:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] git-compat-util: avoid failing dir ownership checks if
 running privileged
Content-Language: en-US
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     philipoakley@iee.email, me@ttaylorr.com, guy.j@maurel.de,
        szeder.dev@gmail.com, johannes.Schindelin@gmx.de,
        gitster@pobox.com, derrickstolee@github.com,
        Randall Becker <rsbecker@nexbridge.com>
References: <20220426183105.99779-1-carenas@gmail.com>
 <20220427000522.15637-1-carenas@gmail.com>
 <6522673b-494a-951c-be5e-3ca01577c12b@gmail.com>
In-Reply-To: <6522673b-494a-951c-be5e-3ca01577c12b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/04/2022 10:33, Phillip Wood wrote:
> Hi Carlo
> 
> On 27/04/2022 01:05, Carlo Marcelo Arenas Belón wrote:

> [...]
>> +{
>> +    const char *real_uid = getenv(env);
>> +
>> +    if (real_uid && *real_uid) {
>> +        char *error;
>> +        long extracted_id = strtol(real_uid, &error, 10);
>> +        if (!*error && LONG_MIN < extracted_id &&
>> +                extracted_id < LONG_MAX) {
> 
> strtol() returns a long so the last two checks are redundant. The 
> standard is silent on what happens to error when the value is out of 
> range. The way to check that all the string was consumed without 
> underflow/overflow is
> 
>      errno = 0;
>      val = strtol(str, &endp, 10);
>      if (errno || !*endp)

Sorry that should be "if (errno || *endp)" to check for an error

 > [...]
 >     #if sizeof(uid_t) == sizeof(int)
 >         if (extracted_id > INT_MAX)
 >             error(...)
 >     #endif

I think we should probably check if uid_t is a short integer as well as

 > +#ifdef __TANDEM
 > +#define ROOT_UID 65535

suggests it may be an unsigned short on NonStop.

Not knowing the size of uid_t or if it is signed or not (as far as I can 
tell posix just says it's an integer) makes the limit checks tricky - 
maybe we make euid a long (or unsigned long) here and it the function 
below rather than casting it to uid_t and possibly truncating it.

 > [...]
>> +
>>   static inline int is_path_owned_by_current_uid(const char *path)
>>   {
>>       struct stat st;
>> +    uid_t euid;
>> +
>>       if (lstat(path, &st))
>>           return 0;
>> -    return st.st_uid == geteuid();
>> +
>> +    euid = geteuid();
>> +    if (euid == ROOT_UID) {
>> +        /* we might have raised our privileges with sudo */
>> +        extract_id_from_env("SUDO_UID", &euid);

You are ignoring any errors when parsing the environment variable - that 
is not a good idea in a security check.

Best Wishes

Phillip

>> +    }
>> +    return st.st_uid == euid;
>>   }
>>   #define is_path_owned_by_current_user is_path_owned_by_current_uid
> 

