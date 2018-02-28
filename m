Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 499611F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964974AbeB1XXa (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:23:30 -0500
Received: from mail-ot0-f201.google.com ([74.125.82.201]:53619 "EHLO
        mail-ot0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964971AbeB1XXY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:23:24 -0500
Received: by mail-ot0-f201.google.com with SMTP id 73so2308495oth.20
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=9XsmeCCBk7e6wwN5WA7TJlpnWt0G2XiYH7b/hUURf1M=;
        b=l8mLEIeZgLv71J8MmfDnADRIwj4S5gru194jKi0d15+DLauwtLVrHC8BBcCeBVohJ/
         Bp8u4SJ6cfqw0R9Ga9TkX5gwChsJ/zU9OliAHpPdJ84VUPuNKU4umZdnTeOJ0u/jnJYi
         uiNstPaVmMJqgGmy0QNOklRIUlUhU/jKZ9sWktIl2u2dzkU0GXA4P0Bx6dRcY4t2xHOR
         tO788kS1GW+ZY2pLTp/ICRY9ULhMPzpOnSWQKssk4SnG0J0V/qEcZZt+tCjsA5tjCvle
         zsoMB9FSMVvOq0Fl7WrAee4MwWp4uRKNqovyz7Gy0Arc1KaE6qyAwTr3N3C2PG/LNazH
         8qAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=9XsmeCCBk7e6wwN5WA7TJlpnWt0G2XiYH7b/hUURf1M=;
        b=JE84+/S+Puy1llAnDwJ+/8zpeqRFHQVie3FOahDYb4oIk4mpLpHuuA9D/IVOfvepxb
         smn9BPfHLKGVyX2uUccHT6NnKVBaicZRpIrvLezaOVo41ppQnEw3sBr0wbQuYijDGnMy
         X5ehiZw1hNo/6xTDU4ywEM49+CIODaNHPC13T8faqE1dY0QTF3vAuEudM9+tKsCbKGsR
         tgHHiRq4aTVJh5olqgm/irVe+Ca8ZZP/RC04iyJIHamC0XL8tE0SX0pWeZNp+obig9K+
         Os51uJSd3mm2Bqi6xZaofL2SLmZDYVzAz3e286jMSRxU+nPDVl0YIneA5+t3ObdaRMnv
         WUhg==
X-Gm-Message-State: APf1xPC6sc0YH/89e2cukYLjR5SA+PomdKSJshlUJo9m3v30lbHu6apn
        ANKhtP/0AGVpkyqcA6JiF+ZDJsHAidsV/XFPgwnUbyTfaEAX1HRm1NqsC3RHGsP9dKSDUW9tUwB
        ShjTHGh1zn9wB9uk17k+Q70j+TEtAMejOsVYNVa93blq7KOPGvU64xe6Dlg==
X-Google-Smtp-Source: AG47ELuD+BxV7Vurds0gvRq9rqSwN2qKTii0I0WOWbFUY0xu/4zQEM+fVvfsedTavf+PjGlzC0KsAWLow4E=
MIME-Version: 1.0
X-Received: by 10.157.27.70 with SMTP id l64mr6712937otl.74.1519860203724;
 Wed, 28 Feb 2018 15:23:23 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:20 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-4-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 03/35] pkt-line: add delim packet support
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
 pkt-line.c | 17 +++++++++++++++++
 pkt-line.h |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 6307fa4a3..87a24bd17 100644
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
@@ -298,6 +310,9 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 	} else if (!len) {
 		packet_trace("0000", 4, 0);
 		return PACKET_READ_FLUSH;
+	} else if (len == 1) {
+		packet_trace("0001", 4, 0);
+		return PACKET_READ_DELIM;
 	} else if (len < 4) {
 		die("protocol error: bad line length %d", len);
 	}
@@ -331,6 +346,7 @@ int packet_read(int fd, char **src_buffer, size_t *src_len,
 		break;
 	case PACKET_READ_NORMAL:
 		break;
+	case PACKET_READ_DELIM:
 	case PACKET_READ_FLUSH:
 		pktlen = 0;
 		break;
@@ -443,6 +459,7 @@ enum packet_read_status packet_reader_read(struct packet_reader *reader)
 	case PACKET_READ_NORMAL:
 		reader->line = reader->buffer;
 		break;
+	case PACKET_READ_DELIM:
 	case PACKET_READ_FLUSH:
 		reader->pktlen = 0;
 		reader->line = NULL;
diff --git a/pkt-line.h b/pkt-line.h
index f2edfae9a..3f836f01a 100644
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
 enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 						size_t *src_len, char *buffer,
-- 
2.16.2.395.g2e18187dfd-goog

