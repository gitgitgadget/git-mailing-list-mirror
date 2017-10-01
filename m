Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 747C320A10
	for <e@80x24.org>; Sun,  1 Oct 2017 14:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751125AbdJAO4d (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 10:56:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55427 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbdJAO4c (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 10:56:32 -0400
Received: by mail-wm0-f67.google.com with SMTP id u138so6342203wmu.4
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 07:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jMfARSDcgxaPLGiSDs8KjbnH0y3DDFhS5cH9V02UlLg=;
        b=h8yPdpWeZCZsyJmSCAEYhSUvJTTf0Upr3wcCMLQ/IJsjcW6j2m7ckdCBJ2verfz5cG
         Ym+VtRUbbqMs+u77Fs+k9eokJv4rv17xp5jSCwe/ZX14zFJG03nNbkxJNceT0L4fFJeq
         +rbaRfbXeRGgrqPQJRHYFHxYpWRORCU0B0rHfn2EFSvZ+CeFQJi3lOOit0RSMKdwJplx
         oeH4IGxuSGAtAtbtB5wrlrDxJfv+Q7Ad8b7nu1pUmEfSW2L3eHG5jEk2qQikY5aAuRCd
         DPkrs6NftJLd+mth03qCR315rSmrhN+eOpSu13emOqRPrGx3CkVqlj86MxndAQCjwVeC
         +7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jMfARSDcgxaPLGiSDs8KjbnH0y3DDFhS5cH9V02UlLg=;
        b=WvbK0YIvT3T14L4nAt7lcd7me9UuftRESDtYKnlj9px37UCZJwqAYY7gyb3VoMqgfk
         gCOb7xxpj5Jiv0zCnEtPLvRjh++0e1ledhvo+8psU12ATF/9KZm8xWqEmJw3ZHibUVZP
         7rxAYMSyh7rR7etuBLORbcdylmj8sf2ulTj8ZWCJqNxJTIQ+O61+6WNnHPiggCUgO+gS
         QVRqUqozbJqZrsItFdcI1prC1LnJ7/pMDgRLqvlBW0icvd6kXWPRuMapWJcAMj7aINdo
         WyDytZi71f9d9EtFt87/khKi9TpodXhCQeryUdujZPeTdS8hMHgD/SHqHzbFuMkOjtm8
         4bXg==
X-Gm-Message-State: AHPjjUgQ3nXrh/vdGai6K9+9+EAsVsjnGuOrZEmEKhyHXcMWCAuPkM59
        ZXAK9BH0II73u5jsp0sZu+cEYg==
X-Google-Smtp-Source: AOwi7QAGHo4L5sKReiCSsnx3uPmNccWSlW9sYjkLqumJ9q7kJQaCC5IPFqsc1box/uCRLHA2Ye3CJQ==
X-Received: by 10.28.55.209 with SMTP id e200mr8373656wma.72.1506869791491;
        Sun, 01 Oct 2017 07:56:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id w82sm10473516wme.5.2017.10.01.07.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Oct 2017 07:56:30 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 01/11] sha1_file: do not leak `lock_file`
Date:   Sun,  1 Oct 2017 16:56:02 +0200
Message-Id: <9725917d9854a54e4daeda70940c3bb0ff5d9201.1506862824.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.727.g9ddaf86
In-Reply-To: <cover.1506862824.git.martin.agren@gmail.com>
References: <cover.1506862824.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no longer any need to allocate and leak a `struct lock_file`.
Initialize it on the stack instead.

Instead of setting `lock = NULL` to signal that we have already rolled
back, and that we should not do any more work, check with
`is_lock_file_locked()`. Since we take the lock with
`LOCK_DIE_ON_ERROR`, it evaluates to false exactly when we have called
`rollback_lock_file()`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 sha1_file.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 5a2014811..c50d6237e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -456,12 +456,12 @@ struct alternate_object_database *alloc_alt_odb(const char *dir)
 
 void add_to_alternates_file(const char *reference)
 {
-	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
+	struct lock_file lock = LOCK_INIT;
 	char *alts = git_pathdup("objects/info/alternates");
 	FILE *in, *out;
 
-	hold_lock_file_for_update(lock, alts, LOCK_DIE_ON_ERROR);
-	out = fdopen_lock_file(lock, "w");
+	hold_lock_file_for_update(&lock, alts, LOCK_DIE_ON_ERROR);
+	out = fdopen_lock_file(&lock, "w");
 	if (!out)
 		die_errno("unable to fdopen alternates lockfile");
 
@@ -481,17 +481,15 @@ void add_to_alternates_file(const char *reference)
 		strbuf_release(&line);
 		fclose(in);
 
-		if (found) {
-			rollback_lock_file(lock);
-			lock = NULL;
-		}
+		if (found)
+			rollback_lock_file(&lock);
 	}
 	else if (errno != ENOENT)
 		die_errno("unable to read alternates file");
 
-	if (lock) {
+	if (is_lock_file_locked(&lock)) {
 		fprintf_or_die(out, "%s\n", reference);
-		if (commit_lock_file(lock))
+		if (commit_lock_file(&lock))
 			die_errno("unable to move new alternates file into place");
 		if (alt_odb_tail)
 			link_alt_odb_entries(reference, '\n', NULL, 0);
-- 
2.14.1.727.g9ddaf86

