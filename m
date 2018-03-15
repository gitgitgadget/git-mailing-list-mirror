Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 942381F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbeCORb5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:31:57 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:52388 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeCORbz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:31:55 -0400
Received: by mail-io0-f202.google.com with SMTP id r79so6281191iod.19
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=5fLKdcLuC1o1hPy+ZV06ZubqFE8SfuMpLZE2FCXOYwM=;
        b=oCbiVyTJtuGkf8WKc6VQ3agYb7ZWd442DBgE5J0Ga7HMSx+vEqBltQcoMtTafpx9je
         CwZ2dh0IaL2lTRFHuMooGRsqeCOlgY/iNM74Fotxlh+cvMEGWZrBIwxlY4XvmkP10IQH
         dZIyVewzNrjDK1fuUKRvZ1Awt8j2Tn00RDRGvhud8cU2j6uqJfV8KsDldIfhgqUQjzyh
         z+Tg2VdDTdYge7Qe5FXCLwgzTkJKRZBxUXvxRM7QiQPgcI6jADu0wjs9uS3kjtTQ5R1N
         vin0raCidJiwahRRn5lKhqJ22+hw3s6H65TTJWDdaOMH01LuIkqfzT9aKL9Fls3xVDee
         Xjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=5fLKdcLuC1o1hPy+ZV06ZubqFE8SfuMpLZE2FCXOYwM=;
        b=Bh4CgVOiVw7LysKPtKdo5VQOV2dNvO26q6vKugFLdtCsRFVJeiZX6k6GIDpX4pe6we
         1gZwn/3Bn7O25h/PU3jgzqD/RHP1BFpaLOm2Fme07zlPBBdd6nnsk2bWFWCKhTuPQiz1
         mqEHT3fiHGcwbcBbnL9ZhY7TxPb0kdQo7uralBGPRyh3ivFTwWrbjESwFq+pi9yoMcv8
         I0HshFE78nfxof1oW5TG+lhphyAzqpKmGRYd6EV9XRe4RDr+XgApOoP/Y5b8FffySd1p
         n3+fnUeldMAVxm72s7LZBPAwJ5Z7iJQYEf91rv2Xjr/vQzFCb3/+nPlHmcYlFvv/QAOT
         PDYw==
X-Gm-Message-State: AElRT7ErngcBGjQQqQHksHrj9lAGon7x6O83D7ReQk0i6IZ2ty451qVs
        Y1J6OjiJ3TqbVRYHWmDJkvfQcavq2PaT9+6OzaTm4X12flMl2YNaRsOl8/ULwIvgiWvjHvyU4qS
        YET+JWLdxNK7CpDYehQYNFoV+RHtRYAJ2bw6ZLAEzHeLdXxVW89tM5TVLkQ==
X-Google-Smtp-Source: AG47ELv5E7DdkzunWwAaMgg6KJYRDoCl8mjqhvVqpYiFm6D+6rywhv66/t8+4CtEk9uuq539oK9Z2FsYvwI=
MIME-Version: 1.0
X-Received: by 10.36.118.211 with SMTP id z202mr3205781itb.16.1521135114150;
 Thu, 15 Mar 2018 10:31:54 -0700 (PDT)
Date:   Thu, 15 Mar 2018 10:31:10 -0700
In-Reply-To: <20180315173142.176023-1-bmwill@google.com>
Message-Id: <20180315173142.176023-4-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com> <20180315173142.176023-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v6 03/35] pkt-line: add delim packet support
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

One of the design goals of protocol-v2 is to improve the semantics of
flush packets.  Currently in protocol-v1, flush packets are used both to
indicate a break in a list of packet lines as well as an indication that
one side has finished speaking.  This makes it particularly difficult
to implement proxies as a proxy would need to completely understand git
protocol instead of simply looking for a flush packet.

To do this, introduce the special deliminator packet '0001'.  A delim
packet can then be used as a deliminator between lists of packet lines
while flush packets can be reserved to indicate the end of a response.

Documentation for how this packet will be used in protocol v2 will
included in a future patch.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pkt-line.c | 16 ++++++++++++++++
 pkt-line.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 1881dc8813..7296731cf3 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -91,6 +91,12 @@ void packet_flush(int fd)
 	write_or_die(fd, "0000", 4);
 }
 
+void packet_delim(int fd)
+{
+	packet_trace("0001", 4, 1);
+	write_or_die(fd, "0001", 4);
+}
+
 int packet_flush_gently(int fd)
 {
 	packet_trace("0000", 4, 1);
@@ -105,6 +111,12 @@ void packet_buf_flush(struct strbuf *buf)
 	strbuf_add(buf, "0000", 4);
 }
 
+void packet_buf_delim(struct strbuf *buf)
+{
+	packet_trace("0001", 4, 1);
+	strbuf_add(buf, "0001", 4);
+}
+
 static void set_packet_header(char *buf, const int size)
 {
 	static char hexchar[] = "0123456789abcdef";
@@ -301,6 +313,10 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 		packet_trace("0000", 4, 0);
 		*pktlen = 0;
 		return PACKET_READ_FLUSH;
+	} else if (len == 1) {
+		packet_trace("0001", 4, 0);
+		*pktlen = 0;
+		return PACKET_READ_DELIM;
 	} else if (len < 4) {
 		die("protocol error: bad line length %d", len);
 	}
diff --git a/pkt-line.h b/pkt-line.h
index 11b04f026f..9570bd7a0a 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -20,8 +20,10 @@
  * side can't, we stay with pure read/write interfaces.
  */
 void packet_flush(int fd);
+void packet_delim(int fd);
 void packet_write_fmt(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 void packet_buf_flush(struct strbuf *buf);
+void packet_buf_delim(struct strbuf *buf);
 void packet_write(int fd_out, const char *buf, size_t size);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int packet_flush_gently(int fd);
@@ -75,6 +77,7 @@ enum packet_read_status {
 	PACKET_READ_EOF,
 	PACKET_READ_NORMAL,
 	PACKET_READ_FLUSH,
+	PACKET_READ_DELIM,
 };
 enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 						size_t *src_len, char *buffer,
-- 
2.16.2.804.g6dcf76e118-goog

