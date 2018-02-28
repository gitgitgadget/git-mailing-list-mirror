Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A79E1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965040AbeB1XYo (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:24:44 -0500
Received: from mail-yw0-f202.google.com ([209.85.161.202]:57092 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964929AbeB1XYd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:24:33 -0500
Received: by mail-yw0-f202.google.com with SMTP id i1so2346176ywm.23
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=WVvlVMKBcAFt1YLqCMrzRxb3prg374m3xU1qgGVo+b0=;
        b=E1VotrqPOpyJwzyzyGFgjDdMb7uUn11fENisKPBXlKnt/WbFMEHO69PAUzZKF29NGM
         rP0Mik56p+7UPAguQ30f7+wPZHf9gd05ozZ7gZa4XQBmSEwhAcAy/8HXJqQyj+u3qPc9
         62xVztPIL58pkoignFutY0Tox8pl58OhUQVP1Ngvsg4CXJJm4nA63JG7YtgZwk3dnb6H
         fpmoBbQ8cCpIpFKoxXu5WLgTP3nA/AsKaD40UOvAk8qyk6bhnvvPfspmpYjhCT4C0p1x
         tdsaZbRy8w0/nSfgfzgDOYZpSoPIc5gVBz/itcXtihupjiGelSiWvRIsiCVoTscOMLTL
         aYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=WVvlVMKBcAFt1YLqCMrzRxb3prg374m3xU1qgGVo+b0=;
        b=ii2p9cF18G5XY03PVr0eFQZuzh7XBRDLvSAXiXINS5uxLBhxJt0WZSIsy4eCPR3QYY
         k5Vbx8HGbqhsYLUJSKvpsZIYtCv5OBeJRA+VNx8RXo2fOmVvNhfFDSHwPNPja4TM5O8u
         H+500s0dzAyuo/m8YRwNyHPWjuswRqeSO8SpJ9ng6RJcfTjA/bhLMxW821kOIfYmZVTC
         3mULFa4uzh/5RkBbH9TUgyApOT17XF67TXRblxuA/3cg95EvwYAGJUcWk3Ylu85tthXw
         figz8QxWyp6L5oIAWd7keb9O8bNh2r7OU785boxuKBRKVdz2pA8BCUfyfzF19WyW5XIs
         zCAA==
X-Gm-Message-State: APf1xPC5XWVsKaomVJp4qH935yQN4R2FpEA7ge65/s3O72Hnex9UnuQh
        hzO2Ild5lNnFhJXKD5mBtdx8AZspxdAJXaG92YKVAbLD/n2HQbs3yIkt2h/8BhkVD9aUvZbqFjW
        MsWG82Ry6MhewUBUWmLMp5tUIJVWWKL60koV2A+PfT0OLzVkw75Gyi10MuQ==
X-Google-Smtp-Source: AG47ELt4x6FF8g8EuMbSmtt5pGFV++evAZsnk2NnlKwBrRamrkHBM2Nv2KCHiaaMP9i88SzEvXJmPgCDkYM=
MIME-Version: 1.0
X-Received: by 2002:a25:c583:: with SMTP id v125-v6mr1227312ybe.53.1519860272640;
 Wed, 28 Feb 2018 15:24:32 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:45 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-29-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 28/35] pkt-line: add packet_buf_write_len function
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the 'packet_buf_write_len()' function which allows for writing an
arbitrary length buffer into a 'struct strbuf' and formatting it in
packet-line format.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pkt-line.c | 16 ++++++++++++++++
 pkt-line.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 87a24bd17..5223e24e2 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -215,6 +215,22 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 	va_end(args);
 }
 
+void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len)
+{
+	size_t orig_len, n;
+
+	orig_len = buf->len;
+	strbuf_addstr(buf, "0000");
+	strbuf_add(buf, data, len);
+	n = buf->len - orig_len;
+
+	if (n > LARGE_PACKET_MAX)
+		die("protocol error: impossibly long line");
+
+	set_packet_header(&buf->buf[orig_len], n);
+	packet_trace(data, len, 1);
+}
+
 int write_packetized_from_fd(int fd_in, int fd_out)
 {
 	static char buf[LARGE_PACKET_DATA_MAX];
diff --git a/pkt-line.h b/pkt-line.h
index 3f836f01a..4f97ae3e5 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -26,6 +26,7 @@ void packet_buf_flush(struct strbuf *buf);
 void packet_buf_delim(struct strbuf *buf);
 void packet_write(int fd_out, const char *buf, size_t size);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len);
 int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int write_packetized_from_fd(int fd_in, int fd_out);
-- 
2.16.2.395.g2e18187dfd-goog

