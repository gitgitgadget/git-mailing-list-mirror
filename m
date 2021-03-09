Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFAAC433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 21:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2B2D65253
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 21:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhCIVOL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 16:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhCIVNw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 16:13:52 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECB1C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 13:13:51 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id f3so16525005oiw.13
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 13:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jKmAE55JNQfn8jwiXMSNsFoWo5UW4ew6fh8ld4wTE/U=;
        b=U/MCdm15aI9Au52XacMOvWp4Eto4OnUUP6cHgeBwnNYAnNKBzc1HIiF00k8JD36bZP
         /uNe7CZe0r9krHOJLob9b+Ia1ZAgyVQhsc6jryVH9yLt69lSbqQAPWTlcPWK+MtPK6Za
         foC6IrqxB9IuhoHEqQR/IZNTwQ/FPFCykNyBNNFjYOp6OfSxoPbgC20qlLA8hv2+F85+
         GHKAVSCIwpNeZGr4WL5VlMSpOPyn82yy615l1D444lfq0r+CvenFvpeEiLsQs3j2ReQp
         jQ3jUuyOaI5T3GgEqWUTiMv/bbeQjC3eXIoVv1WNJDYjyyyCDaplQ/svpWAwvfVB1KE8
         KY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jKmAE55JNQfn8jwiXMSNsFoWo5UW4ew6fh8ld4wTE/U=;
        b=OAVKJlxkDPDMd3EmyTMULRaD4BZ0iR+/mZpOqADoamgaTvrGk3uV9mu04IqNI6YmYj
         QP6rFVKJjo6KpNp1F4BCsBnl6d0qMdwijXWLPdbn3OeeC2EXtzmsHaZN0NTNISE9VGE6
         KVet5YM0L/FalrDx955WA+bacDqGmJJacvaCj4e4ds2dyzLa4UFZR6C88XunBRyddUZF
         kbnfn+cmaFctAjTHjllwPxHxXCb90mneB5AL7Oo7m9H5c6mdZOAcWabN1zuhTXKrIrgv
         xHVoCI4TG4D9O3lcVix951Tn94oQ+SUsP11Su8iH+b+IcrZMSWu3Gv4gAw95NUrA8nfB
         bGjg==
X-Gm-Message-State: AOAM530bVj43j+7Q4t5xWmG+35q2od/ws+P4EBtfC5nUqJYyPAji6dnE
        peC2YHrUwH1MG8kNrXx+HcQ=
X-Google-Smtp-Source: ABdhPJzjciYuuYnptsYIZqzzflISJss6O+wxPavLg2x44vxRqVpzq9SNHrefEVwY85kxOvYt1nV0rg==
X-Received: by 2002:aca:2416:: with SMTP id n22mr57590oic.161.1615324431319;
        Tue, 09 Mar 2021 13:13:51 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:88a7:dd04:71df:86ee? ([2600:1700:e72:80a0:88a7:dd04:71df:86ee])
        by smtp.gmail.com with ESMTPSA id b133sm3307213oia.17.2021.03.09.13.13.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 13:13:50 -0800 (PST)
Subject: Re: [PATCH 11/20] sparse-index: convert from full to sparse
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
 <a2d77c23a0cbbe090b4ed6d840f608cffd4248fd.1614111270.git.gitgitgadget@gmail.com>
 <CABPp-BE70+QVRm0z+Sfpt3V++O2VFkayHySTapFbJyD8VxKyBg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1a99d567-664d-6ce6-89cf-871b04c51674@gmail.com>
Date:   Tue, 9 Mar 2021 16:13:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BE70+QVRm0z+Sfpt3V++O2VFkayHySTapFbJyD8VxKyBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/25/2021 2:33 AM, Elijah Newren wrote:
> On Tue, Feb 23, 2021 at 12:14 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:

>> +                       /*
>> +                        * allow terminating directory separators for
>> +                        * sparse directory enries.
> 
> enries -> entries

Thanks.

>> +                        */
>> +                       if (c == '\0')
>> +                               return S_ISDIR(mode);
> 
> Yaay, much simpler (than the RFC version).

>> +       /*
>> +        * Is the current path outside of the sparse cone?
>> +        * Then check if the region can be replaced by a sparse
>> +        * directory entry (everything is sparse and merged).
>> +        */
>> +       match = path_matches_pattern_list(ct_path, ct_pathlen,
>> +                                         NULL, &dtype, pl, istate);
>> +       if (match != NOT_MATCHED)
>> +               can_convert = 0;
> 
> Not sure if you saw my comments on the flow control at
> https://lore.kernel.org/git/CABPp-BE9wPwmC0=pA4p1_QSRDHrO8RzqfJQdE2NxYZsYL_Rcig@mail.gmail.com/
> (the typos elsewhere seem to still be present).  If you saw it and
> decided against it, that's fine, just wanted the idea to at least be
> floated.

Sorry for dropping this one. I _did_ decide against it, and
primarily because the "if (can_convert)" condition contains
a return statement. I like to use 'gotos' for blocks that
will eventually be entered by all paths through the code,
such as "goto cleanup;" but here I find the "can_convert"
check to be clearer.

>> +               /*
>> +                * Detect if this is a normal entry oustide of any subtree
> 
> s/oustide/outside/

Got it.

>> +test_expect_success 'sparse-index contents' '
>> +       init_repos &&
>> +
>> +       test-tool -C sparse-index read-cache --table >cache &&
>> +       for dir in folder1 folder2 x
>> +       do
>> +               TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
>> +               grep "040000 tree $TREE $dir/" cache \
>> +                       || return 1
>> +       done &&
> 
> Thanks for making the output look more like ls-tree output; it's
> easier to parse that way, at least for me.

Excellent.
 
> I mostly read over the range-diff since it was much shorter.  You've
> addressed a number of questions/comments I had on the RFC version, but
> there's still some I didn't see a response to so I reposted them here.
 
Thanks for being diligent!
-Stolee
