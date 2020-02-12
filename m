Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7B3C3B189
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 19:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1752082F
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 19:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4KuY2xH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgBLTTT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 14:19:19 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37921 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgBLTTS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 14:19:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id a9so3884038wmj.3
        for <git@vger.kernel.org>; Wed, 12 Feb 2020 11:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xGLShWRwgmgcavGpfQKxf1elrPernX+1kaC56t6YE4A=;
        b=B4KuY2xHgvLuj71eQAdmRcFZEo3okhzdGvo3pCy9FLvLp6k/AkVHybuV+L0sJycHgh
         btPNO2RvD/ltThZcWvxtSSoXovu6NNIZJ6de7cubawafuKe9XnDQmYBOUvVinLuhe6J3
         SYPjlzbNxH+Fd7fW2VCZQbCG/uIJbv72wgSvox6DfFe6Gqan1FKOJ62c0SF4rr8DRPPg
         uKhCCqSdVWB3UqUYsweBbVZicz3o616DvqHvBhAuwSzyi7QGGLVQgmB/yhIO8zm3EMW2
         4V9zUH10wWGbeRZaIwgMlloHQn8zKwrzuajBKZh+cI7/+FBLZoXMBVaIHxoCxYZvYVXO
         CCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xGLShWRwgmgcavGpfQKxf1elrPernX+1kaC56t6YE4A=;
        b=XwzDcpeAwxY4hELob0XHtXjUbNyXEfJJs7Gw2OU4opKT0SvSQVbr4RvvLZ2F7jEpxV
         UEIpN8K/w91JG2YPfGmazCQHkQMkEHT+m9BfgbYuxsxdqo5VTRwq64fV1PkMAF/vIbZF
         8S9QWmsIJrHnX2OPQi/MR52d/IoZn+gi3ZCgStZRGzAzaXHKzFjca8b8r75xeTeAiOF9
         Arz11W2CpBXnaLj812bx90+LUrKTxI0ROR7VJ+vpHYLCKOxAtqzO9W0GzPTSqrW9iQp1
         dKRTGezIW+/jBgLNXxGMnRjPk4wVfJt9DZ7vTpm1hN3oP2yJEgIWaTOg7DMoLXifRLCd
         MYCg==
X-Gm-Message-State: APjAAAWOL+ebzfEgokTqFg4oPI6rtitLm7ErYYkhz4hWip6D5I3KhbN6
        so52Z3Ef/T/DTFrEfSDQPx2g2oBX
X-Google-Smtp-Source: APXvYqyf0gW0taWkI780FpVlP1hVCo6BsufXTyWxIxEsQdIlC+A3euZw00xX0QJiC+pSVOMMBP605g==
X-Received: by 2002:a1c:b08a:: with SMTP id z132mr595119wme.73.1581535156206;
        Wed, 12 Feb 2020 11:19:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y139sm1998264wmd.24.2020.02.12.11.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 11:19:15 -0800 (PST)
Message-Id: <746d9ff810c384db8568c75472b18f8a9afec5fb.1581535151.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.545.git.1581535151.gitgitgadget@gmail.com>
References: <pull.545.git.1581535151.gitgitgadget@gmail.com>
From:   "Parth Gala via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Feb 2020 19:19:11 +0000
Subject: [PATCH 5/5] object.c: clear_commit_marks_all() accept 'r' as
 parameter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Parth Gala <parthpgala@gmail.com>,
        Parth Gala <parthpgala@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Parth Gala <parthpgala@gmail.com>

'clear_commit_marks_all()' and its callers are modified to enable
passing 'r' as an argument to 'clear_commit_marks_all()'.

Signed-off-by: Parth Gala <parthpgala@gmail.com>
---
 builtin/checkout.c | 3 ++-
 object.c           | 6 +++---
 object.h           | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index b52c490c8f..bd2b8de8b7 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -989,6 +989,7 @@ static void suggest_reattach(struct commit *commit, struct rev_info *revs)
 static void orphaned_commit_warning(struct commit *old_commit, struct commit *new_commit)
 {
 	struct rev_info revs;
+	struct repository *r = the_repository;
 	struct object *object = &old_commit->object;
 
 	repo_init_revisions(the_repository, &revs, NULL);
@@ -1011,7 +1012,7 @@ static void orphaned_commit_warning(struct commit *old_commit, struct commit *ne
 		describe_detached_head(_("Previous HEAD position was"), old_commit);
 
 	/* Clean up objects used, as they will be reused. */
-	clear_commit_marks_all(ALL_REV_FLAGS);
+	clear_commit_marks_all(r, ALL_REV_FLAGS);
 }
 
 static int switch_branches(const struct checkout_opts *opts,
diff --git a/object.c b/object.c
index 804488c8dd..2bc08d8df7 100644
--- a/object.c
+++ b/object.c
@@ -443,12 +443,12 @@ void clear_object_flags(struct repository *r, unsigned flags)
 	}
 }
 
-void clear_commit_marks_all(unsigned int flags)
+void clear_commit_marks_all(struct repository *r, unsigned int flags)
 {
 	int i;
 
-	for (i = 0; i < the_repository->parsed_objects->obj_hash_size; i++) {
-		struct object *obj = the_repository->parsed_objects->obj_hash[i];
+	for (i = 0; i < r->parsed_objects->obj_hash_size; i++) {
+		struct object *obj = r->parsed_objects->obj_hash[i];
 		if (obj && obj->type == OBJ_COMMIT)
 			obj->flags &= ~flags;
 	}
diff --git a/object.h b/object.h
index bfc95e062a..b0f0bce0a3 100644
--- a/object.h
+++ b/object.h
@@ -190,6 +190,6 @@ void clear_object_flags(struct repository *, unsigned flags);
 /*
  * Clear the specified object flags from all in-core commit objects.
  */
-void clear_commit_marks_all(unsigned int flags);
+void clear_commit_marks_all(struct repository *, unsigned int flags);
 
 #endif /* OBJECT_H */
-- 
gitgitgadget
