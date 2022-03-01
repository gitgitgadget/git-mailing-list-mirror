Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19073C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 00:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiCAAJN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 19:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiCAAJH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 19:09:07 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9F89A4CF
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:08:27 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id oj16-20020a17090b4d9000b001bc9dddd9easo7371977pjb.7
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZJ9JuO2ZLBsSPC5VW54LiMsNmiMznGVzF+HcPh0t8SY=;
        b=UnStrozCus9TQCvBw+ugtOWzewUz+PZNylqJKcCzN/5BF4LoBtAyg12PVDs/8Ya4El
         xIsRzTJ0a6wkZdcmnRCffP0woc+eKzrMKSYsqbLu6F4RjOY7blC2XeT7MUsKjQbYRcij
         1CL/5sMVYuJu4QeSqUZIR1GnvZ7rDwT+l5qzV5+nrmHtSfQmo29f3N9/qFaTgE9vTJPo
         K4IR+R/n/Sk34v2K07XPLk9XPsFOmxioybleisga26imhb/MOdKgCK8zX0DbmE3JdfWJ
         NthTBa36bt4auxJpNGzICS/0SRiL5Mw5d6v5tKBEWIhl4t3WoIQvQnOs8sF9wfjGDM5s
         5IYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZJ9JuO2ZLBsSPC5VW54LiMsNmiMznGVzF+HcPh0t8SY=;
        b=tzD1bfvHfGc7fSlFGVKMIV/qA1aswgnwamKxlCCziWHFuQGh4kadaep5kqMvLdZRhQ
         NzEp/bFRw0mYkVPcEVr4RGctmRGDKJCstSaBuGETJnB6HXZ8DRb6ojzGk393vWN4J8ax
         aSHiheiDfHNxXtrOsedvHnucNi1T0NH5GA00vG0IIi4OhHzbIaPmwyErChddX4JXkz29
         68lPffl8R8aCLkrdGeCmulUsK9ZMhgCLpz4Y92VAd4Gr3l5glmcyKF9wvD2M0CuMLZot
         yDhasqo9BkqJ3t5QWgGUc7Eeq7nuE2jZb4Jfbb/ScNK/OSZVYm6cPBvImRKWo66CiESl
         UwrQ==
X-Gm-Message-State: AOAM5327layJQVCw5viynA/ggwhCMuUe7tyQafRoVURR0EAEJStu0l8x
        dKM/Y5HeTiXpAXcMZvMc+PKIDUBU0VnQzB/ThZtBJqBdeni4x2/D7Nn9+7zQxmKIkG2cEnLZGD5
        Jwh/P41y0rBfRDEZTNU/SdiCSAktwrSNUe4lr1/tyNMsOesQM8W9J1h2ZF4TU/+g=
X-Google-Smtp-Source: ABdhPJzW//TJEsGhFmlhQeDxS1t5QEZYFc4G43aGUedIvBny6/R8J0f0fL8DGjxuPhuKaruurx9zNZkuZ8kGwA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:aa19:0:b0:4f1:1cff:faa8 with SMTP id
 e25-20020a62aa19000000b004f11cfffaa8mr24345689pff.25.1646093306986; Mon, 28
 Feb 2022 16:08:26 -0800 (PST)
Date:   Mon, 28 Feb 2022 16:08:06 -0800
In-Reply-To: <20220301000816.56177-1-chooglen@google.com>
Message-Id: <20220301000816.56177-4-chooglen@google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH 03/13] submodule--helper: reorganize code for sh to C conversion
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a function, update_submodule2(), that will implement the
functionality of run-update-procedure and its surrounding shell code in
submodule.sh. This name is temporary; it will replace update_submodule()
when the sh to C conversion is complete.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c11ee1ea2b..1b67a3887c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2452,6 +2452,16 @@ static int do_run_update_procedure(struct update_data *ud)
 	return run_update_command(ud, subforce);
 }
 
+/*
+ * NEEDSWORK: As we convert "git submodule update" to C,
+ * update_submodule2() will invoke more and more functions, making it
+ * difficult to preserve the function ordering without forward
+ * declarations.
+ *
+ * When the conversion is complete, this forward declaration will be
+ * unnecessary and should be removed.
+ */
+static int update_submodule2(struct update_data *update_data);
 static void update_submodule(struct update_clone_data *ucd)
 {
 	fprintf(stdout, "dummy %s %d\t%s\n",
@@ -2618,11 +2628,7 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
 					    &update_data.update_strategy);
 
 	free(prefixed_path);
-
-	if (!oideq(&update_data.oid, &update_data.suboid) || update_data.force)
-		return do_run_update_procedure(&update_data);
-
-	return 3;
+	return update_submodule2(&update_data);
 }
 
 static int resolve_relative_path(int argc, const char **argv, const char *prefix)
@@ -3022,6 +3028,16 @@ static int module_create_branch(int argc, const char **argv, const char *prefix)
 				    force, reflog, quiet, track, dry_run);
 	return 0;
 }
+
+/* NEEDSWORK: this is a temporary name until we delete update_submodule() */
+static int update_submodule2(struct update_data *update_data)
+{
+	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force)
+		return do_run_update_procedure(update_data);
+
+	return 3;
+}
+
 struct add_data {
 	const char *prefix;
 	const char *branch;
-- 
2.33.GIT

