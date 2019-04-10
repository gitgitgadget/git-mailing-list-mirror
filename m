Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A36D520248
	for <e@80x24.org>; Wed, 10 Apr 2019 16:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbfDJQYd (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 12:24:33 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:35479 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729881AbfDJQYd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 12:24:33 -0400
Received: by mail-qt1-f201.google.com with SMTP id c28so1617361qtd.2
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 09:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZEjbmaQhMa1PUBfSaF2qR0gA/5T880d3kpY/s4VibMk=;
        b=O5LuHjizgsHkeo69fEO6Wq2IxiThc+UkFYIN0fVdZiBJq7EkzAw5hhMNx4kiudapLt
         XQAGh/cSE654nSR/qqoP1G2DrBh1aDU2cFYqCOIgZobKuQPLekzY1Utt0vfdfP9iOybe
         iHPZOHsF7B2cksWca1IZXuGJMnujpjYg5rz/7MxHQn8QJ8dJPcD79POjlWHZirwvvdyR
         IAg9ckdgD7TrGMg3y8Vx4DlDaxvoTwDl0zSz+BBc4endWkuYbP0nuw/BgdnnmVBViTeT
         6KXMdsQPKme3GkOeGEJsmxjSmp0xzdNrIrlyhfoQswrel9nTJ+UQGuNzFic+73R0sPWw
         GNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZEjbmaQhMa1PUBfSaF2qR0gA/5T880d3kpY/s4VibMk=;
        b=J/eyhhtEk9Ym4io5pxwQP9ThDgs/aE7djMWO8VHL2erVtrm08opnX1yRefTtOeqVPw
         lCSh0liHPlnfEK38vVgWiRLrvt/jggaFhZ3lyAfH91QvFzbXC4nmwQZpptyx6tPvwVdy
         dtdDBl6xI5Kum4KFtQkf9Q0lwbvUOYnmRwkoieASgHg4xNjW2Sk5Tv6R2t7NlUg4gDCG
         wQho/jOzywfOf3yoe2rAOvEIJBrL4epa91KTeytQYkTzWvjvaqGYsNUsByB3mwQY7ODk
         IbOnaYWzeQRWu2jhwOTVxruytjf2VMZZU9FLhYSaZ2mKvUIAG6Y34I6IbE0QVh1YDABT
         pK7A==
X-Gm-Message-State: APjAAAWAzM74+JTPJ870hjhBuAiAADWPmcvCYXxSPWETujB50RQA4Jmz
        X0ucQyCnU1TGSu3G47HZ3TsIvdU7VOjCazK1t0MSYUn5cK6e3mnfLytuIA5UfzPKg6Zi5z0iOC2
        rMsQ6ZUwmnIMgNbkS+aGqPyDZEo5mKYal7njek22oCTxLcHZfU0VJ
X-Google-Smtp-Source: APXvYqz+rgL3QqDmmVEy6/vXFrl/ykDURfpPhioSvIoueFfcLaEmDhIaS5H6rSEpA6h12WCK1ZnhCRET
X-Received: by 2002:a37:6903:: with SMTP id e3mr5522881qkc.48.1554913472102;
 Wed, 10 Apr 2019 09:24:32 -0700 (PDT)
Date:   Wed, 10 Apr 2019 12:24:05 -0400
In-Reply-To: <20190410162409.117264-1-brho@google.com>
Message-Id: <20190410162409.117264-3-brho@google.com>
Mime-Version: 1.0
References: <20190410162409.117264-1-brho@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v6 2/6] blame: use a helper function in blame_chunk()
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
index 5c07dec19035..9555a9420836 100644
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
2.21.0.392.gf8f6787159e-goog

