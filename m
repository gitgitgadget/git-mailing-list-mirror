Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9CD31F404
	for <e@80x24.org>; Wed, 14 Mar 2018 18:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752462AbeCNSc2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:32:28 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:33726 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752278AbeCNScZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:32:25 -0400
Received: by mail-yw0-f202.google.com with SMTP id d10so4817303ywe.0
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=5fLKdcLuC1o1hPy+ZV06ZubqFE8SfuMpLZE2FCXOYwM=;
        b=IgGaSZ8M461vgy23mw0R/G/+x8rf8EaQ3OcB4ddwOjHemZq0bSIQmFhs7/egMitM7c
         1QdOnXxqpyAFcupnqsSUmJtxqaPX/PK0pmfbGNh7TYDFfOPCho1KjMA7lBAlAE9arZRm
         SJkVjRee3bh3lPbpQSQk7gxb735gWQo4yl7sh1n3FB8h3hpsAJRBlTrmD6a290tVVCVk
         +ATaB2FJAv9XAzPoijZPlOz8/12fABprcfGjY+N1rY5AVUvn5lnxA7hZpbDQIl7c7pR6
         Vgn0hvebH2ibeyRhFsYO+39pfEZMH8dA5F11q0OQ3pxjf6vLGoEJmnTxAyHHmoQsMURd
         bzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=5fLKdcLuC1o1hPy+ZV06ZubqFE8SfuMpLZE2FCXOYwM=;
        b=t4KVxvT1GfugQ2kERsoywUn47FuQxnxYUSZZ08q2kzOrFDe/KdQ3IwTPDZblMQU6Pg
         aZn/Zkfg9wcAfhybguMTq279A937fh7FZJmE4MLLBUMDfi9UPsK5HbSN8Pe/oNBbwAaY
         MjNb9qz5uZsCanCxTeLwAKkj1GyuveDZahjmaCA8qL/09QviAUPe74Xj7iuxw/0OVKEo
         DWbD3GOqlH9bTGBOP0lesrzEdlGAi8M286souih+h4aMdkOsgWXbpTdEAUi8K9qr/xx5
         cAolZAb+8zceEm8qpor45/VjZJIvMqUFjM0tmy1c+PcwU8HZu1DZKJxljp17pAbuciVF
         JMJg==
X-Gm-Message-State: AElRT7GuwQX5bQVKu9GGReLzLyOXdngD0EWYuDXjyOZT3lAMufLc6h3Z
        obE/4ae6hBF8oAXDhrqtePqRlawGjpvBTnmTuaf/l/C/tpxLG9IFYk9FBUZsMddpryYexx7fAFF
        ymYrBhUh8QbULNargXkdIx2zIACBQezH9JNRCoHbEV9BHKY4nnjLxnFmn/A==
X-Google-Smtp-Source: AG47ELs6wo2hqbPJ5fXmvaLUglnHuOMrENAMdPZY+CUkg2s3hqFroB1TiK6ZhrNPh+fxJOpPdywtAszUSlg=
MIME-Version: 1.0
X-Received: by 2002:a25:6c45:: with SMTP id h66-v6mr2631882ybc.41.1521052344463;
 Wed, 14 Mar 2018 11:32:24 -0700 (PDT)
Date:   Wed, 14 Mar 2018 11:31:40 -0700
In-Reply-To: <20180314183213.223440-1-bmwill@google.com>
Message-Id: <20180314183213.223440-4-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v5 03/35] pkt-line: add delim packet support
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

