Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1E4CA90AF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 08:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F3C020740
	for <git@archiver.kernel.org>; Wed, 13 May 2020 08:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4VMPfP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732398AbgEMIsK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 04:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732382AbgEMIsK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 04:48:10 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEB4C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 01:48:09 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id h26so12929112lfg.6
        for <git@vger.kernel.org>; Wed, 13 May 2020 01:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Y8afBzhWbnUt1fTGL5iQ22TO9j7Mt8sfs6oIUBktgKo=;
        b=p4VMPfP/lzTSRBAvFG4Sx14bY26WhhcJyB+6a4FH6uN8YBlIaS7iC/91DTuU4ZIeJI
         loBLK1MxvCugKVuB7TXDAGSHJtaWgLMiDhD/BOaCaj5SW++JartMB506gf/o4D5EIGA2
         p1LzBeR61vwrrM2TUJgD8ZIUzv8GB9UmHKQwyYhpPll9bEDn3yN/rrt6c4PXxs7Fwfft
         J+HTcj/JEIj0kgqsXYavgStu3oktj+Pf2oInttIUdPdzUZCL5atJFjj9diXKx7gOJOnS
         VRZaiX9j94GtiRPwoqKwa+IjuJ+HNV8hR5ecCfknk6q++/baC5F0Dwh4YkCsFB0iQAGT
         k/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Y8afBzhWbnUt1fTGL5iQ22TO9j7Mt8sfs6oIUBktgKo=;
        b=WzO6ce9FUJSJlGpBj0hS43EykKXrRy9UQjc6VyrWdIHM4sShA8a1/nVdNjMXitXGRX
         UpTRgn+nStaw0e2YLiDD1XrixvrpKv/aoxYDTcxIFLK0LML12xdH3yddi0kHA2oapkJt
         Ly/l3oIk0M+WBdDehHjMV+ElpQojWbE6rjmX3T7Bu5G5UYIyL7KRChiSHga1O1qtVzFj
         ty5gEJlNOebNYaUjwpMAM9MNbj4Rx+FUM0rRa+iGlT8PeGlkGLpdYpW0JSrOjtuDEWr5
         7Y/tSdp5IX/gPL19k1NeIMiLLzE72OIVTE2ee0GvxaqFDKddTeczazyCdabeUXJKf1Nx
         bSLg==
X-Gm-Message-State: AOAM530n8N17eWuTUrvXEKoXAOkiBKcOG6vtwVeWxq0vVkGnHSLXgRdR
        BzeJ2Q4sX5iB4IXOreVFtHTa8eqS6c4h7ezxD8rtHu2o
X-Google-Smtp-Source: ABdhPJzDyYrcJb1hWOq/4K2AeobmDTbFMwWi+8N6RjrKaUVBYWcfaXCxnqDu6eQsFHwcOD9asJpozyXRVIcyAmb5KyI=
X-Received: by 2002:a19:cc07:: with SMTP id c7mr17406242lfg.163.1589359688054;
 Wed, 13 May 2020 01:48:08 -0700 (PDT)
MIME-Version: 1.0
From:   Chunlin Zhang <zhangchunlin@gmail.com>
Date:   Wed, 13 May 2020 16:47:56 +0800
Message-ID: <CAG2rzA=c8bGD6A_8kKCdz+UABjed9W6mSJYjLhYckbsXiFe4CQ@mail.gmail.com>
Subject: bugreport: Wrong binary file content after cherry-pick
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git version: after v2.21.0 can reproduce this bug

reproduce steps:
git clone https://github.com/zhangchunlin/gitbug
cd gitbug
git cherry-pick dev

Then there will be a conflict with the cherry-pick, but if you run
"md5sum *", will get:
6f96c8bc9e3df2f6fef1ecbb09f218f6
ICS_usc_any_any_9.1.5_8871.uscc_261_130664_2048-release.apk
6f96c8bc9e3df2f6fef1ecbb09f218f6
ICS_usc_any_any_9.8.0_b2cbd84d94.b2cbd84_297_131010_2048-release.apk

The second file get a wrong file content.
3 related files md5:
6f96c8bc9e3df2f6fef1ecbb09f218f6
ICS_usc_any_any_9.1.5_8871.uscc_261_130664_2048-release.apk
d1bdd852b32c09ec93a5494afb3c67e7
ICS_usc_any_any_9.1.5_8871.uscc_266_130703_2048-release.apk
b2c50a9d7d488aa0b62ec7e68706ea85
ICS_usc_any_any_9.8.0_b2cbd84d94.b2cbd84_297_131010_2048-release.apk

I use git bisect to found the commit which cause this problem:
https://github.com/git/git/commit/48c9cb9d6d058bcf18e931a1ed0d88792bb506c9
