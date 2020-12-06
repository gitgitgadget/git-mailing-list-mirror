Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1634EC433FE
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 04:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3541230FE
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 04:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgLFEO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 23:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgLFEOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 23:14:25 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A87C061A4F
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 20:13:22 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id a3so10472248wmb.5
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 20:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=E/130efsdGwjWAPHRrEwEf23FVU/DEOUrjJvfKLN/lk=;
        b=S2cQj7HgnQ8DCAM4Re5DSUxhpDl0qU+WlxVK9ZRtUJH5oYhcBIL+DpgzoZCkny5J7j
         QGoy8HI5afcHZXCssNTcNAsSMvoBSOeLM4A53LPaoHRqgHV048Jeo0q+jYB1+lUcQz73
         VVUM9i6ZzJ5+atf9tU7QS0M0Ntu5XkqZuxTMW0Y7fYeRN5Zbi0UKpeBXtAYgMnkOUcPl
         OLBIJGnsoOpaKKJL9HVate7Bt//DR8mK39rOIlU1QrUk8SodwXpn9nEsRhFeiAaqJOUX
         1IPKilBcY+URySMiBaxzj6L9dhlmzJ2w3LJokekGD2VlW9/uXTWvuANECbzhMgFRyITo
         hTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=E/130efsdGwjWAPHRrEwEf23FVU/DEOUrjJvfKLN/lk=;
        b=ekf1L/RJZK+HI+2bNiPSE4VpvnduhBztVGYRiWb1LPSaLBN/CfRBPgWbWmm19+8SQu
         bzlHO2jzgwjGYz1TLhQ6FHUy3vGdELEMy6V3vto3p+3g++IQITevTpmIJu3Kl+eVdRPC
         4CyD00QSW6IOeE4rfjBRj8Kn7B7QETKTNek/GbAAcmiu83OLz+LDiw8V8htesZREpRP/
         trih6YxQlby/jFJeMjTUZEL8ioH/h0Cgcv/iOEVPnQM6gQOh+oX9+QcOZluwfZIm7KUO
         umrUhAqXlxblLcpDIUig8PoOWwE/lXNrbhHeKSs4y4lA2OZofORl95eWbgLv41xddIy3
         2zKw==
X-Gm-Message-State: AOAM5305eTjQOdMV1xB7Kogp8bFFOdctliZgMKCIqNh3pHp18t3oW355
        qbQXPVPBkAinCY4DR8G4L0xoRxOmsXg=
X-Google-Smtp-Source: ABdhPJxXHDXlNy0XK0OWRuQ64EwWVR98Ffk7aSM+vuBZpvUHCssX+7gexGbJmZyqrNkS/9y9He/ZBw==
X-Received: by 2002:a1c:4d0a:: with SMTP id o10mr11279057wmh.185.1607223279485;
        Sat, 05 Dec 2020 18:54:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p3sm9206777wrs.50.2020.12.05.18.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 18:54:39 -0800 (PST)
Message-Id: <95a3fcb8be08cce186144d175a6cda71ab42d445.1607223276.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 06 Dec 2020 02:54:30 +0000
Subject: [PATCH 1/7] diffcore-rename: avoid usage of global in
 too_many_rename_candidates()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

too_many_rename_candidates() got the number of rename targets via an
argument to the function, but the number of rename sources via a global
variable.  That felt rather inconsistent.  Pass in the number of rename
sources as an argument as well.

While we are at it... We had a local variable, num_src, that served two
purposes.  Initially it was set to this global value, but later was used
for counting a subset of the number of sources.  Since we now have a
function argument for the former usage, introduce a clearer variable
name for the latter usage.

This patch has no behavioral changes; it's just renaming and passing an
argument instead of grabbing it from the global namespace.  (You may
find it easier to view the patch using git diff's --color-words option.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index d367a6d2443..68ddf51a2a1 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -434,12 +434,11 @@ static void record_if_better(struct diff_score m[], struct diff_score *o)
  * 1 if we need to disable inexact rename detection;
  * 2 if we would be under the limit if we were given -C instead of -C -C.
  */
-static int too_many_rename_candidates(int num_create,
+static int too_many_rename_candidates(int num_targets, int num_sources,
 				      struct diff_options *options)
 {
 	int rename_limit = options->rename_limit;
-	int num_src = rename_src_nr;
-	int i;
+	int i, limited_sources;
 
 	options->needed_rename_limit = 0;
 
@@ -447,30 +446,30 @@ static int too_many_rename_candidates(int num_create,
 	 * This basically does a test for the rename matrix not
 	 * growing larger than a "rename_limit" square matrix, ie:
 	 *
-	 *    num_create * num_src > rename_limit * rename_limit
+	 *    num_targets * num_sources > rename_limit * rename_limit
 	 */
 	if (rename_limit <= 0)
 		rename_limit = 32767;
-	if ((num_create <= rename_limit || num_src <= rename_limit) &&
-	    ((uint64_t)num_create * (uint64_t)num_src
+	if ((num_targets <= rename_limit || num_sources <= rename_limit) &&
+	    ((uint64_t)num_targets * (uint64_t)num_sources
 	     <= (uint64_t)rename_limit * (uint64_t)rename_limit))
 		return 0;
 
 	options->needed_rename_limit =
-		num_src > num_create ? num_src : num_create;
+		num_sources > num_targets ? num_sources : num_targets;
 
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
-	if ((num_create <= rename_limit || num_src <= rename_limit) &&
-	    ((uint64_t)num_create * (uint64_t)num_src
+	if ((num_targets <= rename_limit || limited_sources <= rename_limit) &&
+	    ((uint64_t)num_targets * (uint64_t)limited_sources
 	     <= (uint64_t)rename_limit * (uint64_t)rename_limit))
 		return 2;
 	return 1;
@@ -576,7 +575,7 @@ void diffcore_rename(struct diff_options *options)
 	if (!num_create)
 		goto cleanup;
 
-	switch (too_many_rename_candidates(num_create, options)) {
+	switch (too_many_rename_candidates(num_create, rename_src_nr, options)) {
 	case 1:
 		goto cleanup;
 	case 2:
-- 
gitgitgadget

