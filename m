Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75347C4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 04:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43DBC61005
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 04:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhFAE50 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 00:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhFAE5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 00:57:25 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E5DC061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 21:55:43 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h12so6207601plf.11
        for <git@vger.kernel.org>; Mon, 31 May 2021 21:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mWFSQV35yuloPu0JcVhC/FAZIKoZwHRdpDcg6YRvcVI=;
        b=sK8jzve6zm++MYNLAJPL4HR4E+jisvROJq1VbpL15NXxoq0XjND4ra98fP1f3sQB8x
         DxRpSeHcdFP5vcTiz+kZRZfhDPA4UDJeftz91Hqn0EnCplO+0eEHA2hcsyZkeNKpabPw
         E507TaqRSBnfbva9mdK1jCVmXY3pHY/fr0tSq02+hVE2nDg0mosr6kOg4rQ1JqbWjQX5
         msAQvnrAkpPlzTOg7DzF05/JwohfFc861dYBruexBZJnhpG0IQ+OAm0fYk1SrQuEdsoi
         cjF55wHqj5+OidSGJeUhKFPoaH7/y4Sp3ysFxyZkq0kAn2tQbXb9bJD0IL5nEY4hyAUH
         OM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mWFSQV35yuloPu0JcVhC/FAZIKoZwHRdpDcg6YRvcVI=;
        b=sIF1wMvI/0/HY0RuS4kRemtyWP7Kn1XJ2wadGCWywpeE/IHw9KpacmgfP7N6x421pC
         IPgx1X1avNk0c8O3i2Wllq8MbS6NhD5Ldco/vesdWHGuL4+35tb55bIyJikG7ssB7Ykp
         7zoi0MglSDsxD/g1fRY95X+FZinxeNIwtLpV4s+U8gwSBuyd6KXyFXz0r0NNEabDV2sd
         qVNBoJ+fum/pPF0LxjLSs2HAlIYRHsx9t8X1rc0gvUv1HolOlyq4ejkMlIw/ualvDZSY
         Xv7igCwhWJ2a0j66m9mjFYhe4dJUUlTbgyVgF4DFwwhwskfuoQ0pMbeRd6RlaAQoeT5/
         TtGA==
X-Gm-Message-State: AOAM532UV2reEvXS7v6aqwcQPsVBgkVLeRqe43r40ChZaf/TEgIzPV2a
        eEplEz9rpCjw20qoRfsSdHQ=
X-Google-Smtp-Source: ABdhPJxaNP05HU6tVTioFuxAD6u98xQqCYbNTUG5Y+vcnzpEeEihkGSpObqWR/6MC3s3gz3Hu4u2rA==
X-Received: by 2002:a17:90a:4205:: with SMTP id o5mr23098478pjg.140.1622523342613;
        Mon, 31 May 2021 21:55:42 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-27.three.co.id. [116.206.28.27])
        by smtp.gmail.com with ESMTPSA id x19sm12500965pgj.66.2021.05.31.21.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 21:55:42 -0700 (PDT)
Subject: Re: [PATCH v3 07/22] t1413: use tar to save and restore entire .git
 directory
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
References: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
 <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
 <f6ab40c4e6599540da38ae5af8e574dc65909e79.1622480197.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <51a802ff-0789-4051-6d45-5b9c6e55ba8a@gmail.com>
Date:   Tue, 1 Jun 2021 11:55:37 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <f6ab40c4e6599540da38ae5af8e574dc65909e79.1622480197.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 31/05/21 23.56, Han-Wen Nienhuys via GitGitGadget wrote:
> diff --git a/t/t1413-reflog-detach.sh b/t/t1413-reflog-detach.sh
> index bde05208ae6a..934688a1ee82 100755
> --- a/t/t1413-reflog-detach.sh
> +++ b/t/t1413-reflog-detach.sh
> @@ -7,8 +7,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>   . ./test-lib.sh
>   
>   reset_state () {
> -	git checkout main &&
> -	cp saved_reflog .git/logs/HEAD
> +	rm -rf .git && "$TAR" xf .git-saved.tar
>   }
>   

Why do you do rm -rf git directory then extract tar archive to reset?

-- 
An old man doll... just what I always wanted! - Clara
