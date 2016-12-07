Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 706E620259
	for <e@80x24.org>; Wed,  7 Dec 2016 15:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753442AbcLGPg6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 10:36:58 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34928 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753264AbcLGPgv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 10:36:51 -0500
Received: by mail-pg0-f65.google.com with SMTP id p66so23822782pga.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 07:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tNtdi1j3Jinjsd+0+cM5dL53vF3LRhOgY0RUB6vqzJA=;
        b=W2cQ98Q/iJrt4jvBTfzrILG8Jf48R9EdoDIPJAuPSYlfKf2zNcUQPOLeGyQKRcnjWd
         yljzGZ1nd6ynbnAJyeK53AcN9Yncp9nmAJmsIZzmI/sDHVl35/ZGzylFYHkxwekkFDQR
         pA2atQKUdqfkpHBhvmmyUXUgfJ72gnDQ/LDo0G3nlhS8+9NNy6cC8skteeFSzym8Q9Qk
         l8u/k7656yLW+hFgoHyCmqMu+MAjbOWd1hikC/B52Leu2wsUVeNI3n7IjxUpc4CoePjI
         NH+FKqDYFi7+em3Snwk+JAgtXrIsW4GPgCMDTNAwkjrIIuH3PgcNNMJkI2dU4TdadHeh
         KF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tNtdi1j3Jinjsd+0+cM5dL53vF3LRhOgY0RUB6vqzJA=;
        b=UmhTLw5unJZljvPLEJq1B7AK91bFAUKHzfFh/cHGoPMgbMzZYAC2gTIMDcxWApWabs
         hNvqIUWI6x+aVUGZTtyT8tXB2WkJF2qbygH9DHb9SOsZAAh14HvT52vnh4nMnEv7Xc0L
         65GpblB6D2FNSfdipEKpyhAuBvTpY4KIGacEDD1mmLbs/6shvEQhi8ELGlsArrw776hL
         Br/dLDjpymOuqSl6f2mrXsWfbva99B6D7PfEeXfJbhuDJXAf74SjVqF9A/EJ4uqXUOzF
         /xRB8Pvq7rvN0Db2HXOBRgwGQpPR426ijtAqKyV8X0TkcfDMMsRWDXAPPKSQ2MzVirLT
         s9Qw==
X-Gm-Message-State: AKaTC02iC002e3SP2kym8qyz9Oud8HfisyH/sXQOp0TEbvE7208IsFv90GJ8WkfPhnx5eg==
X-Received: by 10.99.125.24 with SMTP id y24mr118980624pgc.27.1481125008617;
        Wed, 07 Dec 2016 07:36:48 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([122.15.255.69])
        by smtp.gmail.com with ESMTPSA id l7sm43584459pfg.35.2016.12.07.07.36.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 07:36:48 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com, jnareb@gmail.com,
        Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v8 14/19] ref-filter: modify the 'lstrip=<N>' option to work with negative '<N>'
Date:   Wed,  7 Dec 2016 21:06:22 +0530
Message-Id: <20161207153627.1468-15-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161207153627.1468-1-Karthik.188@gmail.com>
References: <20161207153627.1468-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently the 'lstrip=<N>' option only takes a positive value '<N>'
and strips '<N>' slash-separated path components from the left. Modify
the 'lstrip' option to also take a negative number '<N>' which would
only _leave_ behind 'N' slash-separated path components from the left.

