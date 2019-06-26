Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 944FE1F461
	for <e@80x24.org>; Wed, 26 Jun 2019 23:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfFZXvN (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 19:51:13 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:37016 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfFZXvN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 19:51:13 -0400
Received: by mail-pg1-f201.google.com with SMTP id e16so206503pga.4
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 16:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nyiPkoZ6sPMQUqADlP4e3n5AVmwefyeDNcV2SY+k2Eg=;
        b=pck/+SGgndoArsLEzclKeBuA33xERNCtazq6F/qZM8zmWwFxQwxN0HTwnkjw27Gror
         me5NmXPZpVcC2drtrB6fpYjeVC3DjQJW8w+WzmTGTHGKGfs7Nbr5+FsLyKkwvK+uiHrF
         olLMhMobr9UywtP8/u6P3uQzBteZmYiWwPslA7nK4YVGHMHKMDpOXnXQyveKexYXsEQC
         eB5dVxHePK9DGTZBNJiR8EQ3rrgSJwRSIBWAzvm1idX72p2kbx2/F3/zB3rZyblVLjO4
         nZbLjI/Vw0NPuwgB7F4NcpPC2Euf2P+H4T+zso1O5OGWx5RJR5sDB/xlCEVu3mpm2PnC
         UT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nyiPkoZ6sPMQUqADlP4e3n5AVmwefyeDNcV2SY+k2Eg=;
        b=tR+aeAzBpz79XRkcWeTrFl976KuAltgvmS3kHWlQ/6tAVhIXh89H3jniBMV3ohcWBU
         z26u7Ghcrp6RXnEc6irnQUKvmON3AONG0cnQ3HuOXWoc8IiTcfhqa3ycxGdsDRye4EgF
         NqHeWklfSpJBImhd9T9PLMsJGfAWCsz7fnbxtZeoRlp87j5JC8cNt51+xvMurOHB4Bui
         U7o06ITqug6+nISu2wopAnLcStg5MgFYDHFeLRXD44ToZmu3mP3DEOBvp/pezxot/pzq
         /k1huI5Dr68Y3rAd/dQboAh/zfMqUmQfSWZPF2/L8o72Y6c2Goe+gc9Id7CIzGy7oTCO
         3xZA==
X-Gm-Message-State: APjAAAVN3DGka27qOidb3yrNq+igKGkTgchMGmjCZ30c9l82LmMOy57S
        Uvz6QH6HXokdRSDRacY23XY6twqNNbIdx7kbb3al/2hiCJa1KtvMMNRYJTlsHpyC5iMfoOMrpMZ
        FUIMaeVUNeJmNcNrfvv4t2A3CpDPF31RLOJwcdXxH9VYY0m2nzEd63WynQrBBJyvLYYqtR0Zb3A
        ==
X-Google-Smtp-Source: APXvYqzO8ku6mz0527nK0ssKEn5ZD+E3wSnpm0wOXYWKSQipsH7/nRL8smureSAPXZ2dW9X8jyTRQOicWEseMFEs8V4=
X-Received: by 2002:a65:448b:: with SMTP id l11mr640926pgq.74.1561593072454;
 Wed, 26 Jun 2019 16:51:12 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:50:26 -0700
In-Reply-To: <20190626235032.177551-1-emilyshaffer@google.com>
Message-Id: <20190626235032.177551-8-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190626235032.177551-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH v2 07/13] walken: filter for authors from gmail address
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to demonstrate how to create grep filters for revision walks,
filter the walk performed by cmd_walken() to print only commits which
are authored by someone with a gmail address.

This commit demonstrates how to append a grep pattern to a
rev_info.grep_filter, to teach new contributors how to create their own
more generalized grep filters during revision walks.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/walken.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/walken.c b/builtin/walken.c
index 335dcb6b21..da2d197914 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -11,6 +11,7 @@
 #include "parse-options.h"
 #include "pretty.h"
 #include "line-log.h"
+#include "grep.h"
 
 /*
  * All builtins are expected to provide a usage to provide a consistent user
@@ -28,10 +29,8 @@ const char * const walken_usage[] = {
  */
 static void init_walken_defaults(void)
 {
-	/*
-	 * We don't use any other components or have settings to initialize, so
-	 * leave this empty.
-	 */
+	/* Needed by our grep filter. */
+	init_grep_defaults(the_repository);
 }
 
 /*
@@ -60,6 +59,10 @@ static void final_rev_info_setup(int argc, const char **argv, const char *prefix
 	 * setup_revisions(argc, argv, rev, &opt);
 	 */
 
+	/* Add a grep pattern to the author line in the header. */
+	append_header_grep_pattern(&rev->grep_filter, GREP_HEADER_AUTHOR, "gmail");
+	compile_grep_patterns(&rev->grep_filter);
+
 	/* Let's force oneline format. */
 	get_commit_format("oneline", rev);
 	rev->verbose_header = 1;
@@ -86,10 +89,7 @@ static void final_rev_info_setup(int argc, const char **argv, const char *prefix
  */
 static int git_walken_config(const char *var, const char *value, void *cb)
 {
-	/*
-	 * For now, we don't have any custom configuration, so fall back on the
-	 * default config.
-	 */
+	grep_config(var, value, cb);
 	return git_default_config(var, value, cb);
 }
 
-- 
2.22.0.410.gd8fdbe21b5-goog

