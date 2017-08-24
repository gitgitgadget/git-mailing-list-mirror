Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8247C20285
	for <e@80x24.org>; Thu, 24 Aug 2017 22:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754014AbdHXWyC (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 18:54:02 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35143 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753702AbdHXWx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 18:53:58 -0400
Received: by mail-pg0-f54.google.com with SMTP id 63so4750139pgc.2
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 15:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7NdcF5xtS7hTe5z3uoTnjQ7twZizkZJCbEbKtyERkkc=;
        b=QO8dKZ0PP57oGMJdHJDgRf02CRVkiDnxCU2HxYPpRsy1X2vLYg5hCrdcOcJVGp2LuM
         H6dPiKr68Eh0gxkhdjtroPV/7U81QvkYnsE5NHWCoXG5h2lQu64c4ZKgeYbZFiP9aJ5x
         51/RvCCYC4ZF+oazkzj4duhFaoQa9JgNPmbqh4FbLuIJ7cwncVTniLOkh3rg5PVATrCy
         8w08sCJtBPHweCBDicbhWitAqMYEnpXpVmfjfqJH7COI/i2HM4X2idh1bmxHhSMAxxcp
         fLPPQdDrsNZ2Ajs+PMfLm8U4+Ap4wdIJH2NOvPD9vx8OfskkRXD38P6vbADbXm+O5Hmr
         Tg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7NdcF5xtS7hTe5z3uoTnjQ7twZizkZJCbEbKtyERkkc=;
        b=AKaUEq8C10iKxoRsKZpmDwHlunZQrDDorrhPX8AH8jzCw/IBlt3R3PhkdNt83RhPMR
         VOZ7uZQpidYcxJ1AkawVBOE+QJjo0kt3i0H6T18StND1Xw5Zy+8DUo9C2MUcxY/Ej3tA
         thdLZ7/m0/gnpfmNq0xRBZbMqBs0aoY2lw4zavDrhzmrLFy42CW+w+kVn8xadXX0SC3U
         H5uhr2AHsQC/qqOQwUv0IhzmqIF+K9QF3aiPDNQkuiyBDTQgaYQAlFtCBj2e4Sp0Shc4
         ItuOvqgNLWQek0e4YEw61Q04bJqG3PyqbxRIwRBZI6xFg34PwvbTRMA4bv6dBLvZzfE3
         8RYQ==
X-Gm-Message-State: AHYfb5iUijwK20CJVZYBeQC14kvOduDtBw1EPVB/kLHx3MW+fAX2IeVO
        GkPXtL+24NaZOTU6z19gsQ==
X-Google-Smtp-Source: ADKCNb7sENnREJ01U7v8+rhYoN4ZmD3SfsSHY9WEOxDXbhFCOF/OxNzKLkAUZc2Q+QdNQBORrzVF8A==
X-Received: by 10.84.232.77 with SMTP id f13mr8577263pln.173.1503615237489;
        Thu, 24 Aug 2017 15:53:57 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id x8sm9402667pfi.174.2017.08.24.15.53.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Aug 2017 15:53:56 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, sbeller@google.com,
        gitster@pobox.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [RFC 2/7] pkt-line: add strbuf_packet_read
Date:   Thu, 24 Aug 2017 15:53:23 -0700
Message-Id: <20170824225328.8174-3-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.342.g6490525c54-goog
In-Reply-To: <20170824225328.8174-1-bmwill@google.com>
References: <20170824225328.8174-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add function which can be used to read the contents of a single pkt-line
into a strbuf.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pkt-line.c | 21 +++++++++++++++++++++
 pkt-line.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index cf98f371b..875524ab8 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -312,6 +312,27 @@ int packet_read(int fd, char **src_buf, size_t *src_len,
 	return len;
 }
 
+int strbuf_packet_read(int fd_in, struct strbuf *sb_out, int options)
+{
+	int packet_len;
+	strbuf_grow(sb_out, LARGE_PACKET_DATA_MAX);
+	packet_len = packet_read(fd_in, NULL, NULL,
+				 /*
+				  * strbuf_grow() above always allocates one extra byte to
+				  * store a '\0' at the end of the string. packet_read()
+				  * writes a '\0' extra byte at the end, too. Let it know
+				  * that there is already room for the extra byte.
+				  */
+				 sb_out->buf, LARGE_PACKET_DATA_MAX+1,
+				 options);
+	if (packet_len < 0)
+		return packet_len;
+
+	sb_out->len = packet_len;
+
+	return sb_out->len;
+}
+
 static char *packet_read_line_generic(int fd,
 				      char **src, size_t *src_len,
 				      int *dst_len)
diff --git a/pkt-line.h b/pkt-line.h
index d9e9783b1..c24c4f290 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -65,6 +65,7 @@ int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
 int packet_read(int fd, char **src_buffer, size_t *src_len, char
 		*buffer, unsigned size, int options);
 
+int strbuf_packet_read(int fd_in, struct strbuf *sb_out, int options);
 /*
  * Convenience wrapper for packet_read that is not gentle, and sets the
  * CHOMP_NEWLINE option. The return value is NULL for a flush packet,
-- 
2.14.1.342.g6490525c54-goog

