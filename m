Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FC8C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ABA4610A8
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbhEaR0a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbhEaR0T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:26:19 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FA9C0494D7
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:00:43 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id a21so1829355oiw.3
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=TSl32/DUT0FaU1PEWU3X+zuhKED9jmrOLIepCvggGYo=;
        b=C5vDrI+WLB2r5wMl1aRGDugSHHJN806LJs6TYThyVI5fYR6G8yrSgLMwgxGY6G/kws
         hmIxCBU+FktAxie35AIb/G8guv6dFGHXF43lZhjQDSSXytcCaI/cLlc6q5hk981v5dH6
         2kk5x1zCJKDwyR6RQtFiLJ+95WaoRjZDsCWGwtaSHJnFAY/19pmOktNioK7dXKsP4i5U
         h1JE+tmb/q3/G/XSNmjpLr/yfV7PTU4wxEFVefs4B7+pYRUaSVf1wuMOu6LzHPJg5XAP
         ckbY05azJDWDIz85ClF3kZ3zgojZ0z14wY2fonpNUGUQptq/+BFBWYR+XpPy55SI/5ag
         Rsjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=TSl32/DUT0FaU1PEWU3X+zuhKED9jmrOLIepCvggGYo=;
        b=nwbGAvYSriC/NvC7MphdLchZ3zkLy/O/+yVGNK05+K2ldL5mkVceO/ba26W4w5ygjk
         vZ02LaAkd6SBwCyxnin/czNz4fe2HMeTSsVv+YFb41mBN3Os9SkK8HLAt1BXWirO9tVg
         gKHr5BGMSs8n3I6uBVckCLj9rHFN4giXVODXUh2U/QVClOINWVpOXRPCBgaHOTdIxqHD
         8z+qHvy3psB9dlfMao09mxoZNfqU6I5cKD2UCuph6KhN/Uynhy04WDHstjAdRfk9Ktwn
         wDkxsFAKxOfgXUvfx7SSqUmimnSO1gB3akz0vEgqevtK2ytrG9UhEnU2zYO777c1zH3m
         kG+A==
X-Gm-Message-State: AOAM531SYeyB0MfmugIAM6S2g+WnKQehSOEEKkpjPrEAOf5WfsLi1uFs
        woD/6x6ylLz0ZcSQcGY7WSA=
X-Google-Smtp-Source: ABdhPJyf36TNOQgwshfzRlpPXi8fMLuBVkBcKZahTCUVTceOYGo1cXd+LMqLMuriARZofbn8GPzpeg==
X-Received: by 2002:a54:4602:: with SMTP id p2mr14935263oip.3.1622476843252;
        Mon, 31 May 2021 09:00:43 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id r19sm316438otn.37.2021.05.31.09.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 09:00:42 -0700 (PDT)
Date:   Mon, 31 May 2021 11:00:41 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Message-ID: <60b50829553df_24d2820813@natae.notmuch>
In-Reply-To: <f9c1115a-2e17-9d3e-02f5-138eab8048d9@gmail.com>
References: <f9c1115a-2e17-9d3e-02f5-138eab8048d9@gmail.com>
Subject: =?UTF-8?Q?RE:_Slow_fetch_on_repo_with_tags_per_each_commit?=
 =?UTF-8?Q?_=28=C3=A0_la_Vim=29?=
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya wrote:
> I have full clone of Vim repository [1] on my computer. This repo has 
> tags for each commit, meaning that when there is a new commit landed on 
> default (master) branch, it will be tagged (something close to release 
> tags but not same).

I sometimes work on that repo and I just have to say how much of a
pleasure it is to work on a properly maintained repo such as git.git.

My last bisection on vim.git landed on this beauty of a commit:

    Update runtime files

 runtime/autoload/netrw.vim         | 1982 ++++++++++++++++++++++++++++++++++----------------------
 runtime/autoload/netrwSettings.vim |   10 +-
 runtime/doc/eval.txt               |   17 +-
 runtime/doc/filetype.txt           |   12 +-
 runtime/doc/options.txt            |    2 +-
 runtime/doc/pi_netrw.txt           |   94 +--
 runtime/doc/popup.txt              |    8 +-
 runtime/doc/quickfix.txt           |    8 +-
 runtime/doc/quickref.txt           |    3 +-
 runtime/doc/syntax.txt             |    3 +-
 runtime/doc/tags                   |    5 +
 runtime/doc/todo.txt               |   45 +-
 runtime/doc/usr_27.txt             |   14 +-
 runtime/doc/version8.txt           |   24 +-
 runtime/doc/windows.txt            |    4 +-
 runtime/ftplugin/qf.vim            |   10 +-
 runtime/lang/menu_sr_rs.utf-8.vim  |   72 +-
 runtime/optwin.vim                 |    4 +-
 runtime/plugin/netrwPlugin.vim     |   14 +-
 runtime/syntax/lisp.vim            |    8 +-
 runtime/syntax/vim.vim             |   66 +-
 runtime/tutor/README.txt           |    2 +-
 src/po/sr.po                       |  677 ++++++++++---------
 23 files changed, 1797 insertions(+), 1287 deletions(-)

Three years of development of a plugin in a single commit.

That's a yikes.

https://github.com/vim/vim/commit/85850f3a5

-- 
Felipe Contreras
