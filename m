Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 431632021B
	for <e@80x24.org>; Tue, 21 Feb 2017 11:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbdBULgb (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 06:36:31 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37166 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbdBULga (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 06:36:30 -0500
Received: by mail-wm0-f45.google.com with SMTP id v77so73068066wmv.0
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 03:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version;
        bh=+w4wycODtluS4jZazAoOnOf6lnMSoM4WXHAB3SltZ1g=;
        b=epNojUjM76PnI6yUdruc8wkTHSy1T5x5z76Y+M0vi2Hjssct9QlMjhdaqvpNaiBTLG
         g8fEbepZ3xg8cyie+FhR+xyXrQXRanB36iy9+OVHeulTxbmtybU3LBhHri2a5LvFEV9l
         Hry4Fj7uOmuvsJkv/EahofoHvAfcHlC+8RGGiBfrpr3PLtNAT4JU3l0WAbAzVvYXu3r0
         l5oT0XcLeBFHHQSrREJQZUJEltYm/ZlbonnXiYrVS1vfvYupS6t53LNtGhGP58RoDMrd
         qUJe8w3IgyuU0V+GOcmZ/BNbbUjflfZOByloIiVm9BiSx+6WBUiOnMeVhY0NAqiw/7tp
         gGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject:date
         :message-id:cc:to:mime-version;
        bh=+w4wycODtluS4jZazAoOnOf6lnMSoM4WXHAB3SltZ1g=;
        b=PUOAdNANU/JZLEt2aPctZ2XtHjHUZa3eYCPqnzhgJjV9NlTHXkwKSSkDf7AhPa2ECk
         xBb89A0dHOJZzlrn8ijuMpZO+noGgCyeYMTx38Z19RLq/FaWdQvx0GYDZ7an/qEKurnD
         /3bt+tPHmTdLLGsgNUmJf2nOuAXvHCgDMMD0vBhvuq9ELsXdfazAkDLQJOQ5EeTSVRyS
         vB6V838IKX+75HqWg46bH6S0T+b+MQs0Po+FTcumKwtzMEINoyrsEqW0UqLocZ5QF3G2
         nUATgt6qu9uBrxF9Il+XaN7n68+D5I+spx6oef20sV5NohvEJ42GpTiwehM+Kkr2E1cy
         upRA==
X-Gm-Message-State: AMke39nUO7ZpdVlCf7iGFosK59FPDieWQ310jbmeSrx82dyAqHe/XcywpoPbQepKzvXEFg==
X-Received: by 10.28.130.207 with SMTP id e198mr24487723wmd.4.1487676988102;
        Tue, 21 Feb 2017 03:36:28 -0800 (PST)
Received: from [10.146.248.58] ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id j18sm28477293wrb.33.2017.02.21.03.36.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Feb 2017 03:36:27 -0800 (PST)
From:   Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [RFC] Subtle differences in passing configs to git clone
Date:   Tue, 21 Feb 2017 12:36:25 +0100
Message-Id: <EC270E42-9431-446C-96F9-E1A0C3E45333@gmail.com>
Cc:     Jeff King <peff@peff.net>
To:     Git List <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I stumbled across the following today:

(1) git -c foo.bar="foobar" clone <URL>

--> uses the config temporarily


(2) git clone -c foo.bar="foobar" <URL>

--> uses the config and writes it to .git/config


This was introduced in 84054f7 ("clone: accept config options on the 
command line") and it makes total sense. However, I think this subtitle
difference can easily confuse users.

I think we should tell the users that we've written to .git/config.
Maybe something like this:

git clone -c foo.bar="foobar" <URL>
Cloning into 'test'...
Writing foo.bar="foobar" to local config...
remote: Counting objects: 2152, done.
remote: Compressing objects: 100% (33/33), done.
remote: Total 2152 (delta 19), reused 0 (delta 0), pack-reused 2119
Receiving objects: 100% (2152/2152), 328.66 KiB | 217.00 KiB/s, done.
Resolving deltas: 100% (1289/1289), done.

What do you think?

Thanks,
Lars
