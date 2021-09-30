Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED02C433FE
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F1DE619E9
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351668AbhI3Njd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 09:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351492AbhI3NjU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 09:39:20 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5293C06176F
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:37 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d26so10114664wrb.6
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EB2fZEVummt8748pmMRqI4GRZrL4BmqzBtvYUa20LUY=;
        b=kBJFBEPUYGSPLIk/pHFRyXxy6wJPT5jqYDgclAyZ0Mv9uuDkeqN/2bqkRPqp5Xsw+a
         W/tVZDonLQ3yhkxgY8h30Get0rP7fmbTD/AhFPsWO+LUOcL4+HoAAGQru2fOVJJpUskR
         fFKOrlFM2NME9QRCZ3p6NZSw1NSRs/PYbmi09yqk/RvI7GvVUhg2CLhRDKEqhNhHIYN5
         dOyu+DjbCVTonm1r52dKRU6Li99sjQTfSHYj9GZPjHI7thxh1IwARo4gd4Pe7Qhzg2SZ
         dgN7cPu+8eO0dAKwOlELjDPyjctIrqCQZDsjaa45NxSkxgrzzGIqTxxUGGxOY4dQvMc9
         sHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EB2fZEVummt8748pmMRqI4GRZrL4BmqzBtvYUa20LUY=;
        b=BKJWzHGUVRYNCXJoJBTALP4unVakdhdvSUuaPcNTNAAbNPa6UUi3wmPCKsZVffnaNc
         Avhy/aX21YT1b8F8hymZROE0hDl4/WUl7/OMYrEcVM2MgX4s4e3F1vegtKP1aiRs5tY6
         bZFfO2Js0wu8VgLJu9VHNt5MF7wGCWtH/vNZISBeGUIop/C/WYtX8YsbTcGtfL3X2MF0
         IsFq4yc6Pmu+fX3dFwR+MNMYvtMvLY3rIUxxdRLCk4ZS9CahaDG8Wv3gEUj/k+RwkmIR
         bYhlD/V6OjGDcaaFRfKBg5OODS+z0SknpdYfBM2fiitMzgTuB9qF2Tvqs4w9/nvRIB6U
         e4sA==
X-Gm-Message-State: AOAM532ka0yJwurQBK1tMh5haJFhirxrpEp5OrPJfDCUGDYsU2Eh4uOz
        /c9EppmmyC9hgaeHGlUloRbSGcQVm5wyV5Tn
X-Google-Smtp-Source: ABdhPJwLST62fhaj1OTQxpQ8EK1NZn8bRrJ/Qn/Bnv6jsAS0Y9aYPmCEsDytCsbRjFOYvTqcyeEClw==
X-Received: by 2002:adf:a499:: with SMTP id g25mr5747822wrb.239.1633009056137;
        Thu, 30 Sep 2021 06:37:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o11sm4654713wmh.11.2021.09.30.06.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 06:37:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 10/17] object-file.c: return -1, not "status" from unpack_loose_header()
Date:   Thu, 30 Sep 2021 15:37:15 +0200
Message-Id: <patch-v9-10.17-6637e8fd2ca-20210930T133300Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1374.g05459a61530
In-Reply-To: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
References: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com> <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Return a -1 when git_inflate() fails instead of whatever Z_* status
we'd get from zlib.c. This makes no difference to any error we report,
but makes it more obvious that we don't care about the specific zlib
error codes here.

See d21f8426907 (unpack_sha1_header(): detect malformed object header,
2016-09-25) for the commit that added the "return status" code. As far
as I can tell there was never a real reason (e.g. different reporting)
for carrying down the "status" as opposed to "-1".

At the time that d21f8426907 was written there was a corresponding
"ret < Z_OK" check right after the unpack_sha1_header() call (the
"unpack_sha1_header()" function was later rename to our current
"unpack_loose_header()").

However, that check was removed in c84a1f3ed4d (sha1_file: refactor
read_object, 2017-06-21) without changing the corresponding return
code.

So let's do the minor cleanup of also changing this function to return
a -1.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 766ba88b851..8475b128944 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1284,7 +1284,7 @@ int unpack_loose_header(git_zstream *stream,
 					       buffer, bufsiz);
 
 	if (status < Z_OK)
-		return status;
+		return -1;
 
 	/* Make sure we have the terminating NUL */
 	if (!memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
-- 
2.33.0.1374.g05459a61530

