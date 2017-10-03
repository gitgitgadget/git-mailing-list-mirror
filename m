Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83B722036B
	for <e@80x24.org>; Tue,  3 Oct 2017 20:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbdJCUPg (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 16:15:36 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:47125 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751742AbdJCUP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 16:15:27 -0400
Received: by mail-pg0-f47.google.com with SMTP id r25so2933335pgn.4
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 13:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hxzelyowxzq/znWOViDEwvzv2VZkl56IZfeeiGsHQ3c=;
        b=eRORDtfYE7pwt+jJTxbL2l1jzp8NUhKFDmTyvMznC128nh5wI8TMo+S+EOvf2m15IG
         Ay7+9XW6hLaMLCtRDAYt1Inl1/vz8mdNyuLNGQT50yh0vY+BuoP2kldiYu44y+Zlhjvj
         vypBlHDw/O01Z1vS8wkTQNF1+yhPsKndFNLSbMShAajj/8ACzBgcYABIm9Jf7VcP/VFM
         ja7zP6SQLo0F26n3cNZtT8JRua+OXvvxk+lmoa8ggdWRH/X7xg7/3QxDy5kms6PoHjuo
         4/GRedXcOsaqmB1wbhhciJS08oe6K052D3CKwqBkv4tlILH11bcjxKWv/zPOrojDfIM/
         EtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hxzelyowxzq/znWOViDEwvzv2VZkl56IZfeeiGsHQ3c=;
        b=EE0ykmwU1CAyBvLqT9+Wj10ab7CzbX1/IUSR27HMWf+La3CY0fje1mqnxAY0T44DMu
         45pBdAxVCDBu+wkUpmFyPtNnuXMA2E5FvSonh4lulwP6FTv3GaIIF6GJ/SVxC646YKJC
         yVwpdFw5ke5z3I4O1By7r9dDjEh6TWOl+4E5zQfs1RGrCPz1JpUHmsXG8VEbb5LAr8WC
         +NvPFYhJCsjXcHPi8Qo37eO5q86zzgJfyyD5PRjhL7oinp4/OSp7UTT1NV53NvaDTMrQ
         AnOdsxHIEs3bqLYJ6PxLVt9F17g5QbrrEkTrP7bwGtPOwn7AHiS5IqtJJjLxpFCFvzdp
         CxcA==
X-Gm-Message-State: AHPjjUjR1wn1h2mMq4cJXsg+fODuu+J1V5B0GglDnpFp2wl8yZxTEKei
        wvZBPYppzfo0dJplzPIdJvRlk6MYu7I=
X-Google-Smtp-Source: AOwi7QDbKDEOYL3WBoS2HeZMq5u50b2ShS6s8VXtv6AscGoYgRJ2T6synXgtl6i0GTfvdmXWaLrGdQ==
X-Received: by 10.84.211.144 with SMTP id c16mr18442819pli.233.1507061726450;
        Tue, 03 Oct 2017 13:15:26 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 184sm3846262pfd.88.2017.10.03.13.15.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Oct 2017 13:15:25 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     bturner@atlassian.com, git@jeffhostetler.com, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 02/10] pkt-line: add packet_write function
Date:   Tue,  3 Oct 2017 13:14:59 -0700
Message-Id: <20171003201507.3589-3-bmwill@google.com>
X-Mailer: git-send-email 2.14.2.920.gcf0c67979c-goog
In-Reply-To: <20171003201507.3589-1-bmwill@google.com>
References: <20170926235627.79606-1-bmwill@google.com>
 <20171003201507.3589-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a function which can be used to write the contents of an arbitrary
buffer.  This makes it easy to build up data in a buffer before writing
the packet instead of formatting the entire contents of the packet using
'packet_write_fmt()'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pkt-line.c | 6 ++++++
 pkt-line.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 647bbd3bc..c025d0332 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -188,6 +188,12 @@ static int packet_write_gently(const int fd_out, const char *buf, size_t size)
 	return 0;
 }
 
+void packet_write(const int fd_out, const char *buf, size_t size)
+{
+	if (packet_write_gently(fd_out, buf, size))
+		die_errno("packet write failed");
+}
+
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 {
 	va_list args;
diff --git a/pkt-line.h b/pkt-line.h
index 66ef610fc..d9e9783b1 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -22,6 +22,7 @@
 void packet_flush(int fd);
 void packet_write_fmt(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 void packet_buf_flush(struct strbuf *buf);
+void packet_write(const int fd_out, const char *buf, size_t size);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
-- 
2.14.2.920.gcf0c67979c-goog

