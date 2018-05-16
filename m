Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3CE61F406
	for <e@80x24.org>; Wed, 16 May 2018 22:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbeEPW7A (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:59:00 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:52055 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752224AbeEPW6z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:58:55 -0400
Received: by mail-vk0-f73.google.com with SMTP id d199-v6so2138574vke.18
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=hnjlgJYFOVI6C4rmJrZ5vp2zCuJsXIleMCgg2nwJ11Y=;
        b=KDGBNC3zFst1RYO8rtPHk6boip8O9bbkiMir5yTlTXxjJTx8hFeFk19GJE9qHPlQ0Q
         19oamA/hZb67qAfn1LJgHggleyh4YG+AOM4jHXxgYA4FoszL6PxyuKQ6+351Qal6AS85
         ce3YzS3ehg4QSyzZF9XKWXopWlZdrSxnnWklrIT55p9JgJ6PgV4CGs13w3RLlosmlzO+
         nwt8oYaN28NwpQviQ3LzCrNf8ixozVP06MNYr0lu7UkC8VwTgNLyUy2OrBM27pzkL9nq
         DS2P2Dg3f3KRTgqQnl4CstO9AP1oUVm/qpK8uw9+DFqt+nPBpK8rRCy077nUsbXpLwN7
         tXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=hnjlgJYFOVI6C4rmJrZ5vp2zCuJsXIleMCgg2nwJ11Y=;
        b=ef4ftf2Gz2xTlp535k4PPk6/wP3LDSYPfcDCrsisFEAN8gVLWEbcooEdkupWvNN0dq
         etYCY4xgB4cAKeGM1JL9WqV7ADjj8I60izhWuT5QKgkCzZGsL7COdml5UvnWoU6VmQ9j
         ohhClOCcMj9MyOz41DfY04zEXI/B1smsWnHZovIcbGoYi3eD3oVExI9GUX9ZVb7SqXM2
         ch6qNGhNMbFVGyVRld1Tfy92ctxVyI2GjLQTRBiAufbOPtDlO9sMwlwpP3kgmq7fR+OR
         8WIaZPMLHRhcnUWNd1qPpI+gfb3RnyzJCgJky7pNQlxqBsznIKJ/+K8IIOUrKfrzJTMw
         FmSQ==
X-Gm-Message-State: ALKqPwfPVMAm24omu5vnq4ui6XS4q4bYPLs5Y/KKLNTs1Cd7zgmw3fUc
        gnM/8QZxgH+HqXAsgq4NTAyNTb+v2EY39820ywv20yWhxTCRfrOOoOU7QKAdG9EqJdxzeT/H9+P
        0DpXzQ8Nm3QanRIrw37/I7FQDiOL0CNn22Wr7E8ZAuqG/WVMGn/bkI07YhQ==
X-Google-Smtp-Source: AB8JxZq/59gklBkbQiHAzfgmqWgyMkppNSBlNZd1zsfv2NAddjui5VFliOIkdFqzo6+izUCbS/0V6/agHSM=
MIME-Version: 1.0
X-Received: by 2002:ab0:49e1:: with SMTP id f30-v6mr2445985uad.11.1526511535135;
 Wed, 16 May 2018 15:58:55 -0700 (PDT)
Date:   Wed, 16 May 2018 15:57:54 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-8-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 07/36] pull: convert get_tracking_branch to use refspec_item_init
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

