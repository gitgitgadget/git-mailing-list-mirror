Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7B7C433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D449961130
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhJNAJN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhJNAIx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 20:08:53 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6741FC061778
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:47 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u18so13867906wrg.5
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B+rhMDunkStFv+m46TBKut8CGMdemjLOjFlqUp/bDQg=;
        b=CeSWbg//W4QpuBFSDmzFHNTgEZHL2ilYiu2U4Opt4F1wEcnuAUScAUEncEPfQRHB/r
         +kimoMpC9wg+rcIrxTuH+vHfxH3yLrgaIThWX1vcTfl7wRo2yMwQ5rH9ztVuRh6k3xHB
         5VQa1QMd/3rv0V92IzSnYLZUJHl9MiNbhny/HEb3rTRvFLz6mDPev51YYi1BmJUvwoY9
         aN+uWDpHm/inQIVvv72OIwqSNrfQ1OubmdCaFgFLfSHqHAtAsZ1gkQ5lRHpY/X4aayKQ
         f7V8tXcfAYvsAmkhAAW1/s5D4L+p6PFVsNJFTEcQRmcaPMqe86rFB0450xq+AcqU+/eY
         J84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B+rhMDunkStFv+m46TBKut8CGMdemjLOjFlqUp/bDQg=;
        b=FURO+PQrHphl1wdNnJXmLYE8tiRZV9/7n2GZwEIEfYfg8vb7GzmPnxtw6Rs8wxtSrA
         oK4m3Rft8JWNqUVXfm7d8zy3yi46G256xpC7wlqMlXsMFCUgSiNM+ZiQ6tpAJN/o7wBT
         SA0d6ZJH7PH2tX4QlZv5rLafY19APsg2zCKdfepDzCIy0kOIdWkhV0t2c09vA7g6Qw1d
         3cmBaKQ9UrrdKSO7FolSFfgXT5cMoPbHP/MuShq8y+p1rTfVJFICqa9z5FOiFXNjs6bB
         OoRZIMeDXzmzT/tE/6PTLK6qB2L+2R2Vob8UHNz7uav4shNxg5KYU7rvBj7b5F8vav6O
         kc9Q==
X-Gm-Message-State: AOAM53070DikbeCvnoZRgU5AJvV/bL914qHc8Et1nVxbxjRNR74r290J
        0/2+o+8dAa/6SQO04jpn+f9l8tFzDexUwQ==
X-Google-Smtp-Source: ABdhPJxgLg4c/zr89h5e+PvBfm4QAZZ0q/zNk6Ljar/5MWycYxIGIsz5twmafKEhACtJrNZI/ZSj6Q==
X-Received: by 2002:a7b:c010:: with SMTP id c16mr2408718wmb.141.1634170005830;
        Wed, 13 Oct 2021 17:06:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y8sm670711wmi.43.2021.10.13.17.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:06:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 15/20] refs API: make refs_ref_exists() not set errno
Date:   Thu, 14 Oct 2021 02:06:27 +0200
Message-Id: <patch-15.20-4b2a4dbe7d5-20211013T235900Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
In-Reply-To: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move refs_ref_exists from the legacy refs_resolve_ref_unsafe() to the
new refs_werrres_ref_unsafe(). I have read its callers and determined
that they don't care about errno being set, in particular:

    git grep -W -w -e refs_ref_exists -e ref_exists

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index c64ed6285a6..f2a56a216c3 100644
--- a/refs.c
+++ b/refs.c
@@ -308,7 +308,9 @@ int read_ref(const char *refname, struct object_id *oid)
 
 int refs_ref_exists(struct ref_store *refs, const char *refname)
 {
-	return !!refs_resolve_ref_unsafe(refs, refname, RESOLVE_REF_READING, NULL, NULL);
+	int ignore_errno;
+	return !!refs_werrres_ref_unsafe(refs, refname, RESOLVE_REF_READING,
+					 NULL, NULL, &ignore_errno);
 }
 
 int ref_exists(const char *refname)
-- 
2.33.1.1346.g48288c3c089

