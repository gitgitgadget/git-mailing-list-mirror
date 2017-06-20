Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 397731FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 02:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751088AbdFTCsa (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:48:30 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34229 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbdFTCs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:48:28 -0400
Received: by mail-pg0-f47.google.com with SMTP id e187so4226952pgc.1
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w0jvwr6CIYYUYZwrunGDCdyjbHZGs9MYjKodHKIEnWQ=;
        b=sSWtzspb5iIJISxVy1907Sc6SzRmv8dg3EqSCpWiRT+fEcQToz9fcLbgSZYJPzM4Sn
         fEvbbRlymJYf0a67PQCOsuy15LajyjYYDrZFy1Vw31DTS2veF/OWEEAD/MrnUrGT0zcM
         VpokEro91ed8+3CTQmE+KkgpcZMSDNjkZpOvkpV+gZfPaDkSTZQRJJlrM6rVklOslhGU
         9VJQzMSpLBlpGAS8CL/eYswIvhB/IL6MtazXTbkAdlBE77LNMR9tWCkB0rPVC78g1xJz
         8LWSZULESyM7XVB4UyOZz5uM0c3CIIeZCpd5nY8Y9Czi7eMmPlujKmrIgZsV3DlEPJkn
         OYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w0jvwr6CIYYUYZwrunGDCdyjbHZGs9MYjKodHKIEnWQ=;
        b=leNgRVf8vHFKjO8NmQZiGrMQWBJ47i3bWdz3ZEQh13GT8aqVmHXs3Qxwh5vaOinhSI
         CT2OQX8Lt+VsAwM1BLzEaevIWiCiluvSOvWZQrsNaZgZO2EBKKhwpmQXOjEy4NZj9E68
         efpMe6hYLwh1OYRHC4MZCWsojCJfjVN2gKbBVTTnFA/xYoQq4TFqGlXgcrfKmFMePTfW
         MPu99s4hyoh26DiCn07eLwqe+gNfAcGApWX54OeXCXjYTjdivMXQA+K+17hDVw5ITKUu
         GqQbz+Y+wSNrPErm8gliP/CZqEXEEP3j2kYdu1YvE4pf/buRtWBjvo7MbGHCKTmmkSh1
         mF0g==
X-Gm-Message-State: AKS2vOwXk+fOyNNTL8SHBB6sbnz0ZvpRydOFPsNmN6LvmtOu0vwXeRED
        fFZ6XoVLv6H6CSfLoqXw1Q==
X-Received: by 10.99.61.74 with SMTP id k71mr9938356pga.57.1497926907709;
        Mon, 19 Jun 2017 19:48:27 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:bc0c:b118:3a9a:5fd4])
        by smtp.gmail.com with ESMTPSA id y8sm25999123pge.0.2017.06.19.19.48.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 19:48:27 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCH 02/26] diff.c: move line ending check into emit_hunk_header
Date:   Mon, 19 Jun 2017 19:47:52 -0700
Message-Id: <20170620024816.20021-3-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170620024816.20021-1-sbeller@google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.12.2.575.gb14f27f917

