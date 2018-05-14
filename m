Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF5661F406
	for <e@80x24.org>; Mon, 14 May 2018 21:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752131AbeENV7Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:59:24 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:36607 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752508AbeENV5S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:57:18 -0400
Received: by mail-yw0-f201.google.com with SMTP id l36-v6so3916211ywa.3
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=kpQaN9lvpBKdssA/vU2er5Xt8KqaU2ou2FaF7KFPkoA=;
        b=gABZS4/6IPqni25bHgFbMBXziuTtwz1fOOJoLaQnG0zmYPk93MIm8a/SX7vOChZuxU
         KfARm5ZGOeFjbFnpW55OQL3rQvvpdiXcZ3ATfZ+RX4647sxwCSxWf9l14b8dix8Sv8KB
         NFc4MeDvSFk+bH0HvcwzEfu+DFQ3KA6nkzoDoPhFzMBj9rchyke7zeIalzhCdsrgDZ2k
         tCoxdMRuPy77DxNM7A7GpVHeWGcJGjCc6U6Tmowo29A+lgmpAcv9gkeuifF5Rzc1Sy9D
         iSw8+rkThWD81tOTsqxxQH+DASKzWfKeQ1OXtrauABlITp9Sh6501cqfKlf5scL/ofSW
         7uWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=kpQaN9lvpBKdssA/vU2er5Xt8KqaU2ou2FaF7KFPkoA=;
        b=kuw09mOykA1VPBmmNVaZ6ZwYxYMnHtwebE6Sj2jP2Y+IcZCEKnI93vzXyv7q85V6zu
         dzTOlmRbwzMcPuvVpQzFuI0z4fBiUxqrUSvboKhChWu3/je5puSCOJOEfDbNsVk1BchS
         OO989uvmH95nwQF5IxRTTtLXOYBRnCXd+xRWBNFn9xY/EpHb0wwx2k7RaPkHOiSnfgSr
         V8R0KmuHqT2oNKbWJ7NwntQfN4d4G7G5mlN4NzNfo6KU1fkjhk+VjWLgYtDegyttJgz3
         dHgDg1eSKErzpr3SLyUOQqFawC/y3BDwfI3x1favKJSPZRfphR/yoLER7n8+CoJkjngG
         //vA==
X-Gm-Message-State: ALKqPwfdszPrJdBy4QuRC6+L8Y2HCbPKJOM3qjmrel2VOV4CLHHx6P+T
        N6vYy7117bbji8v4i7edTYZOeJHbOOhFWm+fphEGfT6XHebnK8yeLGCDEGNompoISpucGPnpVpC
        vlleUGZDeBrgaS9GlADwXnYV3RQj9Ay1S/rayQ8hIEXXphudEYcNJ6iMJug==
X-Google-Smtp-Source: AB8JxZqsnFr2QOvaFRmhWjMT6ZEzSMwyqZQ96+4ynlTC4YEZXxStEnuxUTAbPKxt4fU+eigoKD51i4e62lU=
MIME-Version: 1.0
X-Received: by 2002:a81:8ac5:: with SMTP id a188-v6mr4084678ywg.18.1526335037039;
 Mon, 14 May 2018 14:57:17 -0700 (PDT)
Date:   Mon, 14 May 2018 14:56:07 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-17-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 16/35] fetch: convert fetch_one to use struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
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
index 30083d4bc..769f9d2be 100644
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
 		add_prune_tags_to_fetch_refspec(remote);
 
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

