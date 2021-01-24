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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A82DC433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 06:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8815229C7
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 06:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbhAXGC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 01:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbhAXGCW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 01:02:22 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3424C06174A
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 22:01:41 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id r4so5632804pls.11
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 22:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aZGxupIM3j2COmunN4KJJcFadyf/ypsS6rJ6/PFM2aA=;
        b=m+b5/QbTxT5U3f13qb39vB8w2u+f1PGs9xCitYOXTvac1i9Ccrw95elCmHeJ/rd6ze
         bkHS7eG4rYPO2tIAk311zsc4EIpJvep6RBwp2y6HeGI1SfdnLKGBIQYldZoGURQqgqXM
         lmCoSWlvjhZSz3/3fvliJSZTQg74v6+BfJatwjgmDmLlJh0kR89VLik95u9/5g5NXVVv
         GXLCuyryq6VhR3OORzms8zhdgf4adRcwHnD12c+n0dH5AjUtcO8jR+TexqV0BgKil7Gv
         tb3AdlXGy6tI1OrtSbgoEE82KJ7PIVg+FhhEI6kJ9WfTIjTlaDX1X/CsHWjsGgXFHr5H
         I8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aZGxupIM3j2COmunN4KJJcFadyf/ypsS6rJ6/PFM2aA=;
        b=m4xBvMlbyXuDAOmgw9Ccn+5OMz/uqm9iRhunHm57MLxI/yzg0Y5PlSm7NWr/pBWXba
         aandz/phiWvSRTUl0S5hx4ordiPkqLlqXDxi6o5WVLT+P7/Vgj1zQshU+OkrKUnVJXMS
         +57ixavHUhrNDR5UsM2mh1Uye2I08LL56WteBJbsuncZiSeENSRq24uDECnFqANPxBF9
         Jch75oQv9ywJAYZpnT5i2LiNC7XuiSMPkv7RN9eUayxEmonMUX7rGTUzNWJFpUjaupMW
         TtkDn9XuXHwNtSQTy0S+6GpidZBmGZ/QRe2q91L3SnGqL4mGnTRRAtLa/I6n7GnR2q/d
         b9vA==
X-Gm-Message-State: AOAM530UlKErD3Il0abj77o7Zd6RGfKby93Dvhvkttcgxpk04cvTOsyG
        LI9hjxxYutOrxc+X5GXRQ8wJKcaPrAc=
X-Google-Smtp-Source: ABdhPJxdZ2ZISZN4FVXINrozWzpSW7lfKpka1g3YQBcmfQlzr1R/NfXgIOBSstI4OwmXKUmF5Q+sYg==
X-Received: by 2002:a17:90a:470f:: with SMTP id h15mr15373344pjg.179.1611468101243;
        Sat, 23 Jan 2021 22:01:41 -0800 (PST)
Received: from tiger.hsd1.ca.comcast.net ([2601:646:8d80:9ab0:f634:2e28:1242:da6])
        by smtp.gmail.com with ESMTPSA id i26sm13275331pfq.219.2021.01.23.22.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 22:01:40 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 2/3] merge-ort: ignore the directory rename split conflict for now
Date:   Sat, 23 Jan 2021 22:01:11 -0800
Message-Id: <20210124060112.1258291-3-newren@gmail.com>
X-Mailer: git-send-email 2.30.0.135.g7f7d4a3e17
In-Reply-To: <20210124060112.1258291-1-newren@gmail.com>
References: <20210115192958.3336755-1-newren@gmail.com>
 <20210124060112.1258291-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

get_provisional_directory_renames() has code to detect directories being
evenly split between different locations.  However, as noted previously,
if there are no new files added to that directory that was split evenly,
our inability to determine where the directory was renamed to doesn't
matter since there are no new files to try to move into the new
location.  Unfortunately, that code is unaware of whether there are new
files under the directory in question and we just ignore that, causing
us to fail t6423 test 2b but pass test 2a; turn off the error for now,
swapping which tests pass and fail.

The motivating reason for switching this off as a temporary measure is
that as we add optimizations, we'll start looking at only subsets of
renames, and subsets of renames can start switching the result we get
when this error is (wrongly) on.  Once we get enough optimizations,
however, we can prevent that code from even running when there are no
new files added to the relevant directory, at which point we can revert
this commit and then both testcases 2a and 2b will pass simultaneously.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index b5845ff6e9..f04fab96d7 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1439,7 +1439,18 @@ static void get_provisional_directory_renames(struct merge_options *opt,
 				 "no destination getting a majority of the "
 				 "files."),
 			       source_dir);
-			*clean = 0;
+			/*
+			 * We should mark this as unclean IF something attempts
+			 * to use this rename.  We do not yet have the logic
+			 * in place to detect if this directory rename is being
+			 * used, and optimizations that reduce the number of
+			 * renames cause this to falsely trigger.  For now,
+			 * just disable it, causing t6423 testcase 2a to break.
+			 * We'll later fix the detection, and when we do we
+			 * will re-enable setting *clean to 0 (and thereby fix
+			 * t6423 testcase 2a).
+			 */
+			/*   *clean = 0;   */
 		} else {
 			strmap_put(&renames->dir_renames[side],
 				   source_dir, (void*)best);
-- 
2.30.0.135.g7f7d4a3e17

