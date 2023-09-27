Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A99E82CCD
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 19:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjI0T45 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjI0T4e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 15:56:34 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1DACDC
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:09 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-79fb70402a7so294061839f.0
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844569; x=1696449369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dnxcgIKj3s0Ny3j12+gtpGpedSlcjdex5cQNRhJerE=;
        b=jBiMsu/n0gMoahCz9X5fGrW0mLntQP+/v4RFg4+UQHaueDh3bHTojaVarPvUYYzI3B
         GgWojBo8jQ659sEYWfZGSCyRaRikT6u45NNGBxWLJUt/11xfgNeXKF2aJlPvEY8hoqO7
         8y8rcpiZXeggiSuCxZXUz+cflaIGVC+o0c3e1WuIIAQP03KKzjjeRypfGQg+GDsYMtRI
         PZU2rCV9sdVRg+JsXwnYKeprrLx2+c0yFu22wjVHSg8GWeUTb9r3BCGltbExHOT+B/xz
         TfOzUoCpSZUmGTZyNVjvrT5aADJXP1Ks4X22AdYypdx1r+Y8bEcdRInDsvmhBWR5VgRw
         bruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844569; x=1696449369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dnxcgIKj3s0Ny3j12+gtpGpedSlcjdex5cQNRhJerE=;
        b=beyxn7yPciazpyCrIA+yp8aYbKcwHC2NysOrPGIxGKr3RNut8hzf2nPvUeh/e1EeBT
         UCuUiFNPfMXKPYExK1fvIlvL78od0I7G4YhSWkpwNNhY3MQAmBWaU6/D/UrnMeCtZ2ZK
         ccApQy0L4ErCx0UPXm0Tlzzq6CK+MJe6lA60BJHGZOtlT/04ePQy5AbTelH5LNvX0w2l
         wpYIhEj+WgHPft+beKOkjbqtILqXoulZ8MYBi79dYsUdcyY0fOjODaILyyrV9BR88/57
         in7ra0TpEm/kYEz1Mz2qqGXFu7y6ZPWY49kV3zaaBTNmcoVVUCXMRyjViSfeYRk46R84
         8i+w==
X-Gm-Message-State: AOJu0Yz/cAYTjD+1F3D6c1F+HzL9WC+3kIHS1eol+JPAujphBaOdBWVK
        TakmbSlIwt5o1SlOanySxyY=
X-Google-Smtp-Source: AGHT+IHeTGAaND2c5MjcSWI05jYu1Z+g3gX0QKoky+j3Dh5S1X9X0JKCuMomC1OmDdmwolNSVGmdpg==
X-Received: by 2002:a05:6602:39a:b0:791:1e87:b47e with SMTP id f26-20020a056602039a00b007911e87b47emr3459633iov.15.1695844569202;
        Wed, 27 Sep 2023 12:56:09 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id o23-20020a6b5a17000000b007836c7e8dccsm2935628iob.17.2023.09.27.12.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:56:08 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 25/30] object-file: Handle compat objects in check_object_signature
Date:   Wed, 27 Sep 2023 14:55:32 -0500
Message-Id: <20230927195537.1682-25-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

Update check_object_signature to find the hash algorithm the exising
signature uses, and to use the same hash algorithm when recomputing it
to check the signature is valid.

This will be useful when teaching git ls-tree to display objects
encoded with the compat hash algorithm.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 object-file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 1601d624c9fd..df49d2239f24 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1094,9 +1094,11 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
 			   void *buf, unsigned long size,
 			   enum object_type type)
 {
+	const struct git_hash_algo *algo =
+		oid->algo ? &hash_algos[oid->algo] : r->hash_algo;
 	struct object_id real_oid;
 
-	hash_object_file(r->hash_algo, buf, size, type, &real_oid);
+	hash_object_file(algo, buf, size, type, &real_oid);
 
 	return !oideq(oid, &real_oid) ? -1 : 0;
 }
-- 
2.41.0

