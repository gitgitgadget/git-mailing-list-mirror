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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2630C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9807564EBF
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhBATrg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 14:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbhBATqf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 14:46:35 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC386C061786
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 11:45:54 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id 7so17971706wrz.0
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 11:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IAjoLQ+6HtO0n/chdlaaMSaGY2qzMCuiZTD2k2dLb2E=;
        b=peVM5rLqC+hn3uFY2y3DyghqPqbwqHNZW6SNSxOEIkyZzfHASkLogTdddk2DRLA7kE
         SHXjwgUarSq6pzBLrzhSCilJ5Hk2jLMFYTdBgLtp/t2mdvxYNNsUJSn3zC2pMUZHS0Co
         HybC/YDTtaZS/xTZ94u/yJZi4UcGYhRkW5DRalEOEdq/Oa7mvghtDNwZhFxmgl08krCl
         Z1ZVk/GlUfhHihuAaIxaoO6Tg3DMqsCGeFnvW5OKsBmxzvz42uqK1Dxnsxk2KRziE5jR
         BYzovmtjCGLxu08xCMGA1iR8G+GjTeUezE4PslUEw9A0aE/RUrMYcXR6rHuGdZZ3CJpN
         nbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IAjoLQ+6HtO0n/chdlaaMSaGY2qzMCuiZTD2k2dLb2E=;
        b=dzWzi3ZsjPNOpCGC9NYCbKEHIC7YRs0Tm/qIYLbg2c2e290zDcuZdBDU1LZvIIxqBK
         Gla1PzawB6U2BG6wLKA04sRX/Ps5GBLRe0zgeR8WrAAtjMgOw3YcKaSYbNpZHcmlrmy5
         wzbj6g9E5z9xu45ahq9qhGunJDbV1ybWjxAjj9a93srg+yGk6HtOuyb2lFW00yxWkbUd
         pcK6IC9LrkP1VefjGYOLx0eU7dHkl3qdYxErF1ZRYTreAGHtvoZYXPP+1yvmnn4OfHZ0
         CxQE3QjmLY2wL0BKh0yqyPRXUhD4IIQXCSnFXtCQhFPtj0jpRfXiyIjWGmagKgJMyx19
         irHw==
X-Gm-Message-State: AOAM532gVSOSrtlnaMXflP7Gu+MkJLZd+Eqn8d2shH8bvLG5cHDypnqi
        56q/EgKPSBYaLiMU2Hj4RxN1UqvofEw=
X-Google-Smtp-Source: ABdhPJzEAl3l/kLwyyJAbUple0/fEHIFfa3zFxiy8qaayryZZ1phisBVeyMnFI8kP6urza4LXstSIQ==
X-Received: by 2002:a5d:5549:: with SMTP id g9mr21116148wrw.244.1612208753279;
        Mon, 01 Feb 2021 11:45:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u3sm30205701wre.54.2021.02.01.11.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 11:45:52 -0800 (PST)
Message-Id: <0832f7d324da643d7a480111d693ff5559c2b7a7.1612208747.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
        <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 19:45:37 +0000
Subject: [PATCH v2 04/14] pkt-line: optionally skip the flush packet in
 write_packetized_from_buf()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
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

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 convert.c  | 2 +-
 pkt-line.c | 9 ++++++---
 pkt-line.h | 4 +++-
 3 files changed, 10 insertions(+), 5 deletions(-)

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
index 5d86354cbeb..d91a1deda95 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -275,14 +275,17 @@ int write_packetized_from_fd(int fd_in, int fd_out)
 	return err;
 }
 
-int write_packetized_from_buf(const char *src_in, size_t len, int fd_out)
+int write_packetized_from_buf(const char *src_in, size_t len, int fd_out,
+			      int flush_at_end)
 {
 	static struct packet_scratch_space scratch;
 
-	return write_packetized_from_buf2(src_in, len, fd_out, &scratch);
+	return write_packetized_from_buf2(src_in, len, fd_out,
+					  flush_at_end, &scratch);
 }
 
 int write_packetized_from_buf2(const char *src_in, size_t len, int fd_out,
+			       int flush_at_end,
 			       struct packet_scratch_space *scratch)
 {
 	int err = 0;
@@ -299,7 +302,7 @@ int write_packetized_from_buf2(const char *src_in, size_t len, int fd_out,
 		err = packet_write_gently(fd_out, src_in + bytes_written, bytes_to_write, scratch);
 		bytes_written += bytes_to_write;
 	}
-	if (!err)
+	if (!err && flush_at_end)
 		err = packet_flush_gently(fd_out);
 	return err;
 }
diff --git a/pkt-line.h b/pkt-line.h
index f1d5625e91f..ccf27549227 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -40,8 +40,10 @@ void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len);
 int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int write_packetized_from_fd(int fd_in, int fd_out);
-int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
+int write_packetized_from_buf(const char *src_in, size_t len, int fd_out,
+			      int flush_at_end);
 int write_packetized_from_buf2(const char *src_in, size_t len, int fd_out,
+			       int flush_at_end,
 			       struct packet_scratch_space *scratch);
 
 /*
-- 
gitgitgadget

