Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2070F20984
	for <e@80x24.org>; Sun, 11 Sep 2016 05:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755398AbcIKFmf (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 01:42:35 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34446 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755386AbcIKFmd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 01:42:33 -0400
Received: by mail-pf0-f196.google.com with SMTP id g202so6283048pfb.1
        for <git@vger.kernel.org>; Sat, 10 Sep 2016 22:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sVwguNuvbqhgAIv6+0yLktEso0sh6KrX2Dv+h2Gid0M=;
        b=qTukMyKnNua4VhlAHf4UIBRO9xfoua+WxPXapZ5kstmRZhPmGt4GGkhw0GBiy90I27
         USvHagII6Oj1qCZZqVEjr6Otoi7+HimYhEvig3GPmrJYZz5KeJCA/cAmZP3xkKu8W4Ny
         YL0vI5Ej44t1bvbEgs9Pgj0NDO6iULtG5YEcrrTP1C5Z4Itjun1n9fT434eei6FWqZwJ
         dmZWJawUpw1bsPv6PrRdsKafOlrf/vezlBccDpykQPcsUM1vscgLkq4WiWE4brKJ/mji
         Xy9+Q83dmUp7I7NSsyHDAeObtgqdu/G7kQJvpVIDHP46ctmDpiGc0MllXatz11DVvGbS
         tW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sVwguNuvbqhgAIv6+0yLktEso0sh6KrX2Dv+h2Gid0M=;
        b=Bqjhg+Zu3oKjBYXTybTNnzZg0rCTK+ND9a0WC9IS14dZdEhCctXe3DIrdk97EvGao8
         9i7cQtmmky79KwqiiBZkDVWxLmI3kmxdNc6TBzbXNl9Ei2TeDe3QgvEPlokUc88+6W2j
         ad9+XoW9EYA+OOmacNanyW471RynPGB1S8AooODZSNfqI5nverRYBtnWlU7ExRoSpCQ3
         p0t+pEoJ5396/VLDvHjgUdEDDAyyUCLLnDlK8DvFHdDtHOmpmvYFO19dxQRqKrK/2v7w
         NnQpMduxq5GYOZeXD5vwCRiX9bi/Tu7O5kjEE9E8vJYeQoWxu/0EdNBv/XcWu+FoJ9ss
         BZMA==
X-Gm-Message-State: AE9vXwNZuuRSTXQG8tIwlaTMHt93JgZtpdURWOLDODwmVJC0DDR4VhyHxCyLnv0u/vh28Q==
X-Received: by 10.98.79.27 with SMTP id d27mr21831718pfb.127.1473572552676;
        Sat, 10 Sep 2016 22:42:32 -0700 (PDT)
Received: from localhost (c-67-188-214-183.hsd1.ca.comcast.net. [67.188.214.183])
        by smtp.gmail.com with ESMTPSA id bv6sm15483926pab.46.2016.09.10.22.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Sep 2016 22:42:32 -0700 (PDT)
From:   Stefan Beller <stefanbeller@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 01/10] diff: move line ending check into emit_hunk_header
Date:   Sat, 10 Sep 2016 22:42:01 -0700
Message-Id: <1473572530-25764-2-git-send-email-stefanbeller@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
References: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index cc8e812..aa50b2d 100644
--- a/diff.c
+++ b/diff.c
@@ -610,6 +610,9 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	}
 
 	strbuf_add(&msgbuf, line + len, org_len - len);
+	if (line[org_len - 1] != '\n')
+		strbuf_addch(&msgbuf, '\n');
+
 	emit_line(ecbdata->opt, "", "", msgbuf.buf, msgbuf.len);
 	strbuf_release(&msgbuf);
 }
@@ -1247,8 +1250,6 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		len = sane_truncate_line(ecbdata, line, len);
 		find_lno(line, ecbdata);
 		emit_hunk_header(ecbdata, line, len);
-		if (line[len-1] != '\n')
-			putc('\n', o->file);
 		return;
 	}
 
-- 
2.7.4

