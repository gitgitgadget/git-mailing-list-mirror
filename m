Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3929DC433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 00:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17B2920771
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 00:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuApIaSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgHNAXZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 20:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgHNAXX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 20:23:23 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5720C061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 17:23:23 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 74so3666756pfx.13
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 17:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/M8L+Aeyd7EQZXR+TDI6mzvL+J5tcCYPSEjMdqNsVpY=;
        b=PuApIaSgpDEEW6TnIKQBPaUDW1JVlf5UE8DRfJlaqFs/9Q8XCUmmoogeHWKG0VFFBB
         s2xauediNAF//Dol7aYw8GjOHzgIpg/8T60vyeKYBUrSCPzlVm4GOLSCG1Xt54fxuuuh
         UIEsKWNEg4WfCWsDEbKbvSh5B6p+25BnEtIBPKDbGQSg0VCZmEKAHqVUXZRu1L9uK3ce
         HTe98MtritjK6bK1lJ76W17xvd6Q2qswHKOQQCCukWe2ZDRfslY5J/T4p3KLj1gitxud
         KGyiijhvNyX6q/mFIW4RDRtcav54BW/xYq0kOQOhIH22NaO5BjCQv0xtfJda0p97eA7S
         SO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/M8L+Aeyd7EQZXR+TDI6mzvL+J5tcCYPSEjMdqNsVpY=;
        b=mmkScONPnFH1WeT2njPLQ75NAUjIqDi0yivdOmeo+UMbtzwgAgExNE+fWW/Ppx4oG0
         AQcIbUVBRlQwokv9XUwZc3FtkpzIubEJp3eQNjF12HcLhSIOSy3RALKDHBXyQa/2EE3/
         ULUXNknLe6xqDf4U0CUSupkUenTJe8XdbseFy8el6e+YkwBtOk/IQRTRDb/+qJRB69uR
         R7o8maPvoXnu3JQt0cFKveoKqRkjiJP3MjV7qYfB6+dwJFBZlHbl1hgMkAkuAh1WhrIK
         FWBL2RKaoame4eaYCIi80HLFpBdV76mSt+9hr31l59C6vW9YdF4ThiLpaL9ztkyZjQ9C
         yTrw==
X-Gm-Message-State: AOAM5312OCfWZlXQLLS12dYIXrrm3TuDs1mtqq6pzKLhCqzYaJCTJDFx
        owVG1AWGmj9F066IaCPj7e+xv4Oy
X-Google-Smtp-Source: ABdhPJw0X1WDK2je20su9c9TRpjPcwNuCdoplQ5cMJf+wTnrz92Jswm9epFf3NaBx+Oobv5o2nqtPQ==
X-Received: by 2002:a63:385a:: with SMTP id h26mr88817pgn.238.1597364603145;
        Thu, 13 Aug 2020 17:23:23 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:3f71:3e6:8db2:d7ba:5d94])
        by smtp.gmail.com with ESMTPSA id 203sm6435475pge.34.2020.08.13.17.23.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2020 17:23:22 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v3 1/2] revision: differentiate if --no-abbrev asked explicitly
Date:   Fri, 14 Aug 2020 07:23:09 +0700
Message-Id: <9a26c5b6110081cd8d029f2ab0327c4a1d228ef7.1597364493.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.28.0.215.g32ffa52ee0
In-Reply-To: <cover.1597364493.git.congdanhqx@gmail.com>
References: <cover.1596887883.git.congdanhqx@gmail.com> <cover.1597364493.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we see --no-abbrev in command's arguments, we reset the 'abbrev'
field in diff-options to 0 and this value will be looked at
diff_abbrev_oid() to decide not to truncate the object name.

In a later change, we want to extend --abbrev support to diff-patch
format. When --abbrev supporting diff-patch, we need to differentiate
those below scenarios:

* None of those options --abbrev, --no-abbrev, and --full-index are
  asked. diff-patch should keep old behavior of using DEFAULT_ABBREV
  for the index length.
* --no-abbrev is asked, diff-patch should treat this option as same as
  --full-index and show full object name in index line.

While not doing anything is very effective way to show full object id,
we couldn't differentiate if --no-abbrev or not.

We can differentiate those above scenarios by either:
* Add a new field in diff-options to mark if --no-abbrev was asked.
  With this option, we have a new field for a single purpose, and one
  more thing to worry about.
* Treat --no-abbrev as same as --full-index. This option is problematic,
  since we want to allow --abbrev overwrite --no-abbrev again.
  On the other hand, we also need to keep our promises with scripter
  who uses --full-index to ask for full object names in index line,
  so, we need to respsect --full-index regardless of --abbrev.
* Set 'abbrev' field in diff-options to the length of the hash we are
  using. With this option, we can differentiate if --no-abbrev was asked
  ('abbrev' is hash's length) or none of --[no-]abbrev was asked
  ('abbrev' is '0'), script with --full-index still works and our
  headache is kept as is.

Let's ask for full object id if we see --no-abbrev.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 revision.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 3dcf689341..24027b1af3 100644
--- a/revision.c
+++ b/revision.c
@@ -2430,7 +2430,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--always")) {
 		revs->always_show_header = 1;
 	} else if (!strcmp(arg, "--no-abbrev")) {
-		revs->abbrev = 0;
+		revs->abbrev = hexsz;
 	} else if (!strcmp(arg, "--abbrev")) {
 		revs->abbrev = DEFAULT_ABBREV;
 	} else if (skip_prefix(arg, "--abbrev=", &optarg)) {
-- 
2.28.0.215.g32ffa52ee0

