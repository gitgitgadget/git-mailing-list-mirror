Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F76C77B6E
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 07:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239735AbjDGHZZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 03:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237645AbjDGHZS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 03:25:18 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B13A900F
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 00:24:58 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l12so41583484wrm.10
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 00:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680852288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfqQwIohKbbgtpS2B90XM3z2fAUoZYTF196DGcdHY6A=;
        b=Bc/h1CsW0TwYEjDRxsO8JSd5xBs0DFpkiXRse/LBVgnAiw2fXXnm+Ay1Rk0qtv8yr6
         VuyouJKR/4Wl2joxTfC/1tevee/nCTm06wtHb4YHGtYPeTtuPgBPu9qkG8Xp/iMX5n33
         GO90XlIqXN69CPdLIlzXq1ldPBM4UP/1fHZ4caIpI8qcZJ9XpDAvNfmxgIJAqaZzy2Uy
         dRltr5xcDUxiUNcJ+Tnmj3Sk0IitdEQAIZPGHrOUoGxpjDs3yCjfRcf4/018Etb4Hdsx
         fr56wBm6s8DtSByGZYOrQjCABwjkOpR1WPIq1jXi87Tve0pZjQJP9qU2CVIph70evSdT
         jgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680852288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfqQwIohKbbgtpS2B90XM3z2fAUoZYTF196DGcdHY6A=;
        b=UCySXDhNieP9fZqy1jcOCZYzUlWGGPxmGtCW2HqcD5GQ4JS8KH+vmlR+kGkkBkyo2D
         BNTkxYwIei8ob7+3ZuT0J9w8I1K0RJih+lrkmg+K6AAtnCAgvzKZNdd5VebIqFv3Zv2K
         3BlJOyfKhK5gs0GR6WFflh/97p+DjtR44yz3y6UT+8Ox8ok1igzpX5q/HaQWPpAgdK5n
         eO9KxddDned3xU+Js8f+M2k/HeseDB5OkMz0cWmd1UDKupPXFQM008n2GZWgnxXvP+fv
         UW1fZPkOVkPEiT3s6BQbfaVa1UdRxOoU41BKwx9zrLzMxU5+4UwlR9YoKvyzDuBDNjio
         ISlA==
X-Gm-Message-State: AAQBX9c5Lg0CkAdrfy5WT1wxZfuITSu5kFN3E23P4iQ1HwaW70HCsioK
        Q06+ypFwbCnQRoRo/gEkfMlI+S0u59uAFA==
X-Google-Smtp-Source: AKy350YBHCqI2TmBtsIivgKFXWj0Lmb2yqDY2znD8/ddah0MG15R1taBnAAW944CTuip5vVNQZR9UQ==
X-Received: by 2002:adf:ed47:0:b0:2ce:a897:9fd0 with SMTP id u7-20020adfed47000000b002cea8979fd0mr747097wro.6.1680852288117;
        Fri, 07 Apr 2023 00:24:48 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:3f04:7ca0:90e:3fb7:fec2:981])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d6647000000b002da1261aa44sm3782761wrw.48.2023.04.07.00.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 00:24:47 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 08/14] replay: remove HEAD related sanity check
Date:   Fri,  7 Apr 2023 09:24:09 +0200
Message-Id: <20230407072415.1360068-9-christian.couder@gmail.com>
X-Mailer: git-send-email 2.40.0.228.gb2eb5bb98e
In-Reply-To: <20230407072415.1360068-1-christian.couder@gmail.com>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We want replay to be a command that can be used on the server side on
any branch, not just the current one, so we are going to stop updating
HEAD in a future commit.

A "sanity check" that makes sure we are replaying the current branch
doesn't make sense anymore. Let's remove it.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 0a23ea70dc..a331887d12 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -114,7 +114,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	struct commit *onto;
 	const char *onto_name = NULL;
 	struct commit *last_commit = NULL, *last_picked_commit = NULL;
-	struct object_id head;
 	struct lock_file lock = LOCK_INIT;
 	struct strvec rev_walk_args = STRVEC_INIT;
 	struct rev_info revs;
@@ -153,11 +152,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	onto = peel_committish(onto_name);
 	strbuf_addf(&branch_name, "refs/heads/%s", argv[2]);
 
-	/* Sanity check */
-	if (get_oid("HEAD", &head))
-		die(_("Cannot read HEAD"));
-	assert(oideq(&onto->object.oid, &head));
-
 	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
 	if (repo_read_index(the_repository) < 0)
 		BUG("Could not read index");
@@ -232,7 +226,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 			    oid_to_hex(&last_picked_commit->object.oid));
 		if (update_ref(reflog_msg.buf, "HEAD",
 			       &last_commit->object.oid,
-			       &head,
+			       &onto->object.oid,
 			       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
 			error(_("could not update %s"), argv[2]);
 			die("Failed to update %s", argv[2]);
-- 
2.40.0.228.gb2eb5bb98e

