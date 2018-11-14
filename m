Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF8D21F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbeKNKPL (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:15:11 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:51670 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731191AbeKNKPL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:15:11 -0500
Received: by mail-io1-f74.google.com with SMTP id k9-v6so14164006ioj.18
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 16:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mTUD9ulPYZvydj8DDSVkvbToWUsxJo0+2EWrNpzfDXU=;
        b=HuAjvZ6poCgfO/jLAzRvy/0l4hvccC61RxYcrjyGvlHb/jXbs/zLSkgpbkIwL+oOkb
         Z/YZCfjf5Fmib83TM8rG9NAp5fEcZOqVwKFpp+6lskwzn0jOBexx1c0MLiJzfaazszfY
         AP4pMu0M5Vyad0M6F4JpxXnevoyoCamrtpSXOU72d8+06NQCIUkB43qxu9n9KUZVBPaU
         qWy+sjnOJkjnwR9EtkZKvzxPS1kGRfJ17ztN0y0/Cg/22WboZ/YcUPNJWjRF4YxJubwS
         rxf/gMadKscNbY6VVCutfUyUU7+s3KPc3jntCqzn5LdLPuQSWFVjdpimYYMR2bpTrI+Y
         Aa/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mTUD9ulPYZvydj8DDSVkvbToWUsxJo0+2EWrNpzfDXU=;
        b=kFFuHJIbf9Beyqh/1vNKNLkiFJfK7D8TZGsyUIeNSBLDHBs02c46/8YNoHMtg/ZmEb
         k7zrG1i3A5SVxuOFOaRfg/lqA8nrpzxgnm6MydXJjYogDoqwwhDmH2dXy/VAZRlgyFRG
         5GxszWe2kdamqKo0YhYRFJl+ph5lELzvWZE8yPfvp+KhvN1ChGAbDKZ61mCxNq0YcwZM
         vDEGrkPzwvrU722cQOW98atvLIe6NKoGJwTdu+kx9Gyi2+531akEYH2ivQhMwdynnrRB
         fB8h8smlNNuqa2SEU0bEUZSi/vi5tvjA82HWmNqlnfATU+mbXd0uzk3XMcCsWJuN9odM
         C07g==
X-Gm-Message-State: AGRZ1gJbQ1kHW1+aJUt5NnfgNRyEdLYCLoUndkEjtotdd2erkA/52U49
        NOV7RYvlWdvKRzDxguOjHeuZzhkQZCFQ
X-Google-Smtp-Source: AJdET5fSoIv8rQQk/p1vbxmALI5/RdFzDggXSI4FU1Lg9Wi+tKpIRjgckG2v6FZ/Ze9KPkblCTDKGSYj5rwy
X-Received: by 2002:a24:8342:: with SMTP id d63mr77676ite.26.1542154467951;
 Tue, 13 Nov 2018 16:14:27 -0800 (PST)
Date:   Tue, 13 Nov 2018 16:13:05 -0800
In-Reply-To: <20181114001306.138053-1-sbeller@google.com>
Message-Id: <20181114001306.138053-23-sbeller@google.com>
Mime-Version: 1.0
References: <20181114001306.138053-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH 22/23] path.h: make REPO_GIT_PATH_FUNC repository agnostic
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git_pathdup uses the_repository internally, but the macro
REPO_GIT_PATH_FUNC is specifically made for arbitrary repositories.
Switch to repo_git_path which works on arbitrary repositories.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 path.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/path.h b/path.h
index b654ea8ff5..651e6157fc 100644
--- a/path.h
+++ b/path.h
@@ -165,7 +165,7 @@ extern void report_linked_checkout_garbage(void);
 	const char *git_path_##var(struct repository *r) \
 	{ \
 		if (!r->cached_paths.var) \
-			r->cached_paths.var = git_pathdup(filename); \
+			r->cached_paths.var = repo_git_path(r, filename); \
 		return r->cached_paths.var; \
 	}
 
-- 
2.19.1.1215.g8438c0b245-goog

