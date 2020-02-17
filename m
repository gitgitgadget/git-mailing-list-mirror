Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C52C7619F
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 08:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297872064C
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 08:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4JRo2o7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgBQIlg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:41:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37565 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgBQIld (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 03:41:33 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so18555759wru.4
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 00:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ms8Nz34/TOFMi7UfzRyUn5hd7ezZ67aEMzjAIUfVNsE=;
        b=A4JRo2o7deTQrlKVMEkzYG3ANF7OlFDRkeg3wzxpvU2z273V4jDzrW7G77CTd4jnWK
         VixN14C3hXSvDz5fIhPQuGBLMsRXIlSAKPez5P+e1ccoBGm/5paUPQrODViThftfFvLX
         OZqVpYLoh3n1uwZrJ0ZeJhNN3R1JfdLtjdYqa8Gh+4EG3IEti/+QVaCxMYV+g4aQOjg9
         TeZgXAwJlE55rzB7LUrK6X2TlJ9GF+TMl6tXfsfcfM5Go3ilgwfn+JZdOmWO9f5gPwz2
         Wm5BHc8Wpltd/9WsKqebpxCA667+5eIVWJuUsEkeUaMqtOVfplVJ9IIfeZpqp3ZkEXL2
         W3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ms8Nz34/TOFMi7UfzRyUn5hd7ezZ67aEMzjAIUfVNsE=;
        b=k0l9lyhyg2U68BEMC7zX3fquGqg041lE5nVtJTv9KjW9VHm4hCN0hyfod+R4HtQb8t
         Q24pZMHfTO4NKiK0ze6TshtzBOqceHO23gEz02nzsOwUXcbxUrYK05hv1RCnewSX063O
         7Xqj9Iw0M9kN3VYM4uG0Eucg8Hz+frWhixs5WyLLgaHgSyw9Qc96cRPR71Un4ySLrm+o
         5f1rTMar2WGBSPVLwI6FIg7hGIY5j6XDkXMuexMD1OoGb6v+Lzicr1dGb0rUIJtCVmWZ
         2/uDXkakdMdixTo62zKhBbczzxWchh9/1vNAVKJ4E9TvuC7sagsBSP5L/FRAnLPgKfi3
         3cbg==
X-Gm-Message-State: APjAAAV7fEOP2IUXPrFbCzsq2Y03T51lOFRPkfKi8uPmMsTdhtLa3Pmm
        1eh1HV3UJXF40NtqiDmOs1RhgV2U
X-Google-Smtp-Source: APXvYqzXJY7zpbXJoCXts+E+YB8F0uCR4jLKkAKh7SBqLK/ZpkE/WYJzZf39ohHY5c6ZB7E6JJyRmw==
X-Received: by 2002:a5d:4d8d:: with SMTP id b13mr20901513wru.6.1581928891957;
        Mon, 17 Feb 2020 00:41:31 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id s22sm19187149wmh.4.2020.02.17.00.41.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2020 00:41:31 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v4 11/12] bisect: libify `handle_bad_merge_base` and its dependents
Date:   Mon, 17 Feb 2020 09:40:38 +0100
Message-Id: <20200217084039.78215-12-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217084039.78215-1-mirucam@gmail.com>
References: <20200217084039.78215-1-mirucam@gmail.com>
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

