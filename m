Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CA9C433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 564792067C
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fy1mHgJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgHXRmX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgHXRmN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 13:42:13 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA55DC061574
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 10:42:13 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id m8so5202940pfh.3
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 10:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S48FhMYr2jbNjCOT00mWxP4FBV8JzDowh/BFwzkU2ek=;
        b=fy1mHgJ+KCsi8VaIXR7eerKcEXnfJBEUjD4ePPZu/RFA9i+h5NxgKQ4FgVOpIM/73z
         KtojmCPnYDkod3P2nDCMeHm4cI1GeGJB7HZDXMlbj2aCuqD6X3jP0Gl9UL94F2TT39HF
         Qek+n+C7krK41598XHW/jSFdCqCqogypG5n3jZUlHbuHuQ4N+0mCA2C5Wo357BT3X2SG
         v86VDf/cNGnNQ+4yDxyXg9eSaAMo7/VQYKnnxE9DHgJN1jX8LEc+g0HCWrChuHi/kMeY
         MUNn7RC0oQx/m0/f2DzYhbl6DTpB7xSyUZzoEt3fUQCPUR1dJQYT7b9fJdsa6JC8szqZ
         iAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S48FhMYr2jbNjCOT00mWxP4FBV8JzDowh/BFwzkU2ek=;
        b=JiyhS1CwGQdLuCdkVjp/DY6eztH22Gx2WxYmflqsDz8/FO8fvWZ6i9HKPk3T9urDgQ
         kMhvmVkfMpibjPDdcyPGfq4OP2L6mQ9FatN40jbuWPV5NYnq/RNRKSWAb9jVqIN+63hE
         L2Y27fm3lnP+EJNHomoGPeTO2nEgHTAfwklYqltzdjDZqC8XljrgajC7lYx+MORw1Noy
         kgjHUBBld0RKA6RIMqJU7eBubk7del/xQhMHSYFyN1kScbv60tMkZk+VvxGwpN6MM9sy
         NB6EusrGnxv4GX7+1vfazfHD8GP3Imtuv8jd5w1FChjklwWhgacp5HY+b807awigy5Cs
         BJQA==
X-Gm-Message-State: AOAM533OOknIIJtRR68J392zZImHblsyUoGihnhxtH7jOwBpgmsWqaWo
        cuJx4ezGOuUETsTZUbzDBhc=
X-Google-Smtp-Source: ABdhPJx6RgtYXjN+TKhuq/Q2KPP8+6uxJ1GgON+be7vJdo60PeBwMK/VaU2HBAM9nfQr0Z7XAwmPkw==
X-Received: by 2002:a62:7d4c:: with SMTP id y73mr2104075pfc.137.1598290933338;
        Mon, 24 Aug 2020 10:42:13 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id b15sm9773162pgk.14.2020.08.24.10.42.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 10:42:12 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v18 01/10] transport: not report a non-head push as a branch
Date:   Mon, 24 Aug 2020 13:41:53 -0400
Message-Id: <20200824174202.11710-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200815171740.6257-1-worldhello.net@gmail.com>
References: <20200815171740.6257-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

When pushing a new reference (not a head or tag), report it as a new
reference instead of a new branch.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5516-fetch-push.sh | 2 +-
 transport.c           | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 9c6218f568..77938db77f 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1039,7 +1039,7 @@ test_force_fetch_tag "annotated tag" "-f -a -m'tag message'"
 test_expect_success 'push --porcelain' '
 	mk_empty testrepo &&
 	echo >.git/foo  "To testrepo" &&
-	echo >>.git/foo "*	refs/heads/master:refs/remotes/origin/master	[new branch]"  &&
+	echo >>.git/foo "*	refs/heads/master:refs/remotes/origin/master	[new reference]"  &&
 	echo >>.git/foo "Done" &&
 	git push >.git/bar --porcelain  testrepo refs/heads/master:refs/remotes/origin/master &&
 	(
diff --git a/transport.c b/transport.c
index 15f5ba4e8f..26fefd13c1 100644
--- a/transport.c
+++ b/transport.c
@@ -500,9 +500,12 @@ static void print_ok_ref_status(struct ref *ref, int porcelain, int summary_widt
 				 porcelain, summary_width);
 	else if (is_null_oid(&ref->old_oid))
 		print_ref_status('*',
-			(starts_with(ref->name, "refs/tags/") ? "[new tag]" :
-			"[new branch]"),
-			ref, ref->peer_ref, NULL, porcelain, summary_width);
+				 (starts_with(ref->name, "refs/tags/")
+				  ? "[new tag]"
+				  : (starts_with(ref->name, "refs/heads/")
+				     ? "[new branch]"
+				     : "[new reference]")),
+				 ref, ref->peer_ref, NULL, porcelain, summary_width);
 	else {
 		struct strbuf quickref = STRBUF_INIT;
 		char type;
-- 
2.26.2.543.ge7de2a6e37

