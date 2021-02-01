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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8ACC433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD41D64ECC
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhBATtM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 14:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbhBATqr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 14:46:47 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFDBC061794
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 11:46:00 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id e15so336451wme.0
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 11:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d1cHuoV8KkZBLxPSXFGQmyuEQ52j4D1R8rr07+j1FaY=;
        b=q66JmoZIHBM0ypO5M/rCRGV/X2h2vfWQbO6S8xjzrlggssaHOtzVfKec3PtGwT3uFJ
         LGXq/YmBBSa77eubNylvfbKB4NMC4oPo3g3/lro7kSGwuRHAsA/RotQ5W1g8iht55kkr
         r2MZJkmJhiAHBqlfEFCnagS82+3v5x4S4vjG/ILEydihG7Oul1yOUMvD1sHKcreyFcfI
         gdewIgsJTF47edZ26uaZm7sgBp1vTgo0Eb/aC8DU4Lx2WVTzSiZk4YNy+RklHfYMLh7k
         NnVN3uzB2aooav/XZPxaOzzodYKVvV/nirGOt2Wn3YfBO0SckaC2MW21I5sjEuuZFnfE
         Mjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d1cHuoV8KkZBLxPSXFGQmyuEQ52j4D1R8rr07+j1FaY=;
        b=FOwSHt5xz2Ijb6SKLEDWQS7PQrUr68Zkp8qYbJxt6DtLFGEr1Ct0nRcyCzQJTUWyZ8
         TEziONOB4hg1lZJFUyn8Piv6Cj4tOmWXHUyEtDg4DffsavTQFMJytWM/+hxqyWNDg6sF
         ifgHaoCRdd8ePeOF5YtGvq+/SNVia8JytswPtHx73qG6xl3ubU8j4gF/y1rPS8RtsdN9
         JFAPrIvsMRC2H23F6A98V6MJhy6rVfDQn8a53vBfCNMTMFW8Z5aTK2AmK9CGtE12MSCa
         Fj6nU1N2Ep/jbW8Ocy78hj34rEioJjhMo+wgwInuYigf+6qKREEMrUqrKapr2u2lmmpz
         egwg==
X-Gm-Message-State: AOAM533Mu1ow/LqEGRIQpPvjaFhDAE00iq40oMcbQxBJMK44j6nco0r5
        mxXVh8sA/UIhdBtNf7Fgnf28YqrnlcE=
X-Google-Smtp-Source: ABdhPJwP6ikpr5+jbCr8/Leduz4oqJgitiVjVekVb5YBZyh9xGVsCYIIEDecYMXCtlYxiNq/lBRtaw==
X-Received: by 2002:a1c:4303:: with SMTP id q3mr415201wma.3.1612208758873;
        Mon, 01 Feb 2021 11:45:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b3sm320834wme.32.2021.02.01.11.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 11:45:58 -0800 (PST)
Message-Id: <f5d5445cf42e2f107c5f137922e9887ea46d730d.1612208747.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
        <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 19:45:43 +0000
Subject: [PATCH v2 10/14] unix-socket: elimiate static unix_stream_socket()
 helper function
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

The static helper function `unix_stream_socket()` calls `die()`.  This is not
appropriate for all callers.  Eliminate the wrapper function and move the
existing error handling to the callers in preparation for adapting specific
callers.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 unix-socket.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/unix-socket.c b/unix-socket.c
index 19ed48be990..ef2aeb46bcd 100644
--- a/unix-socket.c
+++ b/unix-socket.c
@@ -1,14 +1,6 @@
 #include "cache.h"
 #include "unix-socket.h"
 
-static int unix_stream_socket(void)
-{
-	int fd = socket(AF_UNIX, SOCK_STREAM, 0);
-	if (fd < 0)
-		die_errno("unable to create socket");
-	return fd;
-}
-
 static int chdir_len(const char *orig, int len)
 {
 	char *path = xmemdupz(orig, len);
@@ -79,7 +71,10 @@ int unix_stream_connect(const char *path)
 
 	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
 		return -1;
-	fd = unix_stream_socket();
+	fd = socket(AF_UNIX, SOCK_STREAM, 0);
+	if (fd < 0)
+		die_errno("unable to create socket");
+
 	if (connect(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
 		goto fail;
 	unix_sockaddr_cleanup(&ctx);
@@ -103,7 +98,9 @@ int unix_stream_listen(const char *path)
 
 	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
 		return -1;
-	fd = unix_stream_socket();
+	fd = socket(AF_UNIX, SOCK_STREAM, 0);
+	if (fd < 0)
+		die_errno("unable to create socket");
 
 	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
 		goto fail;
-- 
gitgitgadget

