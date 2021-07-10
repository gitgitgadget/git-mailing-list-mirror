Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F8BC11F67
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4C15613E4
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbhGJNkY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 09:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbhGJNkT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 09:40:19 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7717C0613E5
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:34 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r11so11236852wro.9
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=viEWWk6phoDHWfOdK63uqB8zG5Y9a4Lvz9yYgEHac/Q=;
        b=aytRNvrJOEf8RIjwMLV7N+fxCg0NlPkR1et0DLHx+n6WpwUqoLT9ZkJJsYqoNsL/jv
         T4T2bsPR3tqylZE1X/VYyTYDHuQAahreWFxDJ+E702JlJ8WVIf92FYt8ISkke5mYLTgT
         BemqyIJrbU2zBJgf8bvh4m+4koccKpvaoxDEQ5JisnlF88DgIKjh3uDXtST87lYbU2ph
         FJzoAFyL8ACzzb4nI3C0oCSoVBOzNwWukUpiNnxMjnvIh0BMe8WDCVEXm5TdKSktDFbO
         3OCmw0/lBFkvTZYEBzlMxEAXxkcGEQOw8HJl5Pjg3t2YhqgbJltM1vXzojADM7bdYea+
         mBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=viEWWk6phoDHWfOdK63uqB8zG5Y9a4Lvz9yYgEHac/Q=;
        b=l99E9wEfOSBVASR5GpWRYmblY5fRm76qry7M88VsORaj2T1zkeiqQCdrvpEgtEXLEj
         3DNyzCpoYHwzwYZ+74RzWVQ/8Y2+/K5nNlXoulJl94cdKr4yxXLeqEmwAAm6Wosujw1w
         UqiJuyxFizswSTEwN4rFwr3ASbxlbGdRFXIbsh3wMIPEN0cZDwix0uJt1qUrGq3HrnbO
         jyZjsLQZkslLYrgAuxJIbRL5NSpTktopDCJZ/xyU1lNFK0kxNloX8OXI+cz66VBM5vLe
         ay8iASVI6L8/7D6QposPzvy8bj3UOeMA8O/vjcKqbgRAvBV6Z770j4gXWcjRqinbhwjK
         Qc8g==
X-Gm-Message-State: AOAM533lM7UN8ta98mNQwOGfkt0zGdUrzAP5TvJtJ4xaqreyeo+YZaZ8
        kfxhtBsQxGmMbE6JdkJzRh7On5xHI5kezQ==
X-Google-Smtp-Source: ABdhPJwMPJ+81KU29H064Fnx4r4LjsxIYvj7k7yr9BfxfVHwC0VpgiQxGfGB/P4wJaHQ9ICs1ntsqw==
X-Received: by 2002:a5d:680e:: with SMTP id w14mr48166207wru.58.1625924253210;
        Sat, 10 Jul 2021 06:37:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm17612787wmq.9.2021.07.10.06.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 06:37:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 04/21] cat-file tests: test that --allow-unknown-type isn't on by default
Date:   Sat, 10 Jul 2021 15:37:07 +0200
Message-Id: <patch-04.21-50a20741e86-20210710T133203Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com> <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a blindspot in the tests for the --allow-unknown-type feature
added in 39e4ae38804 (cat-file: teach cat-file a
'--allow-unknown-type' option, 2015-05-03). We should check that
--allow-unknown-type isn't on by default.

Before this change all the tests would succeed if --allow-unknown-type
was on by default, let's fix that by asserting that -t and -s die on a
"garbage" type without --allow-unknown-type.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1006-cat-file.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index b71ef94329e..dc01d7c4a9a 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -347,6 +347,20 @@ bogus_content="bogus"
 bogus_size=$(strlen "$bogus_content")
 bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_type --literally -w --stdin)
 
+test_expect_success 'die on broken object under -t and -s without --allow-unknown-type' '
+	cat >err.expect <<-\EOF &&
+	fatal: invalid object type
+	EOF
+
+	test_must_fail git cat-file -t $bogus_sha1 >out.actual 2>err.actual &&
+	test_cmp err.expect err.actual &&
+	test_must_be_empty out.actual &&
+
+	test_must_fail git cat-file -s $bogus_sha1 >out.actual 2>err.actual &&
+	test_cmp err.expect err.actual &&
+	test_must_be_empty out.actual
+'
+
 test_expect_success "Type of broken object is correct" '
 	echo $bogus_type >expect &&
 	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
@@ -363,6 +377,21 @@ bogus_content="bogus"
 bogus_size=$(strlen "$bogus_content")
 bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_type --literally -w --stdin)
 
+test_expect_success 'die on broken object with large type under -t and -s without --allow-unknown-type' '
+	cat >err.expect <<-EOF &&
+	error: unable to unpack $bogus_sha1 header
+	fatal: git cat-file: could not get object info
+	EOF
+
+	test_must_fail git cat-file -t $bogus_sha1 >out.actual 2>err.actual &&
+	test_cmp err.expect err.actual &&
+	test_must_be_empty out.actual &&
+
+	test_must_fail git cat-file -s $bogus_sha1 >out.actual 2>err.actual &&
+	test_cmp err.expect err.actual &&
+	test_must_be_empty out.actual
+'
+
 test_expect_success "Type of broken object is correct when type is large" '
 	echo $bogus_type >expect &&
 	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
-- 
2.32.0.636.g43e71d69cff

