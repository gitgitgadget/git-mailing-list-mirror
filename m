Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A24F207D6
	for <e@80x24.org>; Wed,  3 May 2017 10:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752713AbdECKTm (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 06:19:42 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33274 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753371AbdECKTb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 06:19:31 -0400
Received: by mail-pg0-f65.google.com with SMTP id s62so16006543pgc.0
        for <git@vger.kernel.org>; Wed, 03 May 2017 03:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LAzIu1k1/sWrcwIlyhCKu8ap5tufTBNjwO1lmYwim+k=;
        b=bM0bRnuqRQ5/RYUSd5iWVQs1FNd+9TWBOJu5XtKRb4gCXlBPzo2TfTyTllMBbptWtH
         6d2Qu7UrFUqv8ArZY7eUvt+GoPG2Qi/om539SYmPBk3GfrzzITwf4mCDcbUCc5e4AxwB
         vIUFyhSuiwlB39CcF1cqSLaoIDoMk7wKJVy6Y3NqxsBngV2LBXYFRj+I4WAgxcTLpw/A
         zw96qR+Gt8HpNlnCy5gAaxi6I95luCd2/WEsh28OKQr6zBmQoAQVBLV6MFxmJ4nKrfbk
         OXUY94HWmEco48MjW26GchJKbb3vJLpVxyDPjrPiBWo7J2pY2Z1ftWWf+lStC79vv1S8
         5Xbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LAzIu1k1/sWrcwIlyhCKu8ap5tufTBNjwO1lmYwim+k=;
        b=I07V7vSa57pQ1vcySU+bwSHCu8f8EVFFygGP28Eo6tJROgRJWHqdBrr4ir1Fxt7YXH
         p+zUNzneJ28AWWfRJUTLjywzHPpHvXmk1I1iJqF9c/gaX5GNY1oHT18Ijxo1WuV0r9IU
         eCRxTN0azoQ01dcWMI5f24Lhz4J3noYqiq6cM4lRJtuHiGDqfzIoJCT6rDLPyLE1NPQJ
         JTkY/CoMs4g5o4+2+aU22hugcfhPLf+JpPFIHFsuzYByX1N6a7K4bRhIiT/RcoLSsoCS
         B2Kd8rbWivgNAaBw0y5r8ipYru0147Q4DeM6xa7g4bc/96hqhfNXC6YOl/d9MspAW7+k
         Uufg==
X-Gm-Message-State: AN3rC/7rRRCSpxjjiI1H2o+Bid2MmtXwvfnBpnBuU3woyrleTny0vkNV
        2LCDT4x4t2tc5g==
X-Received: by 10.98.43.13 with SMTP id r13mr3987379pfr.32.1493806770901;
        Wed, 03 May 2017 03:19:30 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id t71sm3944737pfk.29.2017.05.03.03.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2017 03:19:30 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 May 2017 17:19:25 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 16/21] sequencer.c: report error on failure to fopen()
Date:   Wed,  3 May 2017 17:17:01 +0700
Message-Id: <20170503101706.9223-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170503101706.9223-1-pclouds@gmail.com>
References: <20170420112609.26089-1-pclouds@gmail.com>
 <20170503101706.9223-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sequencer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 10c3b4ff81..11b5c7c114 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -897,8 +897,8 @@ static void flush_rewritten_pending(void) {
 	FILE *out;
 
 	if (strbuf_read_file(&buf, rebase_path_rewritten_pending(), 82) > 0 &&
-			!get_sha1("HEAD", newsha1) &&
-			(out = fopen(rebase_path_rewritten_list(), "a"))) {
+	    !get_sha1("HEAD", newsha1) &&
+	    (out = fopen_or_warn(rebase_path_rewritten_list(), "a"))) {
 		char *bol = buf.buf, *eol;
 
 		while (*bol) {
@@ -917,7 +917,7 @@ static void flush_rewritten_pending(void) {
 
 static void record_in_rewritten(struct object_id *oid,
 		enum todo_command next_command) {
-	FILE *out = fopen(rebase_path_rewritten_pending(), "a");
+	FILE *out = fopen_or_warn(rebase_path_rewritten_pending(), "a");
 
 	if (!out)
 		return;
@@ -1378,7 +1378,7 @@ static int read_populate_todo(struct todo_list *todo_list,
 
 	if (is_rebase_i(opts)) {
 		struct todo_list done = TODO_LIST_INIT;
-		FILE *f = fopen(rebase_path_msgtotal(), "w");
+		FILE *f = fopen_or_warn(rebase_path_msgtotal(), "w");
 
 		if (strbuf_read_file(&done.buf, rebase_path_done(), 0) > 0 &&
 				!parse_insn_buffer(done.buf.buf, &done))
-- 
2.11.0.157.gd943d85

