Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E18CC433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242304AbhLVEN1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242297AbhLVENT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 23:13:19 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3DEC06175A
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:13:15 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id s1so2143221wrg.1
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dRhNAt4xQFQap+17uvdUV28iVMg0ND3HES4QWesb+Ak=;
        b=Fgr16ag9i0ZGQRRaA0YFcGf1doPssmiZKKjBXmDM/TdBiDKK8tQaWWlt6DvUUmSGax
         x69d7gUKuh8bQKjQoASYrYq1DuEgP8b3DabuKAnpnFClu2SKVq8SHqOCEv+RR5lO4ves
         s8KNr4jmReyWx+ywBEs5t+Y/bj8b0SbL1l4recrt+jyD3OwlITTOt0rl12w437nQTLZh
         dpLwlgeb/cdKjnBG6sbq+CfBnrSbu6OeDJNpDNns8MxEOWtjehi1BB+FVln/jxpsjtmL
         MStSM0BBMXFAb8/WrZsaz+4FTCzh0+2TVXbVz3nF7YORtoiqKppADdr5/hYGZS/N/3A/
         Zerg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dRhNAt4xQFQap+17uvdUV28iVMg0ND3HES4QWesb+Ak=;
        b=L3ADz413tNE7wUkt6BN1ltY+tlSxgH0oxoz+UvUK9+5n3Q/iz5rDcu2b4wvruKkR8X
         n0OBLB1MdVVgnAe585mygdKc3CYgGGYpdZZm15nyrQCg2qJduSM1vnyXvu+LvEy9arPv
         z+3z6R2eHk/YTGm5pStMFrv+RG5BCJTfugqGwkP1c+Wd6tizl0q5LI5KgJ0UvsIN6gG+
         KWhxzaw26N9wSZSM1u3U0WMQpYsdugRCo0rxOa/dRGxTpveeHL6BPO5PlhBhKpU+gTrs
         h/apr3WoYwx34VxHfrGHv/bqT3mjXtjHc0BDkl26elTPxzPjrYhQZw63PoS/20DaetJc
         XLLQ==
X-Gm-Message-State: AOAM5311eOGxCxLc0E7nQkcxF+6YvB+JEotaiDYzyQqElt7Qu6r/FW/0
        zd9TBg6EIO4bc4mOvNorxTIfimAuIivYJQ==
X-Google-Smtp-Source: ABdhPJxnIwi6FWmW6ygDFK+lbLX3Gn2FLisgudZYkBPuYWLAtWV2BF0vNonohfeok52OY1kKn5aWaA==
X-Received: by 2002:adf:a352:: with SMTP id d18mr721832wrb.317.1640146394163;
        Tue, 21 Dec 2021 20:13:14 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1sm749650wrd.92.2021.12.21.20.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 20:13:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 09/10] object-name.c: don't have GET_OID_ONLY_TO_DIE imply *_QUIETLY
Date:   Wed, 22 Dec 2021 05:13:02 +0100
Message-Id: <patch-v5-09.10-47543c57135-20211222T041050Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com>
References: <cover-v4-00.10-00000000000-20211208T123151Z-avarab@gmail.com> <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com>
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
2.34.1.1146.gb52885e7c44

