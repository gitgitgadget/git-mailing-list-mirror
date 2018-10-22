Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12BDB1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 13:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbeJVVhR (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 17:37:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39890 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbeJVVhR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 17:37:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id g10-v6so5498528qtq.6
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 06:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RafJZrSVIwfb9lBFq8Y4u0oa5Ww9W19YFPsDy/lATdk=;
        b=NaGkFkD270hjyBqLE0EDVH/FdMGeh/HZWtbmNSWGmiuZNe6VdVYuSQHSniudbeIVbN
         bGV1Ty8O8AxPYp0PInyeaGQvLtaD+hzPIwfGN83SK8VTzkOVOMyBjUpc7gwIknpH/08u
         OD2wOEBrfOd6tOgX9MyM+41+0wjjgMSpiSYel0Zd2X00tFXABhVTgeQ8HSx+Fh4xAfBI
         vgakcBLCOH2eeMmOUakVbNgGMavEgg1HYbxND7QQQGaF+1AWDNl5KcF41EH0dDDY7tkD
         wSlhPy14jvF3REeTMfRJ3k9/9sgLdMq521oG4PvjGiN0aRcMz1KHlO9CTW3exSJcIbiV
         g/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RafJZrSVIwfb9lBFq8Y4u0oa5Ww9W19YFPsDy/lATdk=;
        b=qvSDXetLd8yaiRvX9kESkO0YnYu4vjyJLPvNxhR+M1nIWrteJsuIgzmIHRcnp5dCDZ
         JWILmJXl0fSOZ5KtKzcB/+kH94xaZ503hd8OGF2fgBjhZfL93d3pti00oEf32TTxROeP
         3PUDYt/raWAS1VDxRnLj9I28ZcJKw6AYv5Bpqzq87w/fiT3C26k9ukJwrmrWHR7Qzb3v
         A87h80WA2xykJWIgSzFik0cyZt4lpr7PpRqlZlgevZJbMgq7p4swxsq6fl/ch4DlV4gb
         GlDdpwTbNAZTzTK+vvDQpk+G7A7p6rX4iZBcabNIDE6XT30h86NrwbU79peMC0JwPksp
         4TLg==
X-Gm-Message-State: AGRZ1gLDlCGyUZ5UGTVAwSJg7bKoLVg+u8FkkgVRWaeX5ttW2QVLOxtf
        hC9syy+aDLX4cUJie3Ef/WVCy9rQgoI=
X-Google-Smtp-Source: AJdET5d2gmHrGQ8FHemN+jeV87eUe6JJ77s7kUoNiaJnnYMM41tRqRXvBCHRsQC4Bbspty83YPAxOw==
X-Received: by 2002:a0c:e606:: with SMTP id z6mr3082285qvm.51.1540214323032;
        Mon, 22 Oct 2018 06:18:43 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id n39-v6sm746052qtn.36.2018.10.22.06.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 06:18:42 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, peartben@gmail.com,
        peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v3 3/3] reset: warn when refresh_index() takes more than 2 seconds
Date:   Mon, 22 Oct 2018 09:18:28 -0400
Message-Id: <20181022131828.21348-4-peartben@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20181022131828.21348-1-peartben@gmail.com>
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181022131828.21348-1-peartben@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

refresh_index() is done after a reset command as an optimization.  Because
it can be an expensive call, warn the user if it takes more than 2 seconds
and tell them how to avoid it using the --quiet command line option or
reset.quiet config setting.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 builtin/reset.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 3b43aee544..d95a27d52e 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -25,6 +25,8 @@
 #include "submodule.h"
 #include "submodule-config.h"
 
+#define REFRESH_INDEX_DELAY_WARNING_IN_MS (2 * 1000)
+
 static const char * const git_reset_usage[] = {
 	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
 	N_("git reset [-q] [<tree-ish>] [--] <paths>..."),
@@ -376,9 +378,19 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			int flags = quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
 			if (read_from_tree(&pathspec, &oid, intent_to_add))
 				return 1;
-			if (!quiet && get_git_work_tree())
+			if (!quiet && get_git_work_tree()) {
+				uint64_t t_begin, t_delta_in_ms;
+
+				t_begin = getnanotime();
 				refresh_index(&the_index, flags, NULL, NULL,
 					      _("Unstaged changes after reset:"));
+				t_delta_in_ms = (getnanotime() - t_begin) / 1000000;
+				if (t_delta_in_ms > REFRESH_INDEX_DELAY_WARNING_IN_MS) {
+					printf(_("\nIt took %.2f seconds to enumerate unstaged changes after reset.  You can\n"
+						"use '--quiet' to avoid this.  Set the config setting reset.quiet to true\n"
+						"to make this the default."), t_delta_in_ms / 1000.0);
+				}
+			}
 		} else {
 			int err = reset_index(&oid, reset_type, quiet);
 			if (reset_type == KEEP && !err)
-- 
2.18.0.windows.1

