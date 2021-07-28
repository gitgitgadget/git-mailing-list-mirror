Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286ACC4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 09:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E24360F9C
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 09:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbhG1J4Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 05:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbhG1J4P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 05:56:15 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35959C061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 02:56:13 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m38-20020a05600c3b26b02902161fccabf1so3849229wms.2
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 02:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qHQeiKHBz51Aip4845EZCV4+N1YpH2TpU2s2hQyhjO4=;
        b=nmqrdiUiePz+/Cnmg5FoACzl2Mto6tfR6DAcTweKIDthIhfG1mpCbL60SopU9S32gK
         0/r2U99G4nkISZjZqN4UsUhA5bFzVBiodxxbJGFj/SZeIDBt3FpMTHGFWry3Wm9dEkIi
         yjBNdX5I7JjCt1mg1jHo5QI+acBxuKc0vmbLNxpjKHItOwBYi7ZkMKsBZIO4uGd2Wa6M
         M6kLSS+/p9BfxIRhMl5nB2hh8tpzjf4tqXKaks3T/ldWD8sHXDsxUyNnYSPSl2ntkLLc
         E3e3sOyg298oMWiaGwmBGOvTiJ7LNRMgbtwLeNf21qsW8Ha2K51WiYAs7AWqmHkyb88B
         aISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qHQeiKHBz51Aip4845EZCV4+N1YpH2TpU2s2hQyhjO4=;
        b=U5Fmr6DwLO/d1Nh1zvADfgBdx6YiO22YmigRHmGeIbdkiCUt5/h+3Us+BBk11aT7sE
         spD2HZzX1EM55MpqPtW3t/LvScmD5LZDmWV7zCUWfonKduYocAxY3Frz26rlcD/9qq1O
         LZLGNXQXvz2CxKUWiTOsZaDDE91f/nV0Ojb4rk3pyp0Hcsoekh2PqQuzosfv8QtIL4rX
         mg0NayOgDizsiHZaSFTVTmcfW0c3A+nlsr4Ba2JeKQ39KphkGl7qMG8vKy2LeT3IDySq
         jmPNmzyRbWnahtK2so+bp7kwYERMIELJ7166cQJWd560kCz0o01xP3Skkn4rz1t7u8Tq
         Ytzg==
X-Gm-Message-State: AOAM5308qDbLn3m5BwXemId/PYIF7NZGXK2TpCuRmrKe+0lmrhAsLFoC
        IchOWgqDOmCXRNtINAa+R6U=
X-Google-Smtp-Source: ABdhPJyHUG02Y7tPdoNanIt/lOCAZD/hoHfQRtE1nUrX4nLFzMnHh5yECQM525ItF/97njtrDPgsMg==
X-Received: by 2002:a7b:c1d8:: with SMTP id a24mr6726246wmj.155.1627466170899;
        Wed, 28 Jul 2021 02:56:10 -0700 (PDT)
Received: from [192.168.1.14] (host-2-98-21-22.as13285.net. [2.98.21.22])
        by smtp.gmail.com with ESMTPSA id i186sm1063860wmi.43.2021.07.28.02.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 02:56:10 -0700 (PDT)
Subject: Re: [PATCH v2] [GSOC] cherry-pick: fix bug when used with
 GIT_CHERRY_PICK_HELP
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.1001.git.1626962763373.gitgitgadget@gmail.com>
 <pull.1001.v2.git.1627135281887.gitgitgadget@gmail.com>
 <a8b260be-dae5-e717-d4cb-3ee123f93620@gmail.com> <xmqq1r7jebbf.fsf@gitster.g>
 <xmqqtukfcvzv.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <e5c6d620-6c02-8824-741a-4136081edd02@gmail.com>
Date:   Wed, 28 Jul 2021 10:56:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqtukfcvzv.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/07/2021 22:00, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>
>>> This will break git-rebase--preserve-merges.sh which uses
>>> GIT_CHERRY_PICK_HELP to set the help and ensure CHERRY_PICK_HEAD is
>>> removed when picking commits.
>>
>> Ahh, I didn't realize we still had scripted rebase backends that
>> called cherry-pick as an executable.  I was hoping that all rebase
>> backends by now would be calling into the cherry-pick machinery
>> directly, bypassing cmd_cherry_pick(), and that was why I suggested
>> to catch stray one the end-users set manually in the environment
>> and clear it there.
>>
>>> I'm a bit confused as to what the
>>> problem is - how is 'git cherry-pick' being run with
>>> GIT_CHERRY_PICK_HELP set in the environment outside of a rebase (your
>>> explanation in [1] does not mention how GIT_CHERRY_PICK_HELP is set)?
>>
>> I didn't press for the information too hard, but I guessed that it
>> was perhaps because somebody like stackoverflow suggested to set a
>> message in their environment to get a "better message."
> 
> A good way forward may be to relieve sequencer.c::print_advice() of
> the responsibility of optinally removing CHERRY_PICK_HEAD; make it a
> separate function that bases its decision on a more direct cue, not
> on the presense of a custom message in GIT_CHERRY_PICK_HELP, make
> do_pick_commit(), which is the sole caller of print_advice(), call
> it after calling print_advice().
> 
> I do not offhand know what that "direct cue" should be, but we may
> already have an appropriate field in the replay_opts structure;
> "replay.action is neither REVERT nor PICK" could be a good enough
> approximation, I dunno.
> 
> Otherwise we can allocate a new bit in the structure, have relevant
> callers set it, and teach cherry-pick an unadvertised command line
> option that sets the bit, and use that option only from
> git-rebase--preserve-merges when it makes a call to cherry-pick.
> When "rebase -p" is either retired or rewritten in C, we can retire
> the option from cherry-pick.
>
> Workable?

Most of the time the builtin rebase should not be writing 
CHERRY_PICK_HEAD in the first place (it needs it when a commit becomes 
empty but not otherwise). For 'rebase -p' adding a command line option 
to cherry-pick as you suggest is probably the cleanest solution - in the 
short term 'rebase -i' could set it until we refactor the code that 
creates CHERRY_PICK_HEAD. One thing to note is that I think 
GIT_CHERRY_PICK_HELP was introduced to allow assist scripted rebase like 
porcelains rather than as a way to allow users to customize the help and 
setting it has always removed CHERRY_PICK_HEAD. There are however no 
users of GIT_CHERRY_PICK_HELP on codesearch.debian.org

Best Wishes

Phillip

