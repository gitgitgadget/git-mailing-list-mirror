Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA02DC433E1
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88AF920774
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tfGm+RfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733153AbgFWRzw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733082AbgFWRzv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 13:55:51 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499E9C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:55:51 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id j10so7482400qtq.11
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M6uWLlokDu6jnAAFUesEpZHX0r0JBcEkr1D2A2GQ7yk=;
        b=tfGm+RfZgoDrecn2+RfX6XuO/VSCSLPpCuNI7jvX53nIle5RStj9ROfusJWQ8vbX0k
         2knAs6NYyeCguO44nSJzKQKnwySgwQpe/+PeVcjFuCvqokGJYXRlSTZwSDPf/dfP1LLF
         rQrNHdGC1RJtn5b+dVCVKIkXzUVN3gNS5OlRXxlwXbwipzX0wb40/lYPA10CqxjUYJIY
         MK4zlJ+LU0ui8270Hew6H51VVPij7tJy+0TqvGdy20QuU62y/k5QXopmdGwJPzdupvau
         sLoesGVgaRKC5Vc8cPW6JcWFx4PGaCRmZtFcBeLMxj/q7KQtWv6rBVn4kfS+rJlQYIlB
         i+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M6uWLlokDu6jnAAFUesEpZHX0r0JBcEkr1D2A2GQ7yk=;
        b=AS30dJ+IDIHdfxj1dXig2jl17felaoKvGRoC+QXoSc/cJZcEtlggXeQK0lg+Ky5YCa
         cS68FPOkLmtdw4Fkns4ELPr6rxdXJmL6FcPyJXzpOKAzv07vB+vLcNjnBkW7FUKpCn2g
         0PDq+o3Dy5yDc7vm18y2bX8GOOMdeIDmbIqRicqiAWzB7axq6yUlHFZkO6MPEWFz1nLJ
         5iJ/lyIpXnH6TcGwNBtZk2rM1dDKtSe5oX//WybwbyHteJirGyRr3/px4fubti1aCeUa
         bM9zaAXu/Jp+8tO3rfXyVIKcKx68whfQvFBDwvyYc4x7cK2iORT/7sVibzMb/HiF1BxW
         ZoWA==
X-Gm-Message-State: AOAM5338m4okJkgg4h5PtDz4ylRatj7Ctj8ncoJt0BjFPEQJ8qXW/OkR
        fmHlp73V/vkhBirPxwg/4RTYlI0ey6E=
X-Google-Smtp-Source: ABdhPJzGlL9VQDp9gZivopI/EDumhOTw4WwcFZBAlmjctdpC6bSjIvu66mbob5C9RLKBOvNPZH5RTw==
X-Received: by 2002:ac8:4342:: with SMTP id a2mr22597625qtn.88.1592934949660;
        Tue, 23 Jun 2020 10:55:49 -0700 (PDT)
Received: from archbookpro.phub.net.cable.rogers.com (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id l2sm1380920qtc.80.2020.06.23.10.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 10:55:49 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/3] pkt-line: use string versions of functions
Date:   Tue, 23 Jun 2020 13:55:33 -0400
Message-Id: <d283a1b514c46ed75d88918f136ca0a6f4b90adc.1592934880.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.307.g7979e895e7
In-Reply-To: <cover.1592934880.git.liu.denton@gmail.com>
References: <cover.1592119902.git.liu.denton@gmail.com> <cover.1592934880.git.liu.denton@gmail.com>
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

Notes:
    Junio, you mentioned in an earlier email[0] that write_str_in_full() and
    strbuf_addstr() each count the string length at runtime. However, I
    don't think that's true since they're both inline functions and
    strbuf_addstr() has the following comment:
    
    	/**
    	 * Add a NUL-terminated string to the buffer.
    	 *
    	 * NOTE: This function will *always* be implemented as an inline or a macro
    	 * using strlen, meaning that this is efficient to write things like:
    	 *
    	 *     strbuf_addstr(sb, "immediate string");
    	 *
    	 */
    
    so I believe that the lengths should be determined at compile-time.
    
    [0]: https://lore.kernel.org/git/xmqqeeqhxred.fsf@gitster.c.googlers.com/

 pkt-line.c | 48 ++++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 8f9bc68ee2..e29f427b19 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -81,49 +81,61 @@ static void packet_trace(const char *buf, unsigned int len, int write)
 	strbuf_release(&out);
 }
 
+static inline void packet_trace_str(const char *buf, int write)
+{
+	packet_trace(buf, strlen(buf), write);
+}
+
+#define control_packet_write(fd, s, errstr) \
+	do { \
+		(void)s"is a string constant"; \
+		packet_trace_str(s, 1); \
+		if (write_str_in_full((fd), s) < 0) \
+			die_errno((errstr)); \
+	} while (0)
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
+	control_packet_write(fd, "0000", _("unable to write flush packet"));
 }
 
 void packet_delim(int fd)
 {
-	packet_trace("0001", 4, 1);
-	if (write_in_full(fd, "0001", 4) < 0)
-		die_errno(_("unable to write delim packet"));
+	control_packet_write(fd, "0001", _("unable to write delim packet"));
 }
 
 void packet_response_end(int fd)
 {
-	packet_trace("0002", 4, 1);
-	if (write_in_full(fd, "0002", 4) < 0)
-		die_errno(_("unable to write stateless separator packet"));
+	control_packet_write(fd, "0002", _("unable to write stateless separator packet"));
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
 
+#define control_packet_buf_write(buf, s) \
+	do { \
+		(void)s"is a string constant"; \
+		packet_trace_str(s, 1); \
+		strbuf_addstr((buf), s); \
+	} while (0)
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
@@ -337,15 +349,15 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
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
2.27.0.307.g7979e895e7

