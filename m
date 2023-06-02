Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1556BC7EE29
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 10:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbjFBK3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 06:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbjFBK2G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 06:28:06 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344BE10CC
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 03:26:30 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f3edc05aa5so2432374e87.3
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 03:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685701563; x=1688293563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLH08/1Jj31YQZ3K0A+NRzZLpvhxie+bpVAPrS6fHA8=;
        b=gpe7AZ/VA+YZyWhhRCzoXa9E4+JvrIZAi+n5xofJupgFMFJ/aFTgCNvbmp9YRV9Cqk
         O4FIrh8/qvUaBDCqX6+Q2xieyQ2G7nh9wMpzVmhGY79Y1+/G2n8R3KXYgcp1QoD2G359
         jAXe2drLF0VaFb4xFOmfo+Xk9bw2Mg8K7lL4TR6hqYanWJFx1wiA1uJow6VnmU2DLoW2
         Fa5YLBMijRNSDyhKR90z2Z9Ut0L1X6QMQElfYXLTW4C9eWZtLAB0o1CXza3yze+uGE/3
         ApMp4NtmvfPU6DD+ytMqraZacDijsX+ovwNG6XmQuR95QWgT+k1dFCJlkdNYHJKOOs9W
         n1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701563; x=1688293563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLH08/1Jj31YQZ3K0A+NRzZLpvhxie+bpVAPrS6fHA8=;
        b=k865my+E9n7/ZX4LStAzbf+r2qJvY6E/tjmbiQmshajf04O4oUIeqOKio199VMS9pg
         4wzZ7mNiprlx2d4/rHVFX0S724maq7b0mfYiFGPctJ31ecRzWbGn8tql8WQrkzIXe13i
         0swJQPOGMBk4c/hMaKrD2A01fbZG78R/QTb8u5ZcWPucVmDIcVI/+aBR6Ccbf599FfEd
         /8iXkNyZTriItKlWJ0Eu+7z38R9GyZpdA0apsLPPWnrrLW0ytrIjjoxf81M6tri8G/O2
         zHMp+rO+wb7KqKHoalVteTfMLajiV6pwyWHEP8ba0k0T7IXFC/iEFFdm217DkDpI+ZKl
         tyZg==
X-Gm-Message-State: AC+VfDx1Va5W+wzHsIL+vYVNIPtzUbjL24N/bVJ1Qix0V4hSxQcC7A7+
        KaN688dFTL8drEfj1/cihNBPb7/nc6xTCQ==
X-Google-Smtp-Source: ACHHUZ6dOr9k0FPNFqPzbi8kWYH2tm7dNex8/iziXWmKW6SaAFFE/IigT6lGjjzn6eOADn1dyH3g3w==
X-Received: by 2002:ac2:5455:0:b0:4f1:26f5:77fb with SMTP id d21-20020ac25455000000b004f126f577fbmr1572630lfn.28.1685701563323;
        Fri, 02 Jun 2023 03:26:03 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:1169:70dc:520b:5de9:c23d:7cde])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c029200b003f601a31ca2sm1468035wmk.33.2023.06.02.03.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 03:26:02 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 08/15] replay: remove progress and info output
Date:   Fri,  2 Jun 2023 12:25:26 +0200
Message-ID: <20230602102533.876905-9-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.15.ga6d88fc8f0
In-Reply-To: <20230602102533.876905-1-christian.couder@gmail.com>
References: <20230509175347.1714141-1-christian.couder@gmail.com>
 <20230602102533.876905-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The replay command will be changed in a follow up commit, so that it
will not update refs directly, but instead it will print on stdout a
list of commands that can be consumed by `git update-ref --stdin`.

We don't want this output to be polluted by its current low value
output, so let's just remove the latter.

In the future, when the command gets an option to update refs by
itself, it will make a lot of sense to display a progress meter, but
we are not there yet.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 52db8e0941..2ad0835c06 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -194,7 +194,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 
 	init_merge_options(&merge_opt, the_repository);
 	memset(&result, 0, sizeof(result));
-	merge_opt.show_rename_progress = 1;
+	merge_opt.show_rename_progress = 0;
 	merge_opt.branch1 = "HEAD";
 	head_tree = repo_get_commit_tree(the_repository, onto);
 	result.tree = head_tree;
@@ -202,9 +202,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	while ((commit = get_revision(&revs))) {
 		struct commit *pick;
 
-		fprintf(stderr, "Rebasing %s...\r",
-			oid_to_hex(&commit->object.oid));
-
 		if (!commit->parents)
 			die(_("replaying down to root commit is not supported yet!"));
 		if (commit->parents->next)
@@ -223,7 +220,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		exit(128);
 
 	if (result.clean) {
-		fprintf(stderr, "\nDone.\n");
 		strbuf_addf(&reflog_msg, "finish rebase %s onto %s",
 			    oid_to_hex(&last_picked_commit->object.oid),
 			    oid_to_hex(&last_commit->object.oid));
@@ -237,7 +233,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		if (create_symref("HEAD", branch_name.buf, reflog_msg.buf) < 0)
 			die(_("unable to update HEAD"));
 	} else {
-		fprintf(stderr, "\nAborting: Hit a conflict.\n");
 		strbuf_addf(&reflog_msg, "rebase progress up to %s",
 			    oid_to_hex(&last_picked_commit->object.oid));
 		if (update_ref(reflog_msg.buf, "HEAD",
-- 
2.41.0.15.ga6d88fc8f0

