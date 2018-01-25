Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9791E1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 23:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbeAYX74 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 18:59:56 -0500
Received: from mail-yb0-f202.google.com ([209.85.213.202]:43503 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751830AbeAYX7m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 18:59:42 -0500
Received: by mail-yb0-f202.google.com with SMTP id m71so5819837ybm.10
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 15:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=xpf+upqz1TsGzk1gh9pSXJmCRPXcurTIg0NN67V/1hw=;
        b=bXp4p3Re4Nx3gTQzp7PaZLCNuru/4D7lK1BI5IyFnWtmnfrHPBjbKVDBdeHHRzDyUr
         WZvS+HyvxERZ6V6rLl5jJJUiFPlx9qyvsdV48HPUra7dcr7zss5TFLGER/99hkLtSxx8
         i6eocAxPYEpdTeU/dpIANsyrPKw4Tb4i8iMe1SBJ18F3D49Q9QpyLj4Y/wTj6NX9Lz+K
         NvLzuddSeqJg40o48wGph2LnUMKaW0RmrRw63suqwvlLTzCjFF7CiJEBVAJSfW+nBGNV
         yXyLeA9JcGaa2y3gVm6aPgOCOyusYldEoLb/hDppvUGmhxFlqXpdHajzHeHpjsloVg8q
         bFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=xpf+upqz1TsGzk1gh9pSXJmCRPXcurTIg0NN67V/1hw=;
        b=mH9/9RE1nQ+JDYBoj6R5trausC18a4wwaR8eagtzTaV4o2gqxdpABA3QdV0sGVtGeG
         VCBlCJNlSXKfP4/Olxd7/xkpg+FpVAefEpSz3oaCUA1QGCFYpJT6vXRUKfeJ4DRZKlPq
         epDrG/DZyRCFYhnF9aZOOVLNkROKK0Z1o6PVLTjgYeY042k0Z2wTFpnZJ4NPEoDFHm5r
         VdEvcIeHVmPb4+HC77Z8lIqyr1NAQRf98TekkrJP5KfeafedKQzB824NLURBtmmNVkcL
         11+GllKVgm016ANENtGHyWPXRdpGdOhCvV9bWviDxIFctelFTyvMY5+S22UJDGT+/oZH
         VzSg==
X-Gm-Message-State: AKwxytd6Wiwc5+r5U2UoIdyPvFKbTNAwUDlCn1tIVqLfL4x+TZrpw7cI
        c6apXvMs7uk+4VRbd4PDILd400z6A/OErr18eHXEUddlgyw7koj173qoy4JbsLzSVsMoYPX+cbI
        F363i2gFYX8dqcRY38vVl8deU6LsmdWfNPtQJVgCsnpI+NEJ11HH+6lcrWA==
X-Google-Smtp-Source: AH8x225TxEAcf8kMNeiqgk6Idac/Hx4PdUB+Ij3ywZoXm3h2oV0WyJ8dGV46A/JMBUNQxF7BsBgbhTqog5Q=
MIME-Version: 1.0
X-Received: by 10.37.217.20 with SMTP id q20mr5882138ybg.39.1516924782064;
 Thu, 25 Jan 2018 15:59:42 -0800 (PST)
Date:   Thu, 25 Jan 2018 15:58:36 -0800
In-Reply-To: <20180125235838.138135-1-bmwill@google.com>
Message-Id: <20180125235838.138135-26-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180125235838.138135-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v2 25/27] pkt-line: add packet_buf_write_len function
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
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

