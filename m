Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB4541F404
	for <e@80x24.org>; Tue, 11 Sep 2018 23:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbeILEwB (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 00:52:01 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:54877 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbeILEwA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 00:52:00 -0400
Received: by mail-ua1-f74.google.com with SMTP id l14-v6so34255uaf.21
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 16:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tk87CXyJVQNQVWPNNs5RozzS/pTt0APvY/pavxAMu8c=;
        b=a+iHYXKGOeEoVb22/hOwCXRlvQkRoaYsOgTXJG0AUEp3eBda76Xl5OnER0NJVSKuA/
         1RexRcXjWpwMX3CSeKdiTlqPA/5Lu8qP6IkPL0xCar6Nrg4891yigD7rqunf3iUfKfr2
         xgp190A/NbiglCtFYPbKz3I0Is/FYK+9FHpA6Yi6n5WQNdrUdjONZM0/cYoJXOJPVOOV
         Iy3Umtv9cKyFvUwHPkT2GjcrgEZnz5/0aKQov7O+iKdfA4sGTawY6dwV4nbnG7JWFYN1
         aOrgXXeC/oZ1RCwPpaH7xQ7Spr4OztmPl0c12CJSBmUkLIaTQQusSbg/TXLDQDEnKKDF
         F/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tk87CXyJVQNQVWPNNs5RozzS/pTt0APvY/pavxAMu8c=;
        b=Gb8tyjO8h9PXOgHvIoAUrKII7z3XDD4jUniLDy0+YeWGRftcQgnhQ9EEHnDTgyutXy
         Qow9iLXiw3bfAm7OlOhyMWlR9z4ZTUpsBLJAuiFzAe08MN2Wid7Qg3H/e/kjvHqs3L+D
         q8NOJ29lsPsDnMtjLqUEDL+jnEz8HvDsMT1stO1wglPCG5CTa/EArq1646YCd4Q0Pz6C
         4KOh2O/EOvhFB20thRnU21R7ptyAdHMvRQrt6RZFZmSiyJthJGkqSmvxGkUCuu1lM1Z2
         4SDNBJcP/tQKdluIcn06J8c4XIHCoWYPeaSbcPpZ+hOsOzTn6L0dFbPCrJE+gBV3Ndwo
         OPBA==
X-Gm-Message-State: APzg51Anbb4PO3H/LjCLo0BK+kl0rcIt3MrgFAGnpt2CEc+pfF4Ta8Ad
        04hFX0rAoqJytRCgjK/eOUGrCWqjPXk2C2bQZf1ZtniW6PcKBCURk0ZVr9XOtLtzGSiErihYsfd
        +NeuAFO/b4b01O9xqJTLftncqHhu80tNYSpu13XUh3sQRMnQc6qG18c14w9JB
X-Google-Smtp-Source: ANB0VdZBjBfbHvisPnBG68N45NDVuJME0+z/jAdGGuMCZEYtr6bJz1NcN3QqoJk5exXhdL5SjpntfGN1MvFB
X-Received: by 2002:a67:4689:: with SMTP id a9-v6mr2882639vsg.31.1536709821028;
 Tue, 11 Sep 2018 16:50:21 -0700 (PDT)
Date:   Tue, 11 Sep 2018 16:49:51 -0700
In-Reply-To: <20180911234951.14129-1-sbeller@google.com>
Message-Id: <20180911234951.14129-10-sbeller@google.com>
Mime-Version: 1.0
References: <20180911234951.14129-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 9/9] builtin/fetch: check for submodule updates for non branch fetches
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For Gerrit users that use submodules the invocation of fetch without a
branch is their main use case.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fetch.c             | 5 ++++-
 t/t5526-fetch-submodules.sh | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 95c44bf6ffa..ea6ecd123e7 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -887,11 +887,14 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				rc |= update_local_ref(ref, what, rm, &note,
 						       summary_width);
 				free(ref);
-			} else
+			} else {
+				check_for_new_submodule_commits(&rm->old_oid);
 				format_display(&note, '*',
 					       *kind ? kind : "branch", NULL,
 					       *what ? what : "HEAD",
 					       "FETCH_HEAD", summary_width);
+			}
+
 			if (note.len) {
 				if (verbosity >= 0 && !shown_url) {
 					fprintf(stderr, _("From %.*s\n"),
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index af12c50e7dd..a509eabb044 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -615,7 +615,7 @@ test_expect_success "fetch new commits on-demand when they are not reachable" '
 	git update-ref refs/changes/2 $D &&
 	(
 		cd downstream &&
-		git fetch --recurse-submodules --recurse-submodules-default on-demand origin refs/changes/2:refs/heads/my_branch &&
+		git fetch --recurse-submodules origin refs/changes/2 &&
 		git -C submodule cat-file -t $C &&
 		git checkout --recurse-submodules FETCH_HEAD
 	)
-- 
2.19.0.397.gdd90340f6a-goog

