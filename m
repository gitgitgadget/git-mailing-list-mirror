Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E723A20899
	for <e@80x24.org>; Mon, 14 Aug 2017 23:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752772AbdHNX5t (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 19:57:49 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33604 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752651AbdHNX5s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 19:57:48 -0400
Received: by mail-pg0-f51.google.com with SMTP id u5so56723411pgn.0
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 16:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=VSxurodUKrct9oajmcrb/ADgbGkXeTEq4j6YCSVl7IM=;
        b=geYf2xqXTtmwbp5Endj4vshHMvOXjTEXvLyXAcBhCgsqHOiwpXyBZs+i3aiMDPsEBv
         9QKQT+kxISgCjWG2YUy7vTkX6kpoQk/N16xIdQ9Po3K0zFyrd2wvR6YmZ5wc45OouBpw
         md5Mm/tbwRpH+6+o/H8qzxj0lk9FzdQXERbwiGf6EJ1Tbx4/MrYfTzSs4463k4jXcZ6D
         j9idC8t1fROWldRO5iB04tkpTwcl7CEhwlCOk/OKlzOExEotoV2jF0pMbztJD8F7ZyTl
         e1XoVbk+ehDZanhnGOUF6uL9DLg4SiUPFKogd4bz1HfGsy5vHWGQdsBNNrqgBaKL1LsP
         b2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=VSxurodUKrct9oajmcrb/ADgbGkXeTEq4j6YCSVl7IM=;
        b=JNAs0LQ0ThNXH4BEc44QIMRXQzz4t0fKielXJ1XONxizy4soK2vVWOv0VmeroowkM8
         oRbyuvdJJQ4Mstw+uvZpZFfVx7xgVrSEihdN7R+uEV4DcrN2CL30zGUggYarA2BFBdyK
         A+z2HKr4Y4qfU3y4I7t3JfOYRqSIfnGtD6VfGk4FklfC6bLTiHDE9sZTViWhF1zMrpcH
         hRL6UrnHy39fkIf3Fihlc0sOxeI4lcSakeJ260bci/OkvY5Da0FGkiIF3L1YufC9vDNS
         agC0Y3oCOAu5UmKwivm/c+XxwfkrHJFNCkYQd4m48tEwwYQEq8gXzDLnarRKdDVNgqAE
         qukQ==
X-Gm-Message-State: AHYfb5jhIFY3Zpzt0PaUb6Ujtvk2beHAUn+fwoo+jzJvjeHD8Mq23XAm
        YFgu3kWHFTIuAq0JioOGMw==
X-Received: by 10.98.200.151 with SMTP id i23mr26888754pfk.281.1502755067768;
        Mon, 14 Aug 2017 16:57:47 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id 190sm15878796pfy.56.2017.08.14.16.57.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Aug 2017 16:57:46 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v3 1/3] diff: avoid redundantly clearing a flag
Date:   Mon, 14 Aug 2017 16:57:41 -0700
Message-Id: <d199b62322a29e55a8ae21636aa7076231352ad7.1502754962.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1502754962.git.jonathantanmy@google.com>
References: <cover.1502754962.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502754962.git.jonathantanmy@google.com>
References: <cover.1502491372.git.jonathantanmy@google.com> <cover.1502754962.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No code in diff.c sets DIFF_SYMBOL_MOVED_LINE except in
mark_color_as_moved(), so it is redundant to clear it for the current
line. Therefore, clear it only for previous lines.

This makes a refactoring in a subsequent patch easier.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 4af73a7e0..23311f9c0 100644
--- a/diff.c
+++ b/diff.c
@@ -898,7 +898,7 @@ static void mark_color_as_moved(struct diff_options *o,
 		if (!match) {
 			if (block_length < COLOR_MOVED_MIN_BLOCK_LENGTH &&
 			    o->color_moved != COLOR_MOVED_PLAIN) {
-				for (i = 0; i < block_length + 1; i++) {
+				for (i = 1; i < block_length + 1; i++) {
 					l = &o->emitted_symbols->buf[n - i];
 					l->flags &= ~DIFF_SYMBOL_MOVED_LINE;
 				}
-- 
2.14.1.480.gb18f417b89-goog

