Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0A5C433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 08:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17F3561155
	for <git@archiver.kernel.org>; Wed,  5 May 2021 08:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhEEIld (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 04:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbhEEIlc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 04:41:32 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EABFC061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 01:40:36 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id w3so1537691ejc.4
        for <git@vger.kernel.org>; Wed, 05 May 2021 01:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B8FkfQECi6qsyUGDpbB1dgOV+3t/HrkRhpgfOncOgAo=;
        b=DH7ZJT2HjCFcj9jqGUWdlUsJx7stsMBlDC+IAwsdqEbJZG9zM4Cq/FcGRiBt39itHZ
         0tKJ2jD1UQhqmboESoZzXmDS1x8VGryeG9qY6mgUx3RSydLH3YXrKvk5qESSIKmI5F+x
         fOvKN/FrtzNxQfONssp+2vRsPGAqphtrHmHsCr9FTWH8/OsO54ZTgB9CaE7ZyV5LFRp4
         FNMm9B5xWqr5fQak/lnWS9tpGjzWazxaKnCBZAvzU5o8C/gQt7V4etTFGbP4gxdctxwK
         xLL90EnmTupOjnKC3CEjwuRjEPLNvXi36NX8t9hIhAXKeAkTtFS84mgD05Rr5FPhXDOo
         B+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B8FkfQECi6qsyUGDpbB1dgOV+3t/HrkRhpgfOncOgAo=;
        b=QYhxvde1mFdc0KOnAUecIEu1dFaqoxBDTBT/hUbHz/oh1ykQvVTr9hMfAs+S2ASA6l
         T8ZPx3/CjJDfNiBXqlpMF2iErLjFQB230lwOuW/AQT20HdWElCQOGKag/DLQ7F5waqus
         UJGh4mzZKAZK0IBb5AaEuEUOfE0Tyg9S6c0dANA/+a1CnZttc7Ss+UxXehRKmmQgepll
         zrsihLb6gKmp8ApkRjVDY1xsbkaW8QufbV33Hp3IbDg0Tc6h+vg7CoR8WIG5IWe7EA+L
         1fOY3M0Rj5IDn1XEKYmqGfeh6fSvC7Zn0dV0NEc+P7QjvfsHAkeFh8ZllLWxRTGos4o3
         SQzw==
X-Gm-Message-State: AOAM5300wZKF/I657bq43mFb6UCeC1+90y7/aaZEoGycohMa4KNwUjXx
        ACdxJ/7ZF2TyqeU1I0Y76c2POISfHWQ=
X-Google-Smtp-Source: ABdhPJwcxF19+OzGvogu5LVnQoHesEh59wd6IBGa4E22bRNSa2awksbQrr0acvh1Rtdj/vkq8Rd1Sw==
X-Received: by 2002:a17:906:a295:: with SMTP id i21mr26072135ejz.160.1620204034993;
        Wed, 05 May 2021 01:40:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b5sm14465824edz.88.2021.05.05.01.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 01:40:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] trace2: refactor to avoid gcc warning under -O3
Date:   Wed,  5 May 2021 10:40:32 +0200
Message-Id: <patch-1.1-87d9bcf1095-20210505T083951Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.745.g2af7c6593ce
In-Reply-To: <20200404142131.GA679473@coredump.intra.peff.net>
References: <20200404142131.GA679473@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor tr2_dst_try_uds_connect() to avoid a gcc warning[1] that
appears under -O3 (but not -O2). This makes the build pass under
DEVELOPER=1 without needing a DEVOPTS=no-error.

This can be reproduced with GCC Debian 8.3.0-6, but not e.g. with
clang 7.0.1-8+deb10u2. We've had this warning since
ee4512ed481 (trace2: create new combined trace facility, 2019-02-22).

As noted in [2] this warning happens because the compiler doesn't
assume that errno must be non-zero after a failed syscall. Let's work
around it as suggested in that analysis. We now return -1 ourselves on
error, and save away the value of errno in a variable the caller
passes in.

1.

    trace2/tr2_dst.c: In function ‘tr2_dst_get_trace_fd.part.5’:
    trace2/tr2_dst.c:296:10: warning: ‘fd’ may be used uninitialized in this function [-Wmaybe-uninitialized]
      dst->fd = fd;
      ~~~~~~~~^~~~
    trace2/tr2_dst.c:229:6: note: ‘fd’ was declared here
      int fd;
          ^~
2. https://lore.kernel.org/git/20200404142131.GA679473@coredump.intra.peff.net/
---
 trace2/tr2_dst.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
index ae052a07fe2..c2aba71041b 100644
--- a/trace2/tr2_dst.c
+++ b/trace2/tr2_dst.c
@@ -197,22 +197,25 @@ static int tr2_dst_try_path(struct tr2_dst *dst, const char *tgt_value)
 #define PREFIX_AF_UNIX_STREAM "af_unix:stream:"
 #define PREFIX_AF_UNIX_DGRAM "af_unix:dgram:"
 
-static int tr2_dst_try_uds_connect(const char *path, int sock_type, int *out_fd)
+static int tr2_dst_try_uds_connect(const char *path, int sock_type,
+				   int *out_fd, int *saved_errno)
 {
 	int fd;
 	struct sockaddr_un sa;
 
 	fd = socket(AF_UNIX, sock_type, 0);
-	if (fd == -1)
-		return errno;
+	if (fd == -1) {
+		*saved_errno = errno;
+		return -1;
+	}
 
 	sa.sun_family = AF_UNIX;
 	strlcpy(sa.sun_path, path, sizeof(sa.sun_path));
 
 	if (connect(fd, (struct sockaddr *)&sa, sizeof(sa)) == -1) {
-		int e = errno;
+		*saved_errno = errno;
 		close(fd);
-		return e;
+		return -1;
 	}
 
 	*out_fd = fd;
@@ -227,7 +230,7 @@ static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
 {
 	unsigned int uds_try = 0;
 	int fd;
-	int e;
+	int saved_errno;
 	const char *path = NULL;
 
 	/*
@@ -271,15 +274,15 @@ static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
 	}
 
 	if (uds_try & TR2_DST_UDS_TRY_STREAM) {
-		e = tr2_dst_try_uds_connect(path, SOCK_STREAM, &fd);
-		if (!e)
+		if (!tr2_dst_try_uds_connect(path, SOCK_STREAM, &fd,
+					     &saved_errno))
 			goto connected;
-		if (e != EPROTOTYPE)
+		if (saved_errno != EPROTOTYPE)
 			goto error;
 	}
 	if (uds_try & TR2_DST_UDS_TRY_DGRAM) {
-		e = tr2_dst_try_uds_connect(path, SOCK_DGRAM, &fd);
-		if (!e)
+		if (!tr2_dst_try_uds_connect(path, SOCK_DGRAM, &fd,
+					     &saved_errno))
 			goto connected;
 	}
 
@@ -287,7 +290,7 @@ static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
 	if (tr2_dst_want_warning())
 		warning("trace2: could not connect to socket '%s' for '%s' tracing: %s",
 			path, tr2_sysenv_display_name(dst->sysenv_var),
-			strerror(e));
+			strerror(saved_errno));
 
 	tr2_dst_trace_disable(dst);
 	return 0;
-- 
2.31.1.745.g2af7c6593ce

