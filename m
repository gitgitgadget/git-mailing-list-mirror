Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74EFA20259
	for <e@80x24.org>; Wed,  7 Dec 2016 15:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932359AbcLGPhn (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 10:37:43 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36333 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752905AbcLGPgv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 10:36:51 -0500
Received: by mail-pf0-f195.google.com with SMTP id c4so20787555pfb.3
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 07:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LxT0FNJ5X6xlIrCELjkdfl7M5Rv5VK6XXnzOdXd7eRI=;
        b=PgxAZqSyCsxUb800sgrMqAWDrhH/2JipQfjWBYld7dEgxqXM1Qx0BQGeaFgbpSG2Hl
         Lcw3ITBn9ZeTqbQq+ZeC4ZVzt1qKzIl9rAZIwSfmlfToMIiCCTGdleR1ieU+h9LKZaj5
         s/pNrB1rDrIGTcsV+9P3qWCry/Qtx4w+UPHrTZrHMFaR1K8GRsWv6PhSWdEmNOMUsWzl
         R3eExaYYOKj3HMmJinhCJkXslDjmm9khE+inBwRImAnMxLamq7rueHS/bJZEDKVx13X9
         PnZ6A0/o/lALUyLfhCKmPYeMG5swlVuerzSQsRcNdbP8RdcwRmeX+HUjeIorEDv+sC9o
         3y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LxT0FNJ5X6xlIrCELjkdfl7M5Rv5VK6XXnzOdXd7eRI=;
        b=bilH1zNNuYTGjjrk6Bj2roGNRGmOWrCzxJIXFRFhQvNPaCZMUjrlEpRXTgd9aUQtxg
         5m/YyLfLSrOvxnvBzeb+LEBEy6vua3KmGj8TCygiFmzcWkZvgrgaThlwoZKK/dx6fIqC
         W0SOgTTXwE66AbxZogEM4/lHCqhJku3SL4Gd+8ZVdkMJ85YbxaNPQn3TaaAKOYNd7k5l
         b8kUbKobubcUB4oVUgLaN/afFxDknptop3h490gDXSMu1/IrVVr6OeWJwQdfiZREj6iG
         vs0xogcAok/+i5YIuxI66SV6lxyC06U185KHVmet8PFSxEONVmWKIekI1u3MyP6PyK7c
         BLWg==
X-Gm-Message-State: AKaTC02FOUN/PbPxgCDClNIEYalXJKk2Y0BdHExFl67+54nw/oyH4kbN2a0aDq9nrTc5wg==
X-Received: by 10.99.36.65 with SMTP id k62mr120694706pgk.13.1481124982502;
        Wed, 07 Dec 2016 07:36:22 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([122.15.255.69])
        by smtp.gmail.com with ESMTPSA id l7sm43584459pfg.35.2016.12.07.07.36.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 07:36:21 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com, jnareb@gmail.com,
        Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 07/19] ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
Date:   Wed,  7 Dec 2016 21:06:15 +0530
Message-Id: <20161207153627.1468-8-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161207153627.1468-1-Karthik.188@gmail.com>
References: <20161207153627.1468-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

Borrowing from branch.c's implementation print "[gone]" whenever an
unknown upstream ref is encountered instead of just ignoring it.

This makes sure that when branch.c is ported over to using ref-filter
APIs for printing, this feature is not lost.

Make changes to t/t6300-for-each-ref.sh and
Documentation/git-for-each-ref.txt to reflect this change.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Helped-by : Jacob Keller <jacob.keller@gmail.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt | 3 ++-
 ref-filter.c                       | 4 +++-
 t/t6300-for-each-ref.sh            | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index b730735..536846f 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -118,7 +118,8 @@ upstream::
 	"[ahead N, behind M]" and `:trackshort` to show the terse
 	version: ">" (ahead), "<" (behind), "<>" (ahead and behind),
 	or "=" (in sync).  Has no effect if the ref does not have
-	tracking information associated with it.
+	tracking information associated with it. `:track` also prints
+	"[gone]" whenever unknown upstream ref is encountered.
 
 push::
 	The name of a local ref which represents the `@{push}` location
diff --git a/ref-filter.c b/ref-filter.c
index 0f81f9f..e0229d3 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1053,8 +1053,10 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 		*s = shorten_unambiguous_ref(refname, warn_ambiguous_refs);
 	else if (atom->u.remote_ref == RR_TRACK) {
 		if (stat_tracking_info(branch, &num_ours,
-				       &num_theirs, NULL))
+				       &num_theirs, NULL)) {
+			*s = "[gone]";
 			return;
+		}
 
 		if (!num_ours && !num_theirs)
 			*s = "";
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 644f169..5019f40 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -382,7 +382,7 @@ test_expect_success 'Check that :track[short] cannot be used with other atoms' '
 
 test_expect_success 'Check that :track[short] works when upstream is invalid' '
 	cat >expected <<-\EOF &&
-
+	[gone]
 
 	EOF
 	test_when_finished "git config branch.master.merge refs/heads/master" &&
-- 
2.10.2

