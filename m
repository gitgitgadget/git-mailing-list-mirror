Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F0FF1F935
	for <e@80x24.org>; Fri, 23 Sep 2016 11:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759036AbcIWLNR (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 07:13:17 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33804 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758875AbcIWLNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 07:13:16 -0400
Received: by mail-pa0-f66.google.com with SMTP id i5so1803747pad.1
        for <git@vger.kernel.org>; Fri, 23 Sep 2016 04:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uYlaR1ljJ2XVmYB377toON09JH6uUaXR7zns3EUGJ1M=;
        b=Tzt4v/Yxmb2NRHE9C4EPLkzZXR4Cuz4ehPOCxD2tMqx/qN2kOvuKrmGLurM+icf9Tv
         iljyV3w/yUC7laF846ylR5nB5Eb5Zx+y60RqWnrrDPDLjfgleXBN10O6AvtwVIm4fw2U
         Drc8uHFHfFa+Ci2xbfkis3sH3iN4TpdA5NUeTfsIv2YHL9D9DaudCjkrcQTe1yjBOVZ7
         fB2D/Xt4s2SZGpikapNNbUhRt8xWGuMyZJ07awngY1b4qwWUVjAP0LEig9FqyIBugiwC
         BHOjt76lFCKrLzhAh0CHqNQ+tVyFd6mqM34OKkSL6OZ8Sbp+155oz0cGIoMzDFdl+Opg
         fX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uYlaR1ljJ2XVmYB377toON09JH6uUaXR7zns3EUGJ1M=;
        b=GVdrAol+NXhrSELes3zXF0JWhM94bvBgFt8vB6XSwO3emSwP/X3LJqQOL8/BjQGiuQ
         kchLC1/pAeFFnNTyKtCqS7YGY7IWtu1guPWorn2x8YL2r+9HtJbYCSmLUIYuZtgvBbPI
         he82vqS/6XGH6zjODNCNpgbf19ifQV5TGsII2RrrdCHxVEQLrXX7IX7CH05tPlpe98lT
         LGItbq0Hti6JFhgD/6MT/5akn2AKRYSMRzXkX4xSH1eZitS5DOYTy7y0k7ihLd4jTTeS
         h3LSt1b33nvD3WpjIpDNj6PIhOOG3BvU0HcxcohwUBU5Yg5HhTf/rpq3msVDT2bFGDuW
         939w==
X-Gm-Message-State: AE9vXwM+tB3NOR+6VrB84TsVNR3pmcj8Yfu4f80cvBiJVbh+fAaV5bCe1KYvFi4T/dO9PQ==
X-Received: by 10.66.27.137 with SMTP id t9mr11392055pag.11.1474629195166;
        Fri, 23 Sep 2016 04:13:15 -0700 (PDT)
Received: from ash ([115.76.130.63])
        by smtp.gmail.com with ESMTPSA id v6sm10868089pfv.8.2016.09.23.04.13.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Sep 2016 04:13:14 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 23 Sep 2016 18:13:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, git@drmicha.warpmail.net,
        max.nordlund@sqore.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 4/3] init: combine set_git_dir_init() and init_db() into one
Date:   Fri, 23 Sep 2016 18:12:06 +0700
Message-Id: <20160923111206.8596-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <xmqqbmzf6e0r.fsf@gitster.mtv.corp.google.com>
References: <xmqqbmzf6e0r.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit "init: do not set core.worktree more often than necessary" adds a
subtle dependency between set_git_dir_init() and init_db(). The former
_must_ be called before init_db() so that original_git_dir can be set
properly. If something else, like enter_repo() or setup_git_directory(),
is used instead, the trick in that commit breaks down.

To eliminate the possibility that init_db() in future may be called
without set_git_dir_init(), init_db() now calls that function internally
(and does not allow anybody else to use it).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 I think a separate commit for this is better than combining back to
 2/3 so we can explain the problem properly (without making 2/3 commit
 message even longer)

 Not sure if you want to s/contains/contain/ in 2/3 by yourself or I
 should resend the whole series. Let me know.

 builtin/clone.c   | 15 +++++++--------
 builtin/init-db.c | 18 +++++++++++-------
 cache.h           |  5 +++--
 3 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 6616392..29b1832 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -928,23 +928,22 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		set_git_work_tree(work_tree);
 	}
 
-	junk_git_dir = git_dir;
+	junk_git_dir = real_git_dir ? real_git_dir : git_dir;
 	if (safe_create_leading_directories_const(git_dir) < 0)
 		die(_("could not create leading directories of '%s'"), git_dir);
 
-	set_git_dir_init(git_dir, real_git_dir, 0);
-	if (real_git_dir) {
-		git_dir = real_git_dir;
-		junk_git_dir = real_git_dir;
-	}
-
 	if (0 <= option_verbosity) {
 		if (option_bare)
 			fprintf(stderr, _("Cloning into bare repository '%s'...\n"), dir);
 		else
 			fprintf(stderr, _("Cloning into '%s'...\n"), dir);
 	}
-	init_db(option_template, INIT_DB_QUIET);
+
+	init_db(git_dir, real_git_dir, option_template, INIT_DB_QUIET);
+
+	if (real_git_dir)
+		git_dir = real_git_dir;
+
 	write_config(&option_config);
 
 	git_config(git_default_config, NULL);
diff --git a/builtin/init-db.c b/builtin/init-db.c
index d70fc45..ee7942f 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -312,8 +312,9 @@ static void create_object_directory(void)
 	strbuf_release(&path);
 }
 
-int set_git_dir_init(const char *git_dir, const char *real_git_dir,
-		     int exist_ok)
+static int set_git_dir_init(const char *git_dir,
+			    const char *real_git_dir,
+			    int exist_ok)
 {
 	original_git_dir = xstrdup(real_path(git_dir));
 
@@ -362,10 +363,14 @@ static void separate_git_dir(const char *git_dir)
 	write_file(git_link, "gitdir: %s", git_dir);
 }
 
-int init_db(const char *template_dir, unsigned int flags)
+int init_db(const char *git_dir, const char *real_git_dir,
+	    const char *template_dir, unsigned int flags)
 {
 	int reinit;
-	const char *git_dir = get_git_dir();
+
+	set_git_dir_init(git_dir, real_git_dir, flags & INIT_DB_EXIST_OK);
+
+	git_dir = get_git_dir();
 
 	if (git_link)
 		separate_git_dir(git_dir);
@@ -585,7 +590,6 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			set_git_work_tree(work_tree);
 	}
 
-	set_git_dir_init(git_dir, real_git_dir, 1);
-
-	return init_db(template_dir, flags);
+	flags |= INIT_DB_EXIST_OK;
+	return init_db(git_dir, real_git_dir, template_dir, flags);
 }
diff --git a/cache.h b/cache.h
index b2d77f3..7fc875f 100644
--- a/cache.h
+++ b/cache.h
@@ -525,9 +525,10 @@ extern void verify_non_filename(const char *prefix, const char *name);
 extern int path_inside_repo(const char *prefix, const char *path);
 
 #define INIT_DB_QUIET 0x0001
+#define INIT_DB_EXIST_OK 0x0002
 
-extern int set_git_dir_init(const char *git_dir, const char *real_git_dir, int);
-extern int init_db(const char *template_dir, unsigned int flags);
+extern int init_db(const char *git_dir, const char *real_git_dir,
+		   const char *template_dir, unsigned int flags);
 
 extern void sanitize_stdfds(void);
 extern int daemonize(void);
-- 
2.8.2.524.g6ff3d78

