Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3B8D207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 23:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755582AbdD1Xyd (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 19:54:33 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35281 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2999765AbdD1XyY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 19:54:24 -0400
Received: by mail-pf0-f170.google.com with SMTP id v14so54859943pfd.2
        for <git@vger.kernel.org>; Fri, 28 Apr 2017 16:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Llug1qayBymegeaDZgBkfBhUFouoNd80tCgS/ynK4qI=;
        b=UQohhFbidPoQH/3pogx8lzA/l0QGDhYUSL3OL8Dc0ifibV4lYQLOBrQau6tV0blszd
         BfBjg0170nw56mEgE5lHodCvH4fosrsO/Q2DavVekmeVkWPqpRKT1NyVtbJAaLn8wK4u
         R6MM3eDZ7nV1i7Ws1M2sZTIRgaTbo4vpt+ph06Hzuf3rUcUvcuHDhTtf2DlW5hQ5H/Hy
         7TNA55kKNk3nFUz2JfoXE72iOAGVj5O5vnlqWFOzgfN5BiyIEvtiIMYV/A3hg6pNTTIQ
         K9fId0In0obeR2PTSSvX3EyZCAiwjycH88+sDA6D8kTM6gNmzvGqR/FNjJb+OeqTOJ7T
         NNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Llug1qayBymegeaDZgBkfBhUFouoNd80tCgS/ynK4qI=;
        b=YpVkMjMge09P50F9x1No+f5S1NTLhAFJhpZWJ4p3KOPi00iK/pTaIvsc2dCD2GLDAb
         eicF9z5gvgrpd/LvIRkPZ3lgeU/H1412788Y2wb3qa+skLxmHAu6v91uqYputMf2+RcY
         BLl4qTZkNVkQ9Ll2PJWbUbOVbF0lhAxGETxuXsCoWSfolr758KitVlsbf5uhBCbvr2mp
         gCBqdPCCCbhMUTS9XgOYYJ0vP1wultGnJEpe6oBowdhWl52RiqSBjAlgxmA+tyiGXj99
         OBXtiaTzeuE4g3Der5AQs95rjyxPP9uSd0tc4wi6SRN02Bk0xu72K5VEihONT8lf8qpt
         zxkQ==
X-Gm-Message-State: AN3rC/6yXxPoKsS899ihwKa+pJlDS9sLrlR57Vucm207DIkw8T9ouf8Z
        JiqfywomC+uILbCWpLTFMw==
X-Received: by 10.98.87.78 with SMTP id l75mr14970205pfb.92.1493423657930;
        Fri, 28 Apr 2017 16:54:17 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 188sm5332429pfu.15.2017.04.28.16.54.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Apr 2017 16:54:16 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 5/6] submodule: improve submodule_has_commits
Date:   Fri, 28 Apr 2017 16:54:01 -0700
Message-Id: <20170428235402.162251-6-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d-goog
In-Reply-To: <20170428235402.162251-1-bmwill@google.com>
References: <20170428235402.162251-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach 'submodule_has_commits()' to ensure that if a commit exists in a
submodule, that it is also reachable from a ref.

This is a prepritory step prior to merging the logic which checkes for
changed submodules when fetching or pushing.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/submodule.c b/submodule.c
index 3bcf44521..100d31d39 100644
--- a/submodule.c
+++ b/submodule.c
@@ -648,6 +648,30 @@ static int submodule_has_commits(const char *path, struct oid_array *commits)
 		return 0;
 
 	oid_array_for_each_unique(commits, check_has_commit, &has_commit);
+
+	if (has_commit) {
+		/*
+		 * Even if the submodule is checked out and the commit is
+		 * present, make sure it is reachable from a ref.
+		 */
+		struct child_process cp = CHILD_PROCESS_INIT;
+		struct strbuf out = STRBUF_INIT;
+
+		argv_array_pushl(&cp.args, "rev-list", "-n", "1", NULL);
+		oid_array_for_each_unique(commits, append_oid_to_argv, &cp.args);
+		argv_array_pushl(&cp.args, "--not", "--all", NULL);
+
+		prepare_submodule_repo_env(&cp.env_array);
+		cp.git_cmd = 1;
+		cp.no_stdin = 1;
+		cp.dir = path;
+
+		if (capture_command(&cp, &out, 1024) || out.len)
+			has_commit = 0;
+
+		strbuf_release(&out);
+	}
+
 	return has_commit;
 }
 
-- 
2.13.0.rc0.306.g87b477812d-goog

