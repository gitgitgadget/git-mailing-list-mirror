Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 618E11F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 17:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754249AbcHXR5p (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 13:57:45 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34670 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753014AbcHXR5o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 13:57:44 -0400
Received: by mail-pf0-f176.google.com with SMTP id p64so9059406pfb.1
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 10:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/WnCiIARnNKAY7w9JeIkYCJwszngl359+BBJFAIHAqI=;
        b=leEtRE916YIcACCxILcVAr92nxut8s2G8uZz/bcFT0a7ruDs0BaY1AhvrdJEGmM38y
         t/CQArt171aqnzNRBGfXA+P9O1hnSjMwBGD1ruDOwxC7SefYYe5RODgr3dxZd+v6ABfx
         vY4h0BTJBj0zKA3Oj0oeo2xcGN99KCyw6PmWQRq/djtoyEHfiuJbFR4Ot8x6dODDIkd5
         8cXew5EuJ5OZKnad8LsSpe/E6uucsWiSTfVgbtA6sJ4ErSJ4jztDzGsGek2FP4m0Mn0Y
         YWd/jHAxJ5K1rzpc9Q64SwPjlnu0U8RHwp0X5gzax0FsKitWhRfqOEjjp3PcQykhp4SF
         j9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/WnCiIARnNKAY7w9JeIkYCJwszngl359+BBJFAIHAqI=;
        b=YOCmy9eyt1rKaLjzU5qSxiECU1OiUyuboMsYdO8j63iMS0dg+qR0BTMGqqX20Zo1w7
         saj/wFxwaXUM4BE9Vs0MtYQoCfF7UiJR20NSufWRLTggUtq0G69B7NjTRKdub3c4PPK6
         LsS5SmYoqSyDUCX1XP+jdFA4BYa4d95WhXoPhPesxdleA1xXoiLyV+7MjWVUYaF4K2gy
         nQJ2Kh7hCeXiv+HJRRx3VokYFNVAtBQiUIF99YfL4qH+zmhxg+zeHjdKZSxjZXo2OslI
         YAwprEE5uDnjj1rQNZoIiZYuF/AWVOW7+5bIzLFSi9y9uityRC/h7FdkqiSgIRLxmnaG
         1LeQ==
X-Gm-Message-State: AE9vXwNjjXe+kbQfzec+P9Rl4ogZvmhv4HFCuD2s9jtkvjaMvofVxkq0r1UIDwWIotMSN2km
X-Received: by 10.98.10.157 with SMTP id 29mr7891464pfk.62.1472059821747;
        Wed, 24 Aug 2016 10:30:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:69c9:3690:64be:c544])
        by smtp.gmail.com with ESMTPSA id l128sm15112028pfl.21.2016.08.24.10.30.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Aug 2016 10:30:20 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, hvoigt@hvoigt.net, Jens.Lehmann@web.de,
        iveqy@iveqy.com, leandro.lucarella@sociomantic.com,
        gitster@pobox.com, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2] push: change submodule default to check
Date:   Wed, 24 Aug 2016 10:30:17 -0700
Message-Id: <20160824173017.24782-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.0.rc1.1.g1ceb01a
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When working with submodules, it is easy to forget to push the submodules.
The setting 'check', which checks if any existing submodule is present on
at least one remote of the submodule remotes, is designed to prevent this
mistake.

Flipping the default to check for submodules is safer than the current
default of ignoring submodules while pushing.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Slightly reworded commit message than in v1,
(https://public-inbox.org/git/20160817204848.8983-1-sbeller@google.com/)
The patch itself is however the same.

I just push it out now with a new commit message, such that we can easier
pick it up later for Git 3.0, when changes that change default make more sense.

As said in an earlier message, you could however also argue that this is
fixing a bug in your workflow, so it might be worth fixing before 3.0
as well. I dunno.

Thanks,
Stefan

 builtin/push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index 3bb9d6b..479150a 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -22,7 +22,7 @@ static int deleterefs;
 static const char *receivepack;
 static int verbosity;
 static int progress = -1;
-static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+static int recurse_submodules = RECURSE_SUBMODULES_CHECK;
 static enum transport_family family;
 
 static struct push_cas_option cas;
-- 
2.10.0.rc1.1.g1ceb01a

