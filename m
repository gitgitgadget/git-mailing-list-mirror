Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43CA01F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 16:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756257AbcIVQLr (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 12:11:47 -0400
Received: from mout.web.de ([212.227.15.4]:63264 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751220AbcIVQLq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 12:11:46 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0LiCbT-1bAWJC3aXz-00nNmp; Thu, 22 Sep 2016 18:11:33
 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] introduce CHECKOUT_INIT
Message-ID: <c2defe5a-3a49-d776-7806-f3abfbd79770@web.de>
Date:   Thu, 22 Sep 2016 18:11:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:skRsqSaCRuXseCPFaRoOm4BEJoB1i9f0nPrhEshl+26/tuDWI4J
 7VcjfHKHYx4uBIVF2eEN1orIGJkX0ZFAeOq3F81R9zrZvmZPGDGT73tPf3V4uj5ecmQow6J
 VSBUuD76W2j0YEta/FVaTskIagXcVvp4rFHUCt63qsA8xnLRtTbYQyVCuQswkmA82F6og/n
 JkI3ZA1J+LDQxs9w+oIwA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zTlv7eYG+wQ=:wKP7fECwA+czveN7Y8J9CR
 bhkieS88LDSshBb0pK7MVmqSW57+yiPYeCKGVNp3k2ZaH2yPWW5jQgVRgiv+9lN9mOo0CeVoV
 9Bcwz+pNwRSToX0xJ84gFmjaVPFN2ZqTt4HfLzs06dR8bzZWpOrvIMMZVY/M0qP7w+o0D8pYO
 3cLTGrSWg9wMzyF0JVt77RPzmrib2IU9Ma+r4T3p6IxqlIIQEeK1NivQIF0t8EzQ/ezuqNuvR
 WZerIcsVhQGb4tv0ZhwSSfPQW8prMKNQUSrYhPAOUMRMCGi38g53feKMIRqnRm8L41GAee/bO
 dxU+7l6g8R3CQ0fG+F/4+yLLohed6hSUMSaIfTfV0s57v4RnSi5fDHyx3oJn+cPtPbTTffVOz
 VzvtZDLtm3GyJ1oPUtLT7G8YBrFXH0VqE+O8o8IJBVgS+x6jVQ8kLzZknjDSgknAsMKUie60i
 YlzuGjiWFDNh4hxXy7UyA0ka4q0iS0XeqmdSuSEl+3O4SZuMapHljnSuPk4FnlzS0aGxQcOfA
 gWlScOSZjtVQZ1muc2k6HI11VN5pP+4YndDkvJrAmKCYZGA7TD24RtUKw9NWefewc3dkTE0yv
 ARLdwMz2lSv06yS6mOy0m6o7AZtkHB+2CGVFFeWqhjH4/AOJ9nMknKpiq4OjTU/xlDW7cVsQN
 KxJ8RoiDM4QBGWffsnu7TzEXH8z4DArZZUUuMt/1LdICloF0eGqqhtzh48nL4saQRkYr7RV27
 ksHEinYzrvkiAIOcz3ixSe3Cc2pnF1OQnCPaRHn6A+yOh7ldaF9eUjpqFxMM4uVzMoRzE7+Z9
 6yAWy4n
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a static initializer for struct checkout and use it throughout the
code base.  It's shorter, avoids a memset(3) call and makes sure the
base_dir member is initialized to a valid (empty) string.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 apply.c                  | 4 +---
 builtin/checkout-index.c | 2 +-
 builtin/checkout.c       | 3 +--
 cache.h                  | 1 +
 unpack-trees.c           | 4 +---
 5 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/apply.c b/apply.c
index e327021..b03d274 100644
--- a/apply.c
+++ b/apply.c
@@ -3334,10 +3334,8 @@ static void prepare_fn_table(struct apply_state *state, struct patch *patch)
 static int checkout_target(struct index_state *istate,
 			   struct cache_entry *ce, struct stat *st)
 {
-	struct checkout costate;
+	struct checkout costate = CHECKOUT_INIT;
 
-	memset(&costate, 0, sizeof(costate));
-	costate.base_dir = "";
 	costate.refresh_cache = 1;
 	costate.istate = istate;
 	if (checkout_entry(ce, &costate, NULL) || lstat(ce->name, st))
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 92c6967..30a49d9 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -16,7 +16,7 @@ static int checkout_stage; /* default to checkout stage0 */
 static int to_tempfile;
 static char topath[4][TEMPORARY_FILENAME_LENGTH + 1];
 
-static struct checkout state;
+static struct checkout state = CHECKOUT_INIT;
 
 static void write_tempfile_record(const char *name, const char *prefix)
 {
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9941abc..4c86272 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -239,7 +239,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 			  const char *revision)
 {
 	int pos;
-	struct checkout state;
+	struct checkout state = CHECKOUT_INIT;
 	static char *ps_matched;
 	struct object_id rev;
 	struct commit *head;
@@ -352,7 +352,6 @@ static int checkout_paths(const struct checkout_opts *opts,
 		return 1;
 
 	/* Now we are committed to check them out */
-	memset(&state, 0, sizeof(state));
 	state.force = 1;
 	state.refresh_cache = 1;
 	state.istate = &the_index;
diff --git a/cache.h b/cache.h
index d0494c8..5d9116c 100644
--- a/cache.h
+++ b/cache.h
@@ -1354,6 +1354,7 @@ struct checkout {
 		 not_new:1,
 		 refresh_cache:1;
 };
+#define CHECKOUT_INIT { NULL, "" }
 
 #define TEMPORARY_FILENAME_LENGTH 25
 extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
diff --git a/unpack-trees.c b/unpack-trees.c
index 3db3f02..ea6bdd2 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1094,12 +1094,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	int i, ret;
 	static struct cache_entry *dfc;
 	struct exclude_list el;
-	struct checkout state;
+	struct checkout state = CHECKOUT_INIT;
 
 	if (len > MAX_UNPACK_TREES)
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
-	memset(&state, 0, sizeof(state));
-	state.base_dir = "";
 	state.force = 1;
 	state.quiet = 1;
 	state.refresh_cache = 1;
-- 
2.10.0

