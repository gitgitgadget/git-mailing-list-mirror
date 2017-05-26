Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76345209FD
	for <e@80x24.org>; Fri, 26 May 2017 03:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946836AbdEZDff (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 23:35:35 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33398 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946804AbdEZDfY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 23:35:24 -0400
Received: by mail-pf0-f181.google.com with SMTP id e193so185093345pfh.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 20:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f7BqDVsf+GeKlwN1J7e/uzUMAL816EjOS2PePm4bNR8=;
        b=SYX6pC1paJnzxFdAPWwXgtJ3FuLmqaaVbURCkRYh76f1wm4u1NaIhtIo4lpSHYBp5A
         l1yJK2HmYqq265PfoN/Xa/JMB4+BniPbbPzkOxRt4C/tTPzv6Arl5PdsLiH/Rx0ksNss
         UXfLvXPYh9WlhzpirLtAgwBMRDHn2HTBtfpg7bh1caNdlBQvDlQz4OLkR2Rg+lbH7cFf
         KziMkytxBnvtlOWtMU8zM2J3Ho2zyZWGZr+H066fptEGs+j3u16d9fP/6hXAlzM4r5AM
         ORG3zVTvfP2lDIiEkwyxoI48y/xwA8yhkrr6NrPaO/RslsKTpCxYwe6mRlRnacdUIhL+
         cOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=f7BqDVsf+GeKlwN1J7e/uzUMAL816EjOS2PePm4bNR8=;
        b=SNh7ttaIiqCSuF5EhHmIrgs83pGj/mG/VPqRSGrPIKXaVLcbANHisX5Pj6VF7XGP1M
         UiVcgyAT823/cbuoeJjqkQRQOXcay9J06v+RrY92/IoVHVvjZVf9yOE2YaSj4iReY3S2
         8Ro0WO3Bl7jxvI4fzrw+oeVkIpN2lXqTKvKXZsYxnqHlxaJln3VjR8SPdlLCdBPAjHw8
         XHRP40eLqA8pvrUrLZvtmFYUtLLZfBWd8WdxRz6XluYzsDUzqJiTCkD6EN9V9q4aex5o
         tuU5EvTGdKEmMvsekx/xwXH72kfj/sH+piQ6LPhcSU7UHHX0f/wFpknrTQcZ5q7Buru+
         GkeA==
X-Gm-Message-State: AODbwcBaWb5Gran7gJJtAaFZ/rIve15vbTEk2zZ2iUTpsKmtiAAme4E4
        oiYJyYiLorKZQQ==
X-Received: by 10.84.137.165 with SMTP id 34mr1525977pln.167.1495769723442;
        Thu, 25 May 2017 20:35:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:546a:ce73:1719:5041])
        by smtp.gmail.com with ESMTPSA id p13sm17821298pfl.52.2017.05.25.20.35.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 May 2017 20:35:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 09/13] print errno when reporting a system call error
Date:   Fri, 26 May 2017 12:35:06 +0900
Message-Id: <20170526033510.1793-10-gitster@pobox.com>
X-Mailer: git-send-email 2.13.0-491-g71cfeddc25
In-Reply-To: <20170526033510.1793-1-gitster@pobox.com>
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
 <20170526033510.1793-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c     | 3 ++-
 rerere.c          | 4 ++--
 xdiff-interface.c | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index b3b10cc1ed..26d6a3cf14 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -858,7 +858,8 @@ static int open_next_file(struct commit *commit, const char *subject,
 		printf("%s\n", filename.buf + outdir_offset);
 
 	if ((rev->diffopt.file = fopen(filename.buf, "w")) == NULL)
-		return error(_("Cannot open patch file %s"), filename.buf);
+		return error_errno(_("Cannot open patch file %s"),
+				   filename.buf);
 
 	strbuf_release(&filename);
 	return 0;
diff --git a/rerere.c b/rerere.c
index 971bfedfb2..1351b0c3fb 100644
--- a/rerere.c
+++ b/rerere.c
@@ -484,13 +484,13 @@ static int handle_file(const char *path, unsigned char *sha1, const char *output
 	io.input = fopen(path, "r");
 	io.io.wrerror = 0;
 	if (!io.input)
-		return error("Could not open %s", path);
+		return error_errno("Could not open %s", path);
 
 	if (output) {
 		io.io.output = fopen(output, "w");
 		if (!io.io.output) {
 			fclose(io.input);
-			return error("Could not write %s", output);
+			return error_errno("Could not write %s", output);
 		}
 	}
 
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 060038c2d6..d3f78ca2a7 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -164,9 +164,9 @@ int read_mmfile(mmfile_t *ptr, const char *filename)
 	size_t sz;
 
 	if (stat(filename, &st))
-		return error("Could not stat %s", filename);
+		return error_errno("Could not stat %s", filename);
 	if ((f = fopen(filename, "rb")) == NULL)
-		return error("Could not open %s", filename);
+		return error_errno("Could not open %s", filename);
 	sz = xsize_t(st.st_size);
 	ptr->ptr = xmalloc(sz ? sz : 1);
 	if (sz && fread(ptr->ptr, sz, 1, f) != 1) {
-- 
2.13.0-491-g71cfeddc25

