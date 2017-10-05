Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 173DF20370
	for <e@80x24.org>; Thu,  5 Oct 2017 20:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbdJEUch (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 16:32:37 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:57285 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbdJEUcg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 16:32:36 -0400
Received: by mail-wm0-f65.google.com with SMTP id l68so4384156wmd.5
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 13:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5AhEvcPCGWwYGRliq2j1LgGaI2lKiWdEsL9Ga/A3LR4=;
        b=Obb4u0rLot1JFXuI2H+e3GyaHfooe1hccg8qIgSNlpqOVSWEITKrjkIJ9IT8+rUPDw
         UNIjnrJS1voDy1l1hNSxMTx9Vt0YSaRa+h1PuUr1U2oOs0S8fzzPf493+KnKq+PyUdYu
         H3aoxo7zPdwcq6fBtS3ZG8ETV0dmpvPH7hoztIS4TiJkah8Gm/gDRKVd2F0sJ8m8oF6Y
         tXpcpKFwG27+2BFW2//VEjP1FFNWpDZVGJ/+WB5qmtgi6trtHotv6upl4wOwtuT9Yl2p
         vU7+iEPsAICIyla6eESwBqteiBJHBsgp5U0BzhiRXLvTpDYoxdvmFgzmatJx0KTHYYKg
         HCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5AhEvcPCGWwYGRliq2j1LgGaI2lKiWdEsL9Ga/A3LR4=;
        b=pTLkI7R2ymEv6/ipT8s6wpx++yk+X5CQVc1azQXJPBylW+LMp6UwhDzV4wtSIpCzaD
         KsqNozi1LA9lblO1JeMgXYFYEFfc76wO+Udtoo4Aq8vk0SCAC6ASmZeoGCYC9mo00qgO
         YZ4kzfyF2MW8tMcufc3EQY14fjhNnhMkBkdN55kfW1PcrCE+mMlH3tY06Gooho8mIvoT
         YG9BN7zsohf/KxwPPY6mChmYK86eI922OXhIj8WDJ6Fevx2RSPw++gRK3h7QNVNsydUy
         sM4Bar27BUDAAzzdaJepTqhEuT663Yp3WorcMs0B/NPIzNooqJhURd1O+csUcy60rRQX
         PMeQ==
X-Gm-Message-State: AMCzsaVz2nMedcp4B9MtrhWv672EjDJY4pXIrIm09CF3N3G20w/gt8oD
        hXrn0qJyFZ1UkGAroPsAMnOXIRin
X-Google-Smtp-Source: AOwi7QC6Hx5VUBMVfWoWzxKR0+sKg407Yb/kQgG8WN5XmtY7bTdlts8IlqeyHwSWexu7ECIEzd4AQw==
X-Received: by 10.28.139.72 with SMTP id n69mr281027wmd.29.1507235554537;
        Thu, 05 Oct 2017 13:32:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id i76sm698424wmd.2.2017.10.05.13.32.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Oct 2017 13:32:33 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/12] sha1_file: do not leak `lock_file`
Date:   Thu,  5 Oct 2017 22:32:03 +0200
Message-Id: <7f9a7a5d57bf76925e14111efdabe77f1c946e8d.1507228170.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.2.666.gea220ee40
In-Reply-To: <cover.1507228170.git.martin.agren@gmail.com>
References: <xmqqy3osiwe6.fsf@gitster.mtv.corp.google.com> <cover.1507228170.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no longer any need to allocate and leak a `struct lock_file`.
Initialize it on the stack instead.

Before this patch, we set `lock = NULL` to signal that we have already
rolled back, and that we should not do any more work. We need to take
another approach now that we cannot assign NULL. We could, e.g., use
`is_lock_file_locked()`. But we already have another variable that we
could use instead, `found`. Its scope is only too small.

Bump `found` to the scope of the whole function and rearrange the "roll
back or write?"-checks to a straightforward if-else on `found`. This
also future-proves the code by making it obvious that we intend to take
exactly one of these paths.

Improved-by: Jeff King <peff@peff.net>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
v2: Moved the rollback to the end to have an obvious if-else instead of
retaining the original logic. Thanks Peff.

 sha1_file.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 5a2014811..1d1747099 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -456,19 +456,19 @@ struct alternate_object_database *alloc_alt_odb(const char *dir)
 
 void add_to_alternates_file(const char *reference)
 {
-	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
+	struct lock_file lock = LOCK_INIT;
 	char *alts = git_pathdup("objects/info/alternates");
 	FILE *in, *out;
+	int found = 0;
 
-	hold_lock_file_for_update(lock, alts, LOCK_DIE_ON_ERROR);
-	out = fdopen_lock_file(lock, "w");
+	hold_lock_file_for_update(&lock, alts, LOCK_DIE_ON_ERROR);
+	out = fdopen_lock_file(&lock, "w");
 	if (!out)
 		die_errno("unable to fdopen alternates lockfile");
 
 	in = fopen(alts, "r");
 	if (in) {
 		struct strbuf line = STRBUF_INIT;
-		int found = 0;
 
 		while (strbuf_getline(&line, in) != EOF) {
 			if (!strcmp(reference, line.buf)) {
@@ -480,18 +480,15 @@ void add_to_alternates_file(const char *reference)
 
 		strbuf_release(&line);
 		fclose(in);
-
-		if (found) {
-			rollback_lock_file(lock);
-			lock = NULL;
-		}
 	}
 	else if (errno != ENOENT)
 		die_errno("unable to read alternates file");
 
-	if (lock) {
+	if (found) {
+		rollback_lock_file(&lock);
+	} else {
 		fprintf_or_die(out, "%s\n", reference);
-		if (commit_lock_file(lock))
+		if (commit_lock_file(&lock))
 			die_errno("unable to move new alternates file into place");
 		if (alt_odb_tail)
 			link_alt_odb_entries(reference, '\n', NULL, 0);
-- 
2.14.2.666.gea220ee40

