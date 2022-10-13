Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FF2C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 19:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiJMTSV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 15:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiJMTSU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 15:18:20 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E13310A7FC
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 12:18:20 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id d26so6001286ejc.8
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 12:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P7Kt/ab7orhGL3U8Pn29vaUbVtpEWIUVKpeJyjCdRbY=;
        b=NQAQHq5iMoH+6qKyurSynxGQD6YL9xjlDfkfgphQbmeBQWHBIA5yEifYcoTtzjieN7
         9vUhTFZWfaPwrxzLoP9MBlkB0nEu19w52l5iAON52ynaOglhwuUs2JiafXHUy9QV8tSW
         n/ymj03hiH5RAH0maUGtHmT1zBVIlGS/eWnWxCYKYqLD0DNCwbQrRTnNjmEEQPaY1S2U
         GcrAXA1iWRattQUpJ3EwxVhfmnBlqGHhGyLmI46fadg6KFeoGbh1VUdMo9OKpXFHi52f
         pj246DN37C8pQK2HtJJswpBuU98l6E5r/2BGxTjdu2p1gUxVAlbsL1tZtY2SK2p+MRer
         9/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7Kt/ab7orhGL3U8Pn29vaUbVtpEWIUVKpeJyjCdRbY=;
        b=tvdVzMNNeJmz7fxnlqh+iXtBMcNaCvIM0elFmXgZwpUZe7F+Kwqz0LMeKJTRnhY0Rd
         eIENbqrpfCuzn6guKgRlXzHutkwCQt7KjfN1BRVjJfz8jozJ1zYozm14546ObNWDqSw4
         BjpWs7c8SU/ZDirfqjpGPZ73ggv9nGl0abd3EcjBvxiIaR3BKBeyHWdem6ikOogY5+0r
         vYaJg6pfm5faflaZZGagO4rbX8qVXPi5QYtw/4hc5KhyIEBC7buU3W/7AgBHKW0Nzb0/
         O9E4D8GKx7QpvB+5DxFYCbbncHF+bu+knu4TA8gJi/JBuZSF3tpAO9YEIyTTbyxBv4Q/
         0XPg==
X-Gm-Message-State: ACrzQf36vITOGm8EzfztpMJBsqtCpUUsbVdDWLCLLfIbJqcHmO4OameG
        SyFeg+UnjCgm8PD9ZGoldsdtA77mccXgNw==
X-Google-Smtp-Source: AMsMyM7MdsD/M5kcqjCttgdJNvFXH3DfV5YMGt0aQfLfQAAy+X3K2Ha2vZRCFtOsH6POVWA/mSY5jQ==
X-Received: by 2002:a17:907:97d2:b0:789:5b7b:1a76 with SMTP id js18-20020a17090797d200b007895b7b1a76mr936756ejc.111.1665688698287;
        Thu, 13 Oct 2022 12:18:18 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id jz16-20020a170906bb1000b00787a6adab7csm270936ejb.147.2022.10.13.12.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 12:18:17 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oj3ih-004vzd-02;
        Thu, 13 Oct 2022 21:18:15 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 5/8] rebase: rename merge_base to branch_base
Date:   Thu, 13 Oct 2022 21:16:49 +0200
References: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
 <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
 <00f70c9034452bd87c82fb3aea9658aec32f2ec1.1665650564.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <00f70c9034452bd87c82fb3aea9658aec32f2ec1.1665650564.git.gitgitgadget@gmail.com>
Message-ID: <221013.86bkqfleh5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 13 2022, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> merge_base is not a very descriptive name, the variable always holds
> the merge-base of 'branch' and 'onto' which is commit at the base of
> the branch being rebased so rename it to branch_base.

To me "branch" means or has heavier implications of "named branch" than
just a merge base, and this command is perfectly happy to work on
commits disconnected from any named branch.

But more to the point, the rebase docs for --onto discuss a "merge
base", so you'd read those, and then encounter this code talking about a
"branch base", and wonder what the difference was...
