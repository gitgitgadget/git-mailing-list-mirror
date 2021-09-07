Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F87C433FE
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65E2660E52
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343888AbhIGLAC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 07:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343895AbhIGK7u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 06:59:50 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31C4C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 03:58:40 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z4so13752071wrr.6
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 03:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zglVV0rGpFX+1s8lU+HeNKkRQ0b2n0f1I1s89JyqSDM=;
        b=Kf+r9o6YPosjfp8Xi2aX14oiJU9DCGyC26MfBa7sZqHh+jLRtvhS2f1hFLrFMbYztn
         r2db6fjqCKv0gwZtfPstuort2RGDGFQJD6VjuLy/Elwl1QLyyv2Ocak8kQisYoF2VzO4
         +ot/UA7eZMD/NXxC3IMa7w20nlCsSJGwGYt35mNZ8XutPHRbH/JsPBQNIuv+3kRRkE/n
         T8Ok+IG/ZbhKVmidS9cQMIZlhXCphPIClNQZqtDK4IF78e+vP1jOHuoFSQtdVs/mvMq6
         4yQU/ULrs7k3gfO6iXc/MckVMVZdl60nQf1y/VoFc3+XqbYA+MBe5VooWdcqrPxSxJLU
         ZXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zglVV0rGpFX+1s8lU+HeNKkRQ0b2n0f1I1s89JyqSDM=;
        b=dIyJrAUT+5oJ9eowq57KJKpryQ9rsmD7ejaw8HLUcCh/yb0J68aPQEMxpUg6CbEsie
         tLVYLy4jnSiZ3CTvpkbHSC2ior/hzxfES8BIc81fAlyDHnK/H7F0+Gyn/klHo4U/Euls
         ed+DbLXoXgZE8FQ8XnbtSOKq+gtaN/x/xeUwhbXxm0T6VQqw9AGyv7f3OdJRR4mHnJex
         OwU+w11FEvTr5buCdkkccEzA0DdqgXy6bJ7NVk6S0LJkLgOagZF6LRdPslOF+2f7w0J6
         irMVdF0GZdoFStyszzIia22PiedTm6xOMkFjsbcum883b4jLpw5dNFmwYHcsJhZZ9mVk
         h2Iw==
X-Gm-Message-State: AOAM532IbvGM0mcJLbXqzuVcO3f7ejMueKYKC72YRHcPaEYjS3tMb+bH
        xwJ20QQXX6s3SXcliQxsIPLPJznLCji5ww==
X-Google-Smtp-Source: ABdhPJzFsspG09FIDiEuSKtvhetLWOtJKcS+IVqRRwT6NIsumQFW+LeM84UqjkZV92dnYFG0CkBcyw==
X-Received: by 2002:adf:e0cd:: with SMTP id m13mr18118501wri.137.1631012319109;
        Tue, 07 Sep 2021 03:58:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l16sm8255602wrh.44.2021.09.07.03.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:58:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 16/22] object-file.c: return -1, not "status" from unpack_loose_header()
Date:   Tue,  7 Sep 2021 12:58:11 +0200
Message-Id: <patch-v6-16.22-9e7dbfb4aa3-20210907T104559Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.815.g21c7aaf6073
In-Reply-To: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com> <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
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
index ae6a37ab5fb..11df4485147 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1252,7 +1252,7 @@ int unpack_loose_header(git_zstream *stream,
 	status = git_inflate(stream, 0);
 	obj_read_lock();
 	if (status < Z_OK)
-		return status;
+		return -1;
 
 	/*
 	 * Check if entire header is unpacked in the first iteration.
-- 
2.33.0.815.g21c7aaf6073

