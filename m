Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F2C41F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbeCORdq (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:33:46 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:47464 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752616AbeCORcz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:32:55 -0400
Received: by mail-vk0-f74.google.com with SMTP id n23so4728516vke.14
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=/lrtx29gmdJUFMTurBz7wRhSLe64sCzb4mIOvMwTaBc=;
        b=PVbfGXJlAZf0exgW5dbHLCC3LD8XeySJa1YcaBrI+JN2d4WYwoVgR4pN29J0uviro7
         RuJNiqhJF8bjwHF7KkVauPaSU8OGF9oOYAVUcLO3iwifZG62mxMWlTVvZYULTdEhFGpN
         FjUHSybcbY1ntShg+QMBj27z5s1cj0TIIK/fDTnQ8VA+boSy/KHVvvZZWYFGLX4VmAUI
         hSGzkCLhzVC0/O4RBrJJ91iHEbxEGE0EheCeONbNaVqGaYewBm5lrtoGIIoirTTgRlOc
         ODga4uNYNLCuk81098B7+01jxmmysIgVEkU6gLl5r2DWq1+vqlvQFf0H7AQmxr5bpuWF
         1gSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=/lrtx29gmdJUFMTurBz7wRhSLe64sCzb4mIOvMwTaBc=;
        b=uFs7jI+AFnjTw2vg0ZFK6nZlCswxej4h9WJGq0U+aLgi29zv8CY/YP4g/EcpN0sIia
         DSz4kEWNvovGbdXUrlm6Rh/zlOwRLOZkxTY7wFd47DPLAj/Rzcc0x440FePF6y/dyJ11
         cIekp9yxuLYDoGZ472G3+nS+DzVprNaRPDON3MnNiUDrvCrf+ysExupTMznEpevVqwcT
         b+zniJr17sBkk5JfdIJOdZxveaL5ngCjrlBRK9JrQjl3TLDEuOI31LhMwgbwiw2KmjWt
         g7Iv6cVRPbWvUrPu7oQ0Yt6LJB2l15d+RPWoR2QaYlGs3Wtvnocmp9xeeMG12U5G20qx
         AMyg==
X-Gm-Message-State: AElRT7HErTHEeUY2/ttlTI7gGx/mDBhZ+F79MNa5h91XW6rnSWacA5Fa
        DpKLoZDoQ3qF1Yc0lRCd/+I+s/5IINWyRUadMMBXTsYVdS7WTtWtRoshs6GaU1LDSoUAlPYkp9o
        pQ1geukySxrhpRxEC7AHuyeAeAfyv08ZxYLj069eh+2Lhtzr8iQnJM0HXEw==
X-Google-Smtp-Source: AG47ELsd6iPDsyBa/+ZNxiq04BOf0kO3H9c0LLmJhxDsqkRGPP2TiPLTjVx6rlSjMwKkMUboRSOcbHd1Vx0=
MIME-Version: 1.0
X-Received: by 10.176.74.83 with SMTP id r19mr3933267uae.113.1521135174364;
 Thu, 15 Mar 2018 10:32:54 -0700 (PDT)
Date:   Thu, 15 Mar 2018 10:31:35 -0700
In-Reply-To: <20180315173142.176023-1-bmwill@google.com>
Message-Id: <20180315173142.176023-29-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com> <20180315173142.176023-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v6 28/35] pkt-line: add packet_buf_write_len function
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com,
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
index 7296731cf3..555eb2a507 100644
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
index 9570bd7a0a..5b28d43472 100644
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
2.16.2.804.g6dcf76e118-goog

