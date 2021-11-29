Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B0EC433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhK2WWw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbhK2WVH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:21:07 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946A5C091D04
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 11:59:23 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t9so22355732wrx.7
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 11:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OmV7/9WnJ5T7wNxQz7g1rhUZXP9NKVc7XbQFg82g1e0=;
        b=XNTd6r+zB5lzL0ebSPc7cvxILXSJXCqj93d51QpUV2td0QT72KlGtpRukcERvGUY8b
         +7mCyZ1/FXXBhjybziENs1KQGazsU1ydwsNyIDs7wxWPTu6/8XtVDnATsJR3VDfnT1xp
         jUWgZoIMWonn+zOL0uk2aYVWK+nWYX8HzF6N6bm1zdpQJiLDdHLyp0YVBZ7BHQjGwg6m
         VmLQsyu0419PyBTOKwOTNhVHYwtPDiH4QDG8bs3iAjBmISbsrI18HnPmTu552+YgRZeO
         sBZ4wTiFMrNcdkQb+DXA/fbGSs8u/Xr6ZZq/Yt2hA1ajqz6KpVe0Sg53C25MLrZVVYxx
         lpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OmV7/9WnJ5T7wNxQz7g1rhUZXP9NKVc7XbQFg82g1e0=;
        b=V2t/rnjpc6BKihHK/6cWOUeyidkwekZBfjKZUl7nX4ZLlk48RIrWmuJ/qPIV7SiyM7
         XwqLm4MPNrypPUmfYjbdE3218T00U39GpPzZJ7QGZ1ote1U+5n009dO7Rah8sDdJs7Lj
         f7pm4yUx8AtZJABkIO2svilhQdLKu4TVcU8v4j9+ViOBHYHtQNhjcIFwZTtXv1nCVuh3
         sZjn1zaCauEs9Vs+mFnXK9F6v9OUdl6OwypHY4Wy6iduju8+G9K6aeCIbx14xlcAWZCD
         RRJoM07ByfXN06AXNW346OnWoC6OZBpS+l+kjH99wq4+ab4mlmdjbpnAfw6O9B40Vbd5
         jWWA==
X-Gm-Message-State: AOAM532Nf25nhPyLD93MEcCoOAl6ryHk5cy1lsYQT0lJuyAJrtW62f6h
        1eVVyleCsLhbYeob3Iv6G3cKtFqg5gOrPg==
X-Google-Smtp-Source: ABdhPJxCVQW0jGabWXf6ejms69bUhvJKVZXpTDCv3Ifg+scoTjuzbArmBkGclygUCvvERKiuBQUPQg==
X-Received: by 2002:a05:6000:1885:: with SMTP id a5mr37248024wri.258.1638215961901;
        Mon, 29 Nov 2021 11:59:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t8sm298200wmq.32.2021.11.29.11.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 11:59:21 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 09/10] object-name.c: don't have GET_OID_ONLY_TO_DIE imply *_QUIETLY
Date:   Mon, 29 Nov 2021 20:57:49 +0100
Message-Id: <patch-v3-09.10-145c00db08c-20211129T195357Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.841.gf15fb7e6f34
In-Reply-To: <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com>
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

In the subsequent commit we'll add a new caller that expects to call
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
2.34.1.841.gf15fb7e6f34

