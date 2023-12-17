Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D89144C81
	for <git@vger.kernel.org>; Sun, 17 Dec 2023 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2hYPccN"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1f055438492so1749330fac.3
        for <git@vger.kernel.org>; Sun, 17 Dec 2023 06:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702824103; x=1703428903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4opvOjBcm3b9ZlpvxPjhXXCr3HxAO3fjdsZCeIwaGV0=;
        b=T2hYPccNiE4ViBoE/d4Jk00edpN64VwyC3GSBjZNq6SwUQBFW1mDdO5KkjiGhSMVOc
         QKdTdvSM50yMJwo+Ssd/9xy5lRrYEluLqNCNbaSlxY0WxaC5n318mBfE3+smun2sSQn8
         8VKBOyRCBmmH6QEbZ5euK99WMYNNY2NjcfMr8XcPXujnAaWUgr5vgJqY8HyQbirv3AcG
         79XHmn+5s9IlPU5zqFGyQlo9Vuf2MO2RK1/sKo5Y+pLhfaGedCttPT0MQlVLzH/F7Rbq
         2FIDCQBiB73k4p5PMkTG/zZUkncYJckREOIw2F9hThZ5qi2O7PO+ps+KhFDnF0hswAqh
         vGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702824103; x=1703428903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4opvOjBcm3b9ZlpvxPjhXXCr3HxAO3fjdsZCeIwaGV0=;
        b=KjvWtCRlnbkQt/ZoIzKrwzunHvZQyKKABUA/xVf52pIMsXo4GyxI8koCcFAsQSDK5l
         Grklfjj2XcKgqJqkmWIMLxBCKf+ehXqfLSLx92/e0efxZV/sNLy3N+QRCxi+hodijjJH
         fbi3oLQ99HUIHkPbIhDNAfleIGnfz3jgYxQifvqNADKRajHQWquhxu92DmsOK0LNCXRb
         UvtqXRLKFIkehyWBZA0cRxU4wdq4iThzXZmdDC+aNZS87S0LARcxkWjoQqhdzz3YLOUU
         M2kIj8WknPbfyznpnEPmc8IpjJMmZR10Ai8JVS9zQtt0dg0/YN238dDeHSOhjC3XJ1ZL
         k9pg==
X-Gm-Message-State: AOJu0YxHz1QENcGiTtiwHjzwWIOjl+9hM3D705cBdwZ3AOIIPW78stlq
	BWLfK/ByZ4MHoc39EWTMRtkFaP48ZR0=
X-Google-Smtp-Source: AGHT+IHAR5Zdq+V1tebbtFiJB/CWioJPXyDIYVcyduqRf7P6+sLTvzu4qN/wLjzD1jx1+y1pXHWCXw==
X-Received: by 2002:a05:6870:c785:b0:203:9f4b:9529 with SMTP id dy5-20020a056870c78500b002039f4b9529mr1805051oab.36.1702824103409;
        Sun, 17 Dec 2023 06:41:43 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id i4-20020a63cd04000000b005c1ce3c960bsm16276657pgg.50.2023.12.17.06.41.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Dec 2023 06:41:42 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v4 3/3] pkt-line: do not chomp newlines for sideband messages
Date: Sun, 17 Dec 2023 22:41:38 +0800
Message-Id: <dd2e34da16ccd213e77a317c1d5afd2e44ebf339.1702823801.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1702823801.git.zhiyou.jx@alibaba-inc.com>
References: <cover.1696425168.git.zhiyou.jx@alibaba-inc.com> <cover.1702823801.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 275edbf6e7..0d2b7d8d93 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -97,7 +97,7 @@ test_expect_success 'unpack-sideband: packet_reader_read() consumes sideband, no
 	test_cmp expect-err err
 '
 
-test_expect_failure 'unpack-sideband: packet_reader_read() consumes sideband, chomp payload' '
+test_expect_success 'unpack-sideband: packet_reader_read() consumes sideband, chomp payload' '
 	test_when_finished "rm -f expect-out expect-err" &&
 	test-tool pkt-line send-split-sideband >split-sideband &&
 	test-tool pkt-line unpack-sideband \
-- 
2.41.0.232.g2f6f0bca4f.agit.8.0.4.dev

