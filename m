Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11F88209A9
	for <e@80x24.org>; Wed, 21 Sep 2016 11:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932484AbcIULaR (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 07:30:17 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34228 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932289AbcIULaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 07:30:16 -0400
Received: by mail-pf0-f193.google.com with SMTP id 21so2296834pfy.1
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 04:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RWIPnXvPGR69PuDtZzldOuMyJFwDgnVuyxRGHEplYOU=;
        b=Tp52Ey29rJG9SV7KuGPbh8SWMbPn5oRTPfdrAKaUMml38cqLSKhz0GX+klnzhDPJlh
         7mX0D4ra7q50+l4wiIs/T9j4FkhhE1jM8h3C84pk/hys2dhSQFYXorpwEATzBHK3/Bh8
         NmUUnjCxyT8QknAR7O01EGRPJQlnVOETclyrYITh14vPoQGq6+UnCg2Ee3Q9HsMsaqbL
         6ZHFmMW6r1EY5nDl+s5EOFq9JTwHGkWrlatEzGuOEs0RZeNW6yJs3F5u4AfBvqFvyn5B
         x4wGZJLRzf+ftdADu2VtvxGFdoBv6daBw/QlZbdfDl4GA1wBjndJyP33yWw7mWGtmjsb
         Z6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RWIPnXvPGR69PuDtZzldOuMyJFwDgnVuyxRGHEplYOU=;
        b=jky6fAzESFqgQs9TCW3RXMG1GkRP6UyjO3ninA+VRQbSbYXwt8y5yhRsyOw9ftgS7z
         F4HvTMOGNe3Es26pWJsPVFca/w89uW2xJDEm7lpYM5xM4dgcJL+nwTqMNgxkzLw3WgmP
         Y/UqTYzK5D26J/k+R9eSCH/aTTP+kj4GdlMRGepXOzVBUCPznq0b5Mt0rhVcuO7I/Slg
         K67tRNxf9NNyZOkpEEvXdNNqaoF0jP3bz+Iq11tGz6LR50YnOgQhizgUcBECb5wwh5rS
         EYNKMORj9eMUqYELUgroLbVSbdIfv2kELapopWN1YHdFgqGDmJr5sF0GyUnWHvtOEjpW
         KiTg==
X-Gm-Message-State: AE9vXwPf2X8o7jMfK3v0mPyirCd9SSk6OeCUyDhPwDOOMvkHyhak81EFqaJCS5eg+zcuPw==
X-Received: by 10.98.4.70 with SMTP id 67mr36103921pfe.24.1474457415322;
        Wed, 21 Sep 2016 04:30:15 -0700 (PDT)
Received: from ash ([115.76.130.63])
        by smtp.gmail.com with ESMTPSA id x126sm86050417pfx.61.2016.09.21.04.30.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Sep 2016 04:30:14 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 21 Sep 2016 18:30:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, git@drmicha.warpmail.net,
        max.nordlund@sqore.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 2/3] init: do not set core.worktree more often than necessary
Date:   Wed, 21 Sep 2016 18:29:38 +0700
Message-Id: <20160921112939.3444-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160921112939.3444-1-pclouds@gmail.com>
References: <20160908134719.27955-1-pclouds@gmail.com>
 <20160921112939.3444-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "git init" is called with GIT_WORK_TREE environment set, we want to
keep this worktree's location in core.worktree so the user does not have
to set the environment again and again. See ef6f0af (git-init: set
core.worktree if GIT_WORK_TREE is specified - 2007-07-04)

We detect that by this logic (in needs_work_tree_config): normally
worktree's top dir would contains ".git" directory, if this is not true,
worktree is probably set to elsewhere by the user.

Unfortunately when it calls get_git_dir() it does not take ".git" files
into account. When we find a .git file, we immediately follow the file
until we find the real ".git" directory. The location of this first
".git" file is lost.

The .git file would satisfy the logic above and not create
core.worktree (correct). But because the final .git's location is used,
needs_work_tree_config() is misled and creates core.worktree anyway.

This would not be a huge deal normally. But if this happens in a
multiple worktree setup it becomes a real problem because up until now,
core.worktree will be applied to the main worktree only. If you
accidentally do "git init" from a linked worktree, you set
core.worktree (for the main repo) pointing to the _linked_ worktree.
After that point, may you live in interesting times.

Record the .git file location and use it here.

PS. real_path() resolves symlinks So original_git_dir is not truly
original if '.git' is a symlink. Hopefully it's not longer used in favor
of .git files.

Noticed-by: Max Nordlund <max.nordlund@sqore.com>
Helped-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/init-db.c | 5 ++++-
 t/t0001-init.sh   | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index d5d7558..0d5cc76 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -23,6 +23,7 @@ static int init_is_bare_repository = 0;
 static int init_shared_repository = -1;
 static const char *init_db_template_dir;
 static const char *git_link;
+static const char *original_git_dir;
 
 static void copy_templates_1(struct strbuf *path, struct strbuf *template,
 			     DIR *dir)
@@ -263,7 +264,7 @@ static int create_default_files(const char *template_path)
 		/* allow template config file to override the default */
 		if (log_all_ref_updates == -1)
 			git_config_set("core.logallrefupdates", "true");
-		if (needs_work_tree_config(get_git_dir(), work_tree))
+		if (needs_work_tree_config(original_git_dir, work_tree))
 			git_config_set("core.worktree", work_tree);
 	}
 
@@ -314,6 +315,8 @@ static void create_object_directory(void)
 int set_git_dir_init(const char *git_dir, const char *real_git_dir,
 		     int exist_ok)
 {
+	original_git_dir = xstrdup(real_path(git_dir));
+
 	if (real_git_dir) {
 		struct stat st;
 
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 488564b..b8fc588 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -400,9 +400,11 @@ test_expect_success 're-init from a linked worktree' '
 		test_commit first &&
 		git worktree add ../linked-worktree &&
 		mv .git/info/exclude expected-exclude &&
+		cp .git/config expected-config &&
 		find .git/worktrees -print | sort >expected &&
 		git -C ../linked-worktree init &&
 		test_cmp expected-exclude .git/info/exclude &&
+		test_cmp expected-config .git/config &&
 		find .git/worktrees -print | sort >actual &&
 		test_cmp expected actual
 	)
-- 
2.8.2.524.g6ff3d78

