Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA97C433DF
	for <git@archiver.kernel.org>; Tue, 19 May 2020 10:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BF1E20758
	for <git@archiver.kernel.org>; Tue, 19 May 2020 10:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMXq44qf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgESKyU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 06:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728662AbgESKyS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 06:54:18 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90275C05BD09
        for <git@vger.kernel.org>; Tue, 19 May 2020 03:54:18 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id n22so8238162qtv.12
        for <git@vger.kernel.org>; Tue, 19 May 2020 03:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R4tgJGEiZjfkukk7zy3D2mJp0VLdTghlqnhnyxpePkc=;
        b=pMXq44qfH21mGkoAvourLwzBEfNHJFLWLmxaLntAix64mzWoV5UBpp5N5GXAVxU5ne
         ++36nRLZDz0lFAPDrR1zqBxJ1QBpVTomTi8dlZoN2J+u+jAWEJPVw/j2f761d5yLrbes
         nK9BjIWDVLUNlzfUtkwA0R4YRWtQGx7lsQsnIKoHyJtpZ3sPzLY34FPoqvwYRa6Sz2e9
         XA0JYEHohGUoKuno5SCCRNL11lzPCkkxE53dtsKqQyq60S+JP5umeYxw66OWOENPTlXu
         u41pXK+whTfPCR7qQaqXTZj4CrUFag+UY11BzyF0ahRB4fysdg+4OZrsKkEIaiDoTZre
         rVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R4tgJGEiZjfkukk7zy3D2mJp0VLdTghlqnhnyxpePkc=;
        b=o2E3YVLzgYatAkqFqG5I6Di2u+y4t9rSFdSKQnqCpyyBFYLCeS3n0ChZ4hzGvYCN9E
         GmzGoqtqHDjf5YmMh6QcmDOU8954k+smW5YzNa6tSsoYzROc06+nMOJIEVWg0YE9ei+9
         sIc52bsI/u4f6BGgPmDPMv9N/q7fa+5hJLs2I54Bd7msKFSUrDPfd7OxknzK6oAinQkE
         AHuxwby1PyuCU27+UhFUALtrKK7BeQIxhK2xEID141wIyfLfiTVV4l6jCm8dZfu44XBZ
         1c05XqyjcRWWku0lAdHxq0HhLfJRtIme8i0SrDCmRgmoTyFDAxCScC69Zb6+7658o95T
         /YTg==
X-Gm-Message-State: AOAM531oBxCUrij+YfMCg7ce826M+BTI5MXK6xepnzOgoU43pWAAieRk
        i659ftIBVjU7cPXKIlnfbJRQ+f6C
X-Google-Smtp-Source: ABdhPJzBCWg54gLgrAp5Kduk9C9mVAf0rFF5d/Zd2rFNJt0h6KRh3XeFwScXwq/ZPuH4y0+fXHYBbg==
X-Received: by 2002:ac8:7181:: with SMTP id w1mr20914182qto.125.1589885657611;
        Tue, 19 May 2020 03:54:17 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id c63sm10177775qkf.131.2020.05.19.03.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 03:54:17 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 6/7] pkt-line: define PACKET_READ_RESPONSE_END
Date:   Tue, 19 May 2020 06:53:59 -0400
Message-Id: <ff83344e9e8e771ee463e4cb056cfc47b4c661b5.1589885479.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.706.g87896c9627
In-Reply-To: <cover.1589885479.git.liu.denton@gmail.com>
References: <cover.1589816718.git.liu.denton@gmail.com> <cover.1589885479.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future commit, we will use PACKET_READ_RESPONSE_END to separate
messages proxied by remote-curl. To prepare for this, add the
PACKET_READ_RESPONSE_END enum value.

In switch statements that need a case added, die() or BUG() when a
PACKET_READ_RESPONSE_END is unexpected. Otherwise, mirror how
PACKET_READ_DELIM is implemented (especially in cases where packets are
being forwarded).

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 connect.c                |  2 ++
 pkt-line.c               | 11 +++++++++++
 pkt-line.h               |  2 ++
 remote-curl.c            |  2 ++
 serve.c                  |  2 ++
 t/helper/test-pkt-line.c |  4 ++++
 6 files changed, 23 insertions(+)

