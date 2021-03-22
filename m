Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53936C433E1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 13:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19AB361606
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 13:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhCVNFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 09:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbhCVNDk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 09:03:40 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5776AC061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 06:03:40 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id dc12so7643135qvb.4
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 06:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:references:from:organization:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7JqBU/1X+LWu/Mlvnd0cl48lDuspB0Ckr3rRtGe7yAc=;
        b=l7VySOtku16jRI6n3RtwA/5ANy39f/OtNZmXnMsOM4T4Pq88YsbwcTfuaFMYsMHDlp
         H+2BJAiPioevdVK8Xia/3jJtyU9AR6/dDI7bEUhoptscwQClaIrExIka15Im7HArON5c
         NPJtR/tF26Ieu/3xmBOA+uT4QPXcPXwD93+rAMZnJMIXGKgTb+pd1vt0cnzRSBOQbVz9
         b0LLlzkB9UXc0QJSG0JhDFn2H4QLBdvm39f3KBdWLPourShgUa0p+wlmSHIu9lRVdV8l
         75tBDaWc4IjM8EDTp72byN5jXOceo0YCpMWboI8wlgpUb/vYISK4RVektsbEaI3jkt1l
         Nv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7JqBU/1X+LWu/Mlvnd0cl48lDuspB0Ckr3rRtGe7yAc=;
        b=l269ra8zzU/BfKO2VinGBI6KOgDdEp9MiNEKT2KOieV9q0z2aOtv2OqPRHtarVY37D
         gqriPypdOBIAFP+CVhG1Wn1EjKPvqH3AU/UNct1usz7vPXgJXRirza4SP0Rermmdr5P6
         ywcggZ8mGwUdzzBzKiklrg0CeL5doooYYNbPZDv2wppNahPPE/FfsvxiheDklR9IneHm
         LPWb4+MqwSGUdknok6nWUeWnSrMaQLooFNlZlHsQacZ+EHXU1poVLVb6mDD8LccpL95W
         fluhNvNT78OYWjEFxjcaCIuliCc696iaKRkyCQVF1tfBtW/KpMLTjXUxGawt+PwdkQAa
         jIZw==
X-Gm-Message-State: AOAM532zSi8kii6h3y8vcPhk1Q9PeX1FqY6foMEi9mJLrWCKawUBrGc2
        9nbT9Pk9QA6evTWc7ucftVsQbofGhto=
X-Google-Smtp-Source: ABdhPJwa7d4/zP3zc5Gw52oW7hQHRzPgnVIEl9dR/vQqkcc0syfNbwsBL2ubfItWan5/dQvwmolQuw==
X-Received: by 2002:a05:6214:18d2:: with SMTP id cy18mr21029655qvb.50.1616418219295;
        Mon, 22 Mar 2021 06:03:39 -0700 (PDT)
Received: from mbp.home ([187.33.45.102])
        by smtp.gmail.com with ESMTPSA id 17sm10925226qky.7.2021.03.22.06.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 06:03:38 -0700 (PDT)
Sender: Renato Botelho <garga.bsd@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <4442fd0a-3306-a22b-3614-e3272f8f0be5@FreeBSD.org>
 <YFUX+Rqdj3gteyql@camp.crustytoothpaste.net>
From:   Renato Botelho <garga@FreeBSD.org>
Organization: FreeBSD
Subject: Re: --no-edit not respected after conflict
Message-ID: <78c7bd2c-c487-756e-c85d-dcfe2866f5f4@FreeBSD.org>
Date:   Mon, 22 Mar 2021 10:03:36 -0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YFUX+Rqdj3gteyql@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/03/21 18:30, brian m. carlson wrote:
> On 2021-03-19 at 14:44:30, Renato Botelho wrote:
>> I was reverting multiple commits using --no-edit parameter and after one of
>> those commits conflicted and I resolved using mergetool, no-edit option was
>> not respected anymore and next commits opened editor for me to review commit
>> message.
> 
> I'm not sure I understand what you're seeing here, and I think maybe if
> I knew that I could provide more useful information.  Could you maybe
> provide the set of commands that you're running up to and when you see
> this problem, or even better, a reproduction testcase?
> 

I ran `git revert --no-edit commit1 commit2 ... commitN` and one of 
those reverts had a conflict and the process stopped waiting for a 
resolution.

I ran `git mergetool` and resolved the conflict, then ran `git revert 
--continue` and then it ignored --no-edit parameter for all other 
commits and opened $EDITOR for me to edit commit message.

I managed to reproduce it on a testing repository doing following steps:

% echo a > file
% git init
% git add file
% git commit -m a
% echo b > file; git commit -a -m b
% echo c > file; git commit -a -m c
% echo d > file; git commit -a -m d
% echo e > file; git commit -a -m e
% git log --oneline

d3ec7fc e
23ad2b7 d
2265c82 c
5e0c98a b
b34f81a a

% git revert --no-edit d3ec7fc 2265c82 5e0c98a

It will revert d3ec7fc without any interaction, as expected, then will 
stop the process on 2265c82 due to conflict and after resolve conflict 
when I do:

% git revert --continue

--no-edit parameter will be ignored when reverting 5e0c98a.

-- 
Renato Botelho
