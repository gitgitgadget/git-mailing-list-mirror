Return-Path: <SRS0=24Vd=34=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C541FC35250
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 09:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F57222314
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 09:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaqGCqtQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbgBHJIm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Feb 2020 04:08:42 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34207 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbgBHJIk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Feb 2020 04:08:40 -0500
Received: by mail-wm1-f68.google.com with SMTP id s144so4715771wme.1
        for <git@vger.kernel.org>; Sat, 08 Feb 2020 01:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ms8Nz34/TOFMi7UfzRyUn5hd7ezZ67aEMzjAIUfVNsE=;
        b=gaqGCqtQewHMKxq7JvxGf4etm1Ri+bYICtpzQToVS3H5kFNpTUdM2Dnh0dw5emhglQ
         +S0eJrtGBpI2Hneal+40ycTgKSLJw0V63esJErh5QCiEZcKTAYMiUQ9pa28BXkTv4swp
         berwtOqcIMxvN1ZB0ZcpOVPv82OKxIu4a+tLJKB4OWAVWd9q8Rd6QzZCatEIx7cbUhDK
         X2MEp2WO2AvE80i0R2uay3lN/DffyGeHU7SO/hutmzNWpx2x92xDw7SlXGhvj4b41akU
         ay0XiGzb+oYNPOQ96md8NpK6KrZ5z5LhOnh+aCkd592vF/jZMyTbMNh6m+llIDqa/L8E
         iJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ms8Nz34/TOFMi7UfzRyUn5hd7ezZ67aEMzjAIUfVNsE=;
        b=p//H6c4sO+767FDLxBtRrpq76JkwYqTN/oUd6FZBCpMSZ/oKa9ugR1frZBMz2u7jff
         /AqLu9uy8mhw0F/prFY3bzLj8w1OGXtYU1xwfpxuQZvTIck056b/z10sJVZiBqCsDCx5
         BCLtum8BPu+E3sBCfZkHC00WnJOrG10bRU009PXjAivrFnLyiJu6WXhyknyTn+qhhGDs
         HgIHZo20+JmKtvWB9m3t06bQKqYlY9uvFJMi/SKGwn9J/PlVmQM5j66ryllPgpVswEb9
         pOmB7YvBULG6dJrLRW4nggqKn8tBgjx7wjTUHNaN1B8DSQX3dguje9yzdl0+XUGGzAa5
         3kcw==
X-Gm-Message-State: APjAAAVeydmlVaze4yE+50ryLu8kBQzHYA0Iy7WpSTCkmFxgy6qorLuM
        b7Qw1kwXNy5+R6Q0REc1cDAK4LKN
X-Google-Smtp-Source: APXvYqyrkjdlewSXoYPJEzWH7JeGVePsFiHr2iBzroHFor50gDWp385vNFIFC6L/ug16hpXxeFhucw==
X-Received: by 2002:a05:600c:2109:: with SMTP id u9mr3608906wml.183.1581152918433;
        Sat, 08 Feb 2020 01:08:38 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id e1sm6999346wrt.84.2020.02.08.01.08.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Feb 2020 01:08:38 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 12/13] bisect: libify `handle_bad_merge_base` and its dependents
Date:   Sat,  8 Feb 2020 10:07:03 +0100
Message-Id: <20200208090704.26506-13-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200208090704.26506-1-mirucam@gmail.com>
References: <20200208090704.26506-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Since we want to get rid of git-bisect.sh, it would be necessary to
convert those exit() calls to return statements so that errors can be
reported.

Emulate try catch in C by converting `exit(<positive-value>)` to
`return <negative-value>`. Follow POSIX conventions to return
<negative-value> to indicate error.

Update all callers to handle the error returns.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 bisect.c | 9 +++++----
 bisect.h | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/bisect.c b/bisect.c
index f5ce3a4b70..837332a428 100644
--- a/bisect.c
+++ b/bisect.c
@@ -761,7 +761,7 @@ static struct commit **get_bad_and_good_commits(struct repository *r,
 	return rev;
 }
 
-static void handle_bad_merge_base(void)
+static enum bisect_error handle_bad_merge_base(void)
 {
 	if (is_expected_rev(current_bad_oid)) {
 		char *bad_hex = oid_to_hex(current_bad_oid);
@@ -782,14 +782,14 @@ static void handle_bad_merge_base(void)
 				"between %s and [%s].\n"),
 				bad_hex, term_bad, term_good, bad_hex, good_hex);
 		}
-		exit(3);
+		return BISECT_MERGE_BASE_CHECK;
 	}
 
 	fprintf(stderr, _("Some %s revs are not ancestors of the %s rev.\n"
 		"git bisect cannot work properly in this case.\n"
 		"Maybe you mistook %s and %s revs?\n"),
 		term_good, term_bad, term_good, term_bad);
-	exit(1);
+	return BISECT_FAILED;
 }
 
 static void handle_skipped_merge_base(const struct object_id *mb)
@@ -830,7 +830,8 @@ static enum bisect_error check_merge_bases(int rev_nr, struct commit **rev, int
 	for (; result; result = result->next) {
 		const struct object_id *mb = &result->item->object.oid;
 		if (oideq(mb, current_bad_oid)) {
-			handle_bad_merge_base();
+			res = handle_bad_merge_base();
+			break;
 		} else if (0 <= oid_array_lookup(&good_revs, mb)) {
 			continue;
 		} else if (0 <= oid_array_lookup(&skipped_revs, mb)) {
diff --git a/bisect.h b/bisect.h
index f68ae85376..0d9758179f 100644
--- a/bisect.h
+++ b/bisect.h
@@ -48,6 +48,7 @@ enum bisect_error {
 	BISECT_OK = 0,
 	BISECT_FAILED = -1,
 	BISECT_ONLY_SKIPPED_LEFT = -2,
+	BISECT_MERGE_BASE_CHECK = -3,
 	BISECT_INTERNAL_SUCCESS_MERGE_BASE = -11
 };
 
-- 
2.25.0