diff --git a/connect.c b/connect.c
index 23013c6344..11c6ec70a0 100644
--- a/connect.c
+++ b/connect.c
@@ -127,6 +127,7 @@ enum protocol_version discover_version(struct packet_reader *reader)
 		die_initial_contact(0);
 	case PACKET_READ_FLUSH:
 	case PACKET_READ_DELIM:
+	case PACKET_READ_RESPONSE_END:
 		version = protocol_v0;
 		break;
 	case PACKET_READ_NORMAL:
@@ -310,6 +311,7 @@ struct ref **get_remote_heads(struct packet_reader *reader,
 			state = EXPECTING_DONE;
 			break;
 		case PACKET_READ_DELIM:
+		case PACKET_READ_RESPONSE_END:
 			die(_("invalid packet"));
 		}
 
diff --git a/pkt-line.c b/pkt-line.c
index 3beab1dc6b..8f9bc68ee2 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -99,6 +99,13 @@ void packet_delim(int fd)
 		die_errno(_("unable to write delim packet"));
 }
 
+void packet_response_end(int fd)
+{
+	packet_trace("0002", 4, 1);
+	if (write_in_full(fd, "0002", 4) < 0)
+		die_errno(_("unable to write stateless separator packet"));
+}
+
 int packet_flush_gently(int fd)
 {
 	packet_trace("0000", 4, 1);
@@ -337,6 +344,10 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 		packet_trace("0001", 4, 0);
 		*pktlen = 0;
 		return PACKET_READ_DELIM;
+	} else if (len == 2) {
+		packet_trace("0002", 4, 0);
+		*pktlen = 0;
+		return PACKET_READ_RESPONSE_END;
 	} else if (len < 4) {
 		die(_("protocol error: bad line length %d"), len);
 	}
diff --git a/pkt-line.h b/pkt-line.h
index 0d92c5e17f..6cb92d7a5d 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -22,6 +22,7 @@
  */
 void packet_flush(int fd);
 void packet_delim(int fd);
+void packet_response_end(int fd);
 void packet_write_fmt(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 void packet_buf_flush(struct strbuf *buf);
 void packet_buf_delim(struct strbuf *buf);
@@ -94,6 +95,7 @@ enum packet_read_status {
 	PACKET_READ_NORMAL,
 	PACKET_READ_FLUSH,
 	PACKET_READ_DELIM,
+	PACKET_READ_RESPONSE_END,
 };
 enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 						size_t *src_len, char *buffer,
diff --git a/remote-curl.c b/remote-curl.c
index e020140092..d02cb547e9 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -601,6 +601,8 @@ static int rpc_read_from_out(struct rpc_state *rpc, int options,
 		case PACKET_READ_FLUSH:
 			memcpy(buf - 4, "0000", 4);
 			break;
+		case PACKET_READ_RESPONSE_END:
+			die(_("remote server sent stateless separator"));
 		}
 	}
 
diff --git a/serve.c b/serve.c
index 317256c1a4..c046926ba1 100644
--- a/serve.c
+++ b/serve.c
@@ -217,6 +217,8 @@ static int process_request(void)
 
 			state = PROCESS_REQUEST_DONE;
 			break;
+		case PACKET_READ_RESPONSE_END:
+			BUG("unexpected stateless separator packet");
 		}
 	}
 
diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
index 12ca698e17..69152958e5 100644
--- a/t/helper/test-pkt-line.c
+++ b/t/helper/test-pkt-line.c
@@ -46,6 +46,9 @@ static void unpack(void)
 		case PACKET_READ_DELIM:
 			printf("0001\n");
 			break;
+		case PACKET_READ_RESPONSE_END:
+			printf("0002\n");
+			break;
 		}
 	}
 }
@@ -75,6 +78,7 @@ static void unpack_sideband(void)
 		case PACKET_READ_FLUSH:
 			return;
 		case PACKET_READ_DELIM:
+		case PACKET_READ_RESPONSE_END:
 			break;
 		}
 	}
-- 
2.26.2.706.g87896c9627

