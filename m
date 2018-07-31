Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4105B1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 00:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732205AbeGaCJj (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 22:09:39 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:56249 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732009AbeGaCJj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 22:09:39 -0400
Received: by mail-yb0-f202.google.com with SMTP id y16-v6so7701484ybk.22
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 17:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=HhqN5tNnD1Woca6up3NDDm85ig0VO9ZsDatqTvtQUig=;
        b=SfKlPbE9doZIl0gIvkpU5aLhH9V5qeIRqcuMkhWORjJzjqayucD3yipu00F4mssO8c
         ielHkhBq+SXmotCF49sndZ7Z/TlIDfZAUJwqf+m0j9GA6zBeP8oeChWSnq9F8nJz1Eo7
         OKjl9GG93nsW0Xt8Aovk/UOU/eiEHj8Rd6aSfVcNtiKKJfdl/NYBPcXIEPuCPCk+l7kv
         WZtsUOq1XOrMyIXoylIUscvC91y4zuXenK+6jsAs+S/VYMwhamMsxddzEAyVf76V9RTD
         Lio5k7Sis6BgPytUO6pwOjJKxu/3NAPPdbUAjbgVuEO8I1Puzkh6t5DwGSGm6fWPthAj
         qKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=HhqN5tNnD1Woca6up3NDDm85ig0VO9ZsDatqTvtQUig=;
        b=hhdhmIKhUFbkX5bm2LCSV0YoKqOVlvVfGAslZqTI9gWoktOr4+n7xdhErFlw/A0xVm
         iKB2mdhUNSWxqe4MHq4WJUwDQzW0F1AApgngxx7BCLyaZYQ6DxEtxtAE9vqc5J6mJmpK
         2w3KLFCxKpOF0npoCinYOI7jj5tq4gaRs2/eP43Aa2zEENLkO4eeOReLqHuSut3m4LXR
         jcCh120L3Oy12VfzURuVW/o54KvPP6o6FwmcvCvdIC0TuMb7G9lpozDJMqwkmU7SS7aU
         tCjEhiw4fdT7B9Q/OH83jgZatQIVnY/8iEKs5Zvfybptwjzt4g4opsnrSzlmmMwvECFu
         I6mg==
X-Gm-Message-State: AOUpUlGOmk4EQDnoct8VF/esp3n4IWlFwegSguSj6LHvJ9clotywgGuU
        BUf2Q9eHt7OyEbraFREwMRAzm3rzeJXZ
X-Google-Smtp-Source: AAOMgpf833A9WytnQkJ4bDi5KRpWO0FyOJycPllKiJuRy8qV+m/NhKOm/32O9XiNqZpmDwSPkMPjARhqC2RA
MIME-Version: 1.0
X-Received: by 2002:a25:e805:: with SMTP id k5-v6mr5747802ybd.53.1532997126883;
 Mon, 30 Jul 2018 17:32:06 -0700 (PDT)
Date:   Mon, 30 Jul 2018 17:31:41 -0700
In-Reply-To: <20180731003141.105192-1-sbeller@google.com>
Message-Id: <20180731003141.105192-9-sbeller@google.com>
References: <20180728030448.192177-1-sbeller@google.com> <20180731003141.105192-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 8/8] diff.c: rewrite emit_line_0 more understandably
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

emit_line_0 has no nested conditions, but puts out all its arguments
(if set) in order. There is still a slight confusion with set
and set_sign, but let's defer that to a later patch.

'first' used be output always no matter if it was 0, but that got lost
at "diff: add an internal option to dual-color diffs of diffs",
2018-07-21), as there we broadened the meaning of 'first' to also
signal an early return.

The change in 'emit_line' makes sure that 'first' is never content, but
always under our control, a sign or special character in the beginning
of the line (or 0, in which case we ignore it).

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 73 +++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 32 deletions(-)

diff --git a/diff.c b/diff.c
index f565a2c0c2b..2bd4d3d6839 100644
--- a/diff.c
+++ b/diff.c
@@ -580,43 +580,52 @@ static void emit_line_0(struct diff_options *o,
 			int first, const char *line, int len)
 {
 	int has_trailing_newline, has_trailing_carriage_return;
-	int nofirst;
 	int reverse = !!set && !!set_sign;
+	int needs_reset = 0;
+
 	FILE *file = o->file;
 
 	fputs(diff_line_prefix(o), file);
 
-	if (len == 0) {
-		has_trailing_newline = (first == '\n');
-		has_trailing_carriage_return = (!has_trailing_newline &&
-						(first == '\r'));
-		nofirst = has_trailing_newline || has_trailing_carriage_return;
-	} else {
-		has_trailing_newline = (len > 0 && line[len-1] == '\n');
-		if (has_trailing_newline)
-			len--;
-		has_trailing_carriage_return = (len > 0 && line[len-1] == '\r');
-		if (has_trailing_carriage_return)
-			len--;
-		nofirst = 0;
-	}
-
-	if (len || !nofirst) {
-		if (reverse && want_color(o->use_color))
-			fputs(GIT_COLOR_REVERSE, file);
-		if (set_sign || set)
-			fputs(set_sign ? set_sign : set, file);
-		if (first && !nofirst)
-			fputc(first, file);
-		if (len) {
-			if (set_sign && set && set != set_sign)
-				fputs(reset, file);
-			if (set)
-				fputs(set, file);
-			fwrite(line, len, 1, file);
-		}
-		fputs(reset, file);
+	has_trailing_newline = (len > 0 && line[len-1] == '\n');
+	if (has_trailing_newline)
+		len--;
+
+	has_trailing_carriage_return = (len > 0 && line[len-1] == '\r');
+	if (has_trailing_carriage_return)
+		len--;
+
+	if (!len && !first)
+		goto end_of_line;
+
+	if (reverse && want_color(o->use_color)) {
+		fputs(GIT_COLOR_REVERSE, file);
+		needs_reset = 1;
+	}
+
+	if (set_sign || set) {
+		fputs(set_sign ? set_sign : set, file);
+		needs_reset = 1;
 	}
+
+	if (first)
+		fputc(first, file);
+
+	if (!len)
+		goto end_of_line;
+
+	if (set) {
+		if (set_sign && set != set_sign)
+			fputs(reset, file);
+		fputs(set, file);
+		needs_reset = 1;
+	}
+	fwrite(line, len, 1, file);
+	needs_reset |= len > 0;
+
+end_of_line:
+	if (needs_reset)
+		fputs(reset, file);
 	if (has_trailing_carriage_return)
 		fputc('\r', file);
 	if (has_trailing_newline)
@@ -626,7 +635,7 @@ static void emit_line_0(struct diff_options *o,
 static void emit_line(struct diff_options *o, const char *set, const char *reset,
 		      const char *line, int len)
 {
-	emit_line_0(o, set, NULL, reset, line[0], line+1, len-1);
+	emit_line_0(o, set, NULL, reset, 0, line, len);
 }
 
 enum diff_symbol {
-- 
2.18.0.132.g195c49a2227

