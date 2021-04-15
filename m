Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B089AC433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 19:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC0B60BD3
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 19:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbhDOTKq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 15:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbhDOTKi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 15:10:38 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EEFC061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 12:10:15 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id h13so7724382qka.2
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 12:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PgPlUbRUKWW2XZt9ECdot7KMRUNLwlYJdz2qEBYdEuc=;
        b=oBJ/J0B7Spr4jexICW/VMFPOEo+9oN/vzLzclb4Bw3jM4x8brpsCKIx2OlvNoJ0NXN
         oruSVchmwbyqu8SjJ/D27cJwVSQEcxxUQbasUkdOrU0P/+99ckWuYROKVqiVH+hzrDS+
         C+9Phq4UrAK3roMM3qFMo3NxFTFGsC7qw4rF5Wp3XjTNDeJRP0IajxazIJTnCL7kQJ4t
         evfXgIFwHAQ4u3G39N3CU2PxELutxv2p/yCbHDQGALNPttr5p0kdIh4tmnZoFUxoRQKa
         2dmv8UwP2FW8WvE0hLE5bem3COh/ckziDAalYuSlQto3yzCOzvG5oIGjaHeSGmXRNaxY
         fP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PgPlUbRUKWW2XZt9ECdot7KMRUNLwlYJdz2qEBYdEuc=;
        b=moY69FpoHSivMAcgg5dc8Ll5zLvLkM3D0u7skNWZfJoMJRgxa40V+UKKDgPgym0VR2
         sM0KbgSDEI5tq9It9Xv1ZEeeolakvOQz0ToIlqPd/v/ZYzadWI7E5p28g3MNlJXkTAA8
         5/H5xAAbBrpXF9KdseJMgOb49MRQR/epVdUOWyJj3K///v5av7IRKlvz0/Lg+x7/Xi4W
         /xCWnIDEnSE2KqqAJRdsb3enHitq1+AHKTnlgLqYA/JafDaBFXUxvm5d2YOhyF7D/q7A
         SIzXdpLBKzaIWp7rpjYwDg2yqL9/SHq1rI33KKPY0Exqgh559Zo7hUZ4A9jawA1wevw7
         5S5w==
X-Gm-Message-State: AOAM533HjL9HIUjGU37oItlbGTtdXIeQd4eXvH9HIE52zQi/0/5ZTfo0
        0iyWa8MbdaG25ipJ+lUMd9Qyve46DFd+Xw==
X-Google-Smtp-Source: ABdhPJw92rX+Gj20XasR/gKCQw2QyRQj1FX8T2GjM2HgRnRS0l/ao18BNanRmGnQWWxtoS3Lp4ax4A==
X-Received: by 2002:a37:acd:: with SMTP id 196mr5225569qkk.219.1618513813933;
        Thu, 15 Apr 2021 12:10:13 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id 71sm2667976qkm.40.2021.04.15.12.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 12:10:13 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com
Subject: [PATCH] pkt-line: do not report packet write errors twice
Date:   Thu, 15 Apr 2021 16:10:07 -0300
Message-Id: <64b81865fdfcc505b6aa3e6ebaebf3b9ccb36eb1.1618513583.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On write() errors, packet_write() dies with the same error message that
is already printed by its callee, packet_write_gently(). This produces
an unnecessarily verbose and repetitive output:

error: packet write failed
fatal: packet write failed: <strerror() message>

In addition to that, packet_write_gently() does not always fulfill its
caller expectation that errno will be properly set before a non-zero
return. In particular, that is not the case for a "data exceeds max
packet size" error. So, in this case, packet_write() will call
die_errno() and print a strerror(errno) message that might be totally
unrelated to the actual error.

Fix both those issues by turning packet_write() and
packet_write_gently() into wrappers to a lower level function which is
now responsible to either error() or die() as requested by its caller.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 pkt-line.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 0194137528..39c9ca4212 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -194,13 +194,18 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
 	return status;
 }
 
-static int packet_write_gently(const int fd_out, const char *buf, size_t size)
+static int do_packet_write(const int fd_out, const char *buf, size_t size,
+			   int gentle)
 {
 	char header[4];
 	size_t packet_size;
 
-	if (size > LARGE_PACKET_DATA_MAX)
-		return error(_("packet write failed - data exceeds max packet size"));
+	if (size > LARGE_PACKET_DATA_MAX) {
+		if (gentle)
+			return error(_("packet write failed - data exceeds max packet size"));
+		else
+			die(_("packet write failed - data exceeds max packet size"));
+	}
 
 	packet_trace(buf, size, 1);
 	packet_size = size + 4;
@@ -215,15 +220,23 @@ static int packet_write_gently(const int fd_out, const char *buf, size_t size)
 	 */
 
 	if (write_in_full(fd_out, header, 4) < 0 ||
-	    write_in_full(fd_out, buf, size) < 0)
-		return error(_("packet write failed"));
+	    write_in_full(fd_out, buf, size) < 0) {
+		if (gentle)
+			return error_errno(_("packet write failed"));
+		else
+			die_errno(_("packet write failed"));
+	}
 	return 0;
 }
 
+static int packet_write_gently(const int fd_out, const char *buf, size_t size)
+{
+	return do_packet_write(fd_out, buf, size, 1);
+}
+
 void packet_write(int fd_out, const char *buf, size_t size)
 {
-	if (packet_write_gently(fd_out, buf, size))
-		die_errno(_("packet write failed"));
+	do_packet_write(fd_out, buf, size, 0);
 }
 
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
-- 
2.30.1

