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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F318DC352A1
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 09:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9A3217BA
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 09:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuliMiju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgBHJIk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Feb 2020 04:08:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54771 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbgBHJIi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Feb 2020 04:08:38 -0500
Received: by mail-wm1-f67.google.com with SMTP id g1so4824970wmh.4
        for <git@vger.kernel.org>; Sat, 08 Feb 2020 01:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BZA+MS84eFTTHIZpvKxlzTaC/Nse0E6Ugur+gY3o55U=;
        b=WuliMijugBPWLQzMe+JAsPUFRepjTN10gfN+clj9oggF/v+9AtQCuM+GDzBuErg+lZ
         entXEAw4dN1cHlYN0usWCtv45mMPzCWi7sjJApVH0C96YwlX1U2SfZCz1u+KHD2Gwr8O
         U2dg03zlJXBE8C64+0m+ot/g0tCq8RqGYtrc1QX4GwFM9Ajtm7qHaBu2xqM+iKUVaqie
         gmcmKhEbwXWiyTuT4gIlaWZQhbQIGDVT7EL2bX7ESiGHDYka/lGAqnoI92wZCc3Q8BOU
         tIdOqSgzmspkgo7Ia33UExmoFOqHuqLauj98s/4d0+suSnkFxULMndtl8+ErVokSb0ky
         /5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BZA+MS84eFTTHIZpvKxlzTaC/Nse0E6Ugur+gY3o55U=;
        b=qUt4h1sEaWguboWYqXyC45UYwNwaNsLb3Y6dtFGIHdA3XvXcFP4alD2bPTZ1AlxvM1
         QnKkyiWCe035RiR6ywwG/f22J96LV7CO+UdyOMjwBXTJYx1tD4uTYu4qCVTVdAdYTNno
         wObK/rIr9P8yJBZLIZTuGkgwW5NafxUrdGhHIuGYUDNNaIQ5MrQnBpC9SWq+ATf4Fj8F
         5OBTZf1CjaaboSENGqMVV9CehQ7+v5dbLqgLjVKNbg71e/hQA1fEfcd5iVrl7tG/hj6b
         TEDnVfke/KDXzD1AF+BqLqfiA0N9cmRxm0nVHCndSXYGau6B3GoQ4QVCxMyZe1GamKzQ
         7pXA==
X-Gm-Message-State: APjAAAV9Yq0sgSt/c0CsH9LAl/Ss8pvjSlQ4qTE8wQptnOQ/ptya2F7U
        R0n7trYGWiBQLb2Rw0Y6uyMwZ0bo
X-Google-Smtp-Source: APXvYqzJV2wjHBcfsDGod3Z9vPjULIoFvB/gpJlxvTxHxcE27EPn9cjFEeoidOdOHYcFK6Ae0Ohxgw==
X-Received: by 2002:a1c:8151:: with SMTP id c78mr1681184wmd.29.1581152914682;
        Sat, 08 Feb 2020 01:08:34 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id e1sm6999346wrt.84.2020.02.08.01.08.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Feb 2020 01:08:34 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 09/13] bisect: libify `bisect_checkout`
Date:   Sat,  8 Feb 2020 10:07:00 +0100
Message-Id: <20200208090704.26506-10-mirucam@gmail.com>
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

Turn `exit()` to `return` calls in `bisect_checkout()`.
Changes related to return values have no bad side effects on the
code that calls `bisect_checkout()`.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 bisect.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/bisect.c b/bisect.c
index 85bda3500b..f6582ddfed 100644
--- a/bisect.c
+++ b/bisect.c
@@ -704,9 +704,10 @@ static int is_expected_rev(const struct object_id *oid)
 	return res;
 }
 
-static int bisect_checkout(const struct object_id *bisect_rev, int no_checkout)
+static enum bisect_error bisect_checkout(const struct object_id *bisect_rev, int no_checkout)
 {
 	char bisect_rev_hex[GIT_MAX_HEXSZ + 1];
+	enum bisect_error res = BISECT_OK;
 
 	memcpy(bisect_rev_hex, oid_to_hex(bisect_rev), the_hash_algo->hexsz + 1);
 	update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
@@ -716,14 +717,24 @@ static int bisect_checkout(const struct object_id *bisect_rev, int no_checkout)
 		update_ref(NULL, "BISECT_HEAD", bisect_rev, NULL, 0,
 			   UPDATE_REFS_DIE_ON_ERR);
 	} else {
-		int res;
 		res = run_command_v_opt(argv_checkout, RUN_GIT_CMD);
 		if (res)
-			exit(res);
+			/*
+			 * Errors in `run_command()` itself, signaled by res < 0,
+			 * and errors in the child process, signaled by res > 0
+			 * can both be treated as regular BISECT_FAILURE (-1).
+			 */
+			return -abs(res);
 	}
 
 	argv_show_branch[1] = bisect_rev_hex;
-	return run_command_v_opt(argv_show_branch, RUN_GIT_CMD);
+	res = run_command_v_opt(argv_show_branch, RUN_GIT_CMD);
+	/*
+	 * Errors in `run_command()` itself, signaled by res < 0,
+	 * and errors in the child process, signaled by res > 0
+	 * can both be treated as regular BISECT_FAILURE (-1).
+	 */
+	return -abs(res);
 }
 
 static struct commit *get_commit_reference(struct repository *r,
-- 
2.25.0

