Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D92B6211B4
	for <e@80x24.org>; Sun,  9 Dec 2018 20:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbeLIUFL (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 15:05:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38142 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbeLIUFK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 15:05:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so8455983wrw.5
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 12:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=stC4U0fS6L3+UPWXmWTRD/EWbWoBknt4Y6k9/VcGR3U=;
        b=Cs63REAtdAZrBzKj5lEl0OJler3Bs5UB617hxxFUPn1VN2FsCcmrrEVp/Ni0CGyEuY
         ct8izSoMG0ghej+mTq0xhUmFYSWhthILE06ntGh7NjGSetsWHd9AS+uGU5btEdI46ML/
         /NeTOn7EUBLyR1oSa0fZEilIWTCLEa5YzQd9uvbtEzGHpRZTnK46gh2UOCWV9Lf7mnYg
         vTuUdKuiwxeeL6cmzPf3lA+v5tDYKlPCW2fg7fMynb6SyvvHuSSch+LOBnTDD/rCzOiG
         XqoAX3J9A7kJpyzZOVzx/oYPmMQQnzIk8xJYzHF9gQU/QM2H5SIuUXVjPEHYlXHn8y9v
         jdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=stC4U0fS6L3+UPWXmWTRD/EWbWoBknt4Y6k9/VcGR3U=;
        b=iLogtRuOHCZP1TLtYH7wWoYEfa05AxQZj1JDtQeeBl0kRgdevB6YP5GvwOmE7Nvirn
         weBpTDB9sVYtZ6uZZ0eOeILA/rAmu+lOr8ZvyTL+RPiZ7IiaW9R+0TRI+A7AipEN4x2G
         aHlS51y6xiZaISJ6CmICOVn9MZYTA8hxYCEU81oM8BuMK1yggRRVwxXPxsdnbSTD8jD3
         ihjj0uuhf189CRgSCiKYXJ1EpWl2XDTR0ShUAEWqo+z6wO9cxJPYqq2Y4I7fJxC2x3vR
         m77Pv8fVbYLuNeGjilnoObN1oNHLoixbgzoq9R5iccWtvapbXBnvNXNNRhBr9/JrmOnO
         Qz+Q==
X-Gm-Message-State: AA+aEWbxp2YyhYngrVIKxqJBCF5z7gbEXzKmNsUoScjKvEsMlJdrc4ZD
        qfNHNcCA4JWbp3RNJgao+t9C4sst
X-Google-Smtp-Source: AFSGD/VnaUHgN2zcfIpxC9FmYmWuAei2kh1swCWNkGQ/8gkMoZZuP8ZsgwB13vFfkqaTKRyxRf/m+Q==
X-Received: by 2002:adf:f785:: with SMTP id q5mr8250594wrp.9.1544385907649;
        Sun, 09 Dec 2018 12:05:07 -0800 (PST)
Received: from localhost ([2.24.105.121])
        by smtp.gmail.com with ESMTPSA id n127sm12245169wmd.20.2018.12.09.12.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 12:05:06 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 7/8] checkout: allow ignoring unmatched pathspec
Date:   Sun,  9 Dec 2018 20:04:48 +0000
Message-Id: <20181209200449.16342-8-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85
In-Reply-To: <20181209200449.16342-1-t.gummerer@gmail.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently when 'git checkout -- <pathspec>...' is invoked with
multiple pathspecs, where one or more of the pathspecs don't match
anything, checkout errors out.

This can be inconvenient in some cases, such as when using git
checkout from a script.  Introduce a new --ignore-unmatched option,
which which allows us to ignore a non-matching pathspec instead of
erroring out.

In a subsequent commit we're going to start using 'git checkout' in
'git stash' and are going to make use of this feature.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/checkout.c        | 10 +++++++++-
 t/t2022-checkout-paths.sh |  9 +++++++++
 t/t9902-completion.sh     |  1 +
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6ba85e9de5..7e7b5cd1d3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -46,6 +46,7 @@ struct checkout_opts {
 	int show_progress;
 	int overlay_mode;
 	int cached;
+	int ignore_unmatched;
 	/*
 	 * If new checkout options are added, skip_merge_working_tree
 	 * should be updated accordingly.
@@ -358,7 +359,8 @@ static int checkout_paths(const struct checkout_opts *opts,
 			ce->ce_flags |= CE_MATCHED;
 	}
 
-	if (report_path_error(ps_matched, &opts->pathspec, opts->prefix)) {
+	if (!opts->ignore_unmatched &&
+	    report_path_error(ps_matched, &opts->pathspec, opts->prefix)) {
 		free(ps_matched);
 		return 1;
 	}
@@ -586,6 +588,11 @@ static int skip_merge_working_tree(const struct checkout_opts *opts,
 	 * not tested here
 	 */
 
+	/*
+	 * opts->ignore_unmatched cannot be used with switching branches so is
+	 * not tested here
+	 */
+
 	/*
 	 * If we aren't creating a new branch any changes or updates will
 	 * happen in the existing branch.  Since that could only be updating
@@ -1320,6 +1327,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "progress", &opts.show_progress, N_("force progress reporting")),
 		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode")),
 		OPT_BOOL(0, "cached", &opts.cached, N_("work on the index only")),
+		OPT_BOOL(0, "ignore-unmatched", &opts.ignore_unmatched, N_("don't error on unmatched pathspecs")),
 		OPT_END(),
 	};
 
diff --git a/t/t2022-checkout-paths.sh b/t/t2022-checkout-paths.sh
index fc3eb43b89..b44cdf7b63 100755
--- a/t/t2022-checkout-paths.sh
+++ b/t/t2022-checkout-paths.sh
@@ -78,4 +78,13 @@ test_expect_success 'do not touch files that are already up-to-date' '
 	test_cmp expect actual
 '
 
+test_expect_success 'checkout --ignore-unmatched' '
+	test_commit file1 &&
+	echo changed >file1.t &&
+	git checkout --ignore-unmatched -- file1.t unknown-file &&
+	echo file1 >expect &&
+	test_cmp expect file1.t
+
+'
+
 test_done
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index cbc304ace8..475debcf95 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1438,6 +1438,7 @@ test_expect_success 'double dash "git checkout"' '
 	--no-... Z
 	--overlay Z
 	--cached Z
+	--ignore-unmatched Z
 	EOF
 '
 
-- 
2.20.0.405.gbc1bbc6f85

