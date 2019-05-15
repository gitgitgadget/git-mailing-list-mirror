Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A658A1F461
	for <e@80x24.org>; Wed, 15 May 2019 21:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfEOVpU (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 17:45:20 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:48609 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfEOVpU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 17:45:20 -0400
Received: by mail-ot1-f73.google.com with SMTP id q12so687780oth.15
        for <git@vger.kernel.org>; Wed, 15 May 2019 14:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Q2/h2nNA+Bn0hhSACjanZN1P6J+dCHL3g/DsFA8dZn0=;
        b=J/6w4ZIHVggM+jveyAu3RpZPqKuqa6fq/dAZfRhXQv1qkSzYTkENH+stNOB8tfNR+T
         dCvSMgmwOv15vBQEBPQdT9nq+mSdg/sf2fKC4Cnl1hREam44j4Ba+XO4+xRf3OV2/hOi
         SZ2pix7Agug69mrr5dV0pOK3SyuFSHpfX1hojaXFoF++v1v6CdKiq8AO+l8U1tA7iGzX
         BjcQ0NQfQ8N59IIXXgMG30a/XjF+kUuUsVGsEy857ymNfrL0hY9xliFp/1bN9IcOKGVy
         eCKwJr2mG89pFk2wy/rj6GstDOZ9ktlaJIydEVb1xtmZ/u9XzLnFLnnzFM2sseSmxfVu
         BuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Q2/h2nNA+Bn0hhSACjanZN1P6J+dCHL3g/DsFA8dZn0=;
        b=aj6zTdc3AeCjCkPb7paOOum/6insNFc5lmEfqrA882loX+8qo5e9QTip7u3c084f3W
         ipEizR9jeDHkhzGzEw1LTxc5v7cfS5MeC6A5ORzx+Xm2sujtmVg7GEdOqJgmHx8+Ys0N
         ukUyYw4yN/9dG1WrJfRvCewEAeHs8zQeuy6+37Xdh4Scg0QGQuPKOieGXvnP/Yftt3rh
         roQkkeyoACacg3AY3QEUZc/CeaT5lAUqvAXPqIL0JZlsxtfnXMXyAUC38f87lzpbxjc1
         DR+4fa71mqcf2q7GgRlnD7InlnbAfjs7pGRWK4V9/qt3+4s3zMaBj0mXk9YoNixK2XHR
         EfeA==
X-Gm-Message-State: APjAAAWozMNvkawfQSI+nixhwsNkAZvCOoArYcjnF+u6zUOEEvaZhPGt
        taXhHTQKoU2uDJgJ3zVFxDeFRaf6OsKvYQzBw5Ms9GPtZJcpYmhNDwJODqSSDQisxt8ykfe70qW
        AdU31kP8+KA2ilhGvUD5MLU+42cBXA3mZx4yLwTIp8bYGNre8h9gU
X-Google-Smtp-Source: APXvYqwtRxE40r0xABKR3OwbB89YlwCWVKItysA3v6jEsTyXRvokRj5INGEmI+C/FAenz2FZjHslG9AR
X-Received: by 2002:aca:4d48:: with SMTP id a69mr8039408oib.113.1557956719302;
 Wed, 15 May 2019 14:45:19 -0700 (PDT)
Date:   Wed, 15 May 2019 17:44:58 -0400
In-Reply-To: <20190515214503.77162-1-brho@google.com>
Message-Id: <20190515214503.77162-4-brho@google.com>
Mime-Version: 1.0
References: <20190515214503.77162-1-brho@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v7 3/8] blame: use a helper function in blame_chunk()
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
index 145eaf2faf9c..5369be9a2233 100644
--- a/blame.c
+++ b/blame.c
@@ -839,6 +839,27 @@ static struct blame_entry *reverse_blame(struct blame_entry *head,
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
@@ -865,14 +886,9 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
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
@@ -919,14 +935,10 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
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
2.21.0.1020.gf2820cf01a-goog

