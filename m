Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517BAC4BA0B
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 08:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2075B21556
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 08:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVA4AAQn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgBZIYR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:24:17 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32910 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgBZIYR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 03:24:17 -0500
Received: by mail-pf1-f195.google.com with SMTP id n7so1089859pfn.0
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 00:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TJxjHRlNh1xhw+LRWZsk7PSlkJGk4U7qLi7I6l8lT7c=;
        b=XVA4AAQnDJOnoBXPoE8rDXtPV2qJpxTn0ViKHGayWQVN41QZaUOK5v8NtChiGm/Uoi
         7LFcq8lDpiPvPBm1GIn9ORpMYd4t1B7GblKY9T/xeVaTOYpawqPgyzIg1Gx8m9CAO1d1
         d0uW4WHp/XX+7ECCPGtq4OV8q9j51u68fxUbnGexKVRxtN1Hlzln/2xHHPvOXGnqIPkd
         GO0HpYviiO8xGOGRzqfom21sBha6474dgy1ozvsisXFUxvuGdw1pc+N8qjtO4o9XxFid
         F1tnmbBeD0dd6MN74nmVMCfYAFBgKuU0bcfZST2onOJsLkUgpvpXXiU/YQR9QLuWgq3U
         /24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TJxjHRlNh1xhw+LRWZsk7PSlkJGk4U7qLi7I6l8lT7c=;
        b=afJjJfGwZfC7WVfC8tX8ZsJf4s/UQVMzaA3VYC6sF+o2oYTsp2mVsHeUmjJjT3BXkJ
         KXp4CcEC6iEj0l1bJmIDL/O73p8mXYQ8yiRllEU+5iWAaPjwspPfGl75iPzt+ot+OkCz
         PSlCBlqBCMaWh4nsji4FOhCcRjWug58X92wDFl5ip/+CmaObjpwho99KerLqJe+gsFlm
         YrqP1JUz/HjlFzYoCHxgimHwg6cukZ41BIjlfUryezjxnOpwOWBpc/155Np9MKURJSI0
         e7/p/KrMdMmhWAZNuzYd7yw4LcobowWW3qOtB3oBMVOhbZxqBHM/cEeqzBCjquDO4AYN
         xzDw==
X-Gm-Message-State: APjAAAUvdYd9BkTsPECfAQjv+v4+h7c6csexd4Lja0SdNygic34DKwEQ
        ArXoAj0ErR0T9JwbLH8+fimj7ccPDLc=
X-Google-Smtp-Source: APXvYqzXqHFFzbSq5NG6IXinjNzCtf7clDqG4dGIpYZNkW7ipYqGhts0eyVENC48C/++uOsNkGvy8w==
X-Received: by 2002:aa7:9816:: with SMTP id e22mr3163191pfl.229.1582705455648;
        Wed, 26 Feb 2020 00:24:15 -0800 (PST)
Received: from f3 (ag119225.dynamic.ppp.asahi-net.or.jp. [157.107.119.225])
        by smtp.gmail.com with ESMTPSA id m128sm1933658pfm.183.2020.02.26.00.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 00:24:14 -0800 (PST)
Date:   Wed, 26 Feb 2020 17:24:09 +0900
From:   Benjamin Poirier <benjamin.poirier@gmail.com>
To:     Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Jonathan Gilbert <JonathanG@iQmetrix.com>
Subject: Re: [PATCH v7 2/3] git-gui: update status bar to track operations
Message-ID: <20200226082409.GA2270319@f3>
References: <pull.436.v6.git.1574929833.gitgitgadget@gmail.com>
 <pull.436.v7.git.1575167313.gitgitgadget@gmail.com>
 <8fe9dfc30771574344c1a2fc5cd8f21f1a617388.1575167313.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fe9dfc30771574344c1a2fc5cd8f21f1a617388.1575167313.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019/12/01 02:28 +0000, Jonathan Gilbert via GitGitGadget wrote:
> From: Jonathan Gilbert <JonathanG@iQmetrix.com>
> 
> Update the status bar to track updates as individual "operations" that
> can overlap. Update all call sites to interact with the new status bar
> mechanism. Update initialization to explicitly clear status text,
> since otherwise it may persist across future operations.
> 
> Signed-off-by: Jonathan Gilbert <JonathanG@iQmetrix.com>
> ---

Hi Jonathan,

It appears that this change has caused a regression when using git-gui
blame <file> -> right click on a source line -> "Show History Context"

There is an "Application Error" window that appears with the following
details:
can't read "::main_status": no such variable
can't read "::main_status": no such variable
    while executing
"$::main_status  start  [mc "Starting %s... please wait..." "gitk"]"
    (procedure "do_gitk" line 55)
    invoked from within
"do_gitk $cmdline"
    (procedure "blame::_gitkcommit" line 47)
    invoked from within
"blame::_gitkcommit ::blame::__o1::__d"
    invoked from within
".ctxm invoke active"
    ("uplevel" body line 1)
    invoked from within
"uplevel #0 [list $w invoke active]"
    (procedure "tk::MenuInvoke" line 50)
    invoked from within
"tk::MenuInvoke .ctxm 1"
    (command bound to event)

The rest of the functionality seems unaffected but it's pretty annoying
to have to dismiss this message each time.

Can you please look into it?
