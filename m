Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE45020248
	for <e@80x24.org>; Wed,  3 Apr 2019 16:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfDCQCU (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 12:02:20 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:52822 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfDCQCT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 12:02:19 -0400
Received: by mail-qt1-f202.google.com with SMTP id g48so17181154qtk.19
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 09:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IbDBlJ6pktA8Le6KDQI3FiwOvhxnTO4oU0ur7q/h/wE=;
        b=RMKx+T107RK3yGe481rJw6rB39PS6g7Guo07cmYdhQfncwvED8CQJeacilY5TWXESV
         0j7NgGXPfcKE2mPZk/GV8alOI8HURG7upoO1qjh7t5+rKtTvaz3uAj3H3l/TxOEBryP4
         8WSZpuLPwS6RmNEMOBxOhKlrvsquVWlWGGRbH+eH3OMrTwEyGSIQysbrZpNlBQWi0YtZ
         y5o08/Z09/3qIFW8ET/C6+Cp+DTKfhN7ZdSoq92rL4k3FtFSch4xr1J78C5uWvVVjJLn
         xmzG6FQGy3JAHJRue/2Xqo5U2Mhh8ZQZWb1qGwdHIQWIZy56d8ZjHZ6Je1Q+2h3xqxO0
         pAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IbDBlJ6pktA8Le6KDQI3FiwOvhxnTO4oU0ur7q/h/wE=;
        b=OucwBtGRuSgiUncd5qsIrXAZnA8tj6hw+rpgYLZIN7y8MsX0l+WOIgNEgohAMmMgdH
         DipQFZmxkegEh4F1FOD8spm10eHwqWE76/G1wkh7R2IQ7fsYJTGcOY6SrEPrO+Pe8NgH
         d01R/V9BYElCyI4ueOFYKPZ0jkXHMQ9BsiXDvwgqhgMXW2x68rFfhyYB/R+Z6Q9cC0T/
         eojgvWP9RUcSXh4Y6q3ixv/TZStzevRu5a60pnvxP8F5gPbtDGg0Wf7IcSn+Jg5jgMjH
         dHg82Cm64GY3XarzEOUyZ1phbZuMb2vljUFHlPTAfjjF0v7CNFXH2yRew/APUWmEPZPi
         9iQA==
X-Gm-Message-State: APjAAAWiE4R3UuUncdIgWjACp5dkOE3mwg+F/MdQaXe6EeGLobp4Ilyx
        sJgofJ2Z+y1HlNKFuzHW0PWGqPdowXSkx7vRxqjCln01NvHK20hbU8RqKxlGn7ZrHZYs0R3NgZY
        KgxlLWaDpNMl4nbrwsgsGaGdcJBoixUoKsWifOX1E9VuwbWSiUVP/
X-Google-Smtp-Source: APXvYqx7a5kBlvehCgnygBEr68MPY3RmQ5OXM6pc/3HTN/bFL1dDHQ5g921GcGXYDApRWkvLq/2pPmEW
X-Received: by 2002:a37:a07:: with SMTP id 7mr83561qkk.50.1554307338326; Wed,
 03 Apr 2019 09:02:18 -0700 (PDT)
Date:   Wed,  3 Apr 2019 12:02:03 -0400
In-Reply-To: <20190403160207.149174-1-brho@google.com>
Message-Id: <20190403160207.149174-3-brho@google.com>
Mime-Version: 1.0
References: <20190403160207.149174-1-brho@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v5 2/6] blame: use a helper function in blame_chunk()
From:   Barret Rhoden <brho@google.com>
To:     git@vger.kernel.org
Cc:     "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?Ren=C3=A9=20Scharfe?=" <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Michael Platings <michael@platin.gs>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The same code for splitting a blame_entry at a particular line was used
twice in blame_chunk(), and I'll use the helper again in an upcoming
patch.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 blame.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/blame.c b/blame.c
index da57233cbbd9..31e05c1458d8 100644
--- a/blame.c
+++ b/blame.c
@@ -838,6 +838,27 @@ static struct blame_entry *reverse_blame(struct blame_entry *head,
 	return tail;
 }
 
+/*
+ * Splits a blame entry into two entries at 'len' lines.  The original 'e'
+ * consists of len lines, i.e. [e->lno, e->lno + len), and the second part,
+ * which is returned, consists of the remainder: [e->lno + len, e->lno +
+ * e->num_lines).  The caller needs to sort out the reference counting for the
+ * new entry's suspect.
+ */
+static struct blame_entry *split_blame_at(struct blame_entry *e, int len,
+					  struct blame_origin *new_suspect)
+{
+	struct blame_entry *n = xcalloc(1, sizeof(struct blame_entry));
+
+	n->suspect = new_suspect;
+	n->lno = e->lno + len;
+	n->s_lno = e->s_lno + len;
+	n->num_lines = e->num_lines - len;
+	e->num_lines = len;
+	e->score = 0;
+	return n;
+}
+
 /*
  * Process one hunk from the patch between the current suspect for
  * blame_entry e and its parent.  This first blames any unfinished
@@ -864,14 +885,9 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 		 */
 		if (e->s_lno + e->num_lines > tlno) {
 			/* Move second half to a new record */
-			int len = tlno - e->s_lno;
-			struct blame_entry *n = xcalloc(1, sizeof (struct blame_entry));
-			n->suspect = e->suspect;
-			n->lno = e->lno + len;
-			n->s_lno = e->s_lno + len;
-			n->num_lines = e->num_lines - len;
-			e->num_lines = len;
-			e->score = 0;
+			struct blame_entry *n;
+
+			n = split_blame_at(e, tlno - e->s_lno, e->suspect);
 			/* Push new record to diffp */
 			n->next = diffp;
 			diffp = n;
@@ -918,14 +934,10 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 			 * Move second half to a new record to be
 			 * processed by later chunks
 			 */
-			int len = same - e->s_lno;
-			struct blame_entry *n = xcalloc(1, sizeof (struct blame_entry));
-			n->suspect = blame_origin_incref(e->suspect);
-			n->lno = e->lno + len;
-			n->s_lno = e->s_lno + len;
-			n->num_lines = e->num_lines - len;
-			e->num_lines = len;
-			e->score = 0;
+			struct blame_entry *n;
+
+			n = split_blame_at(e, same - e->s_lno,
+					   blame_origin_incref(e->suspect));
 			/* Push new record to samep */
 			n->next = samep;
 			samep = n;
-- 
2.21.0.392.gf8f6787159e-goog

