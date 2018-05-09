Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A600D1F424
	for <e@80x24.org>; Wed,  9 May 2018 20:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965396AbeEIU4h (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 16:56:37 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43920 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935200AbeEIU4f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 16:56:35 -0400
Received: by mail-wr0-f195.google.com with SMTP id v15-v6so36813103wrm.10
        for <git@vger.kernel.org>; Wed, 09 May 2018 13:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JMfM7ja2BtnZ8wWJWCUGXhjRfMxEh1b5rIYBxKz+9B4=;
        b=qhrCmozgLkyju+OXe/ZK1w4ywgsKptTLW0hdIhcPDHDGDFws6e8fNg4+5C7okEbZmV
         xOxrg3Nn3cf52T/uZsMVNFDABGBYkAWVrBsAJNOzrJWGmuIyAiVt5YhUBgaY4MpBXLzf
         8E2TFvwPAyBFUe7q8JrVqt1TeUqZFa5SnslcAE2NB/ocen3HJqCQGgYGD7gpm1/AKORP
         CN+pBw0/45icqVSZbLM1ElQ9HuwXMlLJUNM6UWU4tJ97SpsqWsSU+kObKiqeAFPB4yik
         9l8ilUVf/PVd3gLQeUTcPHgoz24L5HUg+jkOcS8OUOEdJINUWSrHQR8JweBH0X6L8NNg
         zOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JMfM7ja2BtnZ8wWJWCUGXhjRfMxEh1b5rIYBxKz+9B4=;
        b=bY32nGMVGXVNzJzvp8g5CbN23S3K3cuGDqom+tkRGO56klT89416oC5IVxew3XPI08
         y82jR5QgKZ5+JoG7Ya4LV/KyJbZiPW25mSgPGvVZDuDetEJLqNj42sAgdhAa2T+o84yy
         epEicJT35vw2lv7fZLfomhyLfm9Fowuw4aOfLvXj/NA0haXAoClZRUoyrnunFQ6AJ43S
         YfI4WntzaVSDB394N9tnwadTeeB7Aw39delcqzj3PSp1ZKXuHqXDVL1NaOI3svIicDWB
         0Uuu/PijW3C6exuKozKQ/5Xk3Uw5RcSSoxzQ+H4YyeJAORSUVqUlP2UMZiODtZl74Xxy
         7vFw==
X-Gm-Message-State: ALQs6tB5sy3LPuW5v/xZ456hhdhdBYL9KKBfNHHbkevyiCe8ydaEJwYG
        AHJWqCXzrgFN5HMb9sfvhQ7xWehXbmc=
X-Google-Smtp-Source: AB8JxZpjnrzKphwyJFVP5P5nWSkgItG6IE4EsLmYh59nKv2NrMzSbKXi5/8KWrbwYiHRmmfZMVgmjg==
X-Received: by 2002:adf:c4a6:: with SMTP id m35-v6mr37700133wrf.103.1525899394129;
        Wed, 09 May 2018 13:56:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id r14-v6sm40073008wra.41.2018.05.09.13.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 May 2018 13:56:33 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        David Turner <novalis@novalis.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 3/5] refs.c: do not die if locking fails in `delete_pseudoref()`
Date:   Wed,  9 May 2018 22:55:37 +0200
Message-Id: <9446a4b48bab984c097dc391e4e3dc060a40415c.1525898125.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.411.g9fd64c8e46
In-Reply-To: <cover.1525898125.git.martin.agren@gmail.com>
References: <20180508182548.GD7210@sigill.intra.peff.net> <cover.1525898125.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After taking the lock we check whether we got it and die otherwise. But
since we take the lock using `LOCK_DIE_ON_ERROR`, we would already have
died.

Considering the choice between dropping the dead code and dropping the
flag, let's go for option number three: Drop the flag, write an error
instead of dying, then return -1. This function already returns -1 for
another error, so the caller (or rather, its callers) should be able to
handle this. There is some inconsistency around how we handle errors in
this function and elsewhere in this file, but let's take this small step
towards gentle error-reporting now and leave the rest for another time.

While at it, make the lock non-static and reduce its scope. (Placing
`struct lock_file`s on the stack used to be a bad idea, because the
temp- and lockfile-machinery would keep a pointer into the struct. But
after 076aa2cbd (tempfile: auto-allocate tempfiles on heap, 2017-09-05),
we can safely have lockfiles on the stack.)

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 refs.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 8c50b8b139..c006004bcd 100644
--- a/refs.c
+++ b/refs.c
@@ -689,20 +689,23 @@ static int write_pseudoref(const char *pseudoref, const struct object_id *oid,
 
 static int delete_pseudoref(const char *pseudoref, const struct object_id *old_oid)
 {
-	static struct lock_file lock;
 	const char *filename;
 
 	filename = git_path("%s", pseudoref);
 
 	if (old_oid && !is_null_oid(old_oid)) {
+		struct lock_file lock = LOCK_INIT;
 		int fd;
 		struct object_id actual_old_oid;
 
 		fd = hold_lock_file_for_update_timeout(
-				&lock, filename, LOCK_DIE_ON_ERROR,
+				&lock, filename, 0,
 				get_files_ref_lock_timeout_ms());
-		if (fd < 0)
-			die_errno(_("Could not open '%s' for writing"), filename);
+		if (fd < 0) {
+			error_errno(_("could not open '%s' for writing"),
+				    filename);
+			return -1;
+		}
 		if (read_ref(pseudoref, &actual_old_oid))
 			die("could not read ref '%s'", pseudoref);
 		if (oidcmp(&actual_old_oid, old_oid)) {
-- 
2.17.0.411.g9fd64c8e46

