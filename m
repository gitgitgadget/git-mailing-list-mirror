Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07A24200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 16:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932239AbcL0QX4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 11:23:56 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34409 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755559AbcL0QXs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 11:23:48 -0500
Received: by mail-pg0-f67.google.com with SMTP id b1so12844513pgc.1
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 08:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h2PDlAihD9BIheIGvf3K6mstO3qGtgX5d4jszUDTq18=;
        b=O1635BtrkacRyWu/YAxdDITZXBKi2g90IhUlvCOWVnZTs4fWM5rV93lgQ1rNyr6MGC
         T8ZslUGCSqwt50KAFoNLYYwYFTPh3zblmPsT4f1JttJ4a59DEi5XxnRJewwAQCDkHbyE
         6+HnJa13doQuPo3wyi2VSxT4WmRkjuMOTaOhQOlPV2SXtn12kDVPD6fc8yJ2OC+PaV6I
         JVsjZOE8OPrkG9zQhTIqMHsIk9PbU2T8+DVh0Yx5hjLNx5/MF1RclQVt5IWUt0lqcw/H
         cicwfSrI3KpLp2fxcabsn2CLLIZ+JOedEMYtbrqEMwSj9c3QpsuUVUZ2BRRpUrte1aoE
         bVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h2PDlAihD9BIheIGvf3K6mstO3qGtgX5d4jszUDTq18=;
        b=UICVkoYdaj1vE7xqgjfMziIAqv+TnH22JrZ9EioEt06dtXPz1ogIOG/ecQC+ZhwjyO
         cCq6IigEbtLXnJUQa21CVf9i6JvLDprU5O1RK3KmaRl07PBk/aHyXnMtPyCE/W92xX6a
         iB/Gdy4hkablfWGB+gm+h4SGesrEceL4HZQGQ2m3EKx9xL7gb5t/q6jrXxZmphic4MTY
         E7EL4Q64mf8loQeguJpYQmGcYg3jttxwlr2WkxKTJa4zhz02VLskctD/ADBUZ3Uf7m2C
         qvnOmHrlFMZ5Zhc6+BWwb087MqrurR75K7xXvucSKA5u3h0SBq9bV5EDHAnoq8At4jYL
         X+Cg==
X-Gm-Message-State: AIkVDXJMe6yNO0SERq3knf5r5zdWesgY/1/FbwlR8B8Ye0Y3eKq1jQLSlBNGAx7QOpj4uQ==
X-Received: by 10.99.127.16 with SMTP id a16mr59394511pgd.60.1482855827688;
        Tue, 27 Dec 2016 08:23:47 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id c64sm46517096pfa.91.2016.12.27.08.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 08:23:47 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v9 14/20] ref-filter: Do not abruptly die when using the 'lstrip=<N>' option
Date:   Tue, 27 Dec 2016 21:53:51 +0530
Message-Id: <20161227162357.28212-15-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161227162357.28212-1-Karthik.188@gmail.com>
References: <20161227162357.28212-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently when we use the 'lstrip=<N>' option, if 'N' is greater than
the number of components available in the refname, we abruptly end
program execution by calling die().

This behavior is undesired since a single refname with few components
could end program execution. To avoid this, return an empty string
whenever the value 'N' is greater than the number of components
available, instead of calling die().

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt | 3 +--
 ref-filter.c                       | 3 +--
 t/t6300-for-each-ref.sh            | 4 ----
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 46b4583..82c202a 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -98,8 +98,7 @@ refname::
 	abbreviation mode. If `lstrip=<N>` is appended, strips `<N>`
 	slash-separated path components from the front of the refname
 	(e.g., `%(refname:lstrip=2)` turns `refs/tags/foo` into `foo`.
-	`<N>` must be a positive integer.  If a displayed ref has fewer
-	components than `<N>`, the command aborts with an error.
+	`<N>` must be a positive integer.
 
 objecttype::
 	The type of the object (`blob`, `tree`, `commit`, `tag`).
diff --git a/ref-filter.c b/ref-filter.c
index e0015c6..76553eb 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1099,8 +1099,7 @@ static const char *lstrip_ref_components(const char *refname, unsigned int len)
 	while (remaining) {
 		switch (*start++) {
 		case '\0':
-			die(_("ref '%s' does not have %ud components to :lstrip"),
-			    refname, len);
+			return "";
 		case '/':
 			remaining--;
 			break;
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 5eb013c..d3d1a97 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -147,10 +147,6 @@ test_expect_success 'arguments to :lstrip must be positive integers' '
 	test_must_fail git for-each-ref --format="%(refname:lstrip=foo)"
 '
 
-test_expect_success 'stripping refnames too far gives an error' '
-	test_must_fail git for-each-ref --format="%(refname:lstrip=3)"
-'
-
 test_expect_success 'Check format specifiers are ignored in naming date atoms' '
 	git for-each-ref --format="%(authordate)" refs/heads &&
 	git for-each-ref --format="%(authordate:default) %(authordate)" refs/heads &&
-- 
2.10.2

