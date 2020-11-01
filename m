Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955F1C4742C
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 17:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60B4022265
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 17:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWTCpBaq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgKAR3B (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 12:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgKAR24 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 12:28:56 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DBDC061A04
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 09:28:56 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h22so7309659wmb.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 09:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Qp9LJkMZYRVCG5zfjufBRRQ52gm6+FiPNG9T/qFDJ5g=;
        b=rWTCpBaqESYOlcLJMwRfaERcJz3ufLibXftmiDxBqoTu72y6RgUt0UsRb/ZoQ+Rt1s
         S3cwk0ouEfixX0mSJUdNbvSTm6du8kYFRuz7GAYzqR5O9bisqi5vKy8jfXD2BwcsecsG
         x/ZccJtSpPoN3g7+WHk3r2IwRJ6l3Xf4BniUAvydYzaP0d/mkhYLaUg2SPLHXguNs2en
         JOUKq9ueKXt+cWXNG4+mkgkTvuwEGwf+q8m4yktrb79CqsaLt8JMSDOVIL1wuLf5+9Zv
         fUqxmEH03Lgsp1/5CmfwG9pEy4jeIA6XrnucX4S2zUxSUErgOdxTsReJWDIXJQW4nc6U
         5esQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Qp9LJkMZYRVCG5zfjufBRRQ52gm6+FiPNG9T/qFDJ5g=;
        b=L+JP2Ssb+fJ3Q08/JhY0noUhZ8MeWxTu7YCn8cga4y6hAV2ivNmQn8LKLuOF+50k8N
         9NiN2Vv5NixdoDON3IZ/xT8FOnIgb48n5qwG+7FdX/+YWA4yGCHZIaleGUIf/B3mN+uI
         +jj8QA4Dna6QohfQ4NKTpHDr+AN25hJOmlTvhE/FMWSgyQDeFBBgGzPUjON//qz8qPJG
         KZlym9yVryCqvNkshyJnMIEfLSU+oWDmI8ebicOru6VzKANm/ZVRGVHX6ffQGDYeYnzc
         n3XwDIHWO50uux/YRIu1n6E5Oh2rdRjUbLAOdHF83ubU13AV1pO6tXm60qiDow/5hkoA
         lGpw==
X-Gm-Message-State: AOAM533UZ0KWEDbkXoVWgT6v1eJ0pN3V63ltjBERYxrH9sZlFOWVU5Uu
        Syb+lm5cP6UPRZKYVqXprqERX4ZLtOA=
X-Google-Smtp-Source: ABdhPJyeOntwsk+8Ar+uSKdxdwz198pdJJ/KILOYeiHqkogfRs2LcaQD1pI86fTXdmh+4cXJ1GlKxw==
X-Received: by 2002:a7b:cc92:: with SMTP id p18mr13839091wma.116.1604251735017;
        Sun, 01 Nov 2020 09:28:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a12sm4067824wrr.31.2020.11.01.09.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 09:28:54 -0800 (PST)
Message-Id: <3b28696e51a9ba370d25b70844b9fb57a4bfaab2.1604251728.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.774.v2.git.1604251727.gitgitgadget@gmail.com>
References: <pull.774.git.1603889270.gitgitgadget@gmail.com>
        <pull.774.v2.git.1604251727.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 01 Nov 2020 17:28:46 +0000
Subject: [PATCH v2 7/8] blame: simplify 'setup_scoreboard' interface
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The previous commit moved the initialization of 'sb.path' in
'builtin/blame.c::cmd_blame' before the call to
'blame.c::setup_scoreboard'. Since 'cmd_blame' is the only caller of
'setup_scoreboard', it is now unnecessary for 'setup_scoreboard' to
receive 'path' as a separate argument, as 'sb.path' is already
initialized.

Remove this argument from setup_scoreboard's interface and use the
'path' field of the 'sb' 'struct blame_scoreboard' instead.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 blame.c         | 11 +++++------
 blame.h         |  1 -
 builtin/blame.c |  2 +-
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/blame.c b/blame.c
index 686845b2b4..128cb7ba55 100644
--- a/blame.c
+++ b/blame.c
@@ -2764,7 +2764,6 @@ void init_scoreboard(struct blame_scoreboard *sb)
 }
 
 void setup_scoreboard(struct blame_scoreboard *sb,
-		      const char *path,
 		      struct blame_origin **orig)
 {
 	const char *final_commit_name = NULL;
@@ -2803,7 +2802,7 @@ void setup_scoreboard(struct blame_scoreboard *sb,
 		setup_work_tree();
 		sb->final = fake_working_tree_commit(sb->repo,
 						     &sb->revs->diffopt,
-						     path, sb->contents_from);
+						     sb->path, sb->contents_from);
 		add_pending_object(sb->revs, &(sb->final->object), ":");
 	}
 
@@ -2846,12 +2845,12 @@ void setup_scoreboard(struct blame_scoreboard *sb,
 		sb->final_buf_size = o->file.size;
 	}
 	else {
-		o = get_origin(sb->final, path);
+		o = get_origin(sb->final, sb->path);
 		if (fill_blob_sha1_and_mode(sb->repo, o))
-			die(_("no such path %s in %s"), path, final_commit_name);
+			die(_("no such path %s in %s"), sb->path, final_commit_name);
 
 		if (sb->revs->diffopt.flags.allow_textconv &&
-		    textconv_object(sb->repo, path, o->mode, &o->blob_oid, 1, (char **) &sb->final_buf,
+		    textconv_object(sb->repo, sb->path, o->mode, &o->blob_oid, 1, (char **) &sb->final_buf,
 				    &sb->final_buf_size))
 			;
 		else
@@ -2861,7 +2860,7 @@ void setup_scoreboard(struct blame_scoreboard *sb,
 		if (!sb->final_buf)
 			die(_("cannot read blob %s for path %s"),
 			    oid_to_hex(&o->blob_oid),
-			    path);
+			    sb->path);
 	}
 	sb->num_read_blob++;
 	prepare_lines(sb);
diff --git a/blame.h b/blame.h
index b6bbee4147..e8c185c8ef 100644
--- a/blame.h
+++ b/blame.h
@@ -181,7 +181,6 @@ const char *blame_nth_line(struct blame_scoreboard *sb, long lno);
 
 void init_scoreboard(struct blame_scoreboard *sb);
 void setup_scoreboard(struct blame_scoreboard *sb,
-		      const char *path,
 		      struct blame_origin **orig);
 void setup_blame_bloom_data(struct blame_scoreboard *sb,
 			    const char *path);
diff --git a/builtin/blame.c b/builtin/blame.c
index f2e528fcbc..5d8f4c4599 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1085,7 +1085,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	build_ignorelist(&sb, &ignore_revs_file_list, &ignore_rev_list);
 	string_list_clear(&ignore_revs_file_list, 0);
 	string_list_clear(&ignore_rev_list, 0);
-	setup_scoreboard(&sb, path, &o);
+	setup_scoreboard(&sb, &o);
 
 	/*
 	 * Changed-path Bloom filters are disabled when looking
-- 
gitgitgadget

