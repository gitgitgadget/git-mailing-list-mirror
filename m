Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E20720985
	for <e@80x24.org>; Sun, 11 Sep 2016 05:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755578AbcIKFm5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 01:42:57 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36706 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755440AbcIKFmk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 01:42:40 -0400
Received: by mail-pa0-f65.google.com with SMTP id ez1so6009129pab.3
        for <git@vger.kernel.org>; Sat, 10 Sep 2016 22:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9zdBYwLWxdM+8g5lrt1i185TJJLefypIrgR2YzU/v4M=;
        b=bTp611CGx+I2tQwKSxod6NynOgiZ2nf+yQiMvnxcJZPdXEehmdbgYplw8DcKHLBjU4
         UnYHtyjZG3QeqQhabxmT4qrOEr5vO2hxTc/6QSfdTwyXDyJPxYrP4TU6pX6H4U0HetMJ
         U1L5Llq8h4R0k0/7grqAZHVVdCoL5IgHsNsQzGhRM+H1TyLZMDaFA9oQjemzxoOUlHB6
         FTaIHQHh5R6RKm3tLxUqRNg17Yhay7eYuiC3GQBJn5Qj0YMofHHWa/7fN0eBoPS5xVnS
         ssiyS8YQuaxcLzwOk9TC2gGjqnDiBUePiCR/Dug2wbiVIDqM/VKg29ckFUoQ9BPfItww
         WIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9zdBYwLWxdM+8g5lrt1i185TJJLefypIrgR2YzU/v4M=;
        b=ei7CbL6xWSHN0jiNT4euKDNjLPPGZH6MHKIWgWvQkkHmQcYH2x9YlT7oF27llhM2fH
         ocifhPKwjt5B1rUC+TpiEoPXGTON4V9Et8cAo+kFstr8a8emXJqlRPbXvNlYZQSv67Uw
         O8yk+PhCV4V3Q0rJEEVf8fMsmxSxSN5Pi0QSJFIYKADV6X6LXsVDhhx6HHOTbzVvzsGM
         oPVHtrZgZ5itxX5FsWvoc3TDqXzIbOgFuiUDNXPxWB5EMJUO4ib4SVMWBJsgWa5JBK8j
         iwrBkAUV3VOJU2dmz7g4WlfT2wYrjyjc7T174jVA6eBExk1GFkf6YT3pGP7STorME9a6
         CaEA==
X-Gm-Message-State: AE9vXwMtt81beUcSKncUmngsNbN9pafQdBjtABYKTXree6N4WP8fcC4ng5sRuojzQverdA==
X-Received: by 10.66.192.102 with SMTP id hf6mr21610823pac.102.1473572559609;
        Sat, 10 Sep 2016 22:42:39 -0700 (PDT)
Received: from localhost (c-67-188-214-183.hsd1.ca.comcast.net. [67.188.214.183])
        by smtp.gmail.com with ESMTPSA id m5sm15493182paw.40.2016.09.10.22.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Sep 2016 22:42:38 -0700 (PDT)
From:   Stefan Beller <stefanbeller@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 06/10] diff.c: emit_line_0 can handle no color
Date:   Sat, 10 Sep 2016 22:42:06 -0700
Message-Id: <1473572530-25764-7-git-send-email-stefanbeller@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
References: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

---
 diff.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 87b1bb2..2aefd0f 100644
--- a/diff.c
+++ b/diff.c
@@ -473,11 +473,13 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
 	}
 
 	if (len || !nofirst) {
-		fputs(set, file);
+		if (set)
+			fputs(set, file);
 		if (!nofirst)
 			fputc(first, file);
 		fwrite(line, len, 1, file);
-		fputs(reset, file);
+		if (reset)
+			fputs(reset, file);
 	}
 	if (has_trailing_carriage_return)
 		fputc('\r', file);
-- 
2.7.4

