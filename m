Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 097DB2013A
	for <e@80x24.org>; Thu, 16 Feb 2017 00:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756255AbdBPAjG (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 19:39:06 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33885 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753414AbdBPAio (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 19:38:44 -0500
Received: by mail-pf0-f174.google.com with SMTP id e4so799442pfg.1
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 16:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YrCXjrnucRA81cVMa9rKdqg5Z0Y9BLznYauRFwaszBA=;
        b=YcXVelu14UKEIqRQ/5n8lPVpSli+XZ4+xAl+BwyR2do7l8hD/dr49iCh/nQfI9QwfM
         3FOKsHoB30Sp6rGzRgfOpR3anGNkxvYEirJaSCRbg2D5q1PPrAG98cJxGZ/x7I/FaK7h
         MvFHn1hzaWnunw+YfvR2s79pShIAvy/SL8Ql2Jin5YbSdBmgeBkSngi0/gK5EMXDSr3T
         VkYZAJj3NjHseqFr32/42XkCZ8bUVWrSdrP34boipquHV+0pnsudYd8aNkRmswU6hsK5
         QfalGUya29YXHoXNnrIZUgc2qkL0NUR0T/wH/C64DspTxdTtW3lcuLgHQYXOuu+V7BKr
         AI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YrCXjrnucRA81cVMa9rKdqg5Z0Y9BLznYauRFwaszBA=;
        b=txSToBDLOnz/kx2tUlpHTdP5mCJA7PBRisGkvS4aYIhgpFxQLz0Lc5B/Xvr3by2W4y
         7SYhxOdfOGIiVE+WPFU3dXZP9QA1ErXQ2FJf6KwlqjZ+WN5BTa7ScbdYInVOA/tZH2bA
         A7q0a/n66m02sMi5Prnv0S6rdlO3aN7u2T5rv70b71v1DmvO8jNo7X+D9ffoKsQKhVgH
         ZVtvAHbu9hlAUsBn1QVAYHG8nd2Xpyw8lGJ0mq7Mp6DHevUSG4EDTedVrmd0vLheSfgx
         /eCKXKrxPcLU1K/zeP37qs92DDNhKL15PqClfsiZ2VEkIoq6O2NUBuyWyr6/qgFR1J+z
         2V/w==
X-Gm-Message-State: AMke39ngmzWYyJ9vGtXbr9UYkEYWSTcdv08FVLijR5WUaOhZxN5Ke+wU9xHFfpShSwLKRDkV
X-Received: by 10.99.141.195 with SMTP id z186mr327238pgd.141.1487205513594;
        Wed, 15 Feb 2017 16:38:33 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2ca1:506:4965:89ed])
        by smtp.gmail.com with ESMTPSA id i21sm9509665pfi.94.2017.02.15.16.38.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 16:38:33 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 11/15] unpack-trees: pass old oid to verify_clean_submodule
Date:   Wed, 15 Feb 2017 16:38:07 -0800
Message-Id: <20170216003811.18273-12-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
In-Reply-To: <20170216003811.18273-1-sbeller@google.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com>
 <20170216003811.18273-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The check (which uses the old oid) is yet to be implemented, but this part
is just a refactor, so it can go separately first.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 unpack-trees.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 3a8ee19fe8..616a0ae4b2 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1407,7 +1407,8 @@ static void invalidate_ce_path(const struct cache_entry *ce,
  * Currently, git does not checkout subprojects during a superproject
  * checkout, so it is not going to overwrite anything.
  */
-static int verify_clean_submodule(const struct cache_entry *ce,
+static int verify_clean_submodule(const char *old_sha1,
+				  const struct cache_entry *ce,
 				  enum unpack_trees_error_types error_type,
 				  struct unpack_trees_options *o)
 {
@@ -1427,16 +1428,18 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	struct dir_struct d;
 	char *pathbuf;
 	int cnt = 0;
-	unsigned char sha1[20];
 
-	if (S_ISGITLINK(ce->ce_mode) &&
-	    resolve_gitlink_ref(ce->name, "HEAD", sha1) == 0) {
-		/* If we are not going to update the submodule, then
+	if (S_ISGITLINK(ce->ce_mode)) {
+		unsigned char sha1[20];
+		int sub_head = resolve_gitlink_ref(ce->name, "HEAD", sha1);
+		/*
+		 * If we are not going to update the submodule, then
 		 * we don't care.
 		 */
-		if (!hashcmp(sha1, ce->oid.hash))
+		if (!sub_head && !hashcmp(sha1, ce->oid.hash))
 			return 0;
-		return verify_clean_submodule(ce, error_type, o);
+		return verify_clean_submodule(sub_head ? NULL : sha1_to_hex(sha1),
+					      ce, error_type, o);
 	}
 
 	/*
-- 
2.12.0.rc1.16.ge4278d41a0.dirty

