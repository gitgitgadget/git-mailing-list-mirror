Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D3BC433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 13:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbiCDNM1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 08:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbiCDNMW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 08:12:22 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACB4159EBC
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 05:11:34 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id i8so12617808wrr.8
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 05:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=X7UFKt20OzqJRkq7F0/bLmm138QCw2Ra5GrakKUyHwk=;
        b=a9RWE64dvPKSc5R4ZA0bM37WQ0YPZlhM1uKQmTcjY7v6zzqPCwI2dmlykPt2smgn0u
         +ReM7f3A4FsJSMkn2biDancifHDuYabktIQC02ZUrpJtjY0z9occ7VOOd+8u2G0aq9Gp
         VumtF8yfnHWc65Lb/xUby+i+ZAcILcw7irrUCqP/cl0kcc+4IvGDRQezRqGmPU/e8kkT
         J/nPAQbVV/Pb0EUzgZ3POUmbZBWu9AoisHEWjGaAP+XBS+jJ0rp0HQiRO1vQ+w5iZNan
         pGFaANAaRRPnbeIz5hyryDnoRcBSwWyaHPQGFdBjzkFGu6HNCu2vcW2SZ6m772uJArVX
         ptZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=X7UFKt20OzqJRkq7F0/bLmm138QCw2Ra5GrakKUyHwk=;
        b=SPmWSXU/R7OgWx19JRYhnyQX+IRPyIot950DvakDZcJor2bFIqRlfNzccWXrWJFdBh
         ATtrccoXYIY72W43eluQ/b6N/C+UzvYK2COMMGdC1FpCWQe1tVODuEqnelmtwO9sPDY2
         HO/4akvPrLOEbeVCV34r+PBvTYwk3Lxy4xhLVF04I4F4CU4II5haNNRLItRzoGtF1S68
         7DvriCy9Cm8LiQ9NTVYnLaNRGEMgB3D2/M0I6wkMjFARRC1HODPgCAOP47ah3LLszvVi
         IknqIpM9OpMTb/oMK1a6jQG1Jm3pz9mJA84/gQGKyaeERUPo+87FAX40TgScLuFW6amI
         jYsg==
X-Gm-Message-State: AOAM531P7OgupDWU1Ii4GtLTBcvkqsfeM17I2yYNU/89p2+ZcNqZkdn0
        1Dkf8AOFAsfluMO4bmsQWvAJ8+i1DOs=
X-Google-Smtp-Source: ABdhPJxCVSvhzysUnH3WKYljC5Po4Z/xnZdRZfsFx6R4m+zBsN9RtFBSbMMG75XhpP18cFibGsMtAg==
X-Received: by 2002:a5d:59a1:0:b0:1f0:436c:f01d with SMTP id p1-20020a5d59a1000000b001f0436cf01dmr8835851wrr.360.1646399492744;
        Fri, 04 Mar 2022 05:11:32 -0800 (PST)
Received: from localhost.localdomain (230.2.7.51.dyn.plus.net. [51.7.2.230])
        by smtp.gmail.com with ESMTPSA id c4-20020adffb04000000b001f0494de239sm4634042wrr.21.2022.03.04.05.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 05:11:32 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     carenas@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 2/4] terminal: don't assume stdin is /dev/tty
Date:   Fri,  4 Mar 2022 13:11:24 +0000
Message-Id: <20220304131126.8293-3-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304131126.8293-1-phillip.wood123@gmail.com>
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

read_key_without_echo() reads from stdin but uses /dev/tty when it
disables echo. This is unfortunate as there no guarantee that stdin is
the same device as /dev/tty. The perl version of "add -p" uses stdin
when it sets the terminal mode, this commit does the same for the
builtin version. There is still a difference between the perl and
builtin versions though - the perl version will ignore any errors when
setting the terminal mode[1] and will still read single bytes when
stdin is not a terminal. The builtin version displays a warning if
setting the terminal mode fails and switches to reading a line at a
time.

[1] https://github.com/jonathanstowe/TermReadKey/blob/b061c913bbf7ff9bad9b4eea6caae189eacd6063/ReadKey.xs#L1090

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 compat/terminal.c | 5 +++--
 compat/terminal.h | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index bad8e04cd8..249836e78f 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -37,7 +37,8 @@ void restore_term(void)
 int save_term(unsigned flags)
 {
 	if (term_fd < 0)
-		term_fd = open("/dev/tty", O_RDWR);
+		term_fd = (flags & SAVE_TERM_STDIN) ? 0
+						    : open("/dev/tty", O_RDWR);
 	if (term_fd < 0)
 		return -1;
 	if (tcgetattr(term_fd, &old_term) < 0)
@@ -362,7 +363,7 @@ int read_key_without_echo(struct strbuf *buf)
 	static int warning_displayed;
 	int ch;
 
-	if (warning_displayed || enable_non_canonical(0) < 0) {
+	if (warning_displayed || enable_non_canonical(SAVE_TERM_STDIN) < 0) {
 		if (!warning_displayed) {
 			warning("reading single keystrokes not supported on "
 				"this platform; reading line instead");
diff --git a/compat/terminal.h b/compat/terminal.h
index f24b91390d..f5655d0d0b 100644
--- a/compat/terminal.h
+++ b/compat/terminal.h
@@ -3,7 +3,8 @@
 
 /* Save input and output settings */
 #define SAVE_TERM_DUPLEX (1u << 0)
-
+/* Save stdin rather than /dev/tty (fails is stdin is not a terminal) */
+#define SAVE_TERM_STDIN  (1u << 1)
 /*
  * Save the terminal attributes so they can be restored later by a
  * call to restore_term(). Note that every successful call to
-- 
2.35.1

