Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA81C433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 21:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3426F2072E
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 21:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMFOzsyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgFJVTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgFJVTk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 17:19:40 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EF8C08C5C1
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 14:19:39 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l10so3914248wrr.10
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 14:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5o3q2tWwhvnrWyifnIX0snl/MPgguWm3X5nLgsAQexI=;
        b=gMFOzsybvw+7PQ0SIca8CCvB45ZEc5tne1reCkQfcnV/Be1y9MGLe2O807lSpTksem
         4DrW4I0EWloztwkXyiDTVdbF69i0Exqz3tXnAQTecGEQcO06wdUb7CnxUpnD45KmE4ly
         61mR0WReU3jEtvlmeYeiVpnCXD4Nfzujwblzl+KSWonYMSpvkQ7u3Sm0drkJK3Y87vCB
         15+SvAcDRilx509Ne3jEod1ayn2XzkV87HL2dvYaVmTzDu9SIvMo7ceK3rXJeB5vHq7w
         C/SBC2oz4qqZf+cT22bnYhe6zMhRu9MsIpWMC5gXdTNJr7/kUT4z+5BCxQkzApQuvBA9
         r7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5o3q2tWwhvnrWyifnIX0snl/MPgguWm3X5nLgsAQexI=;
        b=oaHnCNYJ5CJonwE4Tk53evXWkWKTctcQPFQk6JS5tifHvWDtsB/qhO35dV6wnF2xjt
         4+OGJSeRjvxQPBtWYpmHWCTkAZV31qj6Gwwfoai8pOZjWoDVl5vZjfHOPV2tzZ9L1EGr
         BRyVbCmmV6EbahIozswHieSZyv+9B5YgFOky3DHXQOSEckmzl5LqW+RPgQnBkJqLPoDQ
         GyY6l45PZJ6lNIOMjAW7aUyJNcEhMaysCUgLjGeIEq0MOZ3f/iyI7dyRLRDxuBT2dbo7
         8zpTX542/dDWn8T/MOo9upFytJVRwE9VTlIKowTTVCJcTgyYF0rFgK9qRRWaprQzQE13
         nwlw==
X-Gm-Message-State: AOAM5333w3t6Gm+9515FW6rRNr+1IpV7ZP3hY/XNmHKCAxHOcx6zxJW2
        4WYEtV1d91X4a2w6gPL4WYm2mO8/
X-Google-Smtp-Source: ABdhPJy1q7Juw7Qp+hCmKgme+fOWEmIPL1Ty0E1mQPT7lMBD6BgBocYzVt6jSiI6xzlSE0xg3pAtOw==
X-Received: by 2002:adf:f512:: with SMTP id q18mr6227956wro.38.1591823978294;
        Wed, 10 Jun 2020 14:19:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t8sm1448674wro.56.2020.06.10.14.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 14:19:37 -0700 (PDT)
Message-Id: <cce86c06bbf459ecbfddf21b1417bacc12315e3e.1591823971.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.git.1591823971.gitgitgadget@gmail.com>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Jun 2020 21:19:27 +0000
Subject: [PATCH 6/9] clone: learn about the possibly-configured default branch
 name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When cloning a repository without any branches, Git chooses a default
branch name for the as-yet unborn branch.

Now that we can configure what the default branch name should be, we
will want `git clone` to respect that setting.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/clone.c         | 14 +++++++++++---
 t/t5609-clone-branch.sh |  9 +++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index cb48a291caf..a21d3e99f82 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1263,9 +1263,17 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		remote_head_points_at = NULL;
 		remote_head = NULL;
 		option_no_checkout = 1;
-		if (!option_bare)
-			install_branch_config(0, "master", option_origin,
-					      "refs/heads/master");
+		if (!option_bare) {
+			char *default_branch = git_default_branch_name(0);
+			const char *nick;
+
+			if (!skip_prefix(default_branch, "refs/heads/", &nick))
+				BUG("unexpected default branch '%s'",
+				    default_branch);
+			install_branch_config(0, nick, option_origin,
+					      default_branch);
+			free(default_branch);
+		}
 	}
 
 	write_refspec_config(src_ref_prefix, our_head_points_at,
diff --git a/t/t5609-clone-branch.sh b/t/t5609-clone-branch.sh
index 6e7a7be0522..66af3ac2669 100755
--- a/t/t5609-clone-branch.sh
+++ b/t/t5609-clone-branch.sh
@@ -67,4 +67,13 @@ test_expect_success 'clone -b not allowed with empty repos' '
 	test_must_fail git clone -b branch empty clone-branch-empty
 '
 
+test_expect_success 'chooses correct default branch name' '
+	GIT_TEST_DEFAULT_BRANCH_NAME= \
+		git -c core.defaultBranchName=up clone empty whats-up &&
+	test_write_lines refs/heads/up refs/heads/up >expect &&
+	git -C whats-up symbolic-ref HEAD >actual &&
+	git -C whats-up config branch.up.merge >>actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

