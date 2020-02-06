Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD110C2D0B1
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 10:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9902F20659
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 10:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJKurtzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbgBFK6E (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 05:58:04 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37340 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgBFK6E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 05:58:04 -0500
Received: by mail-pl1-f194.google.com with SMTP id c23so2210192plz.4
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 02:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ldATcm8clGJHCHG1a+tGPcEdnsEk5PQOyKw/DKw3CM8=;
        b=JJKurtznvZz5uULw8KURg9fpej+QUK9CGey9DH/eHta6e54/YPlQZzc7iuxO8JYwc8
         Q0/FgWWruLTnmTe3gIZjaKU4MpRYoAdo3rm99v2LCbIjMRfdVDkbtS6/5J/488fNj2rb
         CwIcQ/SOA7DZUMu+0Bd8QMxPuJ1c59hXa2Ytd0JwJBoH5BgfWAyirhThpvw4PvT3dswm
         xsQyXCxxjttJbJI3LwtqjL++L5DlULeRqNYNSVk3PMA1xW9GNGxQLlrt/ls4s67ha5LA
         b4cf2iGiIIYh+uW2RBX7AUfxv328Hd5n1Y43bLc1l/XFF8M4PhDNSUM9Hn3QGHcXFRjJ
         xuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ldATcm8clGJHCHG1a+tGPcEdnsEk5PQOyKw/DKw3CM8=;
        b=LxVH22uuftF6gmA8tnrLIhS3dnPx/swN5SnPjknaGdVmpHVB8vPJo/4mjhnqsMjZre
         6QTffniPCBXBhX++GxTCEvCJV42PXZmBL+L7Wht+NCXJGRUzCE/HdX9vKo/JCc0CDF0P
         Neas1NrIUoSFQ4n999nPU5Cu2YRD4W0ndeDOpqIRHtmDbbdnmWQ8zYKXtM3xK9N8X+q4
         kXKaPIubU1Mbn2sjz4gQXoMvKiqEgybrNvZxMCsSv4/Ds6Qx4LmxgBkWGcEJGZqAdPIf
         iflnVR6Zk1h/kmFXyyOSeFGQTNPXcSpZqEZZ+iSpqktSZG4vMKCfwmf7ugy62iRPjshR
         4TTQ==
X-Gm-Message-State: APjAAAXjSo3WZ5dOHDyx31UjuA6qVWAuEp8soKCE5hpZnxUgFfiZVRMt
        mSp5sNCwWsGRE5pM/mVaQf8RqU1i
X-Google-Smtp-Source: APXvYqy1yDt7eH+mSyc850N5gRU9azKwET+ZF9baxxKq3rHlmnE6e7UhGu5+QlfwYIhcCUKUsmI4OA==
X-Received: by 2002:a17:902:8f8a:: with SMTP id z10mr3155415plo.169.1580986683204;
        Thu, 06 Feb 2020 02:58:03 -0800 (PST)
Received: from localhost.localdomain (115-189-93-166.mobile.spark.co.nz. [115.189.93.166])
        by smtp.gmail.com with ESMTPSA id u13sm2944293pjn.29.2020.02.06.02.58.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Feb 2020 02:58:02 -0800 (PST)
From:   Heba Waly <heba.waly@gmail.com>
To:     git@vger.kernel.org
Cc:     emilyshaffer@google.com, gitster@pobox.com,
        jonathantanmy@google.com, Heba Waly <heba.waly@gmail.com>
Subject: [PATCH 1/1] add: change advice config variables used by the add API
Date:   Thu,  6 Feb 2020 23:57:30 +1300
Message-Id: <20200206105730.16231-2-heba.waly@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
In-Reply-To: <20200206105730.16231-1-heba.waly@gmail.com>
References: <20200206105730.16231-1-heba.waly@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

advice.addNothing config variable is used to control the visibility of
two advice messages in the add library. This config variable is
replaced by two new variables, whose names are more clear and relevant
to the two cases.

Also add the two new variables to the documentation.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Documentation/config/advice.txt |  6 ++++++
 advice.c                        |  6 ++++--
 advice.h                        |  3 ++-
 builtin/add.c                   | 12 ++++++++----
 t/t3700-add.sh                  |  2 ++
 5 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index 4be93f8ad9..bdd37c3eaa 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -110,4 +110,10 @@ advice.*::
 	submoduleAlternateErrorStrategyDie::
 		Advice shown when a submodule.alternateErrorStrategy option
 		configured to "die" causes a fatal error.
+	addIgnoredFile::
+		Advice shown if a user attempts to add an ignored file to
+		the index.
+	addEmptyPathspec::
+		Advice shown if a user runs the add command without providing
+		the pathspec parameter.
 --
diff --git a/advice.c b/advice.c
index 098ac0abea..97f3f981b4 100644
--- a/advice.c
+++ b/advice.c
@@ -31,7 +31,8 @@ int advice_graft_file_deprecated = 1;
 int advice_checkout_ambiguous_remote_branch_name = 1;
 int advice_nested_tag = 1;
 int advice_submodule_alternate_error_strategy_die = 1;
-int advice_add_nothing = 1;
+int advice_add_ignored_file = 1;
+int advice_add_empty_pathspec = 1;
 
 static int advice_use_color = -1;
 static char advice_colors[][COLOR_MAXLEN] = {
@@ -92,7 +93,8 @@ static struct {
 	{ "checkoutAmbiguousRemoteBranchName", &advice_checkout_ambiguous_remote_branch_name },
 	{ "nestedTag", &advice_nested_tag },
 	{ "submoduleAlternateErrorStrategyDie", &advice_submodule_alternate_error_strategy_die },
-	{ "addNothing", &advice_add_nothing },
+	{ "addIgnoredFile", &advice_add_ignored_file },
+	{ "addEmptyPathspec", &advice_add_empty_pathspec },
 
 	/* make this an alias for backward compatibility */
 	{ "pushNonFastForward", &advice_push_update_rejected }
diff --git a/advice.h b/advice.h
index 83287b0594..0e6e58d9f8 100644
--- a/advice.h
+++ b/advice.h
@@ -31,7 +31,8 @@ extern int advice_graft_file_deprecated;
 extern int advice_checkout_ambiguous_remote_branch_name;
 extern int advice_nested_tag;
 extern int advice_submodule_alternate_error_strategy_die;
-extern int advice_add_nothing;
+extern int advice_add_ignored_file;
+extern int advice_add_empty_pathspec;
 
 int git_default_advice_config(const char *var, const char *value);
 __attribute__((format (printf, 1, 2)))
diff --git a/builtin/add.c b/builtin/add.c
index 57b3186f69..0e66934f3a 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -390,8 +390,10 @@ static int add_files(struct dir_struct *dir, int flags)
 		fprintf(stderr, _(ignore_error));
 		for (i = 0; i < dir->ignored_nr; i++)
 			fprintf(stderr, "%s\n", dir->ignored[i]->name);
-		if (advice_add_nothing)
-			advise(_("Use -f if you really want to add them.\n"));
+		if (advice_add_ignored_file)
+			advise(_("Use -f if you really want to add them.\n"
+				"Turn this message off by running\n"
+				"\"git config advice.addIgnoredFile false\""));
 		exit_status = 1;
 	}
 
@@ -481,8 +483,10 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (require_pathspec && pathspec.nr == 0) {
 		fprintf(stderr, _("Nothing specified, nothing added.\n"));
-		if (advice_add_nothing)
-			advise( _("Maybe you wanted to say 'git add .'?\n"));
+		if (advice_add_empty_pathspec)
+			advise( _("Maybe you wanted to say 'git add .'?\n"
+				"Turn this message off by running\n"
+				"\"git config advice.addEmptyPathspec false\""));
 		return 0;
 	}
 
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index a649805369..88bc799807 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -327,6 +327,8 @@ cat >expect.err <<\EOF
 The following paths are ignored by one of your .gitignore files:
 ignored-file
 hint: Use -f if you really want to add them.
+hint: Turn this message off by running
+hint: "git config advice.addIgnoredFile false"
 EOF
 cat >expect.out <<\EOF
 add 'track-this'
-- 
2.21.0 (Apple Git-122.2)

