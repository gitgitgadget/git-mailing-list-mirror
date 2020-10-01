Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2625CC4741F
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 03:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB68921D43
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 03:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9Qs8Pu5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbgJADqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 23:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730385AbgJADqY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 23:46:24 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEFAC0613D0
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 20:46:22 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c18so3937613wrm.9
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 20:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=t+pghuU5Gv83eMVih7dQHTihGijXyL5XBxWL7n3ryDI=;
        b=j9Qs8Pu5V0VZy3UKvd3eb3DUcvKitp0o9Tv6sXCNU9mmc2QcvI9knkXb1mYuECVwB5
         T8hzLbIFJpSEzu6EVe59PpNY1YV/Sle7nGbMFis4rZwvks5VtLouDh7aMW8Lq74GXYQ9
         nPviC3a1xjVewCQzwwhIAmZUGDCdV3RrfwChz1EJHhxVcZ0G4QhQt/ofEDv30DE2PkU3
         NTgMbsoA4dHx2DJVwNGS3yapZoR6Le51JLkKYDVU5y/byBuVQ0n8txiccbc5IjCnkH9K
         3GMvKjT37wyuPA5X2sPg7e/wCJZoWOekqkYK0Xk/qYBR/R2okCiSKNBNXWKP0nRVvFn2
         al/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=t+pghuU5Gv83eMVih7dQHTihGijXyL5XBxWL7n3ryDI=;
        b=niVnI6EwDgKjDCRBobuYLv04bBv8tg/pxvpyTA0ZEsxEmKlTeg/bLIggUmNwb6yHKP
         1/7dOiKFkfluAt9k2BV0pP5gq69cgJGnz/ygJ3ChDA8H14thppqYVyzqSmpy/VKILoQ2
         UM+/6cW4qmhGHriJlomYuszvMPQUYcBC+odfbsBp/egQyJQ+e2gQWQ9wL9cVfzkYnXVX
         wG+NmjfMpNa82JZlTrnbmxR59vkUgGrzUK2jRH4sKaLlWv2NImr2M17z+oHrSUoRWZpH
         60ukzAhmXCVtQ/YtUfb7es5K1y5U7PQULvO/t4IpFOEgwKLU3rUGXAH6dka2b6lm9klP
         Fruw==
X-Gm-Message-State: AOAM5319hXdserEatcsw14QPE1sPhghWJo3hRseubqv/5KZbsx6o3Nx1
        avEXNLt6uSZHPVMGwXLGvSSbpKU5ql4=
X-Google-Smtp-Source: ABdhPJw2H/aGG3kgg4Q9Br149q7ROwLz+dcrp77cOELzhfsVEdpJiCoiZR0m38pkFosDKsWMeOKc7g==
X-Received: by 2002:adf:e7ce:: with SMTP id e14mr6110309wrn.43.1601523980979;
        Wed, 30 Sep 2020 20:46:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f23sm5389961wmf.6.2020.09.30.20.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 20:46:20 -0700 (PDT)
Message-Id: <ec371306ec52e157778c0d9591253e6a6b93b552.1601523977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.727.v3.git.1601523977.gitgitgadget@gmail.com>
References: <pull.727.v2.git.1601350615.gitgitgadget@gmail.com>
        <pull.727.v3.git.1601523977.gitgitgadget@gmail.com>
From:   "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Oct 2020 03:46:12 +0000
Subject: [PATCH v3 3/7] remote: add tests for add and rename with invalid
 names
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>, Sean Barag <sean@barag.org>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Sean Barag <sean@barag.org>, Sean Barag <sean@barag.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Barag <sean@barag.org>

In preparation for a future patch that moves `builtin/remote.c`'s
remote-name validation, ensure `git remote add` and `git remote rename`
report errors when the new name isn't valid.

Signed-off-by: Sean Barag <sean@barag.org>
---
 t/t5505-remote.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 8d62edd98b..1156f52069 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -179,6 +179,13 @@ test_expect_success 'rename errors out early when deleting non-existent branch'
 	)
 '
 
+test_expect_success 'rename errors out early when when new name is invalid' '
+	test_config remote.foo.vcs bar &&
+	echo "fatal: '\''invalid...name'\'' is not a valid remote name" >expect &&
+	test_must_fail git remote rename foo invalid...name 2>actual &&
+	test_i18ncmp expect actual
+'
+
 test_expect_success 'add existing foreign_vcs remote' '
 	test_config remote.foo.vcs bar &&
 	echo "fatal: remote foo already exists." >expect &&
@@ -194,6 +201,12 @@ test_expect_success 'add existing foreign_vcs remote' '
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'add invalid foreign_vcs remote' '
+	echo "fatal: '\''invalid...name'\'' is not a valid remote name" >expect &&
+	test_must_fail git remote add invalid...name bar 2>actual &&
+	test_i18ncmp expect actual
+'
+
 cat >test/expect <<EOF
 * remote origin
   Fetch URL: $(pwd)/one
-- 
gitgitgadget

