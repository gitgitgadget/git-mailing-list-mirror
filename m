Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A2EF1F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751211AbeACAS7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:18:59 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:42705 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbeACASr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:18:47 -0500
Received: by mail-it0-f65.google.com with SMTP id p139so51018itb.1
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2lh3mwtTr7GcdhdbzYqIrtZp/vrPcUbnOvauIhsEKLI=;
        b=KdbJjyIhFrubQZ1/Dtljg9gN/Y+Fd1ZDu/vvrTGRBofz4Wrjk+dJocP7LC74Lz65DY
         KWvwgjikQrklYDYZvYDdlb6knZYMPukbSQnuwZLj8pl7cI2M6ZHColHFZ85zEdCxx3T4
         I7rT3urqPlM20zw6hI4DM1bvHCrmr1qhD9PpLU0aEJT0QngEtGGSVUm167ujfRHS4RMh
         whkj2JvKR/r0yZ4TT5e1p9QSY6FH/C8wI4VTzO2j5RezIX1eXqRfJvEV+nNRC3cGM65q
         FhS6YqW2NdpItEvqqZr2YjY8CIsE1qEiX11l6h/j5hu2sdI2pcJIVyAn7NVCnvwIEXsy
         9Jyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2lh3mwtTr7GcdhdbzYqIrtZp/vrPcUbnOvauIhsEKLI=;
        b=CyK5wwmgF9MJeGFWuO0Y7BttkMqCmIGq2SA/NjmG8Rf6OLVSzlAglH7F4swp+4k/0z
         Cf0OdRsRK4y5fkIC5K7VTjhwnqSP3SNOAxiggSy+VniYqnl/3lhhweRHLHp1HHCE31Or
         eGkXa6gBp3jahHUxUpRju+GGYdBkR7NqRJ5FUlGvk5DZW1FzZ4PWXA9x7n1n6NkHKo0e
         r18AGpeLFDh+vI71ddi9r9/LZ+sDV4AIhTBlz4cwo8q/rR4I0tn/suR/OktWUPo7tefL
         1pl7Mnaj0FyhCHu25vb4IOQf2nCJ1yHhzcInmcAegRAeziAeFE99AyLxdT5yyweW7tk8
         7EXw==
X-Gm-Message-State: AKGB3mJv0z7d1+E6OP6E3v7F7esfSsT6IehdXUvNvB9sOUu+wUieMaay
        insmVHqP+AUsAcTv7k6slUdyepZT6V8=
X-Google-Smtp-Source: ACJfBovG3NIpjD6OYTY2YWwrCz8uGlVTG4G13uxNkEBwB9u1ukD7nO49PhYlmdc36L8PFiLWV09Rhg==
X-Received: by 10.36.124.15 with SMTP id a15mr95826itd.135.1514938726366;
        Tue, 02 Jan 2018 16:18:46 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q2sm12679ite.17.2018.01.02.16.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 16:18:45 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 04/26] upload-pack: convert to a builtin
Date:   Tue,  2 Jan 2018 16:18:06 -0800
Message-Id: <20180103001828.205012-5-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103001828.205012-1-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to allow for code sharing with the server-side of fetch in
protocol-v2 convert upload-pack to be a builtin.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Makefile      | 3 ++-
 builtin.h     | 1 +
 git.c         | 1 +
 upload-pack.c | 2 +-
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 2a81ae22e..e0740b452 100644
--- a/Makefile
+++ b/Makefile
@@ -636,7 +636,6 @@ PROGRAM_OBJS += imap-send.o
 PROGRAM_OBJS += sh-i18n--envsubst.o
 PROGRAM_OBJS += shell.o
 PROGRAM_OBJS += show-index.o
-PROGRAM_OBJS += upload-pack.o
 PROGRAM_OBJS += remote-testsvn.o
 
 # Binary suffix, set to .exe for Windows builds
@@ -701,6 +700,7 @@ BUILT_INS += git-merge-subtree$X
 BUILT_INS += git-show$X
 BUILT_INS += git-stage$X
 BUILT_INS += git-status$X
+BUILT_INS += git-upload-pack$X
 BUILT_INS += git-whatchanged$X
 
 # what 'all' will build and 'install' will install in gitexecdir,
@@ -904,6 +904,7 @@ LIB_OBJS += tree-diff.o
 LIB_OBJS += tree.o
 LIB_OBJS += tree-walk.o
 LIB_OBJS += unpack-trees.o
+LIB_OBJS += upload-pack.o
 LIB_OBJS += url.o
 LIB_OBJS += urlmatch.o
 LIB_OBJS += usage.o
diff --git a/builtin.h b/builtin.h
index 42378f3aa..f332a1257 100644
--- a/builtin.h
+++ b/builtin.h
@@ -231,6 +231,7 @@ extern int cmd_update_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_update_server_info(int argc, const char **argv, const char *prefix);
 extern int cmd_upload_archive(int argc, const char **argv, const char *prefix);
 extern int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix);
+extern int cmd_upload_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_var(int argc, const char **argv, const char *prefix);
 extern int cmd_verify_commit(int argc, const char **argv, const char *prefix);
 extern int cmd_verify_tag(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index c870b9719..f71073dc8 100644
--- a/git.c
+++ b/git.c
@@ -478,6 +478,7 @@ static struct cmd_struct commands[] = {
 	{ "update-server-info", cmd_update_server_info, RUN_SETUP },
 	{ "upload-archive", cmd_upload_archive },
 	{ "upload-archive--writer", cmd_upload_archive_writer },
+	{ "upload-pack", cmd_upload_pack },
 	{ "var", cmd_var, RUN_SETUP_GENTLY },
 	{ "verify-commit", cmd_verify_commit, RUN_SETUP },
 	{ "verify-pack", cmd_verify_pack },
diff --git a/upload-pack.c b/upload-pack.c
index d5de18127..20acaa49d 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1032,7 +1032,7 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 	return parse_hide_refs_config(var, value, "uploadpack");
 }
 
-int cmd_main(int argc, const char **argv)
+int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 {
 	const char *dir;
 	int strict = 0;
-- 
2.15.1.620.gb9897f4670-goog

