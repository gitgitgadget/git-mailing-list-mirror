Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F8161F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 16:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKNQf5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 11:35:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54297 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfKNQf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 11:35:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id z26so6343954wmi.4
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 08:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=By+25eV65aHn48gl/86XiGkud0IYziel1AUxBu69RbI=;
        b=hB1qSBsqSTFfxfBsCMP7RVr6MkegwGd9sRg3V+07qcSTNraz+/YuEjKOftp8sszug4
         4kiOStNEwinyzHpMt9Pg7Wl2XW09cW1B4Jn4qgFO/Ltdw1EE0tEZuXRxR1SeSTgFd4fP
         DXT6oAlzNfh3ujLf9TLADR7j7e4+QBQ83pD7ql0JagawBiwfVqaWjbW33DYFPHZlxyYF
         FPJGfVStwJhKJ6J27n2MZQVU7nNhSDN/Mzt2NQguufBHgk23d8zwTTkAEErVWjMM54g6
         8yD5J/ubsLHoct2GrXRsvRSOaOFsIVmQcZuzKg7vxeXq4QMasx8/F8yHgPDq1v6Tjd3d
         TnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=By+25eV65aHn48gl/86XiGkud0IYziel1AUxBu69RbI=;
        b=a9Th4HMoIO+GNxHru7iM3P1E2MwFaVFcbXTjfpTWUIyBH3Brakl+RiDLAogHj9bZYN
         e14ULYHvAUtPGLd3DltnRhe69Zj8+G16lgoAhptkZQRtyazZQAj3V9rYVQ47jAQhl1sO
         2Hie9SKX0Wvh9rw9hEr+oEgRj4Y/49xYMAeFG4nXmPAne+peXO0wewWl4y6AwSBNJgpj
         oNdW6kJUh+Q1xnK96e2Qamq58ZFjGQqEtUa1oG0/Bji5OtEiLFec7ehxoD29Y27t/5Ff
         KU1cLXJ+RrESSfS4JQa3ehRQjBGoNZHVAKya1yaKv8H3rxmTHD2Kc9UB7xNHc9LXbBsa
         0IKg==
X-Gm-Message-State: APjAAAXNlXegjwYynglq2+LxtgxVTmHVRtRDjw6Omw/ON1jPObbKYB+A
        rdazD/4EJZtx3L49HhFSyimO/E1N44E=
X-Google-Smtp-Source: APXvYqwJoCdzH+dBbUC5sz796gwhMWuQBmdlLCZhqvMCvgbin6Z/Y8OXnfLVlr2iQqKw6oTh/1ZcAQ==
X-Received: by 2002:a1c:1b07:: with SMTP id b7mr8867784wmb.111.1573749352693;
        Thu, 14 Nov 2019 08:35:52 -0800 (PST)
Received: from rybak.office.devexperts.com ([185.79.217.61])
        by smtp.googlemail.com with ESMTPSA id h124sm7429008wme.30.2019.11.14.08.35.51
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 08:35:51 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/3] rebase: prepare cmd before choosing action
Date:   Thu, 14 Nov 2019 17:35:47 +0100
Message-Id: <20191114163549.7648-2-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.24.0.windows.2
In-Reply-To: <20191114163549.7648-1-rybak.a.v@gmail.com>
References: <20191114163549.7648-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When git rebase is started with option --exec, its arguments are parsed
into string_list exec and then converted into options.cmd.

In following commits, action --edit-todo will be taught to use arguments
passed with --exec option.  Prepare options.cmd before switch (action)
to make it available for the ACTION_EDIT_TODO branch of the switch.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 builtin/rebase.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 4a20582e72..9457912f9d 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1595,6 +1595,21 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			trace2_cmd_mode(action_names[action]);
 	}
 
+	for (i = 0; i < exec.nr; i++)
+		if (check_exec_cmd(exec.items[i].string))
+			exit(1);
+
+	if (exec.nr) {
+		int i;
+
+		imply_interactive(&options, "--exec");
+
+		strbuf_reset(&buf);
+		for (i = 0; i < exec.nr; i++)
+			strbuf_addf(&buf, "exec %s\n", exec.items[i].string);
+		options.cmd = xstrdup(buf.buf);
+	}
+
 	switch (action) {
 	case ACTION_CONTINUE: {
 		struct object_id head;
@@ -1731,10 +1746,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	for (i = 0; i < exec.nr; i++)
-		if (check_exec_cmd(exec.items[i].string))
-			exit(1);
-
 	if (!(options.flags & REBASE_NO_QUIET))
 		argv_array_push(&options.git_am_opts, "-q");
 
@@ -1746,17 +1757,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
 	}
 
-	if (exec.nr) {
-		int i;
-
-		imply_interactive(&options, "--exec");
-
-		strbuf_reset(&buf);
-		for (i = 0; i < exec.nr; i++)
-			strbuf_addf(&buf, "exec %s\n", exec.items[i].string);
-		options.cmd = xstrdup(buf.buf);
-	}
-
 	if (rebase_merges) {
 		if (!*rebase_merges)
 			; /* default mode; do nothing */
-- 
2.24.0.windows.2

