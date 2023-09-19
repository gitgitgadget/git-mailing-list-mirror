Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD50BCD3447
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 07:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjISHUL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 03:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjISHUK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 03:20:10 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B5C116
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 00:20:03 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c572c9c852so13078825ad.2
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 00:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695108003; x=1695712803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LXnmLYphaQ1g16cUx2xd5BUEutWHdM2G6UTssWpeoqM=;
        b=QpVGhzP4jBPXfLeaHjRYPrvztyjEWM4luvM+7ZiqzDcl1S8SrK5TYkjJvV1la/jcdB
         +hSyxpCnZoGme1xA71rukIybk+uqNVv1rhpzWFFL2O7p0q8gadT7+g/JF6v9tSgmYxyk
         9vz0/LwBLNdbjmePaEvyU2nTPK4zTcENCV9lu5iW4wsL6M4ucVZZWoAn8JFcJSna/cdn
         p0Lz2SUsP/IKriEyJKD1qO7oHtvJRkChfNogiWDExp0QyZtDeFkpxLIPrEfF/566x0as
         RyycY9JevCXJCbu+FO2/9loU3u6ANWkbyvvhwRKQcMT4BhpqSdecv3a5gq7g/Dbi2XDa
         70pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695108003; x=1695712803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LXnmLYphaQ1g16cUx2xd5BUEutWHdM2G6UTssWpeoqM=;
        b=Xs/uJULa63wRDgjMWWkdOtzxcy/CaHwHB7zl2GLdZvtpSMfRzaopOw9qMioy9XphHJ
         JMuv6lht3nuBp4BrbBYaIyUr3lr1kbLccv2Q8tf71jw29Epha9gU9g7lxtj4fwMRey7z
         ZKkdWkHKi6UVwKogwYz7mHOBefSjb9JlnXwyS9g5Y0cNd1qZ4Uj8GNsTPPAPsK1pUc39
         a6HfMQz7TKIS8vVrfVjsZVeGZTnZ1b+cgxOFVikh4MoTUKrxAr7WFW6DsIjiysQTahHq
         U71bvC3eOlBLeUgc6xG63HS/9yLYoIiOCXKdWQdPlBytety/3LJyfJko3wr1/JdcDRh1
         GGlA==
X-Gm-Message-State: AOJu0YxDRgwsh9aQ7d12jlmkX8Y7VFwSFCvD6m76+KFEkIG3y+IJR9mu
        3kTGtzpdGpnmceUtqTegBM1Q9YmUv30=
X-Google-Smtp-Source: AGHT+IGPqOPdiIrgtF87vLBvJm4Oi1zj7bhM+W9+zj5gM8NflOLS2HRkfo2NqdZzdpQe9/x0vSSRAg==
X-Received: by 2002:a17:902:f68f:b0:1c3:bc7c:e14c with SMTP id l15-20020a170902f68f00b001c3bc7ce14cmr10972076plg.32.1695108002662;
        Tue, 19 Sep 2023 00:20:02 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id e1-20020a17090301c100b001b8953365aesm9403045plh.22.2023.09.19.00.20.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Sep 2023 00:20:01 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH] pkt-line: do not chomp EOL for sideband progress info
Date:   Tue, 19 Sep 2023 15:19:56 +0800
Message-Id: <20230919071956.14015-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

In the protocol negotiation stage, we need to turn on the flag
"PACKET_READ_CHOMP_NEWLINE" to chomp EOL for each packet line from
client or server. But when receiving data and progress information
using sideband, we will turn off the flag "PACKET_READ_CHOMP_NEWLINE"
to prevent mangling EOLs from data and progress information.

When both the server and the client support "sideband-all" capability,
we have a dilemma that EOLs in negotiation packets should be trimmed,
but EOLs in progress infomation should be leaved as is.

Move the logic of chomping EOLs from "packet_read_with_status()" to
"packet_reader_read()" can resolve this dilemma.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 pkt-line.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index af83a19f4d..d6d08b6aa6 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -597,12 +597,18 @@ void packet_reader_init(struct packet_reader *reader, int fd,
 enum packet_read_status packet_reader_read(struct packet_reader *reader)
 {
 	struct strbuf scratch = STRBUF_INIT;
+	int options = reader->options;
 
 	if (reader->line_peeked) {
 		reader->line_peeked = 0;
 		return reader->status;
 	}
 
+	/* Do not chomp newlines for sideband progress and error messages */
+	if (reader->use_sideband && options & PACKET_READ_CHOMP_NEWLINE) {
+		options &= ~PACKET_READ_CHOMP_NEWLINE;
+	}
+
 	/*
 	 * Consume all progress packets until a primary payload packet is
 	 * received
@@ -615,7 +621,7 @@ enum packet_read_status packet_reader_read(struct packet_reader *reader)
 							 reader->buffer,
 							 reader->buffer_size,
 							 &reader->pktlen,
-							 reader->options);
+							 options);
 		if (!reader->use_sideband)
 			break;
 		if (demultiplex_sideband(reader->me, reader->status,
@@ -624,12 +630,19 @@ enum packet_read_status packet_reader_read(struct packet_reader *reader)
 			break;
 	}
 
-	if (reader->status == PACKET_READ_NORMAL)
+	if (reader->status == PACKET_READ_NORMAL) {
 		/* Skip the sideband designator if sideband is used */
 		reader->line = reader->use_sideband ?
 			reader->buffer + 1 : reader->buffer;
-	else
+
+		if ((reader->options & PACKET_READ_CHOMP_NEWLINE) &&
+		    reader->buffer[reader->pktlen - 1] == '\n') {
+			reader->buffer[reader->pktlen - 1] = 0;
+			reader->pktlen--;
+		}
+	} else {
 		reader->line = NULL;
+	}
 
 	return reader->status;
 }
-- 
2.40.1.49.g40e13c3520.dirty

