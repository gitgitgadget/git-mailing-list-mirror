Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56D0C2095E
	for <e@80x24.org>; Sat, 25 Mar 2017 18:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbdCYSNE (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 14:13:04 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34111 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751584AbdCYSND (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 14:13:03 -0400
Received: by mail-qk0-f193.google.com with SMTP id v127so2742775qkb.1
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 11:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4bogRbtv479VQzrlb5CIgDdjcuK7xLEuYDqL1Nh+pbY=;
        b=k4vGcd3k1kuj21ljldK0IkjecIbhsPvQUCRofv/EAHRO6BTZAL+LydQTgQ/27B5UE+
         NGUcBiRuFyIbOR5Z4oFkwBx5Ptq7AStgUUzbMep17zVpjYUCjlQ141m7g4qeh+0Kxcgb
         hFQzO+ciu35WpGMPeiZrt1X5E7Z4nGNphn8TsgrHio5lYhJnugH88owg0pXCgmfMRrS5
         SPVMvU2gFaKHVKFkDGVym/53fHY4/8vyg4K+WP8OUItSdlIP/REIJeGMlK+sqoVVMQps
         7lU2v/0uWODHGot87T/4bzxdmRyEow/xevBhoUCDQonqm2TKasAo21KXL8uFGPapQFu5
         GACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4bogRbtv479VQzrlb5CIgDdjcuK7xLEuYDqL1Nh+pbY=;
        b=qAzEhmGS/IwnIsSpAOD4LmWX7TkbxTERl0Biv+QBwQ1JR+X65RlROzDI8w2ekc4BNe
         md5v8CvQUEXw+Fbt5OSL4/EyI9S2ko329R8SwXAJ/qddtp4XADF/4SsUdUAJ88PNjcvP
         Q/cri1E2FaLxN4vzCrPABu8FgGRe1L/Lvc8Q8/0l3DPdKxNqMIoLbjbqT/PFzy1H3zGw
         0U86LyYxJaBbjp8LVBJ9HPXDv1n87A210idMabvzZZb3xrSs8wkNjDp8jzIhJRsNH8Iv
         hvJVBaWjcssXD++9/dTSI3Qxos1lJCyic8wHXyqQ+sK4ls6o0xETZZI8vneu4H1ul336
         iSBw==
X-Gm-Message-State: AFeK/H3PvM3ycHfZ1SODQtPZZvtyZrzdNgLSMCV7yCC78myOehqU1cwKS0jih91ldUs/RQ==
X-Received: by 10.55.184.65 with SMTP id i62mr14232458qkf.234.1490465573403;
        Sat, 25 Mar 2017 11:12:53 -0700 (PDT)
Received: from localhost.localdomain ([189.103.231.223])
        by smtp.gmail.com with ESMTPSA id 141sm4197861qkj.1.2017.03.25.11.12.49
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 25 Mar 2017 11:12:52 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v3 0/2] [GSoC] remove_subtree(): reimplement using iterators
Date:   Sat, 25 Mar 2017 15:12:29 -0300
Message-Id: <1490465551-71056-1-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the third version of the GSoC microproject
of refactoring remove_subtree() from recursively using
readdir() to use dir_iterator. Below are the threads for
other versions:

v1: https://public-inbox.org/git/CAGZ79kZwT-9mHTiOJ5CEjk2wDFkn6+NcogjX0=vjhsAh16ANYg@mail.gmail.com/T/#mae023e7a7d7626f00e0923833c4359f5af493730
v2: https://public-inbox.org/git/CACsJy8Dxh-QPBBLfaFWPAWUsbA9GVXA7x+mXLjEvYKhk1zOpig@mail.gmail.com/T/#t

Duy suggested adding features to dir_iterator might go
beyond the intention of a microproject, but I figured I
might go for it to learn more about the project.

The dir_iterator reimplementation has been tested in a
separate binary I created (and linked with libgit.a) to
reproduce remove_subtree()'s contents. As pointed out in the
last thread, git's tests for this function were unable to
catch a daunting bug I had introduced, and I still haven't
been able to come up with a way to reproduce remove_subtree()
being called. Any help?

Thank you all again for all the reviews.

Daniel Ferreira (2):
  dir_iterator: iterate over dir after its contents
  remove_subtree(): reimplement using iterators

 dir-iterator.c | 100 ++++++++++++++++++++++++++++++++++++++++++++-------------
 dir-iterator.h |   7 ++++
 entry.c        |  32 +++++++-----------
 3 files changed, 95 insertions(+), 44 deletions(-)

--
2.7.4 (Apple Git-66)

