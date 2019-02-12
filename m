Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5A9F1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 22:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfBLW1C (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 17:27:02 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39568 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfBLW1C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 17:27:02 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so254450edt.6
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 14:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EjZdmoCpzjmQXbTddE7TrXbCYC7lkCVKOuquQIFRK80=;
        b=Uob11nBOxdxx46x6u3hkK0eba38GtluGGgBMU1zCBjQ7TxLjQoBU0cIcXPGFhvqVKF
         FG42hAWY+ZBTY5dXW0XWNsGlcD2fH6NC2T08E7y0gp3ge7GBhDXKz5wm3ZT0Wb0728RH
         r/Yz8axWYwHoQM2sSf0s//9DuBqsW0lKwWAWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EjZdmoCpzjmQXbTddE7TrXbCYC7lkCVKOuquQIFRK80=;
        b=LGr8uOjLEDXDHGqvYDmE3sSYriH8mxHiv1+dcvzLhn0e368ZtAW9VHJwRQnYo1L6kp
         uxgGz56uSZTL//oNLLsYADq6+91vKDOk4nf/Ih697xmvXmnoWIvNM7EKKnBKaoDhHzXf
         YrIHTEyrbCoJlMUrBKzNwXqlSpSYn7aQp0vjdtZ7ofwUfbl4Mhfn4XFsZ8O3u5imamSx
         533am6x2yrLoytjfeJMb3PCJDhgTny1cvgnCOpZ04t0oDYy6RZQJoNH5NQmyxlKRyarX
         flJ8B8lEcj2i3x4GkqGggasgQd41iOp4JMKOGpoG2BwYxKkXguvFDDU8nqwWOesGCOnT
         YKRg==
X-Gm-Message-State: AHQUAuYV9VFDK61lWvethys2MfKvCAo6wSojc0QUbaUVPdOkyIIIO6LF
        UzHtN2rYgeestTXWiDWUXCjIqsUx8fVcCesx
X-Google-Smtp-Source: AHgI3IaCUCpshi3U6oX1kob0hSHoHY0XIkWm9v3MX7KgyO1zdK/xQqtThC5KL1/qBkgqUjNuskIVxw==
X-Received: by 2002:a17:906:bb16:: with SMTP id jz22mr4262745ejb.106.1550010420477;
        Tue, 12 Feb 2019 14:27:00 -0800 (PST)
Received: from prevas-ravi.waoo.dk (ip-5-186-119-174.cgn.fibianet.dk. [5.186.119.174])
        by smtp.gmail.com with ESMTPSA id ay20sm3349582ejb.32.2019.02.12.14.26.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 14:26:59 -0800 (PST)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [RFC PATCH 1/5] builtin/grep.c: change todo_* variables to unsigned
Date:   Tue, 12 Feb 2019 23:26:50 +0100
Message-Id: <20190212222654.7432-2-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212222654.7432-1-rv@rasmusvillemoes.dk>
References: <20190212222654.7432-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for subsequent patches that make todo_* free-running
instead of reducing them mod TODO_SIZE, change their type to unsigned
to avoid undefined behaviour in case anybody ever greps more than 2
billion files.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 builtin/grep.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 580fd38f41..6c1e90d43b 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -58,9 +58,9 @@ struct work_item {
  */
 #define TODO_SIZE 128
 static struct work_item todo[TODO_SIZE];
-static int todo_start;
-static int todo_end;
-static int todo_done;
+static unsigned int todo_start;
+static unsigned int todo_end;
+static unsigned int todo_done;
 
 /* Has all work items been added? */
 static int all_work_added;
@@ -132,7 +132,7 @@ static struct work_item *get_work(void)
 
 static void work_done(struct work_item *w)
 {
-	int old_done;
+	unsigned int old_done;
 
 	grep_lock();
 	w->done = 1;
-- 
2.20.1

