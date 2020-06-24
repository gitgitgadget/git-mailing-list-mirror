Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA884C433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99BB120702
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3jfn1vY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403926AbgFXOrx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391250AbgFXOrv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 10:47:51 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5DEC061573
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:47:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s10so2532067wrw.12
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zFO1EtvSmoAkJ5ah0iaCL/vvE8xnlN9KlBlryGuoJn4=;
        b=D3jfn1vYGfcZBktPZnxJfC0cd7SltmkmIIvfnIvcgdUo782IRyLxIwm/74tkgQXs3b
         tg/ZuCqcGlepsSZVvGMsm2WwJPtMIJBWUs69WAZxPlNaEveSR63avCOfFQr0FazkJ2vn
         14mlHHPmMj9kVlPQG9rbiX0lUfeCQfZ6tX5TrhMQp2uQCCjZmu1e2LliXQKQdlZ+cn3o
         S5gESOL9X6t0dWmBq1tgUHbCBRrsNDIODUpSr200hrJgwIz+ot4p5gqyKmqxznlX07zM
         K3/zUF78WEKlEmDUcu/0iHiq4kTjH5phggqTzKcg+cA4lPuyMPqwQIrPnsYgkXHDYZ+B
         XXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zFO1EtvSmoAkJ5ah0iaCL/vvE8xnlN9KlBlryGuoJn4=;
        b=kz+erK0mLX4Y5E6WLUYMDxqLjfDWzJbvW6QBwDrmi1FwksbEzTHcQJa8z5r/8UKdBf
         x2qcvT0sqQ2pKhpVi6gC8Hy4pdZC6nZSqSqBfFuBHLXvcTNrB/XRzho/BTXNDqQlmLXy
         l6sTYHMnm65IkP4reRK+248ioTRCpNzXmzm6uVVyrEiELGz6PsXwNO1gLZM531LqJ2fp
         LDTrid3mYTWiImh+u4P1uEt+P9dwWfvzbW68umjohpkxSTKH4hyUvwIlnpwJxoj69P9q
         09thiWqiP1VSXk45EXrgqgwhOz5LmtZ97XyrWYQsruICp5tQ8zGwzlKWtdJVxLcsecT1
         p7wA==
X-Gm-Message-State: AOAM530CWDY0nMulndHU69emTXjFNno0F2sCABgJL6sKdnXgxyrGPV5K
        HgRjY8aJjMAlMmPs3jzcu6YGpSfnQ+o=
X-Google-Smtp-Source: ABdhPJzhbdVDDIIkUG2r7HiFbIFOKf+cYIzLgLhBg8/KChWg7ntvEzQHdJaZ044EwtzTYrN27jUYHA==
X-Received: by 2002:adf:ef4d:: with SMTP id c13mr19580301wrp.315.1593010069469;
        Wed, 24 Jun 2020 07:47:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w7sm8783602wmc.32.2020.06.24.07.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 07:47:48 -0700 (PDT)
Message-Id: <a9e06427ec4661b105f57ccf4ce5e842ba501a99.1593010066.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.654.v3.git.1593010066.gitgitgadget@gmail.com>
References: <pull.654.v2.git.1592916485.gitgitgadget@gmail.com>
        <pull.654.v3.git.1593010066.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Jun 2020 14:47:45 +0000
Subject: [PATCH v3 2/3] diff-files: fix incorrect usage of an empty tree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In c26022ea8f5 (diff: convert diff_addremove to struct object_id,
2017-05-30), the OID to use for intent-to-add files was inadvertently
changed from the empty blob to the empty tree.

Let's revert that.

To be able to do that, we just taught the regression test introduced in
feea6946a5b (diff-files: treat "i-t-a" files as "not-in-index",
2020-06-20) to _not_ expect the raw diff to contain the hash of the
empty tree (we also had to fix the code to actually produce the expected
output, but for the sake of this here patch, that's beside the point).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff-lib.c b/diff-lib.c
index ea23169afa..7aafd7cc37 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -234,7 +234,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			} else if (revs->diffopt.ita_invisible_in_index &&
 				   ce_intent_to_add(ce)) {
 				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
-					       the_hash_algo->empty_tree, 0,
+					       the_hash_algo->empty_blob, 0,
 					       ce->name, 0);
 				continue;
 			}
-- 
gitgitgadget

