Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4BFE1F404
	for <e@80x24.org>; Sat, 17 Mar 2018 22:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbeCQWFl (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 18:05:41 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45977 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751722AbeCQWFk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 18:05:40 -0400
Received: by mail-wr0-f195.google.com with SMTP id h2so14898583wre.12
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 15:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hgWmpz92rbERxQGxyuJwDZRRQQJiN2srlZRcSaAJd2o=;
        b=oQ02zsn+vLL14QW3Cps0Kw3C7YSX48JH6zdcUtAURDCV8/a7v2EoOapJ+Ngc9V7DTO
         T/aTFM6PiPrtYJnRmkYQJAthomW6RdcRYltBQ4Wv8YdqxvarsFN/I6fBvKCQnkuVkvLg
         FrDFKNeZCi3dMGGYB4O6dkcu5lnce4ligmumVo0rzHL4/5/oQWkBPDRn2So7MZgydTKa
         LJu+hj5R+O8Yr9HCM9elIfyacudJoy2jSZmC7qqlA8EfA6TVsGceLPzWf8tWGgrF56s6
         UpM3Md4S7bNMKF09iqFY4KSh68A2+0fh+s6mTEA0VWAmWzw/aYBPJ2NBrWy//Ilpk2Wm
         XeQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hgWmpz92rbERxQGxyuJwDZRRQQJiN2srlZRcSaAJd2o=;
        b=NJBl5ISwxlfTOnVa3X9rKwfbBA+9etQYeFlAOK89pFRtLZwwbeZpHayOeEz3OSu0o9
         GH5XMlrW/hU80o8gi7auEYDctXxKyFH2IGVBaolyLQjjrZlUUxZ2Uk+J8LazqdCPb4e0
         z9uw6bwT4EOF7fqaE1c06pJoH6cETRMqTzFeSpasOhW8RAufwg17U/V2YzsMaxR0R/YC
         xhw+HJ/I2rb1UkxkwlzZbgFZNsGWMJ/19WbqrpKVqmqB0Hlubgq4WhhkShfH3YsprnQu
         kCz7W/scW27J7cQR9s1R6CGBKJrYyEaJx0BsY87lm3Ho3DNnaQyJbNcaPTp67I9FvGvK
         VoDw==
X-Gm-Message-State: AElRT7EPz5AkARy7FFg8V0UJu9LPZuLx4DComsz4AnB9DsjAz7TkE6V7
        xLjydxDvWNKzs4l2j1cz/iRA01Fr
X-Google-Smtp-Source: AG47ELvLgj30dNb3r5aE2EfbO0mWbQzG/69C+GySvthXKKaJ8NsoakshOWYM23U+czWbe3JY2Ujz1Q==
X-Received: by 10.223.169.215 with SMTP id b81mr5111610wrd.48.1521324338230;
        Sat, 17 Mar 2018 15:05:38 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 63sm124185wrn.7.2018.03.17.15.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Mar 2018 15:05:36 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 0/4] worktree: teach "add" to check out existing branches
Date:   Sat, 17 Mar 2018 22:08:26 +0000
Message-Id: <20180317220830.30963-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f06
In-Reply-To: <20180204221305.28300-1-t.gummerer@gmail.com>
References: <20180204221305.28300-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previous rounds are at <20180121120208.12760-1-t.gummerer@gmail.com>
and <20180204221305.28300-1-t.gummerer@gmail.com>.  Thanks Duy, Eric
and Junio for the comments on the previous round.

Junio: I know it is the rc period right now, but the topic is also
already queued in 'pu', so I wasn't sure if you prefer me submitting
this now, or after 2.17 is released.  I'm happy to resend this once
2.17 is out if that makes it easier for you.

This round improves the end user facing messages, and factors out a
dwim_branch function as suggested by Duy.

Interdiff below:

diff --git a/builtin/worktree.c b/builtin/worktree.c
index ea420bb90b..b5d273751f 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -304,8 +304,6 @@ static int add_worktree(const char *path, const char *refname,
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, "../..");
 
-	fprintf(stderr, _("Preparing %s (identifier %s)"), path, name);
-
 	argv_array_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
 	argv_array_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
 	cp.git_cmd = 1;
@@ -322,12 +320,12 @@ static int add_worktree(const char *path, const char *refname,
 		goto done;
 
 	if (opts->checkout_existing_branch)
-		fprintf(stderr, _(", checking out existing branch '%s'"),
+		fprintf(stderr, _("checking out branch '%s'"),
 			refname);
 	else if (opts->new_branch)
-		fprintf(stderr, _(", creating new branch '%s'"), opts->new_branch);
+		fprintf(stderr, _("creating branch '%s'"), opts->new_branch);
 
-	fprintf(stderr, _(", setting HEAD to %s"),
+	fprintf(stderr, _("worktree HEAD is now at %s"),
 		find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
 
 	strbuf_reset(&sb);
@@ -373,6 +371,32 @@ static int add_worktree(const char *path, const char *refname,
 	return ret;
 }
 
+static const char *dwim_branch(const char *path, struct add_opts *opts)
+{
+	int n;
+	const char *s = worktree_basename(path, &n);
+	const char *branchname = xstrndup(s, n);
+	struct strbuf ref = STRBUF_INIT;
+
+	if (!strbuf_check_branch_ref(&ref, branchname) &&
+	    ref_exists(ref.buf)) {
+		*branch = branchname;
+		opts->checkout_existing_branch = 1;
+		strbuf_release(&ref);
+		UNLEAK(branchname);
+		return branchname;
+	}
+
+	opts->new_branch = branchname;
+	if (guess_remote) {
+		struct object_id oid;
+		const char *remote =
+			unique_tracking_name(opts->new_branch, &oid);
+		return remote;
+	}
+	return NULL;
+}
+
 static int add(int ac, const char **av, const char *prefix)
 {
 	struct add_opts opts;
@@ -425,27 +449,9 @@ static int add(int ac, const char **av, const char *prefix)
 	}
 
 	if (ac < 2 && !opts.new_branch && !opts.detach) {
-		int n;
-		const char *s = worktree_basename(path, &n);
-		const char *branchname = xstrndup(s, n);
-		struct strbuf ref = STRBUF_INIT;
-
-		if (!strbuf_check_branch_ref(&ref, branchname) &&
-		    ref_exists(ref.buf)) {
-			branch = branchname;
-			opts.checkout_existing_branch = 1;
-			UNLEAK(branch);
-		} else {
-			opts.new_branch = branchname;
-			if (guess_remote) {
-				struct object_id oid;
-				const char *remote =
-					unique_tracking_name(opts.new_branch, &oid);
-				if (remote)
-					branch = remote;
-			}
-		}
-		strbuf_release(&ref);
+		const char *dwim_branchname = dwim_branch(path, &opts);
+		if (dwim_branchname)
+			branch = dwim_branchname;
 	}
 
 	if (ac == 2 && !opts.new_branch && !opts.detach) {

Thomas Gummerer (4):
  worktree: improve message when creating a new worktree
  worktree: be clearer when "add" dwim-ery kicks in
  worktree: factor out dwim_branch function
  worktree: teach "add" to check out existing branches

 Documentation/git-worktree.txt |  9 +++--
 builtin/worktree.c             | 60 +++++++++++++++++++++++++---------
 t/t2025-worktree-add.sh        | 15 +++++++--
 3 files changed, 64 insertions(+), 20 deletions(-)

-- 
2.17.0.rc0.231.g781580f06
