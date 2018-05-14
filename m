Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D62E51F406
	for <e@80x24.org>; Mon, 14 May 2018 21:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbeENV5o (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:57:44 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:42902 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752567AbeENV5m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:57:42 -0400
Received: by mail-vk0-f74.google.com with SMTP id g76-v6so17199414vki.9
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=6l9G/9wB1m7upzLpFD76k6RQR6dH99b5t8/as6WZ7D8=;
        b=p+hv/Y8mKgXxX8VaOE3flRk5VSRh25mR8rZ17QNSszxIGA9ESIs6O5KiAbv7ct2rib
         sCSxW44pJLbzeMFa9DmSTWZgHUk4cpfuDlYRXr48gFDyqX/mUz+3mog+FVCrv9nsrScN
         cMMI7IdmcW48sAfDszDfgsMqb9N66x//lwRCN3wH6RF4gEkFpO/eQH0U5ICI+pBfj9AO
         Azn+rw+J7IFWmmJASouvNlzFQuPxPX+kgG9Xuriz64S90ej1JYPu46G+H50zc/hZPaw9
         ahlMLLHZIUFKwT6r+070NmKXosRLm3T8mmBkrXa57MFEjlgSq21BuZ2hXutwgCg5Q0io
         G95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=6l9G/9wB1m7upzLpFD76k6RQR6dH99b5t8/as6WZ7D8=;
        b=p06YBnNQKUkYQT5wlCtkXPQFfxVfLLtwyTlxbZddxDYDKu4ZweQqUkjHzsxPbUpg1j
         Qn53ekX6GQocDvWhGCQkpdjvYkx7yxBMrVoFysTsqA6seO9KGptx70zB8GpiOD1YED3E
         ZguH+/58H3xByk4YilZm32569aUAujVTslKEAe5Xkb+C7/qvWkMs+zuXKCwv5fLu8b2L
         hleGK8AOzcSeEBO1KT+LTBMUYuGLQnpbbtN4cTVYSLjQmwdgW9F0j/aDlKO0qjj3YrET
         4BkPY+0HbkZOL5ATyzuXRbYSwB/ZqA7ziFfD+WPLdmY5M/YgIysVGekOSPSjA/Jfl9a4
         J6DQ==
X-Gm-Message-State: ALKqPwdek3Zsv64Z2un5XLOKyhPmkp25oauCUShtK6+JAIJNwNBNeIXi
        Gn7Baj7ywYHA8Fc//qHL4joWmLVNifBK3g5Y1naJIwSh9qHak2GOCJ+GYR2tdKqjqjmKtY3Y251
        erI3dpEAhyJvl/25sWKII4B2op+9Izu9ORYQ+z71cfGRzY9I8GZRAIXngbg==
X-Google-Smtp-Source: AB8JxZpjCSlRpPLmDZD3vLOCtKjlKYk6YWgsJp10vqSHT0Ie6yT4ovqi3LMMy5l7gs0gnmfVN4SU2+US8m4=
MIME-Version: 1.0
X-Received: by 2002:ab0:5303:: with SMTP id x3-v6mr13516099uax.9.1526335062190;
 Mon, 14 May 2018 14:57:42 -0700 (PDT)
Date:   Mon, 14 May 2018 14:56:17 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-27-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 26/35] remote: convert match_explicit_refs to take a struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'match_explicit_refs()' to take a 'struct refspec' as a
parameter instead of a list of 'struct refspec_item'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 remote.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/remote.c b/remote.c
index 0879ee587..73d462f24 100644
--- a/remote.c
+++ b/remote.c
@@ -1082,12 +1082,11 @@ static int match_explicit(struct ref *src, struct ref *dst,
 }
 
 static int match_explicit_refs(struct ref *src, struct ref *dst,
-			       struct ref ***dst_tail, struct refspec_item *rs,
-			       int rs_nr)
+			       struct ref ***dst_tail, struct refspec *rs)
 {
 	int i, errs;
-	for (i = errs = 0; i < rs_nr; i++)
-		errs += match_explicit(src, dst, dst_tail, &rs[i]);
+	for (i = errs = 0; i < rs->nr; i++)
+		errs += match_explicit(src, dst, dst_tail, &rs->items[i]);
 	return errs;
 }
 
@@ -1311,7 +1310,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
 		refspec = default_refspec;
 	}
 	refspec_appendn(&rs, refspec, nr_refspec);
-	errs = match_explicit_refs(src, *dst, &dst_tail, rs.items, rs.nr);
+	errs = match_explicit_refs(src, *dst, &dst_tail, &rs);
 
 	/* pick the remainder */
 	for (ref = src; ref; ref = ref->next) {
-- 
2.17.0.441.gb46fe60e1d-goog

