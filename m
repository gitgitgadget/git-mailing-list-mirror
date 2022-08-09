Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31034C25B08
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 19:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345842AbiHITJw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 15:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345135AbiHITJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 15:09:09 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAF422BE7
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 11:55:33 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id v5so6750732wmj.0
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 11:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=IUnBkjTsXPS0baa0O+Pu0f+n9e3ezUW+R7pCw2cLpYQ=;
        b=lC2TjbA3rYnGONnHRWrqMWo70xf2E5qvWIzJrq1g4I2uPwK5SyWm0etbcuNDO1YEak
         i6ChmkcqFlPxHv/gyZJVXFyt0rQxKguQKHlPRDPEhgbpL5tqDyc/vPDdAkQ1TF0XbZ0b
         QPr4wbFri9b3IAY59qcAbDE1yL5edUUQvDGZbAw+K5uX/RSUa1kn5eI4kzkEWj43tH6t
         bG1r2p/yJcMs2OX+WMkFkRXUrhCkLsH1NQOecfSURil1gwIyq9pTg+MLQd9Fs6aAD+RF
         LugpeMjQMPP+7RfT9dZ0Ok8B5laLyara9q5wNkTXCdIVkUqhaCa9hrXJ05AydjPdBcxn
         rz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=IUnBkjTsXPS0baa0O+Pu0f+n9e3ezUW+R7pCw2cLpYQ=;
        b=jEYTEztKG+I4PwsaBsGpUXEpwbeoJrapS9/iw5ACd9nMuvctJCixHSXnUP1fMxwySK
         fpU99Y9SmeNou7U4kWyussofu8j7talOSBIVBw980ORIBfGo41HAOqCcIiCQgu0VBz+2
         3J3gLsh+unTkGbulgCTFlftDP5pBbBAEarQfCOSQbjRzxDgqFv5CSME5ZFbLw0vYySYO
         gHNOC30yUS9/+KDiBICvzDd8APtudP/77XLEIuXxDOnr4y8Qsqrsr/sSpWFk4YEUf+c/
         tT/T76n+ryuza59MH9QaFNiQdaigDj+CB31wlCTKIXTAM/gUsjzpBmqWjSWNsWRLghCD
         ekYw==
X-Gm-Message-State: ACgBeo1x/06IsZxAGiDhTSnyNrgX+NdcXxT8vGRX6vhPlD6MQ8Ih4Tnc
        3ajE1iMMQjJ1NWL0fyViNNr+d4V3qWM=
X-Google-Smtp-Source: AA6agR5ya3BTXMLRTejfvbXUoulO2anrfLRbMcc6MM2cuXULJZlPjZXmwHXUIzuLbKIt16ufyvWhSQ==
X-Received: by 2002:a05:600c:1ca9:b0:3a5:125:3738 with SMTP id k41-20020a05600c1ca900b003a501253738mr20697759wms.161.1660071332065;
        Tue, 09 Aug 2022 11:55:32 -0700 (PDT)
Received: from ylate.lan (89-81-181-244.abo.bbox.fr. [89.81.181.244])
        by smtp.googlemail.com with ESMTPSA id j9-20020a05600c1c0900b003a529b7bc27sm13237414wms.9.2022.08.09.11.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 11:55:31 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 09/14] merge-recursive: move better_branch_name() to merge.c
Date:   Tue,  9 Aug 2022 20:54:24 +0200
Message-Id: <20220809185429.20098-10-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220809185429.20098-1-alban.gruin@gmail.com>
References: <20210317204939.17890-1-alban.gruin@gmail.com>
 <20220809185429.20098-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

better_branch_name() will be used by merge-octopus once it is rewritten
in C, so instead of duplicating it, this moves this function
preventively inside an appropriate file in libgit.a.  This function is
also renamed to reflect its usage by merge strategies.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/merge-recursive.c | 16 ++--------------
 cache.h                   |  2 +-
 merge.c                   | 12 ++++++++++++
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index b9acbf5d34..ae429c8514 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -8,18 +8,6 @@
 static const char builtin_merge_recursive_usage[] =
 	"git %s <base>... -- <head> <remote> ...";
 
-static char *better_branch_name(const char *branch)
-{
-	static char githead_env[8 + GIT_MAX_HEXSZ + 1];
-	char *name;
-
-	if (strlen(branch) != the_hash_algo->hexsz)
-		return xstrdup(branch);
-	xsnprintf(githead_env, sizeof(githead_env), "GITHEAD_%s", branch);
-	name = getenv(githead_env);
-	return xstrdup(name ? name : branch);
-}
-
 int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 {
 	const struct object_id *bases[21];
@@ -75,8 +63,8 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 	if (get_oid(o.branch2, &h2))
 		die(_("could not resolve ref '%s'"), o.branch2);
 
-	o.branch1 = better1 = better_branch_name(o.branch1);
-	o.branch2 = better2 = better_branch_name(o.branch2);
+	o.branch1 = better1 = merge_get_better_branch_name(o.branch1);
+	o.branch2 = better2 = merge_get_better_branch_name(o.branch2);
 
 	if (o.verbosity >= 3)
 		printf(_("Merging %s with %s\n"), o.branch1, o.branch2);
diff --git a/cache.h b/cache.h
index 6b5d0a2ba3..61ac42fa43 100644
--- a/cache.h
+++ b/cache.h
@@ -1916,7 +1916,7 @@ int checkout_fast_forward(struct repository *r,
 			  const struct object_id *from,
 			  const struct object_id *to,
 			  int overwrite_ignore);
-
+char *merge_get_better_branch_name(const char *branch);
 
 int sane_execvp(const char *file, char *const argv[]);
 
diff --git a/merge.c b/merge.c
index 2382ff66d3..d87bfd4824 100644
--- a/merge.c
+++ b/merge.c
@@ -102,3 +102,15 @@ int checkout_fast_forward(struct repository *r,
 		return error(_("unable to write new index file"));
 	return 0;
 }
+
+char *merge_get_better_branch_name(const char *branch)
+{
+	static char githead_env[8 + GIT_MAX_HEXSZ + 1];
+	char *name;
+
+	if (strlen(branch) != the_hash_algo->hexsz)
+		return xstrdup(branch);
+	xsnprintf(githead_env, sizeof(githead_env), "GITHEAD_%s", branch);
+	name = getenv(githead_env);
+	return xstrdup(name ? name : branch);
+}
-- 
2.37.1.412.gcfdce49ffd

