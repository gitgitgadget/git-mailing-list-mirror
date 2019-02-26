Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C84CE20248
	for <e@80x24.org>; Tue, 26 Feb 2019 17:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfBZRHH (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 12:07:07 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:48544 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbfBZRHG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 12:07:06 -0500
Received: by mail-qk1-f201.google.com with SMTP id z198so10991340qkb.15
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 09:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nvSRAgpzZd7HgKdW/kzlQ7G5w876vQRZR5Zd7HcLKJI=;
        b=J09TlrkSgm10AYk5XWviZu0sLDawiThqsawGMJh5+tV8jlUz3or7g2VjE+NPIYvx0P
         z60SuIgS09v+JHRbd8pCVVyuvIYOxsxjMWkJKfYEyGErTqXtTOAe5/1Tf8Ezt8F0O75F
         /6hyL033TT6krWCQMCM84YuEbTcolUWqkAKQ968dmFyZ7vY9fS71M7vZqno2z/Q1GHgQ
         o8ofR6fNf9mfqZ6Zw7cNK3Nh/o/k5u+Qjj+4acOKdHr7uVOW8PTcGpdFyJ/kKA1xxGRM
         rwT9y3Z8Hd2db7DN4N3fwe3aORMqyZEg700HQ9xTVn1IHRda8dd8ePFcOo1f4SFQwd7t
         f6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nvSRAgpzZd7HgKdW/kzlQ7G5w876vQRZR5Zd7HcLKJI=;
        b=JQQM3yGgnEsPs6FlDXZuQ3WbCCLh0sziONHuy3Q55NTLOecHxmlJKQKQC9X2cfyM/b
         osKseiKloeZvSac+f961hpl7xHAJu531CFjHIsuL1s9AhMI0ipZH8z2Ak2t6HyhDprhN
         PUM/ynBURjjVLCy3kge5Ij/oF2FIwd3z3haMb28Qg4EcuSRKYCfr9EQGZ3IZMZ66MsL/
         +3ZZZsqOTS3m4LCaPCaF7MQcgNn1AlO8BcXMA14pbDQWnf5IafEpxSUBWOZK+M/TYqhK
         JLsEyhJXlcONhVs2g3N39aueSm1Rsq9oUddH/tkXANo6w/mgDH+0/g13hnNzG7B4qIlE
         VxnQ==
X-Gm-Message-State: AHQUAuYYgbG6BIu1WNpJEXmYKGSM1pOjoBew6lCXHiF4YzEJv3KlGTJC
        3ByrLC3Lb0+A5Dkf8J3lr7TpmzCCvNvFLYOepHzrEcKu2hQmckNe9lM4wWazH/qy10GSM96V+1u
        oP8zH4bu3YsTmgyYJrIkpsJ4EER7iEk2uYzq6keGOy1PEAc16vpSN
X-Google-Smtp-Source: AHgI3IZruE8vBdX30fMi75GJZWxnkQ6w2kEHe+fScAOntOzPtJP2iq002qit/D4FvsQmo0HHeKVM97xW
X-Received: by 2002:ac8:17ce:: with SMTP id r14mr14618529qtk.38.1551200825496;
 Tue, 26 Feb 2019 09:07:05 -0800 (PST)
Date:   Tue, 26 Feb 2019 12:06:46 -0500
In-Reply-To: <20190226170648.211847-1-brho@google.com>
Message-Id: <20190226170648.211847-3-brho@google.com>
Mime-Version: 1.0
References: <20190226170648.211847-1-brho@google.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
Subject: [PATCH v4 2/4] blame: use a helper function in blame_chunk()
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
2.21.0.rc2.261.ga7da99ff1b-goog

