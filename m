Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C2AC678D4
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 22:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjCBWDg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 17:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCBWD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 17:03:29 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D945ADC5
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 14:03:06 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 10-20020a63030a000000b004fb64e929f2so99264pgd.7
        for <git@vger.kernel.org>; Thu, 02 Mar 2023 14:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1CK1+XmaOIwxsuu8wDVNqSp47NjVbJnFfkOEMkQvjBI=;
        b=lZdnDAsh/sK4GlhEaYZslpw9UQJOzZv5RceHTo4eCjxBq+WQd5pMV1wiZ2GbEnBgmw
         cQo3HZ/Eyq8dbpVXbIyZlr/einxQWpJFrrAvZ1Uzxuva1D16HKmhdq+AULFFbrbFNIOj
         BniFkhqwdXk1UPf967xvEZ5nqLIRB2m81SN/HPCMEjXysjF8Ylfktkmf3e4BPmuaWuQl
         eVTyRaBxtRIpvQMdjjAIplLos1nUKx+2MLXamuj2v89Vfd45QMpLujy7fNFLcuBbOSMm
         7ci7t7bQvYfspJf4zNXAch5/s+zwLT3LEjBao7sLZPgg/+QWry692tUv5i0BHeIFXbq+
         GRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1CK1+XmaOIwxsuu8wDVNqSp47NjVbJnFfkOEMkQvjBI=;
        b=AxnB3kIuAxW1I8nWmPxY5AsAW7gMHkaj8k2ZUGFolOhd/4aBhZQmmnPx9HBpW6E2UI
         rN57wsqov9HBJQ/3jdm+5Cf4LiSCXv9wHhowT0l6SpbbBao7CJm5eP+iOkF4ZND8Gtnv
         zmMBzANLOQ9klLlsOQ0UH9pV96+VmNiPeCMkQwO0i9cUpIfJ4IA+jsVMhLTF30og9JsS
         XYTFeIDunhmyKwZWsb8PRlrCHvJsjmpwmIglnZjWMed6bFbXPVSZC95CxW0pCq0d4ASs
         pVlPhMzHMrqklVWTtNA+NnJIExs+fDXUH3JbI4qTlsrInaVO02kcKjzOWopPVa5qbUHK
         KFZg==
X-Gm-Message-State: AO0yUKXX3oawHfqhSYh7eTWhOlI4FuKSO05r4lUMUqTQJI7fEKNqlQ01
        xmD4qirbO/9qyvZBbHtO9jJpxVI/9iU6w7KDQMU3HC4RempXLkhwJOBhFfJ05pvNC8pfiNVtw4i
        2L+XYUdmjnfLvTY3KofJv5d1hB/cXsDtJPE5cnfTD9NLzMS1yIW/HLIUYj3AxrKUIpA==
X-Google-Smtp-Source: AK7set9T+BPC6d7LmWiCjmN/lqHWbfogfe4jdmv+Qy+AkYGnh1WOplNv/4QtaHBHQNhXhmQtRqy73/8ZaeMM9MM=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:2254:b0:5de:ece4:2674 with SMTP
 id i20-20020a056a00225400b005deece42674mr4058pfu.3.1677794582912; Thu, 02 Mar
 2023 14:03:02 -0800 (PST)
Date:   Thu,  2 Mar 2023 22:02:48 +0000
In-Reply-To: <20230302215237.1473444-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230209000212.1892457-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230302220251.1474923-3-calvinwan@google.com>
Subject: [PATCH v9 3/6] submodule: move status parsing into function
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, avarab@gmail.com,
        chooglen@google.com, newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A future patch requires the ability to parse the output of git
status --porcelain=2. Move parsing code from is_submodule_modified to
parse_status_porcelain.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 submodule.c | 74 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 32 deletions(-)

diff --git a/submodule.c b/submodule.c
index faf37c1101..768d4b4cd7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1870,6 +1870,45 @@ int fetch_submodules(struct repository *r,
 	return spf.result;
 }
 
+static int parse_status_porcelain(char *str, size_t len,
+				  unsigned *dirty_submodule,
+				  int ignore_untracked)
+{
+	/* regular untracked files */
+	if (str[0] == '?')
+		*dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
+
+	if (str[0] == 'u' ||
+	    str[0] == '1' ||
+	    str[0] == '2') {
+		/* T = line type, XY = status, SSSS = submodule state */
+		if (len < strlen("T XY SSSS"))
+			BUG("invalid status --porcelain=2 line %s",
+			    str);
+
+		if (str[5] == 'S' && str[8] == 'U')
+			/* nested untracked file */
+			*dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
+
+		if (str[0] == 'u' ||
+		    str[0] == '2' ||
+		    memcmp(str + 5, "S..U", 4))
+			/* other change */
+			*dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
+	}
+
+	if ((*dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
+	    ((*dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) ||
+	     ignore_untracked)) {
+		/*
+		* We're not interested in any further information from
+		* the child any more, neither output nor its exit code.
+		*/
+		return 1;
+	}
+	return 0;
+}
+
 unsigned is_submodule_modified(const char *path, int ignore_untracked)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -1909,39 +1948,10 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 		char *str = buf.buf;
 		const size_t len = buf.len;
 
-		/* regular untracked files */
-		if (str[0] == '?')
-			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
-
-		if (str[0] == 'u' ||
-		    str[0] == '1' ||
-		    str[0] == '2') {
-			/* T = line type, XY = status, SSSS = submodule state */
-			if (len < strlen("T XY SSSS"))
-				BUG("invalid status --porcelain=2 line %s",
-				    str);
-
-			if (str[5] == 'S' && str[8] == 'U')
-				/* nested untracked file */
-				dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
-
-			if (str[0] == 'u' ||
-			    str[0] == '2' ||
-			    memcmp(str + 5, "S..U", 4))
-				/* other change */
-				dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
-		}
-
-		if ((dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
-		    ((dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) ||
-		     ignore_untracked)) {
-			/*
-			 * We're not interested in any further information from
-			 * the child any more, neither output nor its exit code.
-			 */
-			ignore_cp_exit_code = 1;
+		ignore_cp_exit_code = parse_status_porcelain(str, len, &dirty_submodule,
+							     ignore_untracked);
+		if (ignore_cp_exit_code)
 			break;
-		}
 	}
 	fclose(fp);
 
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

