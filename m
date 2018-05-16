Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AEA11F406
	for <e@80x24.org>; Wed, 16 May 2018 22:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeEPW7f (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:59:35 -0400
Received: from mail-oi0-f74.google.com ([209.85.218.74]:39163 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752061AbeEPW7T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:59:19 -0400
Received: by mail-oi0-f74.google.com with SMTP id 5-v6so1682884oiq.6
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=BMqEjA+wWlOKi2mTXvF4m4ovA/rjwBby3zCdMwbrrH8=;
        b=MNgDEk/YohRaE9R22ewwuDJwxrNnfY837HcLgjgOkVWzzWV0ZlrjWjMFDsYHeyVsNn
         gO/3/Z3W6OaQjf25/xW2YPjIswEEj4/TIirtZw2DFdq7w3L1uoIOqxSKu6qQrGedkUok
         TMqC4U1qYAQlTFpsGId1siBnrw62E/HvGLE2XK/G+VreEuc6pPvpMXuR8KUnoQ1yzNhN
         g0upb75+w7D09phXGvwISlmdQPtQZ+1opAcl57W9jljZky1i4+wOGWG/0HJknPkxwN9h
         I9QcMA9QeQxwzWec+Dt29KyvPMtwvsfOQEMPxfuwtcGZd8pgzxnpGkMsqCjAyetvcdqS
         DI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=BMqEjA+wWlOKi2mTXvF4m4ovA/rjwBby3zCdMwbrrH8=;
        b=sdvyaFR53Mut4fTyUO+X2AXcv6Q6tZJmnHt+rIf36seXUc93zbf+s1hOzQGRFI91Ug
         XIhYHM5RDreI4Plc5E4rjK+E0OCvywrSi9aMrMPTdVH/jpcoCxL87a/BPGh65L4cGwLm
         3kR2Zg7WRZXrBsuV+WetF1LrPyOlmn57imP718HBbxyXx4BKIwi5gPXgDgmgaazewYGX
         C595Cz+Scu0ACUsPjw9mc9lcHgUNY7xHSJsJfslxEY6GPN7qkAk9ia4oArbe3bcBJff+
         aJUQYTAX7HqpQg7U/9lAfuXQ91nxkv/TZdvNeBM5QlfCYOIPW/Vb1W5gNbrcWYJHQoel
         PTDw==
X-Gm-Message-State: ALKqPwdZaD+kTOGGQ3YMRmt9ebnhgQwhs9rIZk+eTNxQPCblSv9vacoK
        26ZdPICitG83/jFCP9mbayxJ2cUiwBK0gFhFLmrdHp7knveUv/tZcetgqoVV0hW1Jg8Tl+4eXuJ
        vnto0M76Y+/L73PsigyGdBbJY7jbjsGkcwHVKfw5kGbdaPZslWCq7OkkNlw==
X-Google-Smtp-Source: AB8JxZrZkHJ9d7OhAxGXiRdC6GSE7gpnJmlj2NsB1r0kPrluzIxsyw/9anw3zVTefRKua1VyWyj+akJ4mhM=
MIME-Version: 1.0
X-Received: by 2002:aca:b28b:: with SMTP id b133-v6mr2273664oif.41.1526511558875;
 Wed, 16 May 2018 15:59:18 -0700 (PDT)
Date:   Wed, 16 May 2018 15:58:04 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-18-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 17/36] fetch: convert fetch_one to use struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        sbeller@google.com, bmwill@google.com
Cc:     avarab@gmail.com, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'fetch_one()' to use 'struct refspec'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c | 46 +++++++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7a1637d35..18704c6cd 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1356,10 +1356,8 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 
 static int fetch_one(struct remote *remote, int argc, const char **argv, int prune_tags_ok)
 {
-	static const char **refs = NULL;
-	struct refspec_item *refspec;
-	int ref_nr = 0;
-	int j = 0;
+	struct refspec rs = REFSPEC_INIT_FETCH;
+	int i;
 	int exit_code;
 	int maybe_prune_tags;
 	int remote_via_config = remote_is_configured(remote, 0);
@@ -1394,35 +1392,29 @@ static int fetch_one(struct remote *remote, int argc, const char **argv, int pru
 	if (maybe_prune_tags && remote_via_config)
 		refspec_append(&remote->fetch, TAG_REFSPEC);
 
-	if (argc > 0 || (maybe_prune_tags && !remote_via_config)) {
-		size_t nr_alloc = st_add3(argc, maybe_prune_tags, 1);
-		refs = xcalloc(nr_alloc, sizeof(const char *));
-		if (maybe_prune_tags) {
-			refs[j++] = xstrdup("refs/tags/*:refs/tags/*");
-			ref_nr++;
-		}
-	}
+	if (maybe_prune_tags && (argc || !remote_via_config))
+		refspec_append(&rs, TAG_REFSPEC);
 
-	if (argc > 0) {
-		int i;
-		for (i = 0; i < argc; i++) {
-			if (!strcmp(argv[i], "tag")) {
-				i++;
-				if (i >= argc)
-					die(_("You need to specify a tag name."));
-				refs[j++] = xstrfmt("refs/tags/%s:refs/tags/%s",
-						    argv[i], argv[i]);
-			} else
-				refs[j++] = argv[i];
-			ref_nr++;
+	for (i = 0; i < argc; i++) {
+		if (!strcmp(argv[i], "tag")) {
+			char *tag;
+			i++;
+			if (i >= argc)
+				die(_("You need to specify a tag name."));
+
+			tag = xstrfmt("refs/tags/%s:refs/tags/%s",
+				      argv[i], argv[i]);
+			refspec_append(&rs, tag);
+			free(tag);
+		} else {
+			refspec_append(&rs, argv[i]);
 		}
 	}
 
 	sigchain_push_common(unlock_pack_on_signal);
 	atexit(unlock_pack);
-	refspec = parse_fetch_refspec(ref_nr, refs);
-	exit_code = do_fetch(gtransport, refspec, ref_nr);
-	free_refspec(ref_nr, refspec);
+	exit_code = do_fetch(gtransport, rs.items, rs.nr);
+	refspec_clear(&rs);
 	transport_disconnect(gtransport);
 	gtransport = NULL;
 	return exit_code;
-- 
2.17.0.441.gb46fe60e1d-goog

