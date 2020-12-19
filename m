Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F84C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 04:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1D512395B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 04:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgLSEYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 23:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgLSEYk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 23:24:40 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D59BC0617B0
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 20:23:57 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id h16so4433331edt.7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 20:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xvrdJq1SR1iISylldrp2rhKEgDPWOwwoVbPICl2Z59o=;
        b=ZwW45kXRlT9dBiBcmu3WZ+rNPPOQN9KEWPJ88din891j0m+sNEwhlZhw7eBuQ5gqwI
         lF/FBuoxokzhv06W5qVLdPmZuZd7CSCyPD5TS9XltmF6TQ30xKtaJTmN7xBr8QaiC2o0
         NQG3RSEVROwKrpoDe3Uikh4HxcwDblm2xhuRbOBb3hiu8OFhI9Xz0clk5jzQiNooP35/
         Zkivt5I9kY23AOp0L4RL/aZdkx/O1qhNnj7qEe2hCYFAJ76A8ARM8PenK3/HJOtB3feP
         tT9CEx9FcNw5pRk7v3cScOf2mKG5HnnrNjgkyDxlD0NtlvG7OHshTfh0WUJT8GFCvQzy
         Km+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xvrdJq1SR1iISylldrp2rhKEgDPWOwwoVbPICl2Z59o=;
        b=cL52+gRjtjzRwjxKuNJ4Lc48Hq0orL8yvV5CmgiqwIjFJQjqezZpeyfgSB/wePl8dx
         qu5sjm4aO22NR6mrnc3YU8m162R+oJ2xBFQj+FNhkLDRWfg045m/ZESFlje4U4Q8HFp0
         1DtXKuST3T5we0C6Vo5KZRRl2C15b0yXi6o2bSNHUD/q01+RB7L2GdmRTeNsZ62ZQJfh
         87Q1RYMZizkPblPkLQ7k9CWiQXkiieZM0oKkqNK8/5oNAH3ofWwkWaZoCVhWtE1saWkm
         nLq3aQ+JegSiply+9qddWUcJzI2rhjqsP/PCZKDc5ub5iC9oEqxvMGPeNZmM4YrnPXUA
         4gKw==
X-Gm-Message-State: AOAM531xcsVV0GSd5hJgBD2h33kMB1Abyg0pP0DIWQyH6Zcf2cxNqEVz
        0KZeAm9AHceZFZrN5D/R0w4OVG7xb8CBmEzaVYXlYlDaZlfIIQ==
X-Google-Smtp-Source: ABdhPJx8jPGMsNA15GuvQfa09lfL8Du68Zi2N7fHzXwLDbAZEP2S6l3JCuaOY6El6nPZmvRKiYlX6koraYpoqKmrWGw=
X-Received: by 2002:a50:a6de:: with SMTP id f30mr7617281edc.30.1608351833629;
 Fri, 18 Dec 2020 20:23:53 -0800 (PST)
MIME-Version: 1.0
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Date:   Fri, 18 Dec 2020 23:23:41 -0500
Message-ID: <CADtb9DyozjgAsdFYL8fFBEWmq7iz4=prZYVUdH9W-J5CKVS4OA@mail.gmail.com>
Subject: [BUG] Regression in 'git mergetool --tool-help'
To:     Git List <git@vger.kernel.org>
Cc:     pudinha <rogi@skylittlesystem.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

It seems that 83bbf9b92e (mergetool--lib: improve support for
vimdiff-style tool variants,
2020-07-29) introduced a regression in the output shown by 'git
mergetool --tool-help'.
Even if I have 'meld', 'kdiff3' and 'xxdiff' installed and in PATH,
they are not shown at all when
the above command is invoked. Only vimdiff, gvimdiff and their *2 and
*3 variants are listed.

The commit above was found by bisecting starting from 2.29.2 knowing
2.26.0 is OK. I can
reproduce the bug on Ubuntu 18 and Ubuntu 14 but not on Ubuntu 20 (all
LTS versions and all
with Git 2.29.2) so maybe something else is also at play here...

Cheers,

Philippe.
