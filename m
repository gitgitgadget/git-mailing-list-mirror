Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD5BC2021E
	for <e@80x24.org>; Tue, 22 Nov 2016 10:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755879AbcKVKBL (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 05:01:11 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34070 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755836AbcKVKBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 05:01:09 -0500
Received: by mail-pf0-f193.google.com with SMTP id y68so1122699pfb.1
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 02:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ieRD3CvhV/9N/jGu48Siuv3MLYJUKTFh6LM24JBXhNg=;
        b=piem21E6IsIBmEcd6gHHm1y/aA3ZdLpcFUUVhMa6VWdGWR4KF/r0VugQXwl7QLaO7G
         SRlOutITVyA0R34Pqf1rN5/26dLD+0ZPfNPuLDzx2vQQTLKXHzNRX3AhvvUOuNhq41JR
         jLMXPqliTzmQoOxLG3N1PD1kzEYz9OOeBOOWL+2iMn9WxcfPl71tNmIvkbbZAzV0yhyN
         gIjEgmr7xr9+juumbgumqq+wWJ8jvfu1pzAfzGDlQm4n/mdVxhyh5Ff5f2dqJ98g/SGa
         uW1SPJLUROJ12xc0s8iXv3oOh7KQQapUzQtSRGkrHnEpRxJpPko1oeW2fxqfRQoxIqGS
         MDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ieRD3CvhV/9N/jGu48Siuv3MLYJUKTFh6LM24JBXhNg=;
        b=cUafBsX6nHBRDgKEjoPAWfYC03mvmBVeCoV7UOHwaLSeOWHVg6/oZRt+Le24Gkw67p
         iXyO+hz1Ga9z2UuUyYrRbRFoXXxxALNWgXMRxZaPliDzgjIx5ggBix97rAiHYMzVcJzq
         yvojsN2oPjftnNH9UABuZn0ncrD35ne2VgIyqDaGjUtu5zWuqGuUYRp+HDm1Vw0Wnfst
         7j0pzAwT5rMxTyMlpd2VxAiniXYMTpqKWD9+IjHNUzTmxZlUis5TTb5KGp8RBDFUj5dh
         ezrDP3Hep14qf6swpKlLnLxRVWiw228UmvunKo+liOZrg5GICvYblrqWeYCMRVjT//ko
         G1lw==
X-Gm-Message-State: AKaTC007Cj5pexWkyDdqRwhJNTODwZBCaB2ml8xDz3VqWAZ+atUu9EkZenCMaPG0NbK+vg==
X-Received: by 10.98.158.90 with SMTP id s87mr24612466pfd.62.1479808868187;
        Tue, 22 Nov 2016 02:01:08 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id 4sm25822951pgd.32.2016.11.22.02.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Nov 2016 02:01:07 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 22 Nov 2016 17:01:03 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rappazzo@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/3] get_worktrees() must return main worktree as first item even on error
Date:   Tue, 22 Nov 2016 17:00:45 +0700
Message-Id: <20161122100046.8341-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161122100046.8341-1-pclouds@gmail.com>
References: <20161122100046.8341-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is required by git-worktree.txt, stating that the main worktree is
the first line (especially in --porcelain mode when we can't just change
behavior at will).

There's only one case when get_worktrees() may skip main worktree, when
parse_ref() fails. Update the code so that we keep first item as main
worktree and return something sensible in this case:

 - In user-friendly mode, since we're not constraint by anything,
   returning "(error)" should do the job (we already show "(detached
   HEAD)" which is not machine-friendly). Actually errors should be
   printed on stderr by parse_ref() (*)

 - In plumbing mode, we do not show neither 'bare', 'detached' or
   'branch ...', which is possible by the format description if I read
   it right.

Careful readers may realize that when the local variable "head_ref" in
get_main_worktree() is emptied, add_head_info() will do nothing to
wt->head_sha1. But that's ok because head_sha1 is zero-ized in the
previous patch.

(*) Well, it does not. But it's supposed to be a stop gap
    implementation until refs we can reuse code, to parse "ref: " stuff
    in HEAD, from resolve_refs_unsafe(). Now may be the time since
    refs refactoring is mostly done.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/worktree.c | 8 +++++---
 worktree.c         | 6 ++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 5c4854d..b835b91 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -388,7 +388,7 @@ static void show_worktree_porcelain(struct worktree *wt)
 		printf("HEAD %s\n", sha1_to_hex(wt->head_sha1));
 		if (wt->is_detached)
 			printf("detached\n");
-		else
+		else if (wt->head_ref)
 			printf("branch %s\n", wt->head_ref);
 	}
 	printf("\n");
@@ -406,10 +406,12 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
 	else {
 		strbuf_addf(&sb, "%-*s ", abbrev_len,
 				find_unique_abbrev(wt->head_sha1, DEFAULT_ABBREV));
-		if (!wt->is_detached)
+		if (wt->is_detached)
+			strbuf_addstr(&sb, "(detached HEAD)");
+		else if (wt->head_ref)
 			strbuf_addf(&sb, "[%s]", shorten_unambiguous_ref(wt->head_ref, 0));
 		else
-			strbuf_addstr(&sb, "(detached HEAD)");
+			strbuf_addstr(&sb, "(error)");
 	}
 	printf("%s\n", sb.buf);
 
diff --git a/worktree.c b/worktree.c
index f7c1b5e..a674efa 100644
--- a/worktree.c
+++ b/worktree.c
@@ -89,7 +89,7 @@ static struct worktree *get_main_worktree(void)
 	strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
 
 	if (parse_ref(path.buf, &head_ref, &is_detached) < 0)
-		goto done;
+		strbuf_reset(&head_ref);
 
 	worktree = xcalloc(1, sizeof(*worktree));
 	worktree->path = strbuf_detach(&worktree_path, NULL);
@@ -97,7 +97,6 @@ static struct worktree *get_main_worktree(void)
 	worktree->is_detached = is_detached;
 	add_head_info(&head_ref, worktree);
 
-done:
 	strbuf_release(&path);
 	strbuf_release(&worktree_path);
 	strbuf_release(&head_ref);
@@ -173,8 +172,7 @@ struct worktree **get_worktrees(void)
 
 	list = xmalloc(alloc * sizeof(struct worktree *));
 
-	if ((list[counter] = get_main_worktree()))
-		counter++;
+	list[counter++] = get_main_worktree();
 
 	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
 	dir = opendir(path.buf);
-- 
2.8.2.524.g6ff3d78

