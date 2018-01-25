Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55CBC1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 23:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751675AbeAYX6x (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 18:58:53 -0500
Received: from mail-vk0-f74.google.com ([209.85.213.74]:55960 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbeAYX6v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 18:58:51 -0500
Received: by mail-vk0-f74.google.com with SMTP id o13so4892912vkc.22
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 15:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=sniDeXD39vv4Wk8g5W9I6NZon/nVeqHVZCCNQ8SgTgE=;
        b=VTq4+Sc9Gbj/NfMzGUXjH3lLJ+UpwMEV71WdsNV3nKhISKifZ/UTQU4INAWlRkJKuK
         mEJhNVXEX0IsZ2v8U2RWr81M7rTlnmoy+8lOIqfnc3m0uPEBycVtlVocP0IlSnDaiBLG
         UDHpdq+SJYnv2iPo7cO9ROVdm+gMwSbB945AnEG9AUdE8DOuOKBwXF4joVx42ruALz0N
         BfGxqKf1cbmSkxPLfJ6uyPHqZHQl0xvAaKm9L6erK/8Wzdlki6iQalVVboFcOpySkxOy
         ZBRugmE/IKki8AeR4AvMzDakV1jh2Ef8usNB8o1FWeoS7o+X4W1GWG0TgAip+DE4J755
         N2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=sniDeXD39vv4Wk8g5W9I6NZon/nVeqHVZCCNQ8SgTgE=;
        b=uR7jq4H2IjKmT25/nmohuO6TZ2lmgC9VyceJyaZzrvJhk0XS2FIP51YfCwaYmmA0Mc
         i96hflRw8KTNEqDMvzyCZbiAQs++ijX4wRjgUkGmspmh3j4vyFymLAurBjjp7w5jJntt
         S2Z6F9eO2WpPxKJyzFAQCmmaJQkEhriKJkvADywUwDKLDCDKiksi7vQ5Kik6iBN94T0d
         5DTHeLOSH9CKEZtqSZit/fk3gDx0ThB/IIt+HMJ3tKSbgVEeMCvSCYvna+RdV8cdWTkb
         XyTQxJrW1/js2c1PWtkH1A1KnTpfqqca9Sq6rA94Ikle62Jtf9P7wnaDZDdj7yYl1Qls
         PiLg==
X-Gm-Message-State: AKwxytdsildQk3SMMB6XtPJNvVe+Rx+huL8mp10XUNiui4iSqShDrwzG
        9BjI2jP4ZUW45cxUBFKFh7azxnOaPEk1LOR5+o1S+nM72rQgyZ7g/V6lV9GS0TvCPuMT94zVGjI
        NJxV/zTXnLpOPtxeeIsR+cFin1ETzKQcVb7GRH+Ri3vMn5WwM5HWSXvzPaA==
X-Google-Smtp-Source: AH8x2258S8haf/7u5cxwOoTFGNOQV8NSFk/LB2JSskoc3RJWWCrdkUGHlaA/KlGvdbIZtjxr9nYbz2QactI=
MIME-Version: 1.0
X-Received: by 10.31.139.73 with SMTP id n70mr5685438vkd.6.1516924730497; Thu,
 25 Jan 2018 15:58:50 -0800 (PST)
Date:   Thu, 25 Jan 2018 15:58:14 -0800
In-Reply-To: <20180125235838.138135-1-bmwill@google.com>
Message-Id: <20180125235838.138135-4-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180125235838.138135-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v2 03/27] pkt-line: add delim packet support
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

