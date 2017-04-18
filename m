Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E38061FE90
	for <e@80x24.org>; Tue, 18 Apr 2017 09:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756538AbdDRJ37 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 05:29:59 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34891 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755673AbdDRJ3N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 05:29:13 -0400
Received: by mail-wr0-f194.google.com with SMTP id l44so23827774wrc.2
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 02:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SLBFe82r/NUufKt+9oMdI1fnDdNHLgztyQPN4StztrY=;
        b=NGFNiuAtD/jVjF0eOpFuP84bjKBKCwqh5edD6YBFfctzHMER2DUB8r1o6vCMsKsYIJ
         bQm4kUdjMcK68M/KcCTgEpO9u5wJbx6/C3gCG9NyLQtoDGb7EH0JzReJCHVAUAZP8B24
         jw/ioh5mOL6AkEOfMqZi6p4ktGK964ZhpSCaUmnveBhEQRs8OLBpZD1iPnNhZgjh9vIM
         xwXWPoXaPx2h9yD1L1tJ98uDwsnj1fNzbQXoT9zzMaLKCcLALmVsdA2/QBbTFbueo7v/
         /Oo1GL25qKC3noLqdaWmQRhRHtUp53+Z/jYL2P7rNJZDrNf3Uvl1HLoV09ENyqJLXWUL
         NJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SLBFe82r/NUufKt+9oMdI1fnDdNHLgztyQPN4StztrY=;
        b=LBML/6D3qe4pik9szYndg5qagCnKpFCcd6YUPRDYjYVXyxsEMmp6vpEDLzlL1shw3p
         aCi8pBHVtVRlxt7qqZTznTC0sjtY87gG5cvE5VH9rMjR18xyHIggS+9AAizJt6mIYdOa
         yM8L0q5Xv1dFcZvMHQSRIDTaHKPjDjNEAcPB1X+mGuuRt+GzDuUd+0gkbpEFKyMajGRV
         cvnIM48aOFwFYQrcRN1G5QiNDZeQZZehkUIq8aytZEBJkoKbQJ9FeAzWY2SqDoBDg1Pj
         qStz2EKBKZzfUfcIrTtGDnvQ4XQMSRIBOsMQgWZvQ8yRIaStx4vDt3mMOd9Rz9YM/y0r
         e+Ow==
X-Gm-Message-State: AN3rC/51sSpxAIs9T3mBhaB90qclcVzazyvJSXQWUh5Bpdn2eQpR9KRr
        49kpVB3z71oXvg==
X-Received: by 10.223.181.132 with SMTP id c4mr14174667wre.178.1492507752498;
        Tue, 18 Apr 2017 02:29:12 -0700 (PDT)
Received: from localhost ([193.206.223.117])
        by smtp.gmail.com with ESMTPSA id o9sm14203687wmd.4.2017.04.18.02.29.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Apr 2017 02:29:11 -0700 (PDT)
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To:     Git ML <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH v4 2/3] builtin/am: fold am_signoff() into am_append_signoff()
Date:   Tue, 18 Apr 2017 11:29:04 +0200
Message-Id: <20170418092905.20097-3-giuseppe.bilotta@gmail.com>
X-Mailer: git-send-email 2.12.2.820.g78c033c3a1.dirty
In-Reply-To: <20170418092905.20097-1-giuseppe.bilotta@gmail.com>
References: <20170418092905.20097-1-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are no more direct calls to am_signoff(), so we can fold its
logic  in am_append_signoff().

(This is done in a separate commit rather than in the previous one, to
make it easier to revert this specific change if additional calls are
ever introduced.)

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 builtin/am.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index d072027b5a..b29f885e41 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1181,42 +1181,39 @@ static void NORETURN die_user_resolve(const struct am_state *state)
 	exit(128);
 }
 
-static void am_signoff(struct strbuf *sb)
+/**
+ * Appends signoff to the "msg" field of the am_state.
+ */
+static void am_append_signoff(struct am_state *state)
 {
 	char *cp;
 	struct strbuf mine = STRBUF_INIT;
+	struct strbuf sb = STRBUF_INIT;
 
-	/* Does it end with our own sign-off? */
+	strbuf_attach(&sb, state->msg, state->msg_len, state->msg_len);
+
+	/* our sign-off */
 	strbuf_addf(&mine, "\n%s%s\n",
 		    sign_off_header,
 		    fmt_name(getenv("GIT_COMMITTER_NAME"),
 			     getenv("GIT_COMMITTER_EMAIL")));
-	if (mine.len < sb->len &&
-	    !strcmp(mine.buf, sb->buf + sb->len - mine.len))
+
+	/* Does sb end with it already? */
+	if (mine.len < sb.len &&
+	    !strcmp(mine.buf, sb.buf + sb.len - mine.len))
 		goto exit; /* no need to duplicate */
 
 	/* Does it have any Signed-off-by: in the text */
-	for (cp = sb->buf;
+	for (cp = sb.buf;
 	     cp && *cp && (cp = strstr(cp, sign_off_header)) != NULL;
 	     cp = strchr(cp, '\n')) {
-		if (sb->buf == cp || cp[-1] == '\n')
+		if (sb.buf == cp || cp[-1] == '\n')
 			break;
 	}
 
-	strbuf_addstr(sb, mine.buf + !!cp);
+	strbuf_addstr(&sb, mine.buf + !!cp);
 exit:
 	strbuf_release(&mine);
-}
-
-/**
- * Appends signoff to the "msg" field of the am_state.
- */
-static void am_append_signoff(struct am_state *state)
-{
-	struct strbuf sb = STRBUF_INIT;
-
-	strbuf_attach(&sb, state->msg, state->msg_len, state->msg_len);
-	am_signoff(&sb);
 	state->msg = strbuf_detach(&sb, &state->msg_len);
 }
 
-- 
2.12.2.820.g78c033c3a1.dirty

