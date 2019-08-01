Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 085461F731
	for <e@80x24.org>; Thu,  1 Aug 2019 16:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732748AbfHAQIR (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 12:08:17 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:35173 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfHAQIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 12:08:16 -0400
Received: by mail-pg1-f176.google.com with SMTP id s1so28158359pgr.2
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 09:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qgk2w/X6ItxfatzS13AqeHGQVHaD/EgYCDLhw2O+rfg=;
        b=cDFsycdn+/To0KfDPARNHydylw9td8b8uY1RSFFIqovy3HHIHgyU9U1LeUtEwYMfHK
         Qzl/eXi/Y1P7PqxZQTr5e8LxSNbgWklCtlG2zmEXXeke6tbNwfA4UXx1+ysTaqy4XQpH
         TLjoYJBUR1w+6+cU1Nlryjs+SVJidPjlDCCgwqs2QNylHO3R2OZYn60jYJaVvafx5Y9p
         Kdsm6FwTt0C0iA54jO9LJM8pyr46FJmBFKBZGKP17h7U+ArFDbAWYIBllAPiiU3Ceg9A
         B+BeahJy7tku4KmBzUVFk/EphEAsAoUbyVKsD7A4d+v2T84ur5V6zJfhUsKniHRfu7W3
         HfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qgk2w/X6ItxfatzS13AqeHGQVHaD/EgYCDLhw2O+rfg=;
        b=r8msL7hoQOM+CipqGymWITGIP6b9p22Y3+6plRL5Nf4FcaTAvsGgXg3P+4yXG4i4Mg
         i+3Hzol+ZswZVxaH+zTBaIc7YWKlCwJgMGroeqZ7nB8tduEoWLtsJC+KNHk/By8QCZ1C
         ApIP/7vMrgSHk+NgOjnpdS1yGoPqaeXf9SOP31ifiNDSXamuWWqZkIVekxgb9KkR5sxE
         JjyCF1hbHB7VligkwIeIRBH3vqJXAOfOncwSzdh6/yQU+XOR9wJSuQAhzDd0B/afrGtK
         LYC58V6q6wpeZj4O6Zc2b/avbeygvBKZpEcZzodBLf8VMPPuWKw+N4pG2B1bcPFkfSzo
         mDeg==
X-Gm-Message-State: APjAAAUf0Zlp/4n1iTWfNjmsJX9vAFeajidLdIW7vbu4JRjQeOkPhaQa
        Qs35hCdKMTY++QS4HbIDNLQ=
X-Google-Smtp-Source: APXvYqxWpik0sMsDDpk04oNZLJdFF4vXS0OW3cjj7LiwLmcXeIIKzO2jkCi6R4Rby4WNZsASR/bq8g==
X-Received: by 2002:a62:6044:: with SMTP id u65mr53271999pfb.15.1564675695909;
        Thu, 01 Aug 2019 09:08:15 -0700 (PDT)
Received: from localhost.localdomain (92.18.24.136.in-addr.arpa. [136.24.18.92])
        by smtp.googlemail.com with ESMTPSA id m6sm72728787pfb.151.2019.08.01.09.08.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Aug 2019 09:08:15 -0700 (PDT)
From:   Varun Naik <vcnaik94@gmail.com>
To:     vcnaik94@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: [PATCH v2] checkout.c: unstage empty deleted ita files
Date:   Thu,  1 Aug 2019 09:07:56 -0700
Message-Id: <20190801160756.12601-1-vcnaik94@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726045645.2437-1-vcnaik94@gmail.com>
References: <20190726045645.2437-1-vcnaik94@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is possible to delete a committed file from the index and then add it
as intent-to-add. After `git checkout HEAD`, the file should be
identical in the index and HEAD. The command already works correctly if
the file has contents in HEAD. This patch provides the desired behavior
even when the file is empty in HEAD.

`git checkout HEAD` calls tree.c:read_tree_1(), with fn pointing to
checkout.c:update_some(). update_some() creates a new cache entry but
discards it when its mode and oid match those of the old entry. A cache
entry for an ita file and a cache entry for an empty file have the same
oid. Therefore, an empty deleted ita file previously passed both of
these checks, and the new entry was discarded, so the file remained
unchanged in the index. After this fix, if the file is marked as ita in
the cache, then we avoid discarding the new entry and add the new entry
to the cache instead.

This change should not affect newly added ita files. For those, inside
tree.c:read_tree_1(), tree_entry_interesting() returns
entry_not_interesting, so fn is never called.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Varun Naik <vcnaik94@gmail.com>
---
This patch fixes and tests only "checkout", because "restore" has not
reached maint yet. A second patch on the merge of this patch into master
with a test case for "restore" is coming.

 builtin/checkout.c        |  1 +
 t/t2022-checkout-paths.sh | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index ffa776c6e1..c41dfa53a9 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -105,6 +105,7 @@ static int update_some(const struct object_id *oid, struct strbuf *base,
 	if (pos >= 0) {
 		struct cache_entry *old = active_cache[pos];
 		if (ce->ce_mode == old->ce_mode &&
+		    !ce_intent_to_add(old) &&
 		    oideq(&ce->oid, &old->oid)) {
 			old->ce_flags |= CE_UPDATE;
 			discard_cache_entry(ce);
diff --git a/t/t2022-checkout-paths.sh b/t/t2022-checkout-paths.sh
index fc3eb43b89..6844afafc0 100755
--- a/t/t2022-checkout-paths.sh
+++ b/t/t2022-checkout-paths.sh
@@ -78,4 +78,15 @@ test_expect_success 'do not touch files that are already up-to-date' '
 	test_cmp expect actual
 '
 
+test_expect_success 'checkout HEAD adds deleted intent-to-add file back to index' '
+	echo "nonempty" >nonempty &&
+	>empty &&
+	git add nonempty empty &&
+	git commit -m "create files to be deleted" &&
+	git rm --cached nonempty empty &&
+	git add -N nonempty empty &&
+	git checkout HEAD nonempty empty &&
+	git diff --cached --exit-code
+'
+
 test_done
-- 
2.22.0

