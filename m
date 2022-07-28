Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DA0C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbiG1QTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbiG1QSh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:18:37 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DA271700
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:18:06 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k8so670827wrd.5
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=gFAGvs/ijt8RU2/zkCtOUfuEYnba5OqJfVDedo7Pq9Y=;
        b=bdHBqUx4aoZZ2+rySLoBs3DAGABWA0sQyVarGV7mOLsmfT52MRde3uY+mBeRObEihf
         hHdts8B9HkIuKoxEjiAs12t9H012NxDA7gTn+eSR0IyhhC4Q9kNjTfuHiKXaH+l4ugNy
         2gWSlgNMiidcE4mGKwVu1w2XtYa0avJh+spndM0QU9NtwJAdJ8Mc8iriOKh4JCmSJlAh
         vCplYJfP3LTl/Qkeg3bfw5whBXz7g0hiHRJha+jPzP1ka6axFDLc6ltWfhown5XATvAO
         D4QahzpSKTnEYAMOIy6DsvI0GR+5u8jZcvDlErL5c8elDm10tOZNz3ERg7YqKJCbJNp6
         jOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=gFAGvs/ijt8RU2/zkCtOUfuEYnba5OqJfVDedo7Pq9Y=;
        b=2YuEOTB4aZYF2vBMu01Fn8+DRqiruujCe8voQqVqZsiHT7/FE4TnVpBHL5yQ1F3FX/
         tr7BMvsKeuKiyLvoh+VYwVH/JcNgzaDFS8u7zE8+0zSeJzG53FUH/H2qPDqEiwqLE+nl
         x89xqKA2bfsciKub2RtMm6tibWnlMMc91u2+dF9ULGPqA74Sp6JUUFQ8PnXx6Hj2THJq
         LpoJG2zOsxTInPb4PV9wEV1Z8SJf52h6mrPWXV8seFnFDaRxr0JCTRPbkJMpFH5rUb1V
         nBTBcgTc1OyW8BOIjSr/uNXFNQGE4HYANJsBTffgjWudO/VjmswOL0+kLdRT2GzEQ+aJ
         BFHA==
X-Gm-Message-State: AJIora9wibfR3+TxnLNW5mDZ9BCLymPeIKpsgXsYWvykfSnndG8q1rPk
        1Gr5ZwWv4yF6s0f6/RKyskpMwwcE/g8Q0g==
X-Google-Smtp-Source: AGRyM1tMpCCUZAK5UZy9ETya25U3Zn3943ww0lp1HO6u8M8Qm4gIIdHKQlufyR6ZF+SzwQd/GSefdw==
X-Received: by 2002:a05:6000:1789:b0:21e:6193:b260 with SMTP id e9-20020a056000178900b0021e6193b260mr17270980wrg.182.1659025084868;
        Thu, 28 Jul 2022 09:18:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w13-20020adfee4d000000b0021f0af83142sm1220117wro.91.2022.07.28.09.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:18:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 18/20] submodule--helper: add skeleton "goto cleanup" to update_submodule()
Date:   Thu, 28 Jul 2022 18:17:03 +0200
Message-Id: <patch-18.20-41fb22d8549-20220728T161116Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1167.g38fda70d8c4
In-Reply-To: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a skeleton "goto cleanup" pattern to update_submodule(), rather
than having branches in it "return". This is in preparation for
eventually freeing data with the "cleanup" label, but for now we're
using it as the equivalent of a "done" label.

The "exit()" branch is not handled yet, and neither is the exit() that
run_update_procedure() might invoke. That'll be handled in a
subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 349fe7f269c..68aa10a26cd 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2383,6 +2383,8 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 
 static int update_submodule(struct update_data *update_data)
 {
+	int ret = 1;
+
 	ensure_core_worktree(update_data->sm_path);
 
 	update_data->displaypath = get_submodule_displaypath(
@@ -2417,14 +2419,14 @@ static int update_submodule(struct update_data *update_data)
 		free(remote_ref);
 	}
 
-	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force)
+	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force) {
 		if (run_update_procedure(update_data))
-			return 1;
+			goto cleanup;
+	}
 
 	if (update_data->recursive) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		struct update_data next = *update_data;
-		int ret;
 
 		next.prefix = NULL;
 		oidcpy(&next.oid, null_oid());
@@ -2438,16 +2440,20 @@ static int update_submodule(struct update_data *update_data)
 		/* die() if child process die()'d */
 		ret = run_command(&cp);
 		if (!ret)
-			return 0;
+			goto cleanup;
 		die_message(_("Failed to recurse into submodule path '%s'"),
 			    update_data->displaypath);
-		if (ret == 128)
+		if (ret == 128) {
 			exit(ret);
-		else if (ret)
-			return 1;
+		} else if (ret) {
+			ret = 1;
+			goto cleanup;
+		}
 	}
 
-	return 0;
+	ret = 0;
+cleanup:
+	return ret;
 }
 
 static int update_submodules(struct update_data *update_data)
-- 
2.37.1.1167.g38fda70d8c4

