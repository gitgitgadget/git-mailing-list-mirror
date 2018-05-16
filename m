Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,UNWANTED_LANGUAGE_BODY,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4677B1F406
	for <e@80x24.org>; Wed, 16 May 2018 22:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbeEPW7a (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:59:30 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:54047 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751868AbeEPW71 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:59:27 -0400
Received: by mail-yb0-f202.google.com with SMTP id v14-v6so1237250ybq.20
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=/TdEIjD+XW/+O+q+rFXxii11C5/Zc/hascAPsqAJIEA=;
        b=h3iZKXCJZUNse0Kt0HkMkkzgWIgbjsagL9ZEn7BhaCnHHCdcfoL6394iQsayJHGYa8
         EFvEqPIKtYgXMFAsmBFXzX6wj+xIsp4aJLO8daniakJ3FmfostNfdW/8aQr3WuTsxgUF
         FyA1FVLbho717KPeXl7/NoES0PsnbWpDj73/GvXPkiDErbctmSFk2m+fm0GaFduAdeKu
         RlI7F3HP4Ly1GWIgZWD4ywR19Em2d1tGkuHuGJMalqSSA5WhzVNBofkT78mCu8wQKNH6
         lrHMrP/adqWncLiZgv6wQb8lda8xT549OPSXNlibUofoNrUUIxu2gznAt/uujXSMJv9A
         a6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=/TdEIjD+XW/+O+q+rFXxii11C5/Zc/hascAPsqAJIEA=;
        b=nmxkCEI+WEi5hI3OSHPkQb1xq/PMbPfia0hz6CBL5ZGbeepsIrVCqIAZ35YA1udedG
         l5F+knvIqcMNU6Cz0z6wOIB5fVLuEcogKiOQRCxRVKwT34OPF2uUB9oZLlce+ko5USbn
         Y5K/IaiTMnbl71Co9yh6yeu+Bl9g/ltpY/T3AnaS5YrC8jqs97ThW0NMCkHOTki+GYH+
         TT6WVGUuxVVV0eaQPZ8ODEc1kAA4KFGqn9GKwNSR/hs8qM1QDwDnodJ/lMEnzaDUJ3ZI
         AyV5KKKIcEHxToiF+sRcTgoseDwMbb+RgwyJj1mqFgkA2VHuwSewa+a+4cW+/PT+ux4W
         b0Sw==
X-Gm-Message-State: ALKqPwf95yzZvqz1+wiaOYyVVns7P6bwHpmnYZR1cwZlqciK5jSkNScK
        Dy3j3EPPI6ysydSWieWNEkSu/9p6XMLbjXBWdk6GgZs32jJTXMHwpv4PI9y9x/mktAmosOy1OUV
        H9sRCAGUDB+mZCw/byLUJRndziEI8YyZDjCHUP0UzZDOu6/dXCX4A17UAHA==
X-Google-Smtp-Source: AB8JxZqlqaPKE9uAiDVFsQyIP1ETSNM64kIR1SB8wBKOJg2JyOB7KOyb+ZAoRPV0SX6+pbD+DrUTbmaNBgo=
MIME-Version: 1.0
X-Received: by 2002:a25:a005:: with SMTP id x5-v6mr970831ybh.50.1526511566034;
 Wed, 16 May 2018 15:59:26 -0700 (PDT)
Date:   Wed, 16 May 2018 15:58:07 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-21-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 20/36] fetch: convert do_fetch to take a struct refspec
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

Convert 'do_fetch()' to take a 'struct refspec' as a parameter instead
of a list of 'struct refspec_item'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 6b909cd5b..ec54b1dfe 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1112,7 +1112,7 @@ static void backfill_tags(struct transport *transport, struct ref *ref_map)
 }
 
 static int do_fetch(struct transport *transport,
-		    struct refspec_item *refs, int ref_count)
+		    struct refspec *rs)
 {
 	struct string_list existing_refs = STRING_LIST_INIT_DUP;
 	struct ref *ref_map;
@@ -1136,7 +1136,7 @@ static int do_fetch(struct transport *transport,
 			goto cleanup;
 	}
 
-	ref_map = get_ref_map(transport, refs, ref_count, tags, &autotags);
+	ref_map = get_ref_map(transport, rs->items, rs->nr, tags, &autotags);
 	if (!update_head_ok)
 		check_not_current_branch(ref_map);
 
@@ -1160,8 +1160,8 @@ static int do_fetch(struct transport *transport,
 		 * explicitly (via command line or configuration); we
 		 * don't care whether --tags was specified.
 		 */
-		if (ref_count) {
-			prune_refs(refs, ref_count, ref_map, transport->url);
+		if (rs->nr) {
+			prune_refs(rs->items, rs->nr, ref_map, transport->url);
 		} else {
 			prune_refs(transport->remote->fetch.items,
 				   transport->remote->fetch.nr,
@@ -1410,7 +1410,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv, int pru
 
 	sigchain_push_common(unlock_pack_on_signal);
 	atexit(unlock_pack);
-	exit_code = do_fetch(gtransport, rs.items, rs.nr);
+	exit_code = do_fetch(gtransport, &rs);
 	refspec_clear(&rs);
 	transport_disconnect(gtransport);
 	gtransport = NULL;
-- 
2.17.0.441.gb46fe60e1d-goog

