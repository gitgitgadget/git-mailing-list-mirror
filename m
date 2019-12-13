Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1CCC2D0C8
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82F32173E
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="unbL+J68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731718AbfLMAnh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:43:37 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:41779 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731709AbfLMAnf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 19:43:35 -0500
Received: by mail-pg1-f202.google.com with SMTP id r30so346120pgm.8
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 16:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GHPS1RzDUOQ6QbXrCNkCqbcKszw+nDn47/gRPb+DnK8=;
        b=unbL+J68nBUTkDKU3j6dwQOZ6esKEXRRojZFIonSbGfVEr+vxrch+hSGBxMvYC8+FJ
         L1eEQSFfAi/lRAcqCuRZJnsmIyP8gfyszfxpBDwwZMlu5CV/rBb7j1bUCIZpYLvImmiC
         VPyTW0xLdMl2o0cFwQmtlZh+IMefX3SWuzBp2yT0SAX03xy4bfik8nRvfbCOpa16ttrQ
         a68Ss4wiz/CIgDAxwRWRvDNfYAJz5knCMiRZAl+cPjN6mMy63dxIkhqL9D1IeNllsMdb
         4gSs8ArwjbjGcQShFp5/0L3l5D9/t2La9RIO0FTD2gQ6miTjMXoLZLx2qWNav0byI5ue
         LkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GHPS1RzDUOQ6QbXrCNkCqbcKszw+nDn47/gRPb+DnK8=;
        b=AexhevW126zD8MsSY9nqoDJNtAZX4KYVg7VOCxmwro+y1II/a58zlqQVtCtIN7f6sE
         S69u/YijEsV4ExfGgYfmmdd8rIuDj6aM9UZrkj/R9nV/WxAikcuUmq4BKdwtB3Iij0eI
         8jJJehyl7cH+NpEftpEL/AoDl+3Qx3pYwYM2Fr9bJUbeDVlZFA7CKpmhLnXotjw5LQS3
         sQsoP6+DU71rixCPJ1czg/hdKobq3nJN21a6WxmMX8F2TiZb+SMDRpdFLZBxTJh2OOuo
         dD1RqRmR2BHgvpxnbmYgsZOvX9q6b+rxuWRZrnJvLhzMh2tyN6QV1/HcSMUKPDNxqAWS
         MVcQ==
X-Gm-Message-State: APjAAAX7iKDNgNUXYeNAtT3FmdjAYz3g+g3kg5fvFHuWwmAaNVbh2kzJ
        GfmkFGhD9viS38JxW2cMj3YtM0l+QYET6xFDCa+aKW+GY1PmacgjtN7AUewsZxr5i+Ydr6pxPHb
        YLgtKHkZnqlWFtWmdGv2LeO+3ak4PySq9otmyJydAkOutsTSTEizRV2WD8f3Dbc0468wHpNl3sQ
        ==
X-Google-Smtp-Source: APXvYqzEYHwK0IDXcPe20pSMpyxoQNIXUEyEoPWmb6WuUDXbO7Ur4k/xXha+Vq3bTlkYmTTfIZpWsnpF6F4HBW2zMjY=
X-Received: by 2002:a65:68d4:: with SMTP id k20mr14010540pgt.142.1576197814764;
 Thu, 12 Dec 2019 16:43:34 -0800 (PST)
Date:   Thu, 12 Dec 2019 16:43:01 -0800
In-Reply-To: <20191213004312.169753-1-emilyshaffer@google.com>
Message-Id: <20191213004312.169753-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191213004312.169753-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v4 04/15] help: add shell-path to --build-options
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It may be useful to know which shell Git was built to try to point to,
in the event that shell-based Git commands are failing. $SHELL_PATH is
set during the build and used to launch the manpage viewer, as well as
by git-compat-util.h, and it's used during tests. 'git version
--build-options' is encouraged for use in bug reports, so it makes sense
to include this information there.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 help.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/help.c b/help.c
index a43693fca5..6d1bd17971 100644
--- a/help.c
+++ b/help.c
@@ -642,6 +642,7 @@ void list_version_info(struct strbuf *buf, int build_options)
 			strbuf_addf(buf, "no commit associated with this build\n");
 		strbuf_addf(buf, "sizeof-long: %d\n", (int)sizeof(long));
 		strbuf_addf(buf, "sizeof-size_t: %d\n", (int)sizeof(size_t));
+		strbuf_addf(buf, "shell-path: %s\n", SHELL_PATH);
 		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
 	}
 }
-- 
2.24.1.735.g03f4e72817-goog