Add documentation and tests for the same.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  5 +++--
 ref-filter.c                       | 26 +++++++++++++++++++++-----
 t/t6300-for-each-ref.sh            | 15 ++++++++-------
 3 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index f85ccff..ad9b243 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -95,8 +95,9 @@ refname::
 	abbreviation mode. If `lstrip=<N>` is appended, strips `<N>`
 	slash-separated path components from the front of the refname
 	(e.g., `%(refname:lstrip=2)` turns `refs/tags/foo` into `foo`.
-	`<N>` must be a positive integer.  If a displayed ref has fewer
-	components than `<N>`, the command aborts with an error.
+	if `<N>` is a negative number, then only `<N>` path components
+	are left behind.  If a displayed ref has fewer components than
+	`<N>`, the command aborts with an error.
 
 objecttype::
 	The type of the object (`blob`, `tree`, `commit`, `tag`).
diff --git a/ref-filter.c b/ref-filter.c
index c74b08d..deb2b29 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -33,7 +33,7 @@ struct if_then_else {
 
 struct refname_atom {
 	enum { R_NORMAL, R_SHORT, R_LSTRIP } option;
-	unsigned int lstrip;
+	int lstrip;
 };
 
 /*
@@ -92,8 +92,8 @@ static void refname_atom_parser_internal(struct refname_atom *atom,
 		atom->option = R_SHORT;
 	else if (skip_prefix(arg, "lstrip=", &arg)) {
 		atom->option = R_LSTRIP;
-		if (strtoul_ui(arg, 10, &atom->lstrip) || atom->lstrip <= 0)
-			die(_("positive value expected refname:lstrip=%s"), arg);
+		if (strtol_i(arg, 10, &atom->lstrip))
+			die(_("Integer value expected refname:lstrip=%s"), arg);
 	} else
 		die(_("unrecognized %%(%s) argument: %s"), name, arg);
 }
@@ -1071,21 +1071,37 @@ static inline char *copy_advance(char *dst, const char *src)
 	return dst;
 }
 
-static const char *lstrip_ref_components(const char *refname, unsigned int len)
+static const char *lstrip_ref_components(const char *refname, int len)
 {
 	long remaining = len;
 	const char *start = refname;
 
+	if (len < 0) {
+		int i;
+		const char *p = refname;
+
+		/* Find total no of '/' separated path-components */
+		for (i = 0; p[i]; p[i] == '/' ? i++ : *p++);
+		/*
+		 * The number of components we need to strip is now
+		 * the total minus the components to be left (Plus one
+		 * because we count the number of '/', but the number
+		 * of components is one more than the no of '/').
+		 */
+		remaining = i + len + 1;
+	}
+
 	while (remaining) {
 		switch (*start++) {
 		case '\0':
-			die(_("ref '%s' does not have %ud components to :lstrip"),
+			die(_("ref '%s' does not have %d components to :lstrip"),
 			    refname, len);
 		case '/':
 			remaining--;
 			break;
 		}
 	}
+
 	return start;
 }
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 2b1af9c..26adca8 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -53,12 +53,16 @@ test_atom head refname refs/heads/master
 test_atom head refname:short master
 test_atom head refname:lstrip=1 heads/master
 test_atom head refname:lstrip=2 master
+test_atom head refname:lstrip=-1 master
+test_atom head refname:lstrip=-2 heads/master
 test_atom head upstream refs/remotes/origin/master
 test_atom head upstream:short origin/master
 test_atom head upstream:lstrip=2 origin/master
+test_atom head upstream:lstrip=-2 origin/master
 test_atom head push refs/remotes/myfork/master
 test_atom head push:short myfork/master
 test_atom head push:lstrip=1 remotes/myfork/master
+test_atom head push:lstrip=-1 master
 test_atom head objecttype commit
 test_atom head objectsize 171
 test_atom head objectname $(git rev-parse refs/heads/master)
@@ -141,14 +145,9 @@ test_expect_success 'Check invalid atoms names are errors' '
 	test_must_fail git for-each-ref --format="%(INVALID)" refs/heads
 '
 
-test_expect_success 'arguments to :lstrip must be positive integers' '
-	test_must_fail git for-each-ref --format="%(refname:lstrip=0)" &&
-	test_must_fail git for-each-ref --format="%(refname:lstrip=-1)" &&
-	test_must_fail git for-each-ref --format="%(refname:lstrip=foo)"
-'
-
 test_expect_success 'stripping refnames too far gives an error' '
-	test_must_fail git for-each-ref --format="%(refname:lstrip=3)"
+	test_must_fail git for-each-ref --format="%(refname:lstrip=3)" &&
+	test_must_fail git for-each-ref --format="%(refname:lstrip=-4)"
 '
 
 test_expect_success 'Check format specifiers are ignored in naming date atoms' '
@@ -603,10 +602,12 @@ test_expect_success 'Verify usage of %(symref:short) atom' '
 
 cat >expected <<EOF
 master
+heads/master
 EOF
 
 test_expect_success 'Verify usage of %(symref:lstrip) atom' '
 	git for-each-ref --format="%(symref:lstrip=2)" refs/heads/sym > actual &&
+	git for-each-ref --format="%(symref:lstrip=-2)" refs/heads/sym >> actual &&
 	test_cmp expected actual
 '
 
-- 
2.10.2

