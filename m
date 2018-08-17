Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C53F1F954
	for <e@80x24.org>; Fri, 17 Aug 2018 20:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbeHQXtD (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 19:49:03 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:39504 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbeHQXtD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 19:49:03 -0400
Received: by mail-qt0-f202.google.com with SMTP id c6-v6so7374450qta.6
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 13:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=MlEiNOZ3/4a/zCNEQhRjstMM661t8iOslM+DrPetacA=;
        b=JaOx4lrWkUKVrcJjNGWx7X48wy6z+gyZrJNSioNv9YDOmfOjAzb3vsZtardL5+9V62
         p80TObzWcyAc/BzESzIyf7sGugxGLgRy4NPLZ0X6g1JdL0kPB3715lUvwd8kQN3yV+TA
         o2JTLAvLNBfNlkgOAfJ372SUXVeekYYnd9dQeAGiQvQutliCpY7YLLephHEHYl0ihrMc
         ED8t2MQrrsNxP+oJP7EA5bvP6C18COLtQ+zM7I70nm5jVrA6wHNT+M2p5mx1tDLpzFuJ
         CQm9+aSewLUq+ODOMoyIHQ82GZZYBCWIhLSLBZg59LZr7jZ502P8Alv+L91FiC+ijfxw
         3Dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=MlEiNOZ3/4a/zCNEQhRjstMM661t8iOslM+DrPetacA=;
        b=XD8L8wKVim3AN9i8mlPprMVDPi7sWqPGTsUWPtLnOoosLmqtBFhRorLtQJsTCSM3od
         m2lryeTKpu4VaemyqJRmHZlx2wdE2z2L9sQ3ETaTdnyKULQ/UstEMOcfTr5hEykLT7Y/
         zgCXqNN/TTFDEZi+uMkvcwjaecRw2Qqig59VygHJi+GT5gB6/9dq9Dfg4qjT/0IX/Ozx
         DLA6Syoq5DwlpUHHf3cShceUq1AXPArIyc9XjC0DlBh7brPVf1mm3urlIdZ3p8layFlT
         QHSlbaPy3diQAclwxqc0yM9dJxkgH4UNtUvh2L5hsszmhbYaHfFJOTkmhHtwrN63eE69
         7Q1g==
X-Gm-Message-State: AOUpUlFKR0EtuEWLpAFJx48p55YOd8jXPnpKV79q1YxRb0M/22ZXheHy
        tESjLlZ05NCYJ1n0PtLFOiLosbebSEii
X-Google-Smtp-Source: AA+uWPxWfp/M8qE24QB2+MosFVxn9JstWlS5V5Fy7VXC4kJ9qSE/3WSx8krBPkhJ1Zfjfrwg074Y7oGkvpXH
MIME-Version: 1.0
X-Received: by 2002:a37:640e:: with SMTP id y14-v6mr21769875qkb.51.1534538651569;
 Fri, 17 Aug 2018 13:44:11 -0700 (PDT)
Date:   Fri, 17 Aug 2018 13:43:53 -0700
In-Reply-To: <20180817204354.108625-1-sbeller@google.com>
Message-Id: <20180817204354.108625-3-sbeller@google.com>
References: <nycvar.QRO.7.76.6.1808161022180.71@tvgsbejvaqbjf.bet> <20180817204354.108625-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.265.g16de1b435c9.dirty
Subject: [PATCH 2/3] range-diff: make use of different output indicators
From:   Stefan Beller <sbeller@google.com>
To:     johannes.schindelin@gmx.de
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This change itself only changes the internal communication and should
have no visible effect to the user. We instruct the diff code that
produces the inner diffs to use other markers instead of the
usual markers for new, old and context lines.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 range-diff.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/range-diff.c b/range-diff.c
index b6b9abac266..a906d25f139 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -38,6 +38,14 @@ static int read_patches(const char *range, struct string_list *list)
 
 	argv_array_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
 			"--reverse", "--date-order", "--decorate=no",
+			/*
+			 * Choose indicators that are not used anywhere
+			 * else in diffs, but still look reasonable
+			 * (e.g. will not be confusing when debugging)
+			 */
+			"--output-indicator-new=>",
+			"--output-indicator-old=<",
+			"--output-indicator-context=#",
 			"--no-abbrev-commit", range,
 			NULL);
 	cp.out = -1;
@@ -108,8 +116,18 @@ static int read_patches(const char *range, struct string_list *list)
 			 * we are not interested.
 			 */
 			continue;
-		else
+		else if (line.buf[0] == '>') {
+			strbuf_addch(&buf, '+');
+			strbuf_add(&buf, line.buf + 1, line.len - 1);
+		} else if (line.buf[0] == '<') {
+			strbuf_addch(&buf, '-');
+			strbuf_add(&buf, line.buf + 1, line.len - 1);
+		} else if (line.buf[0] == '#') {
+			strbuf_addch(&buf, ' ');
+			strbuf_add(&buf, line.buf + 1, line.len - 1);
+		} else {
 			strbuf_addbuf(&buf, &line);
+		}
 
 		strbuf_addch(&buf, '\n');
 		util->diffsize++;
-- 
2.18.0.265.g16de1b435c9.dirty

