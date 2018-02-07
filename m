Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3FD61F404
	for <e@80x24.org>; Wed,  7 Feb 2018 01:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754284AbeBGBN2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 20:13:28 -0500
Received: from mail-yw0-f201.google.com ([209.85.161.201]:39083 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754223AbeBGBNY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 20:13:24 -0500
Received: by mail-yw0-f201.google.com with SMTP id r6so4426322ywr.6
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 17:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=sniDeXD39vv4Wk8g5W9I6NZon/nVeqHVZCCNQ8SgTgE=;
        b=L8qGfswwfRla3Fs7j99Kk3OSQ8sn4Y9c0TGoiVZ9Az+YK9YR8JBTZEa5OyWhvQ4eBN
         /cRkg1GVuh3kNljZbXjE4tZmPquFJSSAwu1BU+YvzXFl8kqIzCDB+NKnlBtNFcsVkxLF
         O2yBvPlWLwi3D/exMP/e5KZBveauMiBP6/jH2V/+gT7ybRQT8GPmV03I2YF+kCHGSWpG
         wQkyObJ+WUGBHvFZcQ6iNz+jmLUOC0e9kZl7dJUOds58aoBLHHsrlKYWUgLRJJ73bIXO
         NzOKWrv3XMbSpgbdIMVukHZ4tRI+p1lBrttxBIvb4kOIQ6VkQ3p2c7Ek6f+5s2c0Q8tE
         fNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=sniDeXD39vv4Wk8g5W9I6NZon/nVeqHVZCCNQ8SgTgE=;
        b=jx3OXzJpFExthIhcTs60cqm3REDIywV2TjQddiS/jMGmhNQVW+nVcz46AHuiSdd3DG
         1k8k9cPH3YXkNLI120Oot8tPoO2Fi15xF07To4AQNFFVKUIhMiMxwtyTT6UD/zXyRrPH
         hZTENP/s6Gt5s+l3B80F5eDuBbLXPfh0A5YIgnHVr2NprH5U5DHzCJySxHXaqO2+e0Ig
         7K1BM5ma44IFvtaDA08aKVtnJt95/I2lsa0B+NiZfbhogGslsga1Ud4m6N9Toa2cZ+z7
         WwI7yLJj7RIyxAIB5awmkgjaQSlgOv7P0Conw0jOfVtLrfZ7tIuUht3WT9iMyYDSyfrG
         k+/g==
X-Gm-Message-State: APf1xPA19PSrcaFuiIG8SjR9TG8y5qvf/LCreikMhefAf6B6jtk0W+/W
        93TbvH0Pn4DlZGnzJDHTxWytXvkukhTT1+AZVX6nLFMEC5SZW6ssB9ZGeGomJpnkTj8OqD5mTS6
        eGVHzyc3TODn5I2sjnLGzfAYAXI4aOYhJ97m5Bn092p/Uc5fhGPsWPVywnw==
X-Google-Smtp-Source: AH8x227wyGNtq7si5KBmnYaaFzimPDUMpkrTVUA6V5kA1AKBVCQ32/LMnYbznJyi6SzpzkqxJGK2KzFnouU=
MIME-Version: 1.0
X-Received: by 10.129.157.68 with SMTP id u65mr2108108ywg.155.1517966003790;
 Tue, 06 Feb 2018 17:13:23 -0800 (PST)
Date:   Tue,  6 Feb 2018 17:12:40 -0800
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Message-Id: <20180207011312.189834-4-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v3 03/35] pkt-line: add delim packet support
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

One of the design goals of protocol-v2 is to improve the semantics of
flush packets.  Currently in protocol-v1, flush packets are used both to
indicate a break in a list of packet lines as well as an indication that
one side has finished speaking.  This makes it particularly difficult
to implement proxies as a proxy would need to completely understand git
protocol instead of simply looking for a flush packet.

To do this, introduce the special deliminator packet '0001'.  A delim
packet can then be used as a deliminator between lists of packet lines
while flush packets can be reserved to indicate the end of a response.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pkt-line.c | 17 +++++++++++++++++
 pkt-line.h |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 4fc9ad4b0..726e109ca 100644
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
@@ -297,6 +309,9 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer, size_
 	} else if (!len) {
 		packet_trace("0000", 4, 0);
 		return PACKET_READ_FLUSH;
+	} else if (len == 1) {
+		packet_trace("0001", 4, 0);
+		return PACKET_READ_DELIM;
 	} else if (len < 4) {
 		die("protocol error: bad line length %d", len);
 	}
@@ -333,6 +348,7 @@ int packet_read(int fd, char **src_buffer, size_t *src_len,
 		break;
 	case PACKET_READ_NORMAL:
 		break;
+	case PACKET_READ_DELIM:
 	case PACKET_READ_FLUSH:
 		pktlen = 0;
 		break;
@@ -445,6 +461,7 @@ enum packet_read_status packet_reader_read(struct packet_reader *reader)
 	case PACKET_READ_NORMAL:
 		reader->line = reader->buffer;
 		break;
+	case PACKET_READ_DELIM:
 	case PACKET_READ_FLUSH:
 		reader->pktlen = 0;
 		reader->line = NULL;
diff --git a/pkt-line.h b/pkt-line.h
index 7d9f0e537..16fe8bdbf 100644
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
 	PACKET_READ_EOF = -1,
 	PACKET_READ_NORMAL,
 	PACKET_READ_FLUSH,
+	PACKET_READ_DELIM,
 };
 enum packet_read_status packet_read_with_status(int fd, char **src_buffer, size_t *src_len,
 						char *buffer, unsigned size, int *pktlen,
-- 
2.16.0.rc1.238.g530d649a79-goog

