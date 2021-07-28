Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3583C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 16:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C71F960F9B
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 16:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhG1Qwd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 12:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhG1Qwc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 12:52:32 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7C5C061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 09:52:29 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d8so3385383wrm.4
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 09:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0yudGjNk/obmHUIS3haYllymkZc2KMB29Kx0jl8FlJk=;
        b=jMK8L7KJh2k+V1AuVvSjrctKBHpk4mO9FcVh9FFxvQwFO/aar0BbBoff76hWyjgKuW
         RXTJFNWfYuDUdFD/W4kHpfQE2d7KqtaGQdIYq5iIpkxIESS5bp83dLkZXmhmoR4aqC7P
         AmLN/yyr/fDCIZWlTgmVElbX3oxIgOLxt/QYQIfFhTXQsv005KMB1l4XpFnukCgfzE6l
         tnAsZlm7xWyhXSbuguvOeXJJa3hO/U5/bgx0gMTM6+hu2cHZaUvPNfnzfoadChfaMHL5
         GAmQhgpteU7wcE/1YEjymke/xoKqqt6zCJHfI8i9fer/7kUkye93EJwvOvCYhH3YHE90
         P1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0yudGjNk/obmHUIS3haYllymkZc2KMB29Kx0jl8FlJk=;
        b=N66Ae8Us5jsQshqC9+TK2R8vBOhPTo+rZ7+eg6tBBkK++52wrCoGoG2VQFnQRNm78+
         613bBY1x5N/mw6fHM0TJZe+1DgdRMvsXY3gtubX//SfUZTT5F3eMIZVAbFua1vC2Xtmt
         MjUtPog+UGU7pBOHX8U9QVF17gJSizORcQhukG1ONs1rd/dAWhDBDxi7HmAA07REOvmP
         XA+SJfoNWEU8k1OvsRqOEMfQdLguij07bFNT7VDQC3QQz7S3SAfotrgf9UckL11jxBut
         c8l6C3RQUlfkajGcxj4qyNV35kxo1999CJF5P5u58JFJ5mO5qXvxjD9uBOc1XggRgukk
         Ypcw==
X-Gm-Message-State: AOAM531mbi6fsgtd4XdwliQhaWElDjrnCKnYzOfrSPg60rClJTc6XEDJ
        8XJYAKhOaSdv0nCsTgBnzaE=
X-Google-Smtp-Source: ABdhPJyFHmJt46BkFVryIIjq1MyNlxe0vR4e053InhYrKRVCsOPfQakWLtjGbX/F9/QKAGybrsudIQ==
X-Received: by 2002:adf:d20e:: with SMTP id j14mr304959wrh.177.1627491148538;
        Wed, 28 Jul 2021 09:52:28 -0700 (PDT)
Received: from [192.168.1.14] (host-2-98-21-22.as13285.net. [2.98.21.22])
        by smtp.gmail.com with ESMTPSA id q63sm521459wma.46.2021.07.28.09.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 09:52:27 -0700 (PDT)
Subject: Re: [PATCH v2] [GSOC] cherry-pick: fix bug when used with
 GIT_CHERRY_PICK_HELP
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
References: <pull.1001.git.1626962763373.gitgitgadget@gmail.com>
 <pull.1001.v2.git.1627135281887.gitgitgadget@gmail.com>
 <a8b260be-dae5-e717-d4cb-3ee123f93620@gmail.com>
 <CAOLTT8T9Fu4-r5-2PhNmopW751TBN1LRrwBU70HuKZ48JD1X5Q@mail.gmail.com>
 <8893cce8-61a7-3469-0c2e-8f6fe9f1b295@gmail.com>
 <CAOLTT8T-NYEyxabCbSuLkXVKf15LMqf75a0gSR0aGCmeC8dSZw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <3627fd65-54bc-2dd0-85fc-93ced57fc7ac@gmail.com>
Date:   Wed, 28 Jul 2021 17:52:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAOLTT8T-NYEyxabCbSuLkXVKf15LMqf75a0gSR0aGCmeC8dSZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/07/2021 12:01, ZheNing Hu wrote:
> Phillip Wood <phillip.wood123@gmail.com> 于2021年7月28日周三 下午5:46写道：
>>
>> Hi ZheNing
>>
>>> Ah, because I want to find a way to suppress its advice messages about
>>> "git commit",
>>> and I don’t think anyone else is using this "feature".
>>
>> I'd welcome a patch to improve the advice. I suspect the current advice
>> predates the introduction of the '--continue' flag for cherry-pick. I
>> think that would be a better route forward as it would benefit all
>> users. Setting GIT_CHERRY_PICK_HELP is undocumented and has always
>> removed CHERRY_PICK_HEAD since CHERRY_PICK_HEAD was introduced in commit
>> 7e5c0cbf (Introduce CHERRY_PICK_HEAD, 2011-02-19).
>>
> 
> After I modify the interface of print_advice() in the way suggested by
> Junio, I can provide a
> help_msg parameter for print_advice(), and maybe we can use it to
> provide better advice later.

I think that we could change the advice now to suggest using 'git 
cherry-pick --continue' instead of running 'git commit'. I think that in 
the long term we want to move away from being able to customize the 
advice when 'git rebase -p' is retired.

Best Wishes

Phillip

> Something like this:
> 
> +static void print_advice(struct replay_opts *opts, const char *help_msgs)
> +{
> +       if (help_msgs)
> +               fprintf(stderr, "%s\n", help_msgs);
> +       else if (opts->no_commit)
> +               advise(_("after resolving the conflicts, mark the
> corrected paths\n"
> +                        "with 'git add <paths>' or 'git rm <paths>'"));
> +       else
> +               advise(_("after resolving the conflicts, mark the
> corrected paths\n"
> +                        "with 'git add <paths>' or 'git rm <paths>'\n"
> +                        "and commit the result with 'git commit'"));
>   }
> 
>> Best Wishes
>>
>> Phillip
>>
> 
> Thanks.
> --
> ZheNing Hu
> 
