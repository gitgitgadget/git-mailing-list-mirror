Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7BF21F43C
	for <e@80x24.org>; Wed,  8 Nov 2017 19:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751754AbdKHTzb (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 14:55:31 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:52412 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752328AbdKHTz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 14:55:29 -0500
Received: by mail-io0-f195.google.com with SMTP id f20so7234336ioj.9
        for <git@vger.kernel.org>; Wed, 08 Nov 2017 11:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/RWSoFgZlYGmX6MlLGMjhxHSS4EKhrH7Bfwe2+TBek8=;
        b=ZCI+G+ixkJrswB29zBKIafaDxaNSxtsTdz2xmBPALARJISInQnRqL/61c1AtD7n4BE
         hPp2FJ7AygW2Oo4cSXNHDZMETHmQl0qyi2L95jS5bnFniCV1JiXedTfekWA7BzPSL1NY
         P+CizZWZgWJRnPZtLWXpPQPBqwQVcQKd1/kzchdftsZJmJsev6tnNq4x86oQnBnTP8X9
         mZPkrEgrMfDWIio5ddCO6aaCo4gj3h+1Og2qdmSKxum6aopB+fIZnRtdjdpw/FcqZPTc
         DSf9G9twv1sJXBJlhODzkOiBmhraWGThqCHm8J+MWxd7N+oi4B8MnjIp4hbToCoAv2OS
         r50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/RWSoFgZlYGmX6MlLGMjhxHSS4EKhrH7Bfwe2+TBek8=;
        b=aYaJciH5Z8Q8+DIq9V9NDLBoX0LRHLOKLrRWc2oKIP6blem1ehRRYpwSaNxQonaP3i
         nHrE9H8BBvkDhMwf6OlrThco0b5/m9v5WwuGIGYFIrEku9wWPZ+tlyIOf7MQ9XDbm7p0
         t06lJ4xxcqsPd90aPrWVRebqRmpQ4ZzWUr+Y5utbv+tL1HehkPY5U5RQWGrL8DaXZ5AQ
         BT+TqGu2P6NH6Txt3YWUCKn9S0g+eU44jUPDoyWZmmxGYsOr3BvU1R5eklu9YLG5reWZ
         80yojl5KRkKmIP4ay7kaafIOK6i4gvmE3jpZrDAQoR7pF2wZtbJCOAuZeGUizIMzytOe
         760g==
X-Gm-Message-State: AJaThX5bvbMAArHBK8l2AscgqhKcJSukLLuEDyoek35YkR7Bwj4l3rBC
        xT7W3ZWJAio+fLVqYjarNOJm1kWWGqM=
X-Google-Smtp-Source: ABhQp+SkpVnyaMRQc1yhnYJHR+g8MVY1vpUDFCJpPQ732R7y7vUXcH6oVDhVmBz/ccWFsMo8QHs7QQ==
X-Received: by 10.107.10.82 with SMTP id u79mr2244963ioi.252.1510170927695;
        Wed, 08 Nov 2017 11:55:27 -0800 (PST)
Received: from localhost ([2620:0:100e:422:c178:b390:b6a8:a0e2])
        by smtp.gmail.com with ESMTPSA id h81sm2627998itb.18.2017.11.08.11.55.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Nov 2017 11:55:27 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/4] submodule.c: get superprojects gitlink value
Date:   Wed,  8 Nov 2017 11:55:08 -0800
Message-Id: <20171108195509.7839-4-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
In-Reply-To: <20171108195509.7839-1-sbeller@google.com>
References: <20171108195509.7839-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 27 +++++++++++++++++++++++++++
 submodule.h |  6 ++++++
 2 files changed, 33 insertions(+)

diff --git a/submodule.c b/submodule.c
index 4fcb64469e..68b123eb13 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2074,6 +2074,33 @@ const char *get_superproject_working_tree(void)
 	return ret;
 }
 
+/*
+ * Returns 0 when the gitlink is found in the superprojects index,
+ * the value will be found in `oid`. Otherwise return -1.
+ */
+int get_superproject_gitlink(struct object_id *oid)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf sb = STRBUF_INIT;
+	const char *hash;
+
+	if (start_ls_files_dot_dot(&cp, &sb) < 0)
+		return -1;
+
+	if (!skip_prefix(sb.buf, "160000 ", &hash))
+		/*
+		 * superproject doesn't have a gitlink at submodule position or
+		 * output is gibberish
+		 */
+		return -1;
+
+	if (get_oid_hex(hash, oid))
+		/* could not parse the object name */
+		return -1;
+
+	return 0;
+}
+
 /*
  * Put the gitdir for a submodule (given relative to the main
  * repository worktree) into `buf`, or return -1 on error.
diff --git a/submodule.h b/submodule.h
index f0da0277a4..5fc602f0c7 100644
--- a/submodule.h
+++ b/submodule.h
@@ -137,4 +137,10 @@ extern void absorb_git_dir_into_superproject(const char *prefix,
  */
 extern const char *get_superproject_working_tree(void);
 
+/*
+ * Returns 0 when the gitlink is found in the superprojects index,
+ * the value will be found in `oid`. Otherwise return -1.
+ */
+extern int get_superproject_gitlink(struct object_id *oid);
+
 #endif
-- 
2.15.0.128.g40905b34bf.dirty

