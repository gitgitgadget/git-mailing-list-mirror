Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43E9120A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 00:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbeLOAKS (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:10:18 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:42320 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729985AbeLOAKR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:10:17 -0500
Received: by mail-yw1-f74.google.com with SMTP id d72so4321831ywe.9
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IZAUkKssT2FykRphWLtNBX69xKlH92cRM0qWMPDdb8Q=;
        b=OQM5wgh/Kla5M40qj95yI/WT9THvb0D8R9EbUcfQ2WOvkO8MrqfBMn9iNKuX7codWp
         Gp75COICMt424JMbMimTiO9P2GrBz+pkBbYPrExA6Z04RkpXxhipUK12QrVn/D6t1z0X
         L4DMni6WdQCP1tiFym06cBigSYQdhS3HcuNcqoxK+rVGWQ2FZFE/nuKgPaD8bN8SqeBX
         cNoerDDfMQ9LJUoUdovtYxqMBhkpmY2e+yQ6fGSoLtQm/J4LT0E9gc/UjLbcWLZ7W6Y4
         6EhwjtqtdeMykTsnxJ91hwJF9D8Uvx8NYUfIvwpAlw/fmelxR0XGNOGEyQTkqs5+T+Xd
         wClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IZAUkKssT2FykRphWLtNBX69xKlH92cRM0qWMPDdb8Q=;
        b=eMYBAZ1j3MB8TwPFW4NQhWnSOSTIsl6k2T/mIMF/0lKquNGvFfPhgk+9fMPQU9S2gc
         PXUf6hYki82KXzN31obL9utNkZPoHIJbdr1jZwwurXPbbfd2sP2vR2m3tVTJZe6Gxftc
         VaDHwYMERhZtaydQz+h9PGontrSOl91IUg/wnoxe9/zTCScU+pajbKFHqqOeZyj8QgGp
         oqJvFFm5W1N/Fw7Pj/EWBHJCJYMpxRetB0NWa8QZvJMAYljzI9dDT+F2U5MIXAEkgHEY
         n96wYTO5h01BgsAyRJ/ECM/sPRP2AMjwbIW5tahboEk7v7U1McEPDQCArlECjlRNRCc/
         vzrA==
X-Gm-Message-State: AA+aEWYNEB/IJSFVhQgnZ/0p9nStfAHNiAkEVagI/iST4rxOp+E55pTc
        B3w8kZ3rrKANCGy00OWjClBwwni7gX4X6ZbhLzQLm7eEQk/oGv/XndWDUSYflxWCeU/IMZGCMvu
        X3kehEKH77iaEhZJFtDFFzaEu3ruCFxaCGE3Pjn3OXFd0NA/E6yuVXeFuhuqR
X-Google-Smtp-Source: AFSGD/WBEjqaeYB6GbGY0ltR0p06KHnYnob5OqrT4mSjlwN2qdJrBwMXoiQ3dBVN0o0mgPcHmvb4NPAX6M3q
X-Received: by 2002:a5b:cca:: with SMTP id e10mr2875266ybr.91.1544832616756;
 Fri, 14 Dec 2018 16:10:16 -0800 (PST)
Date:   Fri, 14 Dec 2018 16:09:32 -0800
In-Reply-To: <20181215000942.46033-1-sbeller@google.com>
Message-Id: <20181215000942.46033-14-sbeller@google.com>
Mime-Version: 1.0
References: <20181215000942.46033-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH 13/23] commit-reach: prepare in_merge_bases[_many] to handle
 any repo
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit-reach.c                                  | 15 +++++++++------
 commit-reach.h                                  | 12 ++++++++++--
 contrib/coccinelle/the_repository.pending.cocci | 17 +++++++++++++++++
 3 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 657a4e9b5a..8715008fef 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -312,16 +312,17 @@ int is_descendant_of(struct commit *commit, struct commit_list *with_commit)
 /*
  * Is "commit" an ancestor of one of the "references"?
  */
-int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit **reference)
+int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
+			     int nr_reference, struct commit **reference)
 {
 	struct commit_list *bases;
 	int ret = 0, i;
 	uint32_t min_generation = GENERATION_NUMBER_INFINITY;
 
-	if (parse_commit(commit))
+	if (repo_parse_commit(r, commit))
 		return ret;
 	for (i = 0; i < nr_reference; i++) {
-		if (parse_commit(reference[i]))
+		if (repo_parse_commit(r, reference[i]))
 			return ret;
 		if (reference[i]->generation < min_generation)
 			min_generation = reference[i]->generation;
@@ -330,7 +331,7 @@ int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit *
 	if (commit->generation > min_generation)
 		return ret;
 
-	bases = paint_down_to_common(the_repository, commit,
+	bases = paint_down_to_common(r, commit,
 				     nr_reference, reference,
 				     commit->generation);
 	if (commit->object.flags & PARENT2)
@@ -344,9 +345,11 @@ int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit *
 /*
  * Is "commit" an ancestor of (i.e. reachable from) the "reference"?
  */
-int in_merge_bases(struct commit *commit, struct commit *reference)
+int repo_in_merge_bases(struct repository *r,
+			struct commit *commit,
+			struct commit *reference)
 {
-	return in_merge_bases_many(commit, 1, &reference);
+	return repo_in_merge_bases_many(r, commit, 1, &reference);
 }
 
 struct commit_list *reduce_heads(struct commit_list *heads)
diff --git a/commit-reach.h b/commit-reach.h
index 52667d64ac..a0d4a29d25 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -27,8 +27,16 @@ struct commit_list *repo_get_merge_bases_many_dirty(struct repository *r,
 struct commit_list *get_octopus_merge_bases(struct commit_list *in);
 
 int is_descendant_of(struct commit *commit, struct commit_list *with_commit);
-int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit **reference);
-int in_merge_bases(struct commit *commit, struct commit *reference);
+int repo_in_merge_bases(struct repository *r,
+			struct commit *commit,
+			struct commit *reference);
+int repo_in_merge_bases_many(struct repository *r,
+			     struct commit *commit,
+			     int nr_reference, struct commit **reference);
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define in_merge_bases(c1, c2) repo_in_merge_bases(the_repository, c1, c2)
+#define in_merge_bases_many(c1, n, cs) repo_in_merge_bases_many(the_repository, c1, n, cs)
+#endif
 
 /*
  * Takes a list of commits and returns a new list where those
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index f6c2915a4e..8c6a71bf64 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -90,3 +90,20 @@ expression G;
 - get_merge_bases_many_dirty(
 + repo_get_merge_bases_many_dirty(the_repository,
   E, F, G);
+
+@@
+expression E;
+expression F;
+@@
+- in_merge_bases(
++ repo_in_merge_bases(the_repository,
+  E, F);
+
+@@
+expression E;
+expression F;
+expression G;
+@@
+- in_merge_bases_many(
++ repo_in_merge_bases_many(the_repository,
+  E, F, G);
-- 
2.20.0.405.gbc1bbc6f85-goog

