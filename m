Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F13E7B60F
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 13:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242620AbjJDNSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 09:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242551AbjJDNSY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 09:18:24 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E307A1
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 06:18:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-278fde50024so730534a91.1
        for <git@vger.kernel.org>; Wed, 04 Oct 2023 06:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696425500; x=1697030300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJdymBj+423fFLsFiCBX4i6fvmXBJ4gIUzQTjizvMag=;
        b=QNJlzKKGoc4mlcReviNHWkfQL0hsrdhCwI+sGS8hqjNoICTNYJb9eaftq45ZsSNWwu
         joNqR+SRo31JFdEl8HTxzo2ZktsS+UM+xMylqGNrwhWuaombWgpbbNKbbrNsHmW+06jN
         NuW9RIvIHYfGOo/lEZE5es/S128ld1X5XOK48ApF+uzsgY586Ayry/BVs29DLo66s546
         zdI2FCUM7yYdb++Hyk+RjJDKaCKIcW7KteW4Q9jkNGKYtrWCCQDvB6OiGDsdVsQmOjMq
         I3qHNNycoRyvKeRZEC+Y7O3ioRwCp5pLwo46HGTg/id7eoReph7ZlsogVlOnAMYbGSWe
         FkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696425500; x=1697030300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJdymBj+423fFLsFiCBX4i6fvmXBJ4gIUzQTjizvMag=;
        b=EbU/2xIOkL1JgGnGTo0xZXG0FtMgk+pAyetYJTgyb6b8/wqJoH1kLteiH3Uv+OKrXa
         4pKlFclMs1fZDgZ1B2qsl1Q7FyiYRY43Q2VrBAMzbWY9qdoLHfDcu3e2wl3oBnrlThfT
         KtAi72dhaIO80Z0TccX69wQ6zNatYR0/y06YpELCiDAqaclHBnj9Qd6kQdFr1lekrluh
         L0mjZLLJ2RdL++9iVwjguSBryqG2aZY52H/p5oyqPFMaYNsyWsyN2pOcGLpuMuMuHdrU
         Thwo5LmCPnA+kEqw12U45FYq2xNLJ+BTq/lJESX5B2pHfRHLjRVALiwvJj3U7CCXk8tI
         aFxw==
X-Gm-Message-State: AOJu0YyDapTnK/J7QhEOJz9yCjvz8tHzh0eGxcjz/i09Yu0rKv/uCUXO
        hXVCkdgCAGGx2v6lhDTf+6qQH7yAbNg=
X-Google-Smtp-Source: AGHT+IHb2ZhmxEyyvL4pMz4bmZwW/KipTB2ZsQdEob2vh3ilHZDDEk7gpK8CPEDsehKHYj03NINjeA==
X-Received: by 2002:a17:90b:18b:b0:276:6be8:8bfe with SMTP id t11-20020a17090b018b00b002766be88bfemr3373871pjs.23.1696425500413;
        Wed, 04 Oct 2023 06:18:20 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y14-20020a17090a134e00b00260a5ecd273sm1465496pjf.1.2023.10.04.06.18.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2023 06:18:19 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 3/3] pkt-line: do not chomp newlines for sideband messages
Date:   Wed,  4 Oct 2023 21:18:14 +0800
Message-Id: <68ac3ea711ce2705a328e6b59c95c0ca884a7e6c.1696425168.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1696425168.git.zhiyou.jx@alibaba-inc.com>
References: <ZRKax7Me5uIHKHoC@ugly> <cover.1696425168.git.zhiyou.jx@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

When calling "packet_read_with_status()" to parse pkt-line encoded
packets, we can turn on the flag "PACKET_READ_CHOMP_NEWLINE" to chomp
newline character for each packet for better line matching. But when
receiving data and progress information using sideband, we should turn
off the flag "PACKET_READ_CHOMP_NEWLINE" to prevent mangling newline
characters from data and progress information.

When both the server and the client support "sideband-all" capability,
we have a dilemma that newline characters in negotiation packets should
be removed, but the newline characters in the progress information
should be left intact.

Add new flag "PACKET_READ_USE_SIDEBAND" for "packet_read_with_status()"
to prevent mangling newline characters in sideband messages.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 pkt-line.c             | 31 +++++++++++++++++++++++++++++--
 pkt-line.h             |  1 +
 t/t0070-fundamental.sh |  2 +-
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 5943777a17..e9061e61a4 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -462,8 +462,32 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 	}
 
 	if ((options & PACKET_READ_CHOMP_NEWLINE) &&
-	    len && buffer[len-1] == '\n')
-		len--;
+	    len && buffer[len-1] == '\n') {
+		if (options & PACKET_READ_USE_SIDEBAND) {
+			int band = *buffer & 0xff;
+			switch (band) {
+			case 1:
+				/* Chomp newline for payload */
+				len--;
+				break;
+			case 2:
+			case 3:
+				/*
+				 * Do not chomp newline for progress and error
+				 * message.
+				 */
+				break;
+			default:
+				/*
+				 * Bad sideband, let's leave it to
+				 * demultiplex_sideband() to catch this error.
+				 */
+				break;
+			}
+		} else {
+			len--;
+		}
+	}
 
 	buffer[len] = 0;
 	if (options & PACKET_READ_REDACT_URI_PATH &&
@@ -602,6 +626,9 @@ enum packet_read_status packet_reader_read(struct packet_reader *reader)
 		return reader->status;
 	}
 
+	if (reader->use_sideband)
+		reader->options |= PACKET_READ_USE_SIDEBAND;
+
 	/*
 	 * Consume all progress packets until a primary payload packet is
 	 * received
diff --git a/pkt-line.h b/pkt-line.h
index be1010d34e..a7ff2e2f18 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -85,6 +85,7 @@ void packet_fflush(FILE *f);
 #define PACKET_READ_DIE_ON_ERR_PACKET    (1u<<2)
 #define PACKET_READ_GENTLE_ON_READ_ERROR (1u<<3)
 #define PACKET_READ_REDACT_URI_PATH      (1u<<4)
+#define PACKET_READ_USE_SIDEBAND         (1u<<5)
 int packet_read(int fd, char *buffer, unsigned size, int options);
 
 /*
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index a927c665d6..138c2becc1 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -97,7 +97,7 @@ test_expect_success 'unpack-sideband with demultiplex_sideband(), no chomp newli
 	test_cmp expect-err err
 '
 
-test_expect_failure 'unpack-sideband with demultiplex_sideband(), chomp newline' '
+test_expect_success 'unpack-sideband with demultiplex_sideband(), chomp newline' '
 	test_when_finished "rm -f expect-out expect-err" &&
 	test-tool pkt-line send-split-sideband >split-sideband &&
 	test-tool pkt-line unpack-sideband \
-- 
2.40.1.50.gf560bcc116.dirty

