Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABA2C433E1
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 07:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54A1A206D7
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 07:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTMsd6cy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgFNHcO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 03:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgFNHcL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 03:32:11 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5968CC08C5C2
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 00:32:11 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g18so10301254qtu.13
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 00:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cuuS2VbbmMZgf2gaGaZb42YW0V0128E7H8J6E7hMw5I=;
        b=FTMsd6cyuCvNPuNm1HrKSOqpbNwOWk2a8F5xaLIg3o+sI20gwTjg/qewobA56XZ0qd
         PS313HZE53HPm0/s/Z+FQpTQwiF3+Vd7/oeMmo7rtISLsQjPmzq8ZZ47jGZEz/bBrZ62
         /A5l82S23IT1VvWPIpX2WrdBivvj5+rWzKDNRUMuS56HOrkkqLUBAjPHY0bMS520Z0Pm
         TipJQxPKFfBhfH4jBRlcpMts+F+b7sQdcWrHtYNiG2zOXqUYDOIl51/2oUYU/HDvNq4F
         3PJd4qwwJTekbEejF9MPvrd2sLKth/RNd51DFr77b6fjdbjdWDKUkUDx6h6zabj8r/s/
         s4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cuuS2VbbmMZgf2gaGaZb42YW0V0128E7H8J6E7hMw5I=;
        b=THtkSOTQGqf3v0H82EF1+0v3Igz05GHYUcP28IG7t2p8BWpAo+arGSOqpQZ0RtlJZb
         /bMq0aAhXw9npNapnlSu+2qFfoD10QxoKl31JcIIcyPERCOe4HH71ytgvXbwxJ2TiQCN
         5jRUMGo5+6xYEDl2aTNFauI67h51txtPWlr8+9XLMZWrte6GBAcW2vTwOiJEkQXVD4/o
         XNZV1+UKo6ZQcopKs463IckCUNfHihBzGNVF5pDH6ifq/fDYe4xsqfbzbMvOtDhWp1eT
         UiybxjiKQ8fpiLCnU2WtL3u3JyV869xG4y1qdBD8t4zuniMy+w/yWLYePfr89dEg9m7m
         N2JA==
X-Gm-Message-State: AOAM533YLDaB6wvvGoQKo9dOGzD3HR4oJMyUCMk+lSUqScN2LW727434
        7FFIRly10E6/hX+ge2QR2td5NgSOGG8=
X-Google-Smtp-Source: ABdhPJzrferBNQ10COt44cQMlTw3Z/woC927qkq+lRfWcXzez7LTN8qrQ0G7j7ixakoaFc0Yu5jO5w==
X-Received: by 2002:ac8:3a06:: with SMTP id w6mr10412269qte.199.1592119930424;
        Sun, 14 Jun 2020 00:32:10 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id a82sm8834341qkb.29.2020.06.14.00.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 00:32:10 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 2/3] pkt-line: use string versions of functions
Date:   Sun, 14 Jun 2020 03:31:59 -0400
Message-Id: <d1b79c7734f0609fcac5e523644c3093f538bccf.1592119902.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.132.g321788e831
In-Reply-To: <cover.1592119902.git.liu.denton@gmail.com>
References: <7e803a2ba9458ce35c657e67323edfe4409205ec.1592055716.git.liu.denton@gmail.com> <cover.1592119902.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have many cases where we are writing a control packet as a string
constant out and we need to specify the length of the string. Currently,
the length is specified as a magical `4` literal.

Change these instances to use a function that calls strlen() to
determine the length of the string removing the need to specify the
length at all. Since these functions are inline, the strlen()s should be
replaced with constants at compile-time so this should not result in any
performance penalty.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 pkt-line.c | 46 ++++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 8f9bc68ee2..72c6c29e03 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -81,49 +81,59 @@ static void packet_trace(const char *buf, unsigned int len, int write)
 	strbuf_release(&out);
 }
 
+static inline void packet_trace_str(const char *buf, int write)
+{
+	packet_trace(buf, strlen(buf), write);
+}
+
+static inline void control_packet_write(int fd, const char *s, const char *type)
+{
+	packet_trace_str(s, 1);
+	if (write_str_in_full(fd, s) < 0)
+		die_errno(_("unable to write %s packet"), type);
+}
+
 /*
  * If we buffered things up above (we don't, but we should),
  * we'd flush it here
  */
 void packet_flush(int fd)
 {
-	packet_trace("0000", 4, 1);
-	if (write_in_full(fd, "0000", 4) < 0)
-		die_errno(_("unable to write flush packet"));
+	control_packet_write(fd, "0000", "flush");
 }
 
 void packet_delim(int fd)
 {
-	packet_trace("0001", 4, 1);
-	if (write_in_full(fd, "0001", 4) < 0)
-		die_errno(_("unable to write delim packet"));
+	control_packet_write(fd, "0001", "delim");
 }
 
 void packet_response_end(int fd)
 {
-	packet_trace("0002", 4, 1);
-	if (write_in_full(fd, "0002", 4) < 0)
-		die_errno(_("unable to write stateless separator packet"));
+	control_packet_write(fd, "0002", "stateless separator");
 }
 
 int packet_flush_gently(int fd)
 {
-	packet_trace("0000", 4, 1);
-	if (write_in_full(fd, "0000", 4) < 0)
+	packet_trace_str("0000", 1);
+	if (write_str_in_full(fd, "0000") < 0)
 		return error(_("flush packet write failed"));
 	return 0;
 }
 
+static inline void control_packet_buf_write(struct strbuf *buf, const char *s)
+{
+	packet_trace_str(s, 1);
+	strbuf_addstr(buf, s);
+}
+
 void packet_buf_flush(struct strbuf *buf)
 {
-	packet_trace("0000", 4, 1);
-	strbuf_add(buf, "0000", 4);
+	control_packet_buf_write(buf, "0000");
 }
 
 void packet_buf_delim(struct strbuf *buf)
 {
-	packet_trace("0001", 4, 1);
-	strbuf_add(buf, "0001", 4);
+	control_packet_buf_write(buf, "0001");
 }
 
 void set_packet_header(char *buf, int size)
@@ -337,15 +347,15 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 	if (len < 0) {
 		die(_("protocol error: bad line length character: %.4s"), linelen);
 	} else if (!len) {
-		packet_trace("0000", 4, 0);
+		packet_trace_str("0000", 0);
 		*pktlen = 0;
 		return PACKET_READ_FLUSH;
 	} else if (len == 1) {
-		packet_trace("0001", 4, 0);
+		packet_trace_str("0001", 0);
 		*pktlen = 0;
 		return PACKET_READ_DELIM;
 	} else if (len == 2) {
-		packet_trace("0002", 4, 0);
+		packet_trace_str("0002", 0);
 		*pktlen = 0;
 		return PACKET_READ_RESPONSE_END;
 	} else if (len < 4) {
-- 
2.27.0.132.g321788e831

