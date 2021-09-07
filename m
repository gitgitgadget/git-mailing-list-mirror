Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD46C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1D17610CB
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245377AbhIGMBU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 08:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245337AbhIGMBP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 08:01:15 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18E2C061757
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 05:00:09 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id s29so7979657pfw.5
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 05:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jnkkddKqtqWYsXo+82ptvtqq+qtAQ70WTJ2ehwv2NG8=;
        b=WzQEJW3ZYFKY4lyUnJ2+swxrlfjige9u83A2i0RthKrzqI/qoWlQDKQOSNBif5vDUq
         LvJdGf0GO419c8olKiE8j5ML3iPV2fQC15oQtyfbfl6HHNuGEQ9PrGZsozTWhJnEaSZP
         buyFgZKrZUYvPXbiP50gA48WbrOSVEr2+mSLX0ESx1+8sU9EvuSfVlVPlHAGrEePUF6K
         5t4tPK9bSfjwpa45PKQ8K9j9FZWDe81aH80XIOI2TjmV30ISaubDAgfgnqDPnwuR/Oxa
         21f4VDXG5YBlCJHV2gpKiggliC367+oDV6MdIzXySGYCwxIj31J2AnI2EMHtLvKny+Xg
         K1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jnkkddKqtqWYsXo+82ptvtqq+qtAQ70WTJ2ehwv2NG8=;
        b=LJJR0l+d+5Cv3zpdikgxUj6kpuYwsJynR+k68Mq2v2AK75mv2UZ+c54j0RfX1Yf5gD
         8J7yoZA8tAcq2sJttUz29DMLm5UDiF58Dst8LcnU0WA6JN1SoIZXYpCkCl3cqZ9maV8q
         2DTThiIMAhoy5I4l4bJBVDT/PUIjEuwZbIXNxqlQkp8hEtINhd0D6VbKnCd9XZTEFgsF
         AwDbwJn030bhM/L9QXiiGb9mSkevKmRo+qR4pmSlmNnBBKVQUVt/S/A2/xBC7BHjhuaI
         dZlQOt9rVKa1nqmH1X0iw3j+zYimjOa+5aWJrzQNbG7g8VqTzAZ1vlhWxhFxNYOw7u/+
         AfNw==
X-Gm-Message-State: AOAM5310a6VcuQ/kY/TaWTBZShqJAF/W+rQIdj2BK2jS9gDjRM4BIcHE
        65mZnk05teR++T7cu3wstO8fPlWR9LI=
X-Google-Smtp-Source: ABdhPJzvZJVNrbEqjsQPzwMR0oTlNkNPZC5g2LmlBsJBvGujPkbvOCKRIsY52FyEp0lu1+EHNFoyLw==
X-Received: by 2002:a63:34c6:: with SMTP id b189mr16636612pga.122.1631016009081;
        Tue, 07 Sep 2021 05:00:09 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.210])
        by smtp.gmail.com with ESMTPSA id a142sm11248150pfd.172.2021.09.07.05.00.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Sep 2021 05:00:08 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, emilyshaffer@google.com,
        gitster@pobox.com, jrnieder@gmail.com, kaartic.sivaraam@gmail.com,
        pc44800@gmail.com, periperidip@gmail.com, avarab@gmail.com,
        Atharva Raykar <raykar.ath@gmail.com>
Subject: [PATCH 05/13] submodule--helper: refactor get_submodule_displaypath()
Date:   Tue,  7 Sep 2021 17:29:24 +0530
Message-Id: <20210907115932.36068-6-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210907115932.36068-1-raykar.ath@gmail.com>
References: <20210907115932.36068-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We create a function called `do_get_submodule_displaypath()` that
generates the display path required by several submodule functions, and
takes a custom superprefix parameter, instead of reading it from the
environment.

We then redefine the existing `get_submodule_displaypath()` function
as a call to this new function, where the superprefix is obtained from
the environment.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---
 builtin/submodule--helper.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b0336b0377..10de01a1f7 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -269,11 +269,8 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
 	return 0;
 }
 
-/* the result should be freed by the caller. */
-static char *get_submodule_displaypath(const char *path, const char *prefix)
+static char *do_get_submodule_displaypath(const char *path, const char *prefix, const char *super_prefix)
 {
-	const char *super_prefix = get_super_prefix();
-
 	if (prefix && super_prefix) {
 		BUG("cannot have prefix '%s' and superprefix '%s'",
 		    prefix, super_prefix);
@@ -289,6 +286,13 @@ static char *get_submodule_displaypath(const char *path, const char *prefix)
 	}
 }
 
+/* the result should be freed by the caller. */
+static char *get_submodule_displaypath(const char *path, const char *prefix)
+{
+	const char *super_prefix = get_super_prefix();
+	return do_get_submodule_displaypath(path, prefix, super_prefix);
+}
+
 static char *compute_rev_name(const char *sub_path, const char* object_id)
 {
 	struct strbuf sb = STRBUF_INIT;
-- 
2.32.0

