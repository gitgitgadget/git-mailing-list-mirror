Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE514C433F5
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A89BE61027
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbhKFVuA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbhKFVty (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:49:54 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED780C061205
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:47:12 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d24so19645813wra.0
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L7RXSh0sSGc01+CkbVX6cZFC6IlkrRUvM5uVfLfmspo=;
        b=fElVWLH+NP/Et5ECOX/2+OJyrmSTP1EZwxSj//X5VN5Vs5J7Jbgop5oz0QBlpi+/m3
         RdKfl2FhMavTU8bvhJbMzJk+0XbAvV3N47QnVh+b9ZnjMO1QGhadpYdLOIr2EQQ7s93/
         u6zjkEv/W3tAsj0fnTM5f2JZwbTgl14q1X0nIJ2mK+TFfsKsXN3yIudZIQSJZF8Otpxh
         fAVsVZbOAEqwtY3Y+TvMDkdAUm2zE1BPoVl+ihEF5OjAWu7BpZbvHiCpFN3iXQ0I9wSP
         AsV1m4bA5DOmhM7NOo8JtQcbYAXTErXJbVbioAVd2RPMlcnXQbYDZHmD4Nj4izYvgZlv
         M3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L7RXSh0sSGc01+CkbVX6cZFC6IlkrRUvM5uVfLfmspo=;
        b=OTmSjIDUR9sUwUSPley4dltY+c35lNq7K+jpeqtwY4pysWIu0eMFJDqUPn3rYL7G1k
         U92c3RmW7N0GmMmO0MIBFcYUjmTgxm5V9HosDD1V6L4byu+YGCPrAV71XsxVK7RN3MlA
         ySrjkAOiMQHsBx4jdFmTi9Y4vvVUoZxAeMke/oESZAka6Gh++uTRKxUkD40FdaH8eKiL
         ZF2wR+1NGIFHlEcz108XQuTPUp8/yGae/Uxh8wMlENWnwFbBJWj1y+rjvUikrWfQIC1n
         iiJS6ilu+LsVk8IuBjVYaBmJfS+qjcRYwz2/yezotPXO3jdm4iwuHSizunRAmX3Z69xq
         e0rQ==
X-Gm-Message-State: AOAM532V44jnHKlLgAu1My5nL4ALU5BB59xxjzzGsCWbPuullZUvqbOE
        E4/YZgLLnt/yZrGY3AbJDsskn9XSXtB3ew==
X-Google-Smtp-Source: ABdhPJw4ooZXvJvFbEDJ0fl5CyZPRHBg4pd08hp0SCR2emH/Gy1coKFD+A4b0fiwSh7AF7hu86Gq8w==
X-Received: by 2002:adf:dc43:: with SMTP id m3mr87002879wrj.66.1636235231365;
        Sat, 06 Nov 2021 14:47:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f19sm12736630wmq.34.2021.11.06.14.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:47:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/10] object-name.c: don't have GET_OID_ONLY_TO_DIE imply *_QUIETLY
Date:   Sat,  6 Nov 2021 22:47:01 +0100
Message-Id: <patch-09.10-49f9e30792b-20211106T214259Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com>
References: <xmqqlf33i36a.fsf@gitster.g> <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop having GET_OID_ONLY_TO_DIE imply GET_OID_QUIETLY in
get_oid_with_context_1().

The *_DIE flag was added in 33bd598c390 (sha1_name.c: teach lookup
context to get_sha1_with_context(), 2012-07-02), and then later
tweaked in 7243ffdd78d (get_sha1: avoid repeating ourselves via
ONLY_TO_DIE, 2016-09-26).

Everything in that commit makes sense, but only for callers that
expect to fail in an initial call to get_oid_with_context_1(), e.g. as
"git show 0017" does via handle_revision_arg(), and then would like to
call get_oid_with_context_1() again via this
maybe_die_on_misspelt_object_name() function.

In the subsequent commit we'll add a new caller that excepts to call
this only once, but who would still like to have all the error
messaging that GET_OID_ONLY_TO_DIE gives it, in addition to any
regular errors.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-name.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/object-name.c b/object-name.c
index fdff4601b2c..d44a8f3a7ca 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1795,9 +1795,6 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 	const char *cp;
 	int only_to_die = flags & GET_OID_ONLY_TO_DIE;
 
-	if (only_to_die)
-		flags |= GET_OID_QUIETLY;
-
 	memset(oc, 0, sizeof(*oc));
 	oc->mode = S_IFINVALID;
 	strbuf_init(&oc->symlink_path, 0);
@@ -1932,7 +1929,7 @@ void maybe_die_on_misspelt_object_name(struct repository *r,
 {
 	struct object_context oc;
 	struct object_id oid;
-	get_oid_with_context_1(r, name, GET_OID_ONLY_TO_DIE,
+	get_oid_with_context_1(r, name, GET_OID_ONLY_TO_DIE | GET_OID_QUIETLY,
 			       prefix, &oid, &oc);
 }
 
-- 
2.34.0.rc1.741.gab7bfd97031

