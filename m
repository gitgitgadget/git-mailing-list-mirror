Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1ACDC4338F
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 20:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3D1960EE2
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 20:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhHOUFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Aug 2021 16:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhHOUFK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Aug 2021 16:05:10 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A107C061764
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 13:04:40 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id u15so10307110wmj.1
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 13:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+Gwms26ScgQh/xGSbKtZ53DCEjd3n63/B9O/GG1D5OI=;
        b=X/PVLxlfXfQvog4gQ82pHIpY4me1rqPxQXuUoRLQw2UM7j9l7dQ/YoYB09HLJ2Pm13
         zsDLq++blLslmPUX/+Ae4suph1cSIdv6Dy4oRXMUZl2cVdy7NdxbXRE+qXSUPk5WYW+Z
         V4xFIkTA3yA0q8tFpX/Ebgp6F/ZlD3WMap9fd1j3cxvbA4clCOb7kda9+mJRHLJE9xda
         sXw0J5ECkdVFVvtCMDInOgT1DliSqlLDZScyYDzsesouCQpMzOyDafFgUQ9jbdX3lcrD
         wOjr1QEoJXymB3XnQe7IrKfUUqYncervVOqgPLz8LpBT+SAq7dwPhVzuUQQNAze9yhd9
         /+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+Gwms26ScgQh/xGSbKtZ53DCEjd3n63/B9O/GG1D5OI=;
        b=ttcj0LJt5pyqyE8SE13pVhbVQaEKO/6PsDmR0Uf1q6C3QuwGGqGz2+4sQtAbEco+Gd
         hyaUvJitortgKM2kzR5/ID2SXUofwvwd0LvZpFea2f2gOSrW3zHgS7nzB0fyV/4Qlw7n
         /+ghJCO4ZdI1NDZCiJUmRD9H3KSM4RNGqVxp0NGXPeeQCbj/c7chd/IS2EitTb/qLPSk
         q8UrDF65ogqzLRPDutlJuPZAfGNVs8BLYKPA08CbetgfNF1RPrcXMHeNpoqeRi1kLUNF
         a8eW5KCd+/biEdc9Bo4DVEm6sNibmQ2G/0q8LuHIvYly3VeH5FT5VoEa3NLlfkTjjvVf
         Zfpg==
X-Gm-Message-State: AOAM533hT2dLHV0c5lG+0dUmSIk+xstw+PkIIwx7WWeAB7bJ9vQ6OgpZ
        ls/RwS6ea2FarJtuEFwrUkM=
X-Google-Smtp-Source: ABdhPJx8Ivzu/jlAmwZRbg2xQHueRKtO6vaq7gC4gaJa6X51OATGav3C2MPfchSB4FmUSNb/7xmiAA==
X-Received: by 2002:a1c:27c5:: with SMTP id n188mr11975534wmn.126.1629057878634;
        Sun, 15 Aug 2021 13:04:38 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id u23sm7959439wmc.24.2021.08.15.13.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Aug 2021 13:04:38 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/3] t3403: fix commit authorship
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victor Gambier <vgambier@excilys.com>
References: <pull.1013.git.1628587917.gitgitgadget@gmail.com>
 <7559781ca92096f89a6dcbfeeaa4d2b4d7b98094.1628587917.git.gitgitgadget@gmail.com>
 <CABPp-BFFTLgtrs_m9Gp7tSRwpBnAEoArhMZhhJcuzqNS_g8sUw@mail.gmail.com>
 <xmqq5ywddtsn.fsf@gitster.g> <3b438e42-488c-e4ab-d1fe-3d0992ef0619@gmail.com>
 <nycvar.QRO.7.76.6.2108142350420.59@tvgsbejvaqbjf.bet>
 <xmqqsfzasj80.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <043edd52-c666-0939-bf6d-51b0d225157e@gmail.com>
Date:   Sun, 15 Aug 2021 21:04:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqsfzasj80.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/08/2021 18:36, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>>>> Good point.  The commit tagged with amended-goodbye is later used in
>>>> some tests that ensure the author ident does not change across a
>>>> rebase.  If this commit gets created without authorship customized
>>>> (i.e. before Phillip's fix), we would not catch a possible breakage
>>>> to make rebase discard the original authorship information.
>>>>
>>>> But with this fix, we now can catch such a breakage.
>>>
>>> I'll expand the commit message to make that clear
>>
>> Maybe you could even add a `test another.author@example.com = $(git show
>> -s --format=%ae HEAD)`?
> 
> The version I have from Phillip has updated log message already, but
> not with such a regression prevention.
> 
> The test that the patch under discussion corrects does this:
> 
>      test_expect_success 'correct authorship when committing empty pick' '
>          test_when_finished "git rebase --abort" &&
>          test_must_fail git rebase -i --onto goodbye \
>                  amended-goodbye^ amended-goodbye &&
>          git commit --allow-empty &&
>          git log --pretty=format:"%an <%ae>%n%ad%B" -1 amended-goodbye >expect &&
>          git log --pretty=format:"%an <%ae>%n%ad%B" -1 HEAD >actual &&
>          test_cmp expect actual
>      '

I wonder if it would be better to hard code the author in this test rather
than rather than relying on git log like this

diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
index e26762d0b2..c90e32817f 100755
--- a/t/t3403-rebase-skip.sh
+++ b/t/t3403-rebase-skip.sh
@@ -34,9 +34,10 @@ test_expect_success setup '
         git tag reverted-goodbye &&
         git checkout goodbye &&
         test_tick &&
-       GIT_AUTHOR_NAME="Another Author" \
-               GIT_AUTHOR_EMAIL="another.author@example.com" \
-               git commit --amend --no-edit -m amended-goodbye &&
+       another_author="Another Author <another.author@example.com>" &&
+       git commit --amend --no-edit -m amended-goodbye \
+               --author="$another_author" --date="$GIT_AUTHOR_DATE" &&
+       another_author="$another_author $GIT_AUTHOR_DATE" &&
         test_tick &&
         git tag amended-goodbye &&
  
@@ -110,8 +111,10 @@ test_expect_success 'correct authorship when committing empty pick' '
         test_must_fail git rebase -i --onto goodbye \
                 amended-goodbye^ amended-goodbye &&
         git commit --allow-empty &&
-       git log --pretty=format:"%an <%ae>%n%ad%B" -1 amended-goodbye >expect &&
-       git log --pretty=format:"%an <%ae>%n%ad%B" -1 HEAD >actual &&
+       git log --pretty=format:"$another_author%n%B" -1 amended-goodbye \
+                >expect &&
+       git log --date=raw --pretty=format:"%an <%ae> %ad%n%B" -1 HEAD \
+               >actual &&
         test_cmp expect actual
  '
  
