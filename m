Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 349431F404
	for <e@80x24.org>; Wed,  7 Feb 2018 01:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932270AbeBGBO1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 20:14:27 -0500
Received: from mail-ot0-f201.google.com ([74.125.82.201]:40098 "EHLO
        mail-ot0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932264AbeBGBOY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 20:14:24 -0500
Received: by mail-ot0-f201.google.com with SMTP id w4so2136081ote.7
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 17:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=xpf+upqz1TsGzk1gh9pSXJmCRPXcurTIg0NN67V/1hw=;
        b=fuzgPtUWhPuKG9PrCGxZnW1szekv06zLEtj5bTav/29HDk1A3vnLI1fg5EaIsFcCGt
         j5DtsKBL7OHqJUmY+uvIvAXyO1zTSMUdHClxycaoH0jrCFd6PZ+UYtLUtKSciqXwzRLP
         xVZudhC9oYaChDPVx4Ny8iGNjjtC0PEyHeRKnG5YAydUKUJb/CoCPFGU5Qg372jeDbpH
         FshyO/0H0X1HmLT5V3pd4+dw/s4ZagDSmvhBr2e5gC76OQKdwFXkN9WndIkeLkph36EK
         4x7KARfSzqZCgYWNWVqOVS4NXYxohHegOJcyYcjGqN//dYxkB5PRRCN94eJBC3/XR5VQ
         J0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=xpf+upqz1TsGzk1gh9pSXJmCRPXcurTIg0NN67V/1hw=;
        b=WurRRUmKLKdMN5hcKSSFJTHNL7oSbCl4Qm/jpTkNAyjYuitfHp9F/q66/ZGuAdoGQj
         9JQ9IL+UCtriW3bSCTN9M3w2ASBg4D6rLPssa0RbjpWsw6lrtE/QQ6SUvkZVTKKBz8yG
         FlsR8ATE6Y9N51ZD7Jy7wN1SSv1AcTa4X0ZAX/T3o2/4Gt9yDD/KGcSrOy0z7puUk4bn
         3KjDzX7fERbibVYIa5LZjaMLXdlpR8Kk3CwKcjEJ4OBxIsTCYkS17mLxtCKGro1o5unS
         OblAuyhhyMi4gSO/xC6oH3u1KGlgspCi/g2UeVRzQpy0lJRT8qQFgpOtIi6hMQKx7OOn
         FIEQ==
X-Gm-Message-State: APf1xPBYWNMHmYTDhVXI1HM88cWexdH5UiFnQeD30h2k4e8eTSts+w+R
        3Qh+dBCv2eAPKXDw2Rh1YgMU8grehyh7K8H48M+r0uOqlrs2CU1sD88M1mcGpbdU+bO1DfXzm17
        e3A5kJpyKftP78ybz6IJdz0mS5H4gvyIQJkqbaj1uaynYE4r9L3jC0iEOyw==
X-Google-Smtp-Source: AH8x224E8ZziCgQXMWG8+U6rkHbyWPEX6uaRMIcWKLOz/4guPgee1v+NE88fmNql1N03/zqWuZMBy7YqZ2U=
MIME-Version: 1.0
X-Received: by 10.202.114.203 with SMTP id p194mr2268018oic.62.1517966063647;
 Tue, 06 Feb 2018 17:14:23 -0800 (PST)
Date:   Tue,  6 Feb 2018 17:13:06 -0800
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Message-Id: <20180207011312.189834-30-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v3 29/35] pkt-line: add packet_buf_write_len function
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
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
index 726e109ca..5a8a17ecc 100644
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
+	packet_trace(buf->buf + orig_len + 4, n - 4, 1);
+}
+
 int write_packetized_from_fd(int fd_in, int fd_out)
 {
 	static char buf[LARGE_PACKET_DATA_MAX];
diff --git a/pkt-line.h b/pkt-line.h
index 16fe8bdbf..63724d4bf 100644
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
2.16.0.rc1.238.g530d649a79-goog

