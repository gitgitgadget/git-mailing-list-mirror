Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EEBC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 02:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FCDA61039
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 02:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239426AbhHaC1p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 22:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239401AbhHaC1k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 22:27:40 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC47DC06175F
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 19:26:45 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so1276653wml.3
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 19:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QI5qretF2TJiQDKwvqhE1t94m4tk2N3sba0TcQX4VT0=;
        b=Lxnh8Zo0yVfApnas//IC+tppa8rTXv/qiSym81sHcJoWrAQFvGdOqDDVNbIk4V6/TR
         ZcZHAxqVavJ07kQ36Tdnp9GkxBWNTLs/5fRUN6p6k2ZVzkq3f2CqPw+a3k60Kjh+JzEl
         4wm1p4IAVLPxAmYiauQvu3+pgdXWHT4hhID0viUoiSvecFFaPZU++CJiZS8be8BYtmCW
         URt3GiMr3grYIqcEHV/9E0Qi2kw63JwDYfAq5/M+1+I1gyuHkgxr88q9/QbBrcisc6nL
         whxIBovUjaAkWz5hUfk791Wkjcq0FFwlASokTTW0F76lSYBzIIMFZQDe/yRN+BnPrdGW
         i2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QI5qretF2TJiQDKwvqhE1t94m4tk2N3sba0TcQX4VT0=;
        b=jeFs7hn/HXiv6Axtq2jL+PuLlYJEo9cpDmtHFJDzyDToLHVsHHOqYNEWiaH6yY9Z1y
         m54slgIolyMqZJfUtoF87AYkLXOkvvu97yeXgkfrWKg0OX3dbqPhQG0y8AFzLCekOPpf
         YxXP8qEY7PaPN2RLSOvAXQRwV+fzjZ/hnuSyRiezLbxkwsUOh1fuLHvygi1Y0jVhBBuY
         Rh6LOu2mSrwT0pVYYwsl8OARTGCWXgVFb+fD05WXaz3bNjN+y1TBbgMOHXvbUOodHc88
         BlUYZc9OVe0JfOybf4Pme3pVfQx7TIhq/gy99CtGcC6ogC90fDnIMhO1xOI9J3/Wcf1l
         fNAQ==
X-Gm-Message-State: AOAM531MO1XIa8+bsgO/TPz+A27z4dfOuAkCt8atrQb1PWH5UUJiiHEY
        ZXeN0q9KrOSBPzQ6Xj7uuLp+SGrMldY=
X-Google-Smtp-Source: ABdhPJwOmOLPjkTNFQBbzqI/oiN71bXLl52fHUCGhZ/AWTpJ98+CnsGjvyJT48ujbnc53f7kHOA1Xg==
X-Received: by 2002:a1c:c918:: with SMTP id f24mr1749983wmb.61.1630376804451;
        Mon, 30 Aug 2021 19:26:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v5sm16562856wrw.44.2021.08.30.19.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 19:26:44 -0700 (PDT)
Message-Id: <67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Aug 2021 02:26:38 +0000
Subject: [PATCH 5/7] tmp-objdir: new API for creating and removing primary
 object dirs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The tmp_objdir API provides the ability to create temporary object
directories, but was designed with the goal of having subprocesses
access these object stores, followed by the main process migrating
objects from it to the main object store or just deleting it.  The
subprocesses would view it as their primary datastore and write to it.

For the --remerge-diff option we want to add to show & log, we want all
writes of intermediate merge results (both blobs and trees) to go to
this alternate object store; since those writes will be done by the main
process, we need this "alternate" object store to actually be the
primary object store.  When show & log are done, they'll simply remove
this temporary object store.

We also need one more thing -- `git log --remerge-diff` can cause the
temporary object store to fill up with loose objects.  Rather than
trying to gc that are known garbage anyway, we simply want to know the
location of the temporary object store so we can purge the loose objects
after each merge.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 tmp-objdir.c | 29 +++++++++++++++++++++++++++++
 tmp-objdir.h | 16 ++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/tmp-objdir.c b/tmp-objdir.c
index b8d880e3626..9f75a75d1c0 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -288,7 +288,36 @@ const char **tmp_objdir_env(const struct tmp_objdir *t)
 	return t->env.v;
 }
 
+const char *tmp_objdir_path(struct tmp_objdir *t)
+{
+	return t->path.buf;
+}
+
 void tmp_objdir_add_as_alternate(const struct tmp_objdir *t)
 {
 	add_to_alternates_memory(t->path.buf);
 }
+
+void tmp_objdir_make_primary(struct repository *r, const struct tmp_objdir *t)
+{
+	struct object_directory *od;
+	od = xcalloc(1, sizeof(*od));
+
+	od->path = xstrdup(t->path.buf);
+	od->next = r->objects->odb;
+	r->objects->odb = od;
+}
+
+void tmp_objdir_remove_as_primary(struct repository *r,
+				  const struct tmp_objdir *t)
+{
+	struct object_directory *od;
+
+	od = r->objects->odb;
+	if (strcmp(t->path.buf, od->path))
+		BUG("expected %s as primary object store; found %s",
+		    t->path.buf, od->path);
+	r->objects->odb = od->next;
+	free(od->path);
+	free(od);
+}
diff --git a/tmp-objdir.h b/tmp-objdir.h
index b1e45b4c75d..6067da24e8c 100644
--- a/tmp-objdir.h
+++ b/tmp-objdir.h
@@ -19,6 +19,7 @@
  *
  */
 
+struct repository;
 struct tmp_objdir;
 
 /*
@@ -33,6 +34,11 @@ struct tmp_objdir *tmp_objdir_create(void);
  */
 const char **tmp_objdir_env(const struct tmp_objdir *);
 
+/*
+ * Return the path used for the temporary object directory.
+ */
+const char *tmp_objdir_path(struct tmp_objdir *t);
+
 /*
  * Finalize a temporary object directory by migrating its objects into the main
  * object database, removing the temporary directory, and freeing any
@@ -51,4 +57,14 @@ int tmp_objdir_destroy(struct tmp_objdir *);
  */
 void tmp_objdir_add_as_alternate(const struct tmp_objdir *);
 
+/*
+ * Add the temporary object directory as the *primary* object store in the
+ * current process, turning the previous primary object store into an
+ * alternate.
+ */
+void tmp_objdir_make_primary(struct repository *r,
+			     const struct tmp_objdir *t);
+void tmp_objdir_remove_as_primary(struct repository *r,
+				  const struct tmp_objdir *t);
+
 #endif /* TMP_OBJDIR_H */
-- 
gitgitgadget

