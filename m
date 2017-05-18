Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E833201CF
	for <e@80x24.org>; Thu, 18 May 2017 19:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757682AbdERTiG (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 15:38:06 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33322 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752437AbdERTh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 15:37:58 -0400
Received: by mail-pf0-f170.google.com with SMTP id e193so28545973pfh.0
        for <git@vger.kernel.org>; Thu, 18 May 2017 12:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6yE6gfxhG7Q+J9s4hnHoyIn9Xbe+QCu46jSFl7wEoHw=;
        b=f8Rn85XJ2D27aQxJajqAQ5qd28uHzSI3CQfDttt4w4x2hOneHx2CImduhGlmQ/lKSJ
         +ayfpisJTuo2uCHpCpOWuAJRh4xwTrd4ByCasw/5c8h56xjMv/KJ1vtacnww1V4m7SRy
         m5Zg3PeqanORMiAUhF63M5jb/SHmD4B+ywmFEqxMJQTLmM/0TQyxb/U4E/Wj1yI6/gbJ
         C85LKBr0kjqO4Ty9XYw6j+gwM3vPvfDY5NvF/W3QCpWfohiRlKSpwt06AqyxtsCnuzhg
         u1lm9i/GDLeV5rlEpuFEyxGC66ggF2hmocd7uIg9pmde+jOCc6HiO86sKqW4ZdkaL7Ob
         1Nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6yE6gfxhG7Q+J9s4hnHoyIn9Xbe+QCu46jSFl7wEoHw=;
        b=U/hrkO6DjZsopXvYwaPx3AQ1dT5s6900Kp0v66KHZOnpMT6uBiZcMkrNiXgnm9bVWo
         FTMnMfBXiQ+0D0AmeyLIyYN/wSuwMoRSqD6r1pMfHplPkKTGrhu4NdqI+XeOEFD/kna/
         jAg6IukotYCRBJONgQjPTPZc8z8/W43n/tNwVxa3Ip5qi/z+PlnB0wYPJyVJlBOUxGzU
         VkNqtZ7AUn+iQifpipzy+rFWwz6KqZOpnxhIn/knGfPXxtppDYEjpPJXn3QHqqhFsGYz
         vPfnl0Yzg7pXisbnMubwpcpE1O0XkNwuVDmpwQEHfs5OwvOSG/WzYLiJ81LaP0oouXtm
         MgNw==
X-Gm-Message-State: AODbwcAr0daLA3FQTZQk9euP9VZxtJiDPaiKADEl8prKbDwa07OYQroB
        g54QUlDqH4GfY/EIfS8FXA==
X-Received: by 10.99.125.67 with SMTP id m3mr6205954pgn.153.1495136277599;
        Thu, 18 May 2017 12:37:57 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:7013:588c:5765:703d])
        by smtp.gmail.com with ESMTPSA id o76sm13439160pfi.119.2017.05.18.12.37.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 May 2017 12:37:56 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net
Subject: [PATCHv3 02/20] diff: move line ending check into emit_hunk_header
Date:   Thu, 18 May 2017 12:37:28 -0700
Message-Id: <20170518193746.486-3-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170518193746.486-1-sbeller@google.com>
References: <20170517025857.32320-1-sbeller@google.com>
 <20170518193746.486-1-sbeller@google.com>
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

