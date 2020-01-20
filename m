Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FABC33CA1
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5CB217F4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuGxWyRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgATOik (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:38:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37468 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgATOie (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:38:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so29887096wru.4
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZIkzFJFrWjAGcsgOxUxMnP7DxuoQar/odsNZaPNu02g=;
        b=RuGxWyRiW1imp8n1nCTKkmsP2OsnoNTJfLjkvkqQYzZQ3O1H2fOv+gGdNZ5+Z3sqz8
         W6SJdCpoua7bzSYjYmilXWO2EQIfz4UXrKkpxCaR/mVZ9O28VZ4mIF1vlzyZ1rf6Dbf8
         6z70E1YRahZrTPLSJ3TuDRPMJA3B+U9eCJ1LO8goQczoukgif9+UWb6Ua2L/w5W+TLly
         guEMgvFduSeqnyc4DYpC9vEEY4H6qIEAg0DF7YEx8sr98lZQDLnt34ESHzvLzHJDqCAg
         BMBWp33/kHfTmIrxVqPyHV/K7hjj2mXlQnEGFpZiFSpxUGonh9zWQO4N0dTH0lFE1IPV
         +RZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZIkzFJFrWjAGcsgOxUxMnP7DxuoQar/odsNZaPNu02g=;
        b=LWmJpgWn1Ud5x04C2Ksd01HN4XF2HARp+0mSR2pWpvLQzCwAvBPe6EQTYj+u79NYF5
         iFfoLNSkpSW3NXA7YExBaKGsGHd7VZHJ1Bn27vKwK5RPLFClmYD22daV7FdC/ex59QYH
         A1q23NImfWg5/sqmJsE3W3U3qj6j5CsNx+yWv7+2+sE7DdYf7R+A25UY2/0vJ70S9Mwg
         S950SPgmegmq+4l69rmP5PZJB3T3ytKs3b7dTgXAwu7xZJdaRE2zWqjkdtc1MmkEYl6m
         CnesZgESimIzkVygibTbahxU1x7hBqAjw9O9Y04YcI19ZqpUyHCzdFoqMc71Zs0R9RKM
         gB2g==
X-Gm-Message-State: APjAAAU9D8XVVvsxwvDC+Y0LCb5UYAWe0pmL6jGp/Q81cuTE0YPgn4gw
        6WRAkTIULTOlLe85D2fhid/jL9nEMls=
X-Google-Smtp-Source: APXvYqwJvBnc5FUT1q2TYPg0h+ik8btiyxAWrYFDkxqmtsgjQj3L/axm8JwqhkriWqqu6ynr0+hRyA==
X-Received: by 2002:a5d:55d1:: with SMTP id i17mr18589592wrw.165.1579531113235;
        Mon, 20 Jan 2020 06:38:33 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u8sm23192588wmm.15.2020.01.20.06.38.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:38:32 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 04/29] run-command: make `exists_in_PATH()` non-static
Date:   Mon, 20 Jan 2020 15:37:35 +0100
Message-Id: <20200120143800.900-5-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200120143800.900-1-mirucam@gmail.com>
References: <20200120143800.900-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Removes the `static` keyword from `exists_in_PATH()` function
and declares the function in `run-command.h` file.
The function will be used in bisect_visualize() in a later
commit.

Mentored by: Christian Couder <chriscool@tuxfamily.org>
Mentored by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 run-command.c |  2 +-
 run-command.h | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 9942f120a9..096faea5b9 100644
--- a/run-command.c
+++ b/run-command.c
@@ -210,7 +210,7 @@ static char *locate_in_PATH(const char *file)
 	return NULL;
 }
 
-static int exists_in_PATH(const char *file)
+int exists_in_PATH(const char *file)
 {
 	char *r = locate_in_PATH(file);
 	free(r);
diff --git a/run-command.h b/run-command.h
index 592d9dc035..7c8e206d97 100644
--- a/run-command.h
+++ b/run-command.h
@@ -172,6 +172,17 @@ void child_process_clear(struct child_process *);
 
 int is_executable(const char *name);
 
+/**
+ * Returns if a $PATH given by parameter is found or not (it is NULL). This
+ * function uses locate_in_PATH() function that emulates the path search that
+ * execvp would perform. Memory used to store the resultant path is freed by
+ * the function.
+ *
+ * The caller should ensure that $PATH contains no directory
+ * separators.
+ */
+int exists_in_PATH(const char *);
+
 /**
  * Start a sub-process. Takes a pointer to a `struct child_process`
  * that specifies the details and returns pipe FDs (if requested).
-- 
2.21.1 (Apple Git-122.3)

