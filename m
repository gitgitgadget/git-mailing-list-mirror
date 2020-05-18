Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F6CC433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 15:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A5620657
	for <git@archiver.kernel.org>; Mon, 18 May 2020 15:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCqj+g39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgERPro (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 11:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbgERPrm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 11:47:42 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DDAC05BD09
        for <git@vger.kernel.org>; Mon, 18 May 2020 08:47:42 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id m11so10567258qka.4
        for <git@vger.kernel.org>; Mon, 18 May 2020 08:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T9Umo+uQnskgYD0VKJjB6NmZc/j0wcFhDiAeS4u5wxE=;
        b=UCqj+g39NYE8RGNuU7/H6dMLS5hBN+v7uSUInm+nrpBs5DcWsdRvD8z2qcjCiT0Q/7
         IBr75PB9x2Yt3S10xnpn+/t3PgTRiE753jjXXt3e9J6PEMdBvSTIIXCzrR8+mNnhoNEX
         HCQ0gUu0ufMsNr+E4ClcW4kzDPZiTLk+HNQbiADddQuKrfeclBb4wNHvOBnw9Ovv0OR3
         SB+bFfUyr7d1x0JclN51Lm7eGnw+DkIQ9GOQ0Uk0tv5W0jWRyUmvaFxNQn/RvWhSQ/W5
         xXSNhu7GLnYcNiT2n4fWL0UakWUjRhI1bSC95+Hx6vzpY26NihrbDWrnB2OIxOsR2wpE
         R6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T9Umo+uQnskgYD0VKJjB6NmZc/j0wcFhDiAeS4u5wxE=;
        b=A8y5y9qPkmo4tVwq91ZobQNIwNMyVHe2UP5S62lPUPBc/tTufGH+C58JtGr925R3IW
         CfmPGmkOOpG5K+2yNqWj2uJmPpLsr9xsvFlfkmuAzLWD+a0OyEMi5pZT9cqyPhcrdJ6l
         jsoTIQTE92HV/8awCVmGyMoZtwTRTA1io4uLoujkjnuFhZ3U1hC8N172Da6BBW7QDZs5
         AAICGU3zICyx0waQUZG8877HsSRBWgpLtr+tsZh6J0j078VWViqriAjsFdOZRS886Q8A
         6stlFkvb4PmwjMzFjSuNTnjlpOS2WQbMbdlG884M6S/x7xtkYcFd3OodDFYZar+Jf9R/
         TQ8w==
X-Gm-Message-State: AOAM531gMuD90ZCGtD8TIV19baJ2rXyptEonKFj96tDaEbo5zTMw7dza
        fCYUWf5pi14ck2MgqNCS9ZPhm8wR
X-Google-Smtp-Source: ABdhPJwNfec51qXl2z7yxSED6SgAujfTEq2Z/Wn3g2bNdSlMazXrNzvOLe3V1QUiD3Nt/NmS7AJr1w==
X-Received: by 2002:a37:f517:: with SMTP id l23mr16784967qkk.475.1589816861664;
        Mon, 18 May 2020 08:47:41 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id z201sm5146913qkb.2.2020.05.18.08.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 08:47:40 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 6/7] pkt-line: PACKET_READ_RESPONSE_END
Date:   Mon, 18 May 2020 11:47:23 -0400
Message-Id: <744b0783248efe1b43f80b9be21be6d380a11a08.1589816719.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.706.g87896c9627
In-Reply-To: <cover.1589816718.git.liu.denton@gmail.com>
References: <cover.1589393036.git.liu.denton@gmail.com> <cover.1589816718.git.liu.denton@gmail.com>
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
index 5c3b4539b5..fdd6b90e68 100644
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
index de81776a7a..8156445873 100644
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

