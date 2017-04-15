Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0F101FA14
	for <e@80x24.org>; Sat, 15 Apr 2017 14:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754109AbdDOOlX (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 10:41:23 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:32792 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753039AbdDOOlU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 10:41:20 -0400
Received: by mail-wr0-f194.google.com with SMTP id l28so15442136wre.0
        for <git@vger.kernel.org>; Sat, 15 Apr 2017 07:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e3eQPKzaSiKHFKvxURKsC7AG+xXD8EWRQhEvUxFsRj0=;
        b=PvLk23RdebrczDuRKP/tacRzFVvHd1M6+KS0EKfvaxjQiY14LbZc0X+wgWifdsUeCg
         vKSlKqdc1NT2qEYV+1G8lpq7rCtx/DjUwNfEpmd7OBf0DUGvnbf67zO5efC+Ah3ZAhrx
         LCMvyI0TGEsCfzuwsKU0Nbd7cmj2Y/FzSWOT8gq8QXuzOw4pYcTxu7/bSkJ2li6trDab
         R70gwKw4DqmgXCFRPd/7kvIi8eynh0RibJhmFWUhDKEjeG8MgmTFII2Oh4XzPT8oSlis
         q38I3fUCLKqyplkcZArOjtYtZkbuHjaz8HF5NHcteXd86+RN+EPqb888vgKNlq4l9rOS
         PuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e3eQPKzaSiKHFKvxURKsC7AG+xXD8EWRQhEvUxFsRj0=;
        b=p8TTNXgrw+vraU87ZyT2Fr0re8Lm6VsuagPASS+wrIj0DmHACZ00Sx3YRiA5eUOXtz
         DXFoeT8JyCHocfHRtcHy1jyCFLd9XUHTLnBVkYWT+Vd/U6caFqwsFV1gZ/dmaXTAT1d2
         FJxNxbrAIADZBqGTS3iqjGSrtESVARP17n6XgSuWI+xtBhUELgzZKXGcpSOrkQRxMa+1
         UVTtkV9X5ZIJoOfMOCa0D7lHhp60vGq0dLWuLRPEa8RapXJUa27O+bnCW9ZITaHu0Bd4
         YzKMeQKsY0IgJeWRjeWqTwN0kGsfd6Xw57Rvr9q0DdixneqvgV1j0uKtmKAgDXiIttz/
         1c1w==
X-Gm-Message-State: AN3rC/7Efm2prDf61Gk1lnvSZkbB2YL99//OhD2GG4GDVvJwy6X8w/6p
        Qd9oou9ceppjZw==
X-Received: by 10.223.135.134 with SMTP id b6mr11209284wrb.48.1492267279553;
        Sat, 15 Apr 2017 07:41:19 -0700 (PDT)
Received: from localhost ([151.54.23.249])
        by smtp.gmail.com with ESMTPSA id b10sm2797658wme.22.2017.04.15.07.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Apr 2017 07:41:18 -0700 (PDT)
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To:     Git ML <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 2/3] builtin/am: fold am_signoff() into am_append_signoff()
Date:   Sat, 15 Apr 2017 16:41:02 +0200
Message-Id: <20170415144103.11986-3-giuseppe.bilotta@gmail.com>
X-Mailer: git-send-email 2.12.2.765.g2bf946761b
In-Reply-To: <20170415144103.11986-1-giuseppe.bilotta@gmail.com>
References: <20170415144103.11986-1-giuseppe.bilotta@gmail.com>
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
2.12.2.765.g2bf946761b

