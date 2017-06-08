Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 884241F8CF
	for <e@80x24.org>; Thu,  8 Jun 2017 11:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751132AbdFHLKm (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 07:10:42 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:33582 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750788AbdFHLKm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 07:10:42 -0400
Received: by mail-io0-f170.google.com with SMTP id b184so18594233ioe.0
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 04:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=dukG6EaZtruJZhfIPQ49pPfaUaRaLNvXnkygYOwe02s=;
        b=dE+hS04xgR1tfZ+FrEL3cx+3oBDLIxlW1mfSbU3KJ7N40NqWyXvrHYj/UtNHfcZf8q
         B0j9wc4mA3EgiK2utvBej+eCF+kvl8wZrPjD5/2t8ogu2QPIhRxsaewMjT5SUg3c9ZhD
         +tS+aRq9XuM+7o6HawCPY26wnAAyjDfLOPkRBKsGdvDhegKH4hKL1z0xxVCMOrAjIc+q
         EJ6JO3V6HzrH8T3t8GPa50VrkfFrkOnczfIJfm+dgt53weK6C6dkB5usSy5jPO070FC/
         UTqahydAwe0HHFTm7YL2c/0/XpvqMtId//7IFu8VjSJPnGhQTpxSMgT++fNjH8P+SVjn
         2VDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dukG6EaZtruJZhfIPQ49pPfaUaRaLNvXnkygYOwe02s=;
        b=TOUYamCAfD4ABuGYyh68Rk9uqUdRMZWwuUgbx3axxgYedzqgdUKOTBJo7JSZyD9TSG
         VLDjxwleIXK2h3FmZHVJLI9MGsTvOfnqUBFCjtlPQBchtj8Aog2HeH9iBEA6JzEMSS0b
         dosgywLbR5x6kxjn8Mflv6B9NqurhMpYkjj7pgs/gAr2agM5vjyUttplmO3i1WdpQy3E
         bGQobAozIAISCjHeiP0/XnendvoP8KEeVYACj3UpBef4XnqlCpT04iQfDpu+eLBlsoJp
         ejIQZOs736qwMZRCuCHskmBjBz/ueZ/8LJNGi92Dipf63Zk0ovFPd3UhFPZAwxB7A5nA
         oMlQ==
X-Gm-Message-State: AKS2vOyXQ5/xhc4Tq9kE4m992C+9t7Dh0NyASqq1kbOFnmao3/PAvbA1
        VtI0oOQtehKEZeWJyTQYDXRsXSKVkiFU+K4=
X-Received: by 10.107.15.88 with SMTP id x85mr11982094ioi.180.1496920241153;
 Thu, 08 Jun 2017 04:10:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.72.66 with HTTP; Thu, 8 Jun 2017 04:10:00 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Thu, 8 Jun 2017 07:10:00 -0400
Message-ID: <CAJZjrdUHm2JAGsjurcGxONQomAtvV_GMgzqb0pPEovHSySd=KA@mail.gmail.com>
Subject: Clarifying behavior of diff --stat
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed when answering a StackOverflow question that apparently
--stat modifies the raw diff itself, instead of just adding a diffstat
to the output. In the linux kernel:

$ git diff-tree --raw -M 00a2430ff07d4e0e0e7e24e02fd8adede333b797
00a2430ff07d4e0e0e7e24e02fd8adede333b797
:040000 040000 f5792c6667c23e113a4f18acfdc5e2c38f5217d7
fb019210ebea7cf439f37d67111797ac7e37cca9 M      drivers

$ git diff-tree --raw --stat -M 00a2430ff07d4e0e0e7e24e02fd8adede333b797
00a2430ff07d4e0e0e7e24e02fd8adede333b797
:100644 100644 c144102ea793541c7e8dad1d42072bb62e71ed4f
a186afeaa7001f3f81abb4f95d9edd3099477867 M
drivers/usb/gadget/Makefile
:000000 100644 0000000000000000000000000000000000000000
6d91f21b52a6301c303aac0a4f62e572d83c02aa A
drivers/usb/gadget/function/Makefile
:100644 100644 ab1065afbbd0c0cac55788dad3b805f9a240b2a9
ab1065afbbd0c0cac55788dad3b805f9a240b2a9 R100
drivers/usb/gadget/f_acm.c      drivers/usb/gadget/function/f_acm.c
:1006
[...]
 drivers/usb/gadget/Makefile                        | 30 +------------------
 drivers/usb/gadget/function/Makefile               | 34 ++++++++++++++++++++++
 drivers/usb/gadget/{ => function}/f_acm.c          |  0
 [...]

Is this intentional? And is there a way to generate a raw version of
the extended stat without using --stat?
