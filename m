Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F40C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3316C64ECB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhBATtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 14:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbhBATqd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 14:46:33 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF44CC0613ED
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 11:45:53 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id 7so17971667wrz.0
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 11:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m8IpXcH5RcuEGRDPYOKsp8OHYVdfh8TgVVg0bIEweZA=;
        b=KBhYybb/OVTGy2AUxk8XRdJTadnkgJ/gWBuMDtcycX+oJzJAekuNJgTPsN78OtZu0l
         r4vyvaPnR4M8x3n2L+YG6MBEyzgRVLOl2xNVQPvlz3mply2kqcO3kf34uEPjeIZ3ruo0
         zo7f7GiaAa+VaKqARc7E+d/zSVVPQc5AVgu1RkSEF3ZBU9F7Woc55xM9csKzRi9Nwe2t
         wtaLxBtlw3W5CSFn+KjWR6DJ5nlWrJ81ihIWVXK1TUvD//vywWiAFN6Zfgyayh13vKWZ
         ISAHadM5n/2aEf0WYMP9FOKElt+zO+uZY/9s0bZzUrSdmVJEy53DFZNE4R229cv/txzs
         6jOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m8IpXcH5RcuEGRDPYOKsp8OHYVdfh8TgVVg0bIEweZA=;
        b=eeh9O6s9b82WZ/mzTCQRGV20I2esI/UDs6q03VBwFDaNhKZqf9+narGtdpDmH/9lNW
         H2F5EOUW5pGD8PJcNGSSQwkVKmXvtBJ7ty+quo4zz8em4O4P7Y2I/rOYY74TNkPDUNCS
         uuf0CcBebexIah8u+JB4L368Y4fnNdyLeKbeddTkT0Mv23TLIxUfweNJDGAXHmU3mca8
         hofNGOfFHPuYvxLDIAIw+95P3vaxhzkUs5A4GRnlFmyn8kLcS3v5PVWOR1ME9OTinTO/
         3w87IzT6cFT2GHMbHEulFgRxZdr5IAPmFaM+iqR5eF6LVnn/W05gAMhcgQpkd0dkT3E/
         G00A==
X-Gm-Message-State: AOAM532pxuM4oxNSK+yM9lcp5Z7SbyxKkHKR0s7q+hAdzBA4U/sj6j8g
        N7inr1qGpz3RMPVv/NBQytSg9EVhxok=
X-Google-Smtp-Source: ABdhPJz97bAs9CLqlmOmvmCduyZ6QIFycD2+zRvD8KJT0PyzhC+ydl30EkR0/YNp9Hvfz7BnESq9bQ==
X-Received: by 2002:adf:d852:: with SMTP id k18mr20178028wrl.262.1612208752353;
        Mon, 01 Feb 2021 11:45:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i18sm20111119wrn.29.2021.02.01.11.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 11:45:51 -0800 (PST)
Message-Id: <e671894b4c0419138e66270aa9699053bdd504be.1612208747.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
        <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 19:45:36 +0000
Subject: [PATCH v2 03/14] pkt-line: add write_packetized_from_buf2() that
 takes scratch buffer
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create version of `write_packetized_from_buf()` that takes a scratch buffer
argument rather than assuming a static buffer.  This will be used later as
we make packet-line writing more thread-safe.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 pkt-line.c | 9 ++++++++-
 pkt-line.h | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/pkt-line.c b/pkt-line.c
index 14af049cd9c..5d86354cbeb 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -278,6 +278,13 @@ int write_packetized_from_fd(int fd_in, int fd_out)
 int write_packetized_from_buf(const char *src_in, size_t len, int fd_out)
 {
 	static struct packet_scratch_space scratch;
+
+	return write_packetized_from_buf2(src_in, len, fd_out, &scratch);
+}
+
+int write_packetized_from_buf2(const char *src_in, size_t len, int fd_out,
+			       struct packet_scratch_space *scratch)
+{
 	int err = 0;
 	size_t bytes_written = 0;
 	size_t bytes_to_write;
@@ -289,7 +296,7 @@ int write_packetized_from_buf(const char *src_in, size_t len, int fd_out)
 			bytes_to_write = len - bytes_written;
 		if (bytes_to_write == 0)
 			break;
-		err = packet_write_gently(fd_out, src_in + bytes_written, bytes_to_write, &scratch);
+		err = packet_write_gently(fd_out, src_in + bytes_written, bytes_to_write, scratch);
 		bytes_written += bytes_to_write;
 	}
 	if (!err)
diff --git a/pkt-line.h b/pkt-line.h
index 4ccd6f88926..f1d5625e91f 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -41,6 +41,8 @@ int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int write_packetized_from_fd(int fd_in, int fd_out);
 int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
+int write_packetized_from_buf2(const char *src_in, size_t len, int fd_out,
+			       struct packet_scratch_space *scratch);
 
 /*
  * Read a packetized line into the buffer, which must be at least size bytes
-- 
gitgitgadget

