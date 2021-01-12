Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB37AC4332B
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 15:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 914D123130
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 15:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391360AbhALPcT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 10:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729960AbhALPcS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 10:32:18 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B87EC061795
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 07:31:38 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q18so2944836wrn.1
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 07:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iSqNh8w9nhe34gEVACalSGo+pyNScoUsSJCBtFuqWhM=;
        b=kY1j3YTdt6njQianwvvu7rFoP/KmQaE+d2ZmZ1j/qGHWJVUVzHlEjugr4l4AS86MTc
         hXvRSD7NsLmudH96rwFQLDywVnlDn3PTnKP7FBpGxc45gtMfgqPmkzn5QaNjBxpw4T5k
         SW/iroyccO46//Rvkn4RocxZOOhpgARlJwYkZ4CevYQKtDCnxvidWicnnA78lJ+xn9o5
         JaJvFQJyNxJZsaBbDuXk//VzxcdSNWs3oDypmlQsneeb3WJrdeOK+gQdVfLodNsZ85mL
         UI3pf+QFMWm2Eyni+KfXmv4N1dA9/X2kYVLfO5h2e3Yz9eniyYVbcgEvsQJq1M4Hb7JR
         BxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iSqNh8w9nhe34gEVACalSGo+pyNScoUsSJCBtFuqWhM=;
        b=X/ys6vz+jHnk7+O2J5SoBpi9L5i4b5GDdYjaRTmmc+DON/KjnBqyMHkGthvupMf3VL
         atBbp6UMVOOpCeHRcSnaTfwT3PpHLm4ifQj1McDFxoWh5FHtoHxIsFCPIyFdtNFr2R6N
         XGmcH/TevCSVzFZkt9PlqqXoooeSG+Udcb4ddUaRkhzrHjgz1E06oU8WCrWOmK/BOIXC
         Gje6fz/82VvKUHdjsuVfAmenA7y7lHcbrBm9oLwW2YCnfT9lTihU0IDTMTzCcpIcBr6n
         CyEmtqAfLQ5ibLXNJmiAZjOKvQlsUvdXo7bWY/3IjMqN7ZnU9bxuOzABU43CNGbMEeJ8
         TcDQ==
X-Gm-Message-State: AOAM533ak6bUCELBcQUinA0ZfCMEQHCbOrMlqvIhDnqDGSkit3wEbq0j
        A+hSYWTczdF64YBunFl6t9t7haY1Cks=
X-Google-Smtp-Source: ABdhPJxW+ZV2awW6IY4/e2rSOEvhwko8je50MnAa8H2qyiNrjhSxYmQE2JTlFX10m0lMmudtUJlDzw==
X-Received: by 2002:adf:83a6:: with SMTP id 35mr4878315wre.274.1610465497064;
        Tue, 12 Jan 2021 07:31:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z3sm5734470wrn.59.2021.01.12.07.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 07:31:36 -0800 (PST)
Message-Id: <edf5ac95d662984b67d49bd452faf480c7c2da02.1610465493.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.git.1610465492.gitgitgadget@gmail.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jan 2021 15:31:25 +0000
Subject: [PATCH 03/10] pkt-line: optionally skip the flush packet in
 write_packetized_from_buf()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This function currently has only one caller: `apply_multi_file_filter()`
in `convert.c`. That caller wants a flush packet to be written after
writing the payload.

However, we are about to introduce a user that wants to write many
packets before a final flush packet, so let's extend this function to
prepare for that scenario.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 convert.c  | 2 +-
 pkt-line.c | 5 +++--
 pkt-line.h | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/convert.c b/convert.c
index ee360c2f07c..3f396a9b288 100644
--- a/convert.c
+++ b/convert.c
@@ -886,7 +886,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	if (fd >= 0)
 		err = write_packetized_from_fd(fd, process->in);
 	else
-		err = write_packetized_from_buf(src, len, process->in);
+		err = write_packetized_from_buf(src, len, process->in, 1);
 	if (err)
 		goto done;
 
diff --git a/pkt-line.c b/pkt-line.c
index 5c2d86a2f60..ef83439b9ee 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -261,7 +261,8 @@ int write_packetized_from_fd(int fd_in, int fd_out)
 	return err;
 }
 
-int write_packetized_from_buf(const char *src_in, size_t len, int fd_out)
+int write_packetized_from_buf(const char *src_in, size_t len, int fd_out,
+			      int flush_at_end)
 {
 	int err = 0;
 	size_t bytes_written = 0;
@@ -277,7 +278,7 @@ int write_packetized_from_buf(const char *src_in, size_t len, int fd_out)
 		err = packet_write_gently(fd_out, src_in + bytes_written, bytes_to_write);
 		bytes_written += bytes_to_write;
 	}
-	if (!err)
+	if (!err && flush_at_end)
 		err = packet_flush_gently(fd_out);
 	return err;
 }
diff --git a/pkt-line.h b/pkt-line.h
index c1fa245faf8..5b7a0fb8510 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -33,7 +33,8 @@ void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len);
 int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int write_packetized_from_fd(int fd_in, int fd_out);
-int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
+int write_packetized_from_buf(const char *src_in, size_t len, int fd_out,
+			      int flush_at_end);
 
 /*
  * Read a packetized line into the buffer, which must be at least size bytes
-- 
gitgitgadget

