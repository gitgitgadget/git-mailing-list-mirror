Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6087B207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 18:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424242AbdDUSzo (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 14:55:44 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35903 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424239AbdDUSzm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 14:55:42 -0400
Received: by mail-qt0-f194.google.com with SMTP id t52so13007696qtb.3
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 11:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7qFDoItSWdNRuYQbmZN5V00c4Lyq74zgQaFF0sMmST4=;
        b=SFfcON+BMyYhkgqylUOtWDh+QS2Pfs/+l44e2r4JNz6eNdeqhheUQ2GDOIESZQkc/u
         xtQiDynyHQHKT1Q3fidPL+P4CzDTY7oWFckmWdRaOvnD5Za27izuTe33AJxWECdQ5Kvr
         Dpy6yLXWkAtEqFEQKWVQxiT0PKPPRURCWzMtxsQ4uA2eO0zZUIVvev/Hicbtp2iPO6BT
         X/P2CzTIgzx/d/5aAESxipnP9zAQB0AoHF8YzuxXomA0XTZDymM2y6X5J1C1oBg3jqO1
         kTBXpz2JUR+NrFD7W3VY+cMyKQclbjkMnNqorcKzDUd76ZJco5NQM5nFRrESvc992RL6
         XWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7qFDoItSWdNRuYQbmZN5V00c4Lyq74zgQaFF0sMmST4=;
        b=XtDM1DqipVW3s2e0hOWtJG2M8ebTixDi9adS5x8Lcl6OyHibeBUtiQgzbDNNph3262
         gAMxI/fIeDqIOLtFJ5DSp9dHDSgaCPKCVkBZMIMXPpJQrlMLSKnhJong/DygIsLo8M6Q
         5aW/nm0OPFNLasPe4Qbkx7hWHtdjunFa3Gm1z6110Yu1im7QMlrWjLZr9fqek1tmJqpO
         78EEIW8y7R5v9MCTrWRvxG3KQCAGZ8MxfivNsOW9GMWN8JhmVxo4WO61vLwsezBf0oTN
         +mpTpwqInWdEQsAtXVj4Gu5zSMEAcnjbyWhvKiR6uGs9W8YsYaQF+AyxDRh8UHzJbHXi
         6zwQ==
X-Gm-Message-State: AN3rC/6BNlujOgGX0T3KJ1YBV04eBV85pQkN7Yzd0qRqE4yGNPe0JZsO
        p5T8K7RqTZl1pBM21fU=
X-Received: by 10.200.3.2 with SMTP id q2mr14383051qtg.0.1492795617552;
        Fri, 21 Apr 2017 10:26:57 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id g66sm6700551qkb.55.2017.04.21.10.26.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Apr 2017 10:26:56 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v6 8/8] convert: Update subprocess_read_status to not die on EOF
Date:   Fri, 21 Apr 2017 13:26:11 -0400
Message-Id: <20170421172611.12152-9-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.0.windows.1.33.g243d9b384c
In-Reply-To: <20170421172611.12152-1-benpeart@microsoft.com>
References: <20170421172611.12152-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Enable sub-processes to gracefully handle when the process dies by
updating subprocess_read_status to return an error on EOF instead of
dying.

Update apply_multi_file_filter to take advantage of the revised
subprocess_read_status.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 convert.c     | 10 ++++++++--
 sub-process.c | 10 +++++++---
 sub-process.h |  2 +-
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/convert.c b/convert.c
index 79d04907a5..f1e168bc30 100644
--- a/convert.c
+++ b/convert.c
@@ -635,7 +635,10 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	if (err)
 		goto done;
 
-	subprocess_read_status(process->out, &filter_status);
+	err = subprocess_read_status(process->out, &filter_status);
+	if (err)
+		goto done;
+
 	err = strcmp(filter_status.buf, "success");
 	if (err)
 		goto done;
@@ -644,7 +647,10 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	if (err)
 		goto done;
 
-	subprocess_read_status(process->out, &filter_status);
+	err = subprocess_read_status(process->out, &filter_status);
+	if (err)
+		goto done;
+
 	err = strcmp(filter_status.buf, "success");
 
 done:
diff --git a/sub-process.c b/sub-process.c
index 536b60cced..92f8aea70a 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -21,13 +21,15 @@ struct subprocess_entry *subprocess_find_entry(struct hashmap *hashmap, const ch
 	return hashmap_get(hashmap, &key, NULL);
 }
 
-void subprocess_read_status(int fd, struct strbuf *status)
+int subprocess_read_status(int fd, struct strbuf *status)
 {
 	struct strbuf **pair;
 	char *line;
+	int len;
+
 	for (;;) {
-		line = packet_read_line(fd, NULL);
-		if (!line)
+		len = packet_read_line_gently(fd, NULL, &line);
+		if ((len < 0) || !line)
 			break;
 		pair = strbuf_split_str(line, '=', 2);
 		if (pair[0] && pair[0]->len && pair[1]) {
@@ -39,6 +41,8 @@ void subprocess_read_status(int fd, struct strbuf *status)
 		}
 		strbuf_list_free(pair);
 	}
+
+	return (len < 0) ? len : 0;
 }
 
 void subprocess_stop(struct hashmap *hashmap, struct subprocess_entry *entry)
diff --git a/sub-process.h b/sub-process.h
index a88e782bfc..7d451e1cde 100644
--- a/sub-process.h
+++ b/sub-process.h
@@ -44,6 +44,6 @@ static inline struct child_process *subprocess_get_child_process(
  * key/value pairs and return the value from the last "status" packet
  */
 
-void subprocess_read_status(int fd, struct strbuf *status);
+int subprocess_read_status(int fd, struct strbuf *status);
 
 #endif
-- 
2.12.0.windows.1.33.g243d9b384c

