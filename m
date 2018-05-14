Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F2871F406
	for <e@80x24.org>; Mon, 14 May 2018 21:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbeENV46 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:56:58 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:43818 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752257AbeENV4z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:56:55 -0400
Received: by mail-vk0-f73.google.com with SMTP id o24-v6so16842649vki.10
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=hnjlgJYFOVI6C4rmJrZ5vp2zCuJsXIleMCgg2nwJ11Y=;
        b=QScv79vQylqfng+fIowGxypLTF7wSSRKtxqfAmvp0AYDiGRL3NFveq3w+FBVDHLQzx
         v1WfkmQE0w1KCi1rRK4mQSDgAkpJbuwCGF++Tb25ydN/YkUodwwGJlocloScT825W2Zf
         6xfprerGHgjJ7IOQ/RlhFhVm0O2lEu6tahwW1RmhoYQXAPPahO9m40Up5KOZwakQ1ZxC
         2KHWsrQlSu5/QtpJ9RQmJoKxV6SVP/ig+E3kvwHyDW+n/C/Vyjr8eeVJgO8/XWtywiov
         M39ZE/uDHb++kBItnev7PPhe2P4StCcfOuKfDsv5gMGr3YoO3pN9rakIC6HWlqUAsT4u
         Bhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=hnjlgJYFOVI6C4rmJrZ5vp2zCuJsXIleMCgg2nwJ11Y=;
        b=ij7qlGsUq6OTiSAek0gm6lNB/90wGGQDujjbgLYrVV9lbi5WDd304973KtX2wkUVv4
         v50mgkklUvYZMw4jzELNtJm3n8Hkd1ycvImpUrb6oYo0WTlDGb2u6JfXSr+PNwEB6RXJ
         v2Qc0vS1G3SheQl76VBejiTMinaK1JEQPtOZt9WIdqJqytRlWxBVXJaIIQEHM220gBey
         Fsm55NG6Y5FWyP+blxxH5Ypt3WC7arrKABVaBACy8/FfNkF+NX55iXKFfsB7vqjp+t5q
         B3g1Kq8lOBHUE/E2bephE+8BUG9o+OtsKqoThILO3w+ae46bth6IKig1BIE+gcyiLh9y
         S3OA==
X-Gm-Message-State: ALKqPweNd01kMxzYYVJ1Drxj/MbGfoJHwWf3hEW83Lm5N7SsQBp1/+Hu
        MHiBSb1rR7ImF2Bgw49WJ7Z6ldJGqeVrT5t5KSwi6z0musGi8trmESXVOA7jjKCZ+yOtbHiA3Li
        ewVba9DV1nX0g0ihKebBIsJiDsORoZ36myuvxrrwMi/HnPCBEngFgTkzZeQ==
X-Google-Smtp-Source: AB8JxZr5/f7cJtnFxcSjN0ZfU2/3drVTHzxgv89EvjLqWEP+2nCksmy82PdoLKC+YupWRWgQESXwL5S+1Ko=
MIME-Version: 1.0
X-Received: by 2002:a9f:3fce:: with SMTP id m14-v6mr13107850uaj.72.1526335014517;
 Mon, 14 May 2018 14:56:54 -0700 (PDT)
Date:   Mon, 14 May 2018 14:55:58 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-8-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 07/35] pull: convert get_tracking_branch to use refspec_item_init
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'get_tracking_branch()' to use 'refspec_item_init()' instead of
the old 'parse_fetch_refspec()' function.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/pull.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 5a79deae5..09575fd23 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -676,12 +676,12 @@ static const char *get_upstream_branch(const char *remote)
  */
 static const char *get_tracking_branch(const char *remote, const char *refspec)
 {
-	struct refspec_item *spec;
+	struct refspec_item spec;
 	const char *spec_src;
 	const char *merge_branch;
 
-	spec = parse_fetch_refspec(1, &refspec);
-	spec_src = spec->src;
+	refspec_item_init(&spec, refspec, REFSPEC_FETCH);
+	spec_src = spec.src;
 	if (!*spec_src || !strcmp(spec_src, "HEAD"))
 		spec_src = "HEAD";
 	else if (skip_prefix(spec_src, "heads/", &spec_src))
@@ -701,7 +701,7 @@ static const char *get_tracking_branch(const char *remote, const char *refspec)
 	} else
 		merge_branch = NULL;
 
-	free_refspec(1, spec);
+	refspec_item_clear(&spec);
 	return merge_branch;
 }
 
-- 
2.17.0.441.gb46fe60e1d-goog

