Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D01A1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 22:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbfBLW1f (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 17:27:35 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:34879 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbfBLW1d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 17:27:33 -0500
Received: by mail-qt1-f201.google.com with SMTP id k1so368623qta.2
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 14:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0AVqEGp8Lf916B35P15x2TefwJH9bKGucnpkYkpGL9E=;
        b=DbY23twKNEM9aU+7r6ssUvq7nfiPdLbzCS1TiD15vvyOA7bBT9bHh9A4g8eCaL8hSd
         KgAKBqOFRQHremBS2B+Jwy9jgDcFAACjdfbk8lYwZKXoieXY+xhPck5KytpDxlvoR132
         e4zrop/bpIV6ykLlV85cBl5uaj3qyPc86T2iE3ptXIWcQvxO2KoSGHbLpoKNAk98XRSh
         PAHBFe8Ft6cxOv9bwo4UZgjTV0eocKB8zF4IXi3i57TL5zSGhecK0s8RmmrPRblJhQ6t
         DLgO8ZnhwAVTNkv+N1I9Mh2/tBbXg14mkK/O0DdHvkVT8xBWqYwttGRZ87uXNvDGz6Sn
         aa8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0AVqEGp8Lf916B35P15x2TefwJH9bKGucnpkYkpGL9E=;
        b=YSeFC/1+QWbg8QKBrOMnmA/Wqi798Pf8U+uT5dE5iIkFmJmsADubRijKoXH526wIkz
         +ioZctbVfzOxJy6ASnK8JoUW7zoouoz7mYsp8UOmueaHP+AvbZNESx3CM+DUmTAoHUNI
         Od4Wj+WvAPxNqkzuJakGjc/2n7DDsqKzEBR15jSnu7shWSwZ4kYH2fJRKVUKo8GNPS9Q
         0auznOVR6LvbipOF2Wq8EAtgmGhhQimIpTruafncbSfAaXm75NCSGESx7YsSGgV+2xRq
         EpywBulUS1JcogtmH31G3AyeylPbNGq+OaFIhFtN4MPLbvc7qVu9DifJvJSQ0FwiJ5yv
         Yktw==
X-Gm-Message-State: AHQUAuYpIEPvVxclwOlzVJ8n45+17a05P+LP1Br+eRwhV5IZsa6twI4R
        4qcFPop8cqB9BU1y7dDlR3lvYLYdzAe0UF7Jo4NawQvPEoqvGYBYRrKcr3mRFYnLNgut67KQb2y
        fqPQai5c2y6J9Z4dFvmxh38ks4VNO1bYHXjcmndYOOeNRM8nfjI67
X-Google-Smtp-Source: AHgI3IZ2RG00DygGwonuVMHMQMaOv1e4NsCjI/DIa0DsO6FBkAsHRAVDWxoARJYDD5TjktILGUiQPt6j
X-Received: by 2002:a37:58b:: with SMTP id 133mr2576615qkf.31.1550010452139;
 Tue, 12 Feb 2019 14:27:32 -0800 (PST)
Date:   Tue, 12 Feb 2019 17:27:19 -0500
In-Reply-To: <20190212222722.240676-1-brho@google.com>
Message-Id: <20190212222722.240676-3-brho@google.com>
Mime-Version: 1.0
References: <20190212222722.240676-1-brho@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH v3 2/5] blame: use a helper function in blame_chunk()
From:   Barret Rhoden <brho@google.com>
To:     git@vger.kernel.org
Cc:     "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?Ren=C3=A9=20Scharfe?=" <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
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
 blame.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/blame.c b/blame.c
index da57233cbbd9..f30bb2430c5e 100644
--- a/blame.c
+++ b/blame.c
@@ -838,6 +838,25 @@ static struct blame_entry *reverse_blame(struct blame_entry *head,
 	return tail;
 }
 
+/* Splits a blame entry into two entries at 'len' lines.  The original 'e'
+ * consists of len lines, i.e. [e->lno, e->lno + len), and the second part,
+ * which is returned, consists of the remainder: [e->lno + len, e->lno +
+ * e->num_lines).  The caller needs to sort out the reference counting for the
+ * new entry's suspect. */
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
@@ -864,14 +883,9 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
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
@@ -918,14 +932,10 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
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
2.21.0.rc0.258.g878e2cd30e-goog

