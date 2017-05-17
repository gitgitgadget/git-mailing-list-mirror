Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A97142023D
	for <e@80x24.org>; Wed, 17 May 2017 02:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbdEQC7L (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 22:59:11 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36745 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751704AbdEQC7H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 22:59:07 -0400
Received: by mail-pf0-f175.google.com with SMTP id m17so89824034pfg.3
        for <git@vger.kernel.org>; Tue, 16 May 2017 19:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6yE6gfxhG7Q+J9s4hnHoyIn9Xbe+QCu46jSFl7wEoHw=;
        b=OssAHayojM18vByRHD2kFCDSVNjUzV9J9SQC7nZ8dYdUIJ2zrNP0kn1y2kW/qm5zSL
         gInUYVgzkTWmTA2aiYbNv0BhvejjSijxXNl//7hdvAe5sewEs0TtfRynvt1HHS+SvKHN
         syf2K1luxPocgzilAPM5a8CMNzmVdppfkJ/PHbnMxkjxVuuJVUwKO1Ex3rUEoMdnoSGb
         hX1U4p/fAfd2qUwOBTSWGGET5pjbcQxuORHPf1iNxtc9hnmyCpRdj2cb0I7OVl+NVqHt
         MwQF791mAe+DQJiD3WnMEOXJ4GJEd9HgNQaIROOzQykglzEq160YPTr2c2ASWunInMFw
         uZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6yE6gfxhG7Q+J9s4hnHoyIn9Xbe+QCu46jSFl7wEoHw=;
        b=WJ6/pFbZJBmXwwWHUJpiIKkdZLNzqkEPmzAVbSai6qYHWAmqJKyymZ3+3Expk+TX1E
         SYOss4gf1EVYBVzDyI6AAheWPvAlFd24wEw7etbbcrcHInI9sB22ZEQ3zu0/irCrRUDJ
         rb8mcgwwlBo+Xr5yy+sOraLNq8g+JiNOIo1AmWd4uuU/RqX+1O8wVH0wdaPalhHficaD
         5x4HU6nbrkMzOCbasns7z65t/XSvrmxW+nWKT6i0E2jXNtfi7Gjzsx8I2FAaNiWybp0T
         a6ihLUhqoIG9m0/kAzuW3LbtPH5JAEX/TS0h2EQgTbSCIwLYsToWTtk5uQ/WIve47+kt
         bl+Q==
X-Gm-Message-State: AODbwcA8thS8fc4qKKgGWIY98np9weQysTpUK/26ul14H8hIn5PSLcxt
        LyFch5wi9x4mB0tc
X-Received: by 10.99.112.68 with SMTP id a4mr1303487pgn.198.1494989946473;
        Tue, 16 May 2017 19:59:06 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:b4bc:dafd:125e:c48a])
        by smtp.gmail.com with ESMTPSA id a3sm672251pfc.26.2017.05.16.19.59.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 19:59:05 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, gitster@pobox.com, jonathantanmy@google.com,
        bmwill@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 02/20] diff: move line ending check into emit_hunk_header
Date:   Tue, 16 May 2017 19:58:39 -0700
Message-Id: <20170517025857.32320-3-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170517025857.32320-1-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
 <20170517025857.32320-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The emit_hunk_header() function is responsible for assembling a
hunk header and calling emit_line() to send the hunk header
to the output file.  Its only caller fn_out_consume() needs
to prepare for a case where the function emits an incomplete
line and add the terminating LF.

Instead make sure emit_hunk_header() to always send a
completed line to emit_line().

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 3f5bf8b5a4..c2ed605cd0 100644
--- a/diff.c
+++ b/diff.c
@@ -677,6 +677,8 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	}
 
 	strbuf_add(&msgbuf, line + len, org_len - len);
+	strbuf_complete_line(&msgbuf);
+
 	emit_line(ecbdata->opt, "", "", msgbuf.buf, msgbuf.len);
 	strbuf_release(&msgbuf);
 }
@@ -1315,8 +1317,6 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		len = sane_truncate_line(ecbdata, line, len);
 		find_lno(line, ecbdata);
 		emit_hunk_header(ecbdata, line, len);
-		if (line[len-1] != '\n')
-			putc('\n', o->file);
 		return;
 	}
 
-- 
2.13.0.18.g7d86cc8ba0

