Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 399C920248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbfDPJfj (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:35:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43000 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfDPJfi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:35:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id w25so10106668pfi.9
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mm2P/jdEd+vOH5XoEutnNPln3XNCzup272on/Vw8dvA=;
        b=g5F3flcx/pzHgXquADik8J8yJrD7U0SVq0qrE5WjUPm5J8ejBB88l+zAh6JDAdVeTZ
         O3pAPZ/rP8JdrC3edTzeoVkVnOb4UQfD1XfeuBj/j5oBvnF2rKBBbSHUT7axop0v66eH
         czzpxP4TgpbTZMn41vSBQTO5fE1Cze+ak8zsQw2tMk26Bbp2VFHZlRLnvNLLR09Doff5
         yibCidP8SEh2DX3EEaLNx5y51igqHteMrz6hsM/r+1dY7jFSWpCul81Xy4iDmKztwl5A
         4gD/Ht+A/Tvp83zDgjxT8M9yNeU4P4EQbFjxwyo4YtN9KutepykePS6KocI74mMWq75p
         SMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mm2P/jdEd+vOH5XoEutnNPln3XNCzup272on/Vw8dvA=;
        b=nj8g1/6gYTA1T8hbRM7bpboRhRZ6BYQ17b7GLYQX0y9uukKU7aBToegJQYCxb11iPw
         HmryKx768EJ3xLoDVKm+m8wnEfxw7TPrLL5/8cVKfK+QZmFuFUbKae2zO1GIoO9Xpk0w
         dDeLe6+DH/E4/5NneNHQxh9GnCs58Bl1Jch3LUWrR1FS9Aa7IRDal1dmFZpyjNTjA8z9
         gWZpJZ5VNUVTaSH7Xv680PFjmbg88CSuL3nqxhP0esYlmz48YuVvaEb/x60Pv4/lXgRn
         u2/4E1Tw1JgukOu5g83MdF+i3rQGSPM4crHIVVWEZA2cqLCOWwPoL6RSZDjbCVTWMVCa
         XXnw==
X-Gm-Message-State: APjAAAX28xHvda7ZjEOWK0NWTmBw1PzDHLvUhtRfw5ESJgvJvqM29pHQ
        gQqWaI+MKh1jtpmSeDli2XU=
X-Google-Smtp-Source: APXvYqyPSqWJhApp2Fk2pqCJ6LWs5TdNZSGWWHsF/fNwfbu3zf2D8QRSWhtcIjA0VNOJN+t+XpClHg==
X-Received: by 2002:a65:6284:: with SMTP id f4mr75892528pgv.11.1555407338263;
        Tue, 16 Apr 2019 02:35:38 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id h19sm91532553pfd.130.2019.04.16.02.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:35:35 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:35:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 12/34] commit.c: add repo_get_commit_tree()
Date:   Tue, 16 Apr 2019 16:33:19 +0700
Message-Id: <20190416093341.17079-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190416093341.17079-1-pclouds@gmail.com>
References: <20190406113453.5149-1-pclouds@gmail.com>
 <20190416093341.17079-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the implicit dependency on the_repository in this function.
It will be used in sha1-name.c functions when they are updated to take
any 'struct repository'. get_commit_tree() remains as a compat wrapper,
to be slowly replaced later.

Any access to "maybe_tree" field directly will result in _broken_ code
after running through commit.cocci because we can't know what is the
right repository to use.

the_repository would be correct most of the time. But we're relying less
and less on the_repository and that assumption may no longer be
true. The transformation now is more of a poor man replacement for a C++
compiler catching access to private fields.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 commit.c                        | 5 +++--
 commit.h                        | 5 +++--
 contrib/coccinelle/commit.cocci | 6 +++---
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/commit.c b/commit.c
index 043ba64f17..a9e74647dc 100644
--- a/commit.c
+++ b/commit.c
@@ -345,7 +345,8 @@ static inline void set_commit_tree(struct commit *c, struct tree *t)
 	c->maybe_tree = t;
 }
 
-struct tree *get_commit_tree(const struct commit *commit)
+struct tree *repo_get_commit_tree(struct repository *r,
+				  const struct commit *commit)
 {
 	if (commit->maybe_tree || !commit->object.parsed)
 		return commit->maybe_tree;
@@ -353,7 +354,7 @@ struct tree *get_commit_tree(const struct commit *commit)
 	if (commit->graph_pos == COMMIT_NOT_FROM_GRAPH)
 		BUG("commit has NULL tree, but was not loaded from commit-graph");
 
-	return get_commit_tree_in_graph(the_repository, commit);
+	return get_commit_tree_in_graph(r, commit);
 }
 
 struct object_id *get_commit_tree_oid(const struct commit *commit)
diff --git a/commit.h b/commit.h
index 42728c2906..f1aa4c0472 100644
--- a/commit.h
+++ b/commit.h
@@ -32,7 +32,7 @@ struct commit {
 
 	/*
 	 * If the commit is loaded from the commit-graph file, then this
-	 * member may be NULL. Only access it through get_commit_tree()
+	 * member may be NULL. Only access it through repo_get_commit_tree()
 	 * or get_commit_tree_oid().
 	 */
 	struct tree *maybe_tree;
@@ -143,7 +143,8 @@ void repo_unuse_commit_buffer(struct repository *r,
  */
 void free_commit_buffer(struct parsed_object_pool *pool, struct commit *);
 
-struct tree *get_commit_tree(const struct commit *);
+struct tree *repo_get_commit_tree(struct repository *, const struct commit *);
+#define get_commit_tree(c) repo_get_commit_tree(the_repository, c)
 struct object_id *get_commit_tree_oid(const struct commit *);
 
 /*
diff --git a/contrib/coccinelle/commit.cocci b/contrib/coccinelle/commit.cocci
index 663658a127..d03453341e 100644
--- a/contrib/coccinelle/commit.cocci
+++ b/contrib/coccinelle/commit.cocci
@@ -23,12 +23,12 @@ expression s;
 // These excluded functions must access c->maybe_tree direcly.
 // Note that if c->maybe_tree is written somewhere outside of these
 // functions, then the recommended transformation will be bogus with
-// get_commit_tree() on the LHS.
+// repo_get_commit_tree() on the LHS.
 @@
-identifier f !~ "^(get_commit_tree|get_commit_tree_in_graph_one|load_tree_for_commit|set_commit_tree)$";
+identifier f !~ "^(repo_get_commit_tree|get_commit_tree_in_graph_one|load_tree_for_commit|set_commit_tree)$";
 expression c;
 @@
   f(...) {<...
 - c->maybe_tree
-+ get_commit_tree(c)
++ repo_get_commit_tree(specify_the_right_repo_here, c)
   ...>}
-- 
2.21.0.682.g30d2204636

