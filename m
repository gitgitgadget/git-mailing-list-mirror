Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9487020193
	for <e@80x24.org>; Wed,  2 Nov 2016 17:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756600AbcKBR3c (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 13:29:32 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35916 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756572AbcKBR3b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 13:29:31 -0400
Received: by mail-pf0-f172.google.com with SMTP id 189so15344956pfz.3
        for <git@vger.kernel.org>; Wed, 02 Nov 2016 10:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=E7YSfVRKRdRwjsezx+G1WX6wKtoJx4nAVbW+dhZzsqg=;
        b=DIgpBucO/4z1MHlNIBvqZFOQeWSfwMOx6c4UH7sY5AH9//U5hIUHEiEL4/aWA67LW8
         XKfxtqzXoNxeTfmF0+64f2Du3Cc7gbjYSfCBkhJCVH9B9qon7NiePP3+3pOqO5O+jcoP
         4zYn681iPdbB6jb62o6p7VPdKb2PwJeQ5NWQJK8g2OpzLbHriCUFgg9l1UnqfIk/bneA
         pI00eD3GzTHFFz8eot9aUQ3HFx/5tu/btLKVfuFgCxcmyje2+bPqTJncS60teLZz2cLf
         kiwI688AcRU4ZiqxmzZXUQ2rt8ov7FvxtKEi5MbseDlEKbfrwN++v1LDI9zVXbx6KjgH
         P7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=E7YSfVRKRdRwjsezx+G1WX6wKtoJx4nAVbW+dhZzsqg=;
        b=cXs9oOx7W4eAcvKf4/QF+yFFZRO6m00ezIoijXbL6rMNiaBKbVKfi5H1uhk7uQ7s71
         mng6L8fuc/KMYJk+n58sIGHUUZcf9kk2C1gJB1/6o6Y49EFuTnU9gCr8VsvdZIhy6LmO
         U9gF0qqMf5ER8I6XeROa8392W/GiP4aH3chN6mvUWw9+Dhw0WWHV2e0NrMuiV/OlX4HX
         xG4Cu/Wq+BxEWJQPGNuaiWlqGncTIs9lPjDgx44E10qxaxMWX7KxrK7yQe5+i0hhMA5T
         Q8aB3fqH5waqmrQJwcPpPhQmtfgh4o5LLycqUy/PKcRba2zD8XwHo1zSU/qCgKevN1lR
         FHbw==
X-Gm-Message-State: ABUngvc8V/8XI+18dlykkzeZ8IqjbFvPqQUcaUnnDhrwHc8VjCn6D5T2WjIrIozQTX0Wjvkg
X-Received: by 10.98.67.133 with SMTP id l5mr8762693pfi.170.1478107770191;
        Wed, 02 Nov 2016 10:29:30 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id f23sm6185167pff.59.2016.11.02.10.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Nov 2016 10:29:29 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 1/5] trailer: be stricter in parsing separators
Date:   Wed,  2 Nov 2016 10:29:16 -0700
Message-Id: <4f147d776f906da4a8ba7e256e65c048e9bd8d1a.1478107666.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1478107666.git.jonathantanmy@google.com>
References: <cover.1478107666.git.jonathantanmy@google.com>
In-Reply-To: <cover.1478107666.git.jonathantanmy@google.com>
References: <cover.1477698917.git.jonathantanmy@google.com> <cover.1478107666.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, a line is interpreted to be a trailer line if it contains a
separator. Make parsing stricter by requiring the text on the left of
the separator, if not the empty string, to be of the "<token><optional
whitespace>" form.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 trailer.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/trailer.c b/trailer.c
index f0ecde2..dc525e3 100644
--- a/trailer.c
+++ b/trailer.c
@@ -563,15 +563,30 @@ static int token_matches_item(const char *tok, struct arg_item *item, int tok_le
 }
 
 /*
- * Return the location of the first separator in line, or -1 if there is no
- * separator.
+ * If the given line is of the form
+ * "<token><optional whitespace><separator>..." or "<separator>...", return the
+ * location of the separator. Otherwise, return -1.
+ *
+ * The separator-starts-line case (in which this function returns 0) is
+ * distinguished from the non-well-formed-line case (in which this function
+ * returns -1) because some callers of this function need such a distinction.
  */
 static int find_separator(const char *line, const char *separators)
 {
-	int loc = strcspn(line, separators);
-	if (!line[loc])
-		return -1;
-	return loc;
+	int whitespace_found = 0;
+	const char *c;
+	for (c = line; *c; c++) {
+		if (strchr(separators, *c))
+			return c - line;
+		if (!whitespace_found && (isalnum(*c) || *c == '-'))
+			continue;
+		if (c != line && (*c == ' ' || *c == '\t')) {
+			whitespace_found = 1;
+			continue;
+		}
+		break;
+	}
+	return -1;
 }
 
 /*
-- 
2.8.0.rc3.226.g39d4020

