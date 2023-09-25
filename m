Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08338CE7A95
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 15:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjIYPnC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 11:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbjIYPms (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 11:42:48 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281CB1B0
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 08:41:53 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68bed2c786eso5099312b3a.0
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 08:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695656513; x=1696261313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWBlxYOnj3oiypVmQk70xSZhLI2DR1Jp0/COC85VX18=;
        b=LGjbANAuoGE7NbR9FmLdSuvdsgUFSZz3zoFjhLN3vI5636hr+5mok8QV73b55ATZoq
         BOVLxRpiGnv2oWltScUwt7FTNwNI8BK9E5du9yV88MyCVR4Ci7h0f2Iqi5YWYsMAEoj6
         p5WU5aY818get/SPZQjxdsA6BhgMoveCBo9ST4l5NBnOjoi2xwBekKGfrVKcRnv9OTld
         tKoIOqT4MRRa5skhLFoIcEMpnC9poeqX3+TN5t/DNcrE3VGa/XB0Q8WqdJEsoEO+3E4P
         pnKEJwmkmVkvL7UO+IlefYXBqD4HrHIwfbu9EqlNmITjiY2ZiHx4LzCPB50WfIN88iCG
         dyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695656513; x=1696261313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWBlxYOnj3oiypVmQk70xSZhLI2DR1Jp0/COC85VX18=;
        b=WDsUnuR64L/BUUptvLFtyZc0kYYoIy3WUr8PiPv/4z+BDsCrcgcU5YnBMIXrEIj+5w
         skbxBmzELA4tJBJFunwPUzx38H6GVEg9kIjNViuFTvOWjJ3pUSskomfvmbhN6fFJ5lUJ
         1R59RRa63J7u8Rx+cS1iUs7+2S6kM0LBc7z1Ief0zH2c+aIsI3skYv8xRybjioxZPPcY
         mFQWxE5Mzq42GvI0IW/1k9+oL1CL1STaJjvSxCBfC/SI0H50nKLIulOJD26GSqNY0Tp0
         6kU13OfSxHPpzbhCa0znzavEPCHjRRTus/4gLlfqBa6F2cZooAX/RZJrvhG5rnSMoZ7v
         1oSg==
X-Gm-Message-State: AOJu0YzgrHa7hVFojRi3J6RGP5/dNnukB+GrQwkdTTv+xfFTLTNWyWvv
        EMIO/O3hrr2Zq4WlHoKBX0/8J8htqZ8=
X-Google-Smtp-Source: AGHT+IFo4Cu22Yu4keWkuQWgKTLntw2uug5WJbnSAfDQTbj4PF1jQHHVpZYaaTxAPf9xbOO4jxNoeg==
X-Received: by 2002:a05:6a20:1593:b0:14c:a53c:498e with SMTP id h19-20020a056a20159300b0014ca53c498emr6412572pzj.42.1695656512778;
        Mon, 25 Sep 2023 08:41:52 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a1a4500b00274e610dbdasm10960638pjl.8.2023.09.25.08.41.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Sep 2023 08:41:52 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2 3/3] pkt-line: do not chomp newlines for sideband messages
Date:   Mon, 25 Sep 2023 23:41:44 +0800
Message-Id: <20230925154144.15213-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <CANYiYbF+Xmk4rCNLMJe+i_CFafg8=QU5vbXWNUZbOVsDLTe5QQ@mail.gmail.com>
References: <CANYiYbF+Xmk4rCNLMJe+i_CFafg8=QU5vbXWNUZbOVsDLTe5QQ@mail.gmail.com>
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
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 pkt-line.c             | 32 ++++++++++++++++++++++++++++++--
 pkt-line.h             |  1 +
 t/t0070-fundamental.sh |  2 +-
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 5943777a17..865ad19484 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -462,8 +462,33 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
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
+				/* fallthrough */
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
@@ -602,6 +627,9 @@ enum packet_read_status packet_reader_read(struct packet_reader *reader)
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

