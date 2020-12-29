Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47962C4332E
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 20:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E87C21D94
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 20:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgL2UGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 15:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgL2UGX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 15:06:23 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9ABC061796
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 12:05:33 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id 91so15597349wrj.7
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 12:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0Ue95Y6VgYE2ZtLzIIcPqdKzYogvM9npsEILWau0SY4=;
        b=T6Rqb4OQM3HsU19TaI/EaL19plL9hT93BXTAunzlQhjRGQ36chfNX6Z2hljaiSKYHe
         DUGdd64OlmmqJvRbjyEi6LNyinKjYFBjcxQKB4wTPpemMvWxBtZHRrTj+mtYwqcKaP5b
         M+nwotpslV+GGvnk6/8/lYjeZOQ8P5KaYbk2O/cav7+tT7819WlBTBCAXaeCPoOe+anE
         ok0o2pCVuztm4Q8MmlTgDlcsLkbb/3T0In2qU0cbIKCbnSYQbZxKILZHxbUul1Doruuu
         PjpnoRZvXt5XEM1yb2hrShQzc9QpQo/qWyD9KISpNhiFxEDB1S7Y4TCNLYHF8dOAnotp
         TEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0Ue95Y6VgYE2ZtLzIIcPqdKzYogvM9npsEILWau0SY4=;
        b=IJZc7i85LiqDU4Ps1EM5+vpDnejrB7Ji6WGAPSghcWllcq3S50b5CS0dNZrBRDFIPe
         BooVJZETxSnPT9eAfpMdCSlmxGkof1Q/Z9f+7gvtlx1oDs53Oa6hViQn0F7cpuEN49z/
         ait55tY7o9EJ+hVhE1VIOVduntulZhXLYI+H1ZhX+xPT9tfncj1i3uamcX3M0GN2C6Na
         P4Q5OomlFOCHthxQgRnEtKX7rAbqN6tUBxBCskO5BcgGemDBObUmXt5r4pfavpSLbhqM
         BhgXSd1RATuHGQKtwRWFGUsfUQE3E3ZSqpFOj2sScRtunm7OEUjM5tTUXLB4+7p3hYHL
         30qg==
X-Gm-Message-State: AOAM530MxY11H90e1ks+HSMg3Jv+PYgMkUVyjm1xnasoccAuvInvVTik
        URuCmZYt+VUOMGnxsBoOOe5j6w76DI0=
X-Google-Smtp-Source: ABdhPJzbWxaEWTIK1rrsCy+b8DRFlBjvJ+hy364K1O0e8barb0MZ/nhaAYrXhb1u5snee/1640GlOA==
X-Received: by 2002:a05:6000:10c4:: with SMTP id b4mr58249210wrx.170.1609272331982;
        Tue, 29 Dec 2020 12:05:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v20sm64854237wra.19.2020.12.29.12.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 12:05:31 -0800 (PST)
Message-Id: <fc62f4c4f895a216bb2d39f654e48d390a9d1781.1609272328.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.v3.git.git.1609272328.gitgitgadget@gmail.com>
References: <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
        <pull.929.v3.git.git.1609272328.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Dec 2020 20:05:21 +0000
Subject: [PATCH v3 2/9] diffcore-rename: avoid usage of global in
 too_many_rename_candidates()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

too_many_rename_candidates() got the number of rename destinations via
an argument to the function, but the number of rename sources via a
global variable.  That felt rather inconsistent.  Pass in the number of
rename sources as an argument as well.

While we are at it... We had a local variable, num_src, that served two
purposes.  Initially it was set to the global value, but later was used
for counting a subset of the number of sources.  Since we now have a
function argument for the former usage, introduce a clearer variable
name for the latter usage.

This patch has no behavioral changes; it's just renaming and passing an
argument instead of grabbing it from the global namespace.  (You may
find it easier to view the patch using git diff's --color-words option.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 15a98f566e4..1d6675c040d 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -434,12 +434,11 @@ static void record_if_better(struct diff_score m[], struct diff_score *o)
  * 1 if we need to disable inexact rename detection;
  * 2 if we would be under the limit if we were given -C instead of -C -C.
  */
-static int too_many_rename_candidates(int num_destinations,
+static int too_many_rename_candidates(int num_destinations, int num_sources,
 				      struct diff_options *options)
 {
 	int rename_limit = options->rename_limit;
-	int num_src = rename_src_nr;
-	int i;
+	int i, limited_sources;
 
 	options->needed_rename_limit = 0;
 
@@ -447,30 +446,30 @@ static int too_many_rename_candidates(int num_destinations,
 	 * This basically does a test for the rename matrix not
 	 * growing larger than a "rename_limit" square matrix, ie:
 	 *
-	 *    num_destinations * num_src > rename_limit * rename_limit
+	 *    num_destinations * num_sources > rename_limit * rename_limit
 	 */
 	if (rename_limit <= 0)
 		rename_limit = 32767;
-	if ((num_destinations <= rename_limit || num_src <= rename_limit) &&
-	    ((uint64_t)num_destinations * (uint64_t)num_src
+	if ((num_destinations <= rename_limit || num_sources <= rename_limit) &&
+	    ((uint64_t)num_destinations * (uint64_t)num_sources
 	     <= (uint64_t)rename_limit * (uint64_t)rename_limit))
 		return 0;
 
 	options->needed_rename_limit =
-		num_src > num_destinations ? num_src : num_destinations;
+		num_sources > num_destinations ? num_sources : num_destinations;
 
 	/* Are we running under -C -C? */
 	if (!options->flags.find_copies_harder)
 		return 1;
 
 	/* Would we bust the limit if we were running under -C? */
-	for (num_src = i = 0; i < rename_src_nr; i++) {
+	for (limited_sources = i = 0; i < num_sources; i++) {
 		if (diff_unmodified_pair(rename_src[i].p))
 			continue;
-		num_src++;
+		limited_sources++;
 	}
-	if ((num_destinations <= rename_limit || num_src <= rename_limit) &&
-	    ((uint64_t)num_destinations * (uint64_t)num_src
+	if ((num_destinations <= rename_limit || limited_sources <= rename_limit) &&
+	    ((uint64_t)num_destinations * (uint64_t)limited_sources
 	     <= (uint64_t)rename_limit * (uint64_t)rename_limit))
 		return 2;
 	return 1;
@@ -576,7 +575,8 @@ void diffcore_rename(struct diff_options *options)
 	if (!num_destinations)
 		goto cleanup;
 
-	switch (too_many_rename_candidates(num_destinations, options)) {
+	switch (too_many_rename_candidates(num_destinations, rename_src_nr,
+					   options)) {
 	case 1:
 		goto cleanup;
 	case 2:
-- 
gitgitgadget

