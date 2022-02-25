Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E3CC433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 11:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240336AbiBYL6U (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 06:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240327AbiBYL6T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 06:58:19 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7F82399F9
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 03:57:43 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id gb39so10423083ejc.1
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 03:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=dic4L/lR78e+zxu8+SSmImTUQxGSmHRmA2CKvi/xFK4=;
        b=luAiOyN8jbmTBQvO29lRF9/aM8wm/law+6UR2Pln+vtj+lfz4fZJpG+HYbgWXjzhBp
         XWbWi1+yBAAIWlVUCT7l0rf7D0Oz7SHeG4ADq1/DMQp2TmlI1/baG3clufRGP3hYcg2f
         0jSEIRL4Le5p9uNbpMBBKnLAN0BAsVbCF80tChBZyNTjdPmXFsuHRsP1ZRqOoNCKzg6l
         kO5AhJz8md6/eWUVVbhUMmiMa4GH/xnGP4Nis8PkTkT9pMsVyoeoa6itMtC4pYfqqoig
         YHA+8HTgfDlQ+RG81DB9WRj2ncdF0HFUudN299FvgQDFdYkRCrh/4sUFUtYOe0L5vIDp
         iCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=dic4L/lR78e+zxu8+SSmImTUQxGSmHRmA2CKvi/xFK4=;
        b=UT4GGzixrIrgp69pC15qW4+JdT+aI9Ru9F8JN2wbJgQiLofPKCCdx7fh1G+BHFKWQV
         J7VSKJpLH2Gb7lfa8v9Cz7ZkfrXeyDeIfLGCEKtwG1+8RMLRLB2FQFudNFjSV46AjI1a
         +mhXz3/yJiKBBVCj0EyNq1R5otFwnU7qWnwImQFM1oSJ+T2CSkC1TFFZ9+JWvduDCaT1
         4Q/YdWnblqK9SDjnhrK0XTSmETjWyZt9zaLVa9YtazZ6s5iLc52u/olobaP6Xcr56QYP
         fyknu7u/8UbN3+rRdYsNg2bCC8gMCl97YR+ENE5JU7URDX/x6wDWYchk75XPddT0VmCG
         BnGA==
X-Gm-Message-State: AOAM533KAJSE2x+ythy63Xrg99KzmZTjXr1J6iKkokYEzlFDfW63Qbi4
        9P8ufXmxmlyAOpMmDNgNwAPNeucGcaOazg==
X-Google-Smtp-Source: ABdhPJzFUhstBTwFdLXvbwRo876VHeBf1+0qps4COl06pNymrN1fwszaKBcA3gAWlUNry7VDM4RaqA==
X-Received: by 2002:a17:906:71cc:b0:6cf:73fe:84e5 with SMTP id i12-20020a17090671cc00b006cf73fe84e5mr5805664ejk.148.1645790261728;
        Fri, 25 Feb 2022 03:57:41 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t2-20020aa7d702000000b0040f6617cc10sm1243716edq.89.2022.02.25.03.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 03:57:41 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nNZEC-000Umt-Nw;
        Fri, 25 Feb 2022 12:57:40 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        pclouds@gmail.com
Subject: Re: [PATCH v2] switch: mention the --detach option when dying due
 to lack of a branch
Date:   Fri, 25 Feb 2022 12:57:01 +0100
References: <20220224064710.2252637-1-alexhenrie24@gmail.com>
 <xmqqv8x4m6jn.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqv8x4m6jn.fsf@gitster.g>
Message-ID: <220225.86h78n88gb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 24 2022, Junio C Hamano wrote:

> Alex Henrie <alexhenrie24@gmail.com> writes:
>> diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
>> index ebb961be29..f54691bac9 100755
>> --- a/t/t2060-switch.sh
>> +++ b/t/t2060-switch.sh
>> @@ -32,6 +32,17 @@ test_expect_success 'switch and detach' '
>>  	test_must_fail git symbolic-ref HEAD
>>  '
>>  
>> +test_expect_success 'suggestion to detach' '
>> +	test_must_fail git switch main^{commit} 2>stderr &&
>> +	test_i18ngrep "try again with the --detach option" stderr
>> +'
>> +
>> +test_expect_success 'suggestion to detach is suppressed with advice.suggestDetachingHead=false' '
>> +	test_config advice.suggestDetachingHead false &&
>> +	test_must_fail git switch main^{commit} 2>stderr &&
>> +	test_i18ngrep ! "try again with the --detach option" stderr
>> +'
>
> OK, we try to be consistent with other tests in the file, and leave
> s/test_i18n// to a file-wide clean-up outside the topic.

FWIW that's not the case here. This is the first use of test_i18ngrep in
this file.

But better to use test_cmp as noted in
<220224.86sfs8abj6.gmgdl@evledraar.gmail.com> in the sid-thread.
