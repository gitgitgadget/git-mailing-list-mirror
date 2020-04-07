Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81787C2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 22:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5FE20747
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 22:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N74H1d4j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgDGWLu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 18:11:50 -0400
Received: from mail-pj1-f73.google.com ([209.85.216.73]:37110 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgDGWLu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 18:11:50 -0400
Received: by mail-pj1-f73.google.com with SMTP id w4so844666pjt.2
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 15:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bmeGpckLvyJH+KO+r8gy9KGUkRNvdgUpS/eIbC3Vj9c=;
        b=N74H1d4j6xPZyB4UAX0vuDRi/hjPQ+Wslq4CDY85ZveXXKcGP52Z+5c26Or35c94LA
         KfuEkTC6m8+U3lQy72WJ9jCPdkUXa6H67+596T3syphiHaDI7Ss2RoZrypdQMTlFryJ6
         4UjOMYqOwyiRw0YINMOSZNYpu3RMwyrNV+gnCFyT1EHX+moHOl8MuEv12Q/zORZCW5Na
         KhAhmWdnnE9u34Up0lbwKZMZihtIWMqrGCcQasoNAI51wwf5GZ2OOIE/5GI7f0iQ6l8M
         /c0abTjuP74dw2VJsB/0NMT/pbvSk1PeQIndUzvkb154V33R2jFl3jpRtsnzzgKeA7TC
         HUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bmeGpckLvyJH+KO+r8gy9KGUkRNvdgUpS/eIbC3Vj9c=;
        b=fzlGla683dFIkKSn8naUytf4JrjPb6LrDh4/gkRWJkDyNJLGawS7h7DRBXfMHY+vBg
         LTvR3cYvZZ9FSX9xJolt1WuRxJGndI9oOsLg2Dr1Sk8wxPurWAgfQJDC0CMaiJ8GfpAF
         KciVgA5alQaF2BnwK/+T/gOdb4kTO/2KPioCO02aWyy9Asl3nFPhu5O4YXGvg/w6DkKh
         nPcx9zHdtUTJaGNbbBoYpQpB10hq7RANSl0E66kEbbdnkYMGPjCdWynh2QzEPFyAN/rR
         M4Kta57mnXXy75Qmd2DeeywFtwPCO9sZFizI+d2MP1d98wusiZMrELvRE8uY+JB9rERP
         7QBQ==
X-Gm-Message-State: AGi0PuZtgwVurCPjlsJlljjjNbnlcvzVWeiPmfpWugIxyXF/k6ShUj2N
        Rbo0yA7CDqwYGHSR+2ZJrLIG6v1SLp3nc1M6UeTBRJ4YZoQK/V2UdK1dHEhj/8ugacmLOFS2gkp
        wS593jY2TuLMo4WDOeDXGxD3TyuBgWOVeRPdyo8dKl7RPUIjwJ0HAAi8T7BEP5gEieX8fEJUxb7
        ae
X-Google-Smtp-Source: APiQypK2+TUxfMZVDQdb7bI1MTuoTNYFV07RH+pwbCBnWD/q0g2i1pxL4QGKPAavDCtOBJQcDOLhHktPha4Rrf44DesQ
X-Received: by 2002:a63:1718:: with SMTP id x24mr4181538pgl.421.1586297508819;
 Tue, 07 Apr 2020 15:11:48 -0700 (PDT)
Date:   Tue,  7 Apr 2020 15:11:40 -0700
In-Reply-To: <cover.1586296510.git.jonathantanmy@google.com>
Message-Id: <474eb27d9c136fb69e961546004cfb531d722e2c.1586296510.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200331020418.55640-1-jonathantanmy@google.com> <cover.1586296510.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH v3 1/4] promisor-remote: accept 0 as oid_nr in function
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, garimasigit@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are 3 callers to promisor_remote_get_direct() that first check if
the number of objects to be fetched is equal to 0. Fold that check into
promisor_remote_get_direct(), and in doing so, be explicit as to what
promisor_remote_get_direct() does if oid_nr is 0 (it returns 0, success,
immediately).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/index-pack.c |  5 ++---
 diff.c               | 11 +++++------
 promisor-remote.c    |  3 +++
 promisor-remote.h    |  8 ++++++++
 unpack-trees.c       |  5 ++---
 5 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index d967d188a3..f176dd28c8 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1368,9 +1368,8 @@ static void fix_unresolved_deltas(struct hashfile *f)
 				continue;
 			oid_array_append(&to_fetch, &d->oid);
 		}
-		if (to_fetch.nr)
-			promisor_remote_get_direct(the_repository,
-						   to_fetch.oid, to_fetch.nr);
+		promisor_remote_get_direct(the_repository,
+					   to_fetch.oid, to_fetch.nr);
 		oid_array_clear(&to_fetch);
 	}
 
diff --git a/diff.c b/diff.c
index 1010d806f5..f01b4d91b8 100644
--- a/diff.c
+++ b/diff.c
@@ -6520,12 +6520,11 @@ void diffcore_std(struct diff_options *options)
 			add_if_missing(options->repo, &to_fetch, p->one);
 			add_if_missing(options->repo, &to_fetch, p->two);
 		}
-		if (to_fetch.nr)
-			/*
-			 * NEEDSWORK: Consider deduplicating the OIDs sent.
-			 */
-			promisor_remote_get_direct(options->repo,
-						   to_fetch.oid, to_fetch.nr);
+		/*
+		 * NEEDSWORK: Consider deduplicating the OIDs sent.
+		 */
+		promisor_remote_get_direct(options->repo,
+					   to_fetch.oid, to_fetch.nr);
 		oid_array_clear(&to_fetch);
 	}
 
diff --git a/promisor-remote.c b/promisor-remote.c
index 9f338c945f..2155dfe657 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -241,6 +241,9 @@ int promisor_remote_get_direct(struct repository *repo,
 	int to_free = 0;
 	int res = -1;
 
+	if (oid_nr == 0)
+		return 0;
+
 	promisor_remote_init();
 
 	for (r = promisors; r; r = r->next) {
diff --git a/promisor-remote.h b/promisor-remote.h
index 737bac3a33..6343c47d18 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -20,6 +20,14 @@ struct promisor_remote {
 void promisor_remote_reinit(void);
 struct promisor_remote *promisor_remote_find(const char *remote_name);
 int has_promisor_remote(void);
+
+/*
+ * Fetches all requested objects from all promisor remotes, trying them one at
+ * a time until all objects are fetched. Returns 0 upon success, and non-zero
+ * otherwise.
+ *
+ * If oid_nr is 0, this function returns 0 (success) immediately.
+ */
 int promisor_remote_get_direct(struct repository *repo,
 			       const struct object_id *oids,
 			       int oid_nr);
diff --git a/unpack-trees.c b/unpack-trees.c
index f618a644ef..4c3191b947 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -423,9 +423,8 @@ static int check_updates(struct unpack_trees_options *o)
 				continue;
 			oid_array_append(&to_fetch, &ce->oid);
 		}
-		if (to_fetch.nr)
-			promisor_remote_get_direct(the_repository,
-						   to_fetch.oid, to_fetch.nr);
+		promisor_remote_get_direct(the_repository,
+					   to_fetch.oid, to_fetch.nr);
 		oid_array_clear(&to_fetch);
 	}
 	for (i = 0; i < index->cache_nr; i++) {
-- 
2.26.0.292.g33ef6b2f38-goog

