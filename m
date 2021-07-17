Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6BEC636C9
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 19:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CFAD61153
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 19:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbhGQTh0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 15:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbhGQThY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 15:37:24 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2507EC061762
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 12:34:27 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id t4-20020a05683014c4b02904cd671b911bso5509321otq.1
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 12:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=1xTLPhoMjXMsx4T4bZNM0Aq6tjHRX3CvFBXZUxrwzaA=;
        b=iCxFpPjmR+3bzeGiCUgxVsA030jH2yB8E0blldElz3hgsdERhQbiCFyDHISxQ7M91A
         8XBjSD3trHPPWsk6xaUY+3lcY/7+BoVVOxOuVeimRfXdhNWGxP+5iVMIQEXXu4nS2JBH
         JMNs/WzVzHQUnwtTDadRrMZf+M+qEGluB69fRgLbMLxZkCrd5AUHPPC8Jn+yn88Ru6DK
         cPreeZJGLhQmxsZGRUdONqkQOSsQ36V/n3zCeBbWZ7jJRAmKk4DO102Rb4LJHulfByCm
         N8gw+qki+pU/wai/uvByg9hZwU2dOg+klhToMGPLoLSNf//fGW7YrNNswg5bq1ko7kUA
         HSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=1xTLPhoMjXMsx4T4bZNM0Aq6tjHRX3CvFBXZUxrwzaA=;
        b=tYiE8rcXkmsL+o2OySo9u+n1re/HKRkx3iRdEG/I/NzPLJay0SM8gTEhV2xwjtKtwy
         PLUs5KULO+ZP7XbSKsNs+zbNYLeZzwel2su0gro1cXyVeDTXRc9ZS7Bpi/41TMy9uEPv
         tbCFk31qY6US+NoFgUtO7BK5uZDcMkwTD6wdOyYz1T/uLtphIlfKaBKW8QUeXiN3Pas6
         6X3AKul9c8YZ+ikkJECEORGfrXPAlRfKM/4qlnvM45oDDlKa0cfR/vsk4+eqqilg24Ok
         z6uNM5cs4Fy24RX7JwLzrHbFTmjYW3wh6+wsjR94qEfRxWRSQgh2Xj/MveRXi81w3fkA
         4+NA==
X-Gm-Message-State: AOAM532IugDBSQ7u8YvDe0ARU1c1Z2Ete04l3M/T+W7h02AsWD7nI+Ui
        aR+flyM6FmKY0NUuy4+7i6A=
X-Google-Smtp-Source: ABdhPJzAZzrHnnKXGGrqVQyLDRtB5rtuepQij0/yRHxo4txGJXpUmW5sogLaM8SsVGnWka8i9ucU1A==
X-Received: by 2002:a9d:c4a:: with SMTP id 68mr13099096otr.334.1626550466317;
        Sat, 17 Jul 2021 12:34:26 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id s7sm679034ool.14.2021.07.17.12.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 12:34:25 -0700 (PDT)
Date:   Sat, 17 Jul 2021 14:34:24 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>
Message-ID: <60f330c09ee05_25f220867@natae.notmuch>
In-Reply-To: <a0071549-73f6-9636-9279-3f01143a05de@gmail.com>
References: <a0071549-73f6-9636-9279-3f01143a05de@gmail.com>
Subject: RE: Regression in 'git pull --rebase --autostash' since v2.32.0
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Philippe Blain wrote:
> Your recent clean-up of 'git pull --autostash' seems to unfortunately have made things
> worse if the pull brings new files that conflict with existing untracked files,
> which makes the pull abort,
> and there are tracked files with modifications (so --autostash comes into play).
> 
> Before your change, 'git pull --no-rebase --autostash' did *not* apply the autostash
> after the pull failed, thus loosing modifications to tracked files (and it did not save the
> stash entry !). 'git pull --rebase --autostash' correctly applied the autostash, but ended with
> a strange "error: could not detach HEAD".
> 
> After your change, both 'git pull --no-rebase --autostash' and 'git pull --rebase --autostash'
> have the same buggy behaviour: they do not apply the autostash and do not save it in the stash list.
> 
> I had already documented the old behaviour at [1]. Here, I copy my reproducer script
> (save it as "script"):

I cannot reproduce this. In my case the reproducer script never puts
anything in the stash list.

Moreover, this is not an issue of `git pull`, but `git merge`.

I can reproduce the problem that the modifications are lost like this:

  git init test
  (
    cd test
    date >> file
    git add file
    git commit -m 'add file'
    date >> other
    git add other
    git commit -m 'add other'
    git checkout -b topic @~
    date >> other
    date >> file
    git status
    git "$@" master
    git status
    git stash list
  )

Running this with 'rebase --autostash' fails and nothing is put in the
stash list, but the modifications to 'file' remain. I think this is the
correct behavior.

But with 'merge --autostash' the modifications to 'file' are lost. That
is a bug, and it's already present in v2.32.

Do you agree?

-- 
Felipe Contreras
