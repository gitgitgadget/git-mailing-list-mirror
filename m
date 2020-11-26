Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDE7C64E7C
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 540DF21534
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiYj9+4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731723AbgKZB3I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 20:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbgKZB3I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 20:29:08 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF8AC061A55
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:29:07 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id g14so315555wrm.13
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E+luWtVqvQqThJmgx7PmrY7Jrfbso4FN40N39n03yDU=;
        b=WiYj9+4xaayV+G5Dvvrw0+PzdEOXfiYLKaFNlopEy9IqWCxGKZg+ekrfsp4pbrKFc3
         lir1TnBm3EvQhuH2CmIZ18obQb2ECGb6ixvxHazZgIKel0wDmRv24iB5dq601I+iT8LG
         gyClTVIvGQFVHnBTxkM6kXBLoIS2EzxueLNfo0iK2vX6IhOkN92Q0jBEi/VPv5Fb2tJi
         HB7yQ2nfA1pADjRdPXvBcCoVDhXasNzrgsoRokgSewpbiIGGQJAEhMzkxBVq4jgQKql4
         6ClhsP/yXH5+KACEhW8W8k/rxvLVPoILXHdmxfR7msBcBVi55CckQMpQo0RJNueSahWT
         onOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E+luWtVqvQqThJmgx7PmrY7Jrfbso4FN40N39n03yDU=;
        b=SYYyT9CZVKdUJx9oql+Mj/1pbCPagXan4ayHwYgo1FeuR9SVNxOZOEhMf28FprnGC6
         CbjbPrZLR4AcSPyMRnhXcJZxiLYpamBX9zXJnNHN/8SHmSHZoLdqDTBzh5xl6HNbkJ10
         sXm52sQh0XazfRYuHKQIySD6Oh01XE1C91slVS531k82SSKWYWOpaeReW+95KcZPHNcU
         lfdGBbTkpVuSGNEQHAc1i9DQvweXMyMiz8IYdsBHE/qOilC6nok2yqDySVeu5l2+fpCt
         ZPur/XNTHO2pNyVrFfnDjgBzzAei052CI9ytvWYmQUKVUKam92NV2E11bUW50dFYFnKH
         xMJA==
X-Gm-Message-State: AOAM531CBSKpLnEjt9y0cq6+4ouGIdNxj+IbWbqjHTtw2wtxf36lXFvj
        qgpkMPzlwajzUDjAwXuqf4tCsWiOJ5wgjg==
X-Google-Smtp-Source: ABdhPJzdLuXynqD7Ak62uf2lg9Acolagl+GX041zRzEGRp3BnGZ9BwutjFLbjDClt9B61oZhq24kLQ==
X-Received: by 2002:adf:e484:: with SMTP id i4mr717911wrm.398.1606354145554;
        Wed, 25 Nov 2020 17:29:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q12sm6402523wmc.45.2020.11.25.17.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 17:29:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH 05/12] mktag tests: remove needless SHA-1 hardcoding
Date:   Thu, 26 Nov 2020 02:28:47 +0100
Message-Id: <20201126012854.399-6-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
References: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the tests amended in acb49d1cc8b (t3800: make hash-size
independent, 2019-08-18) even more to make them independent of either
SHA-1 or SHA-256.

Some of these tests were failing for the wrong reasons. The first one
being modified here would fail because the line starts with "xxxxxx"
instead of "object", the rest of the line doesn't matter. Let's just
put a valid hash on the rest of the line anyway to narrow the test
down for just the s/object/xxxxxx/ case.

The second one being modified here would fail under
GIT_TEST_DEFAULT_HASH=sha256 because <some sha-1 length garbage> is an
invalid SHA-256, but we should really be testing <some sha-256 length
garbage> when under SHA-256.

This doesn't really matter since we should be able to trust other
parts of the code to validate things in the 0-9a-f range, but let's do
it for good measure.

There's a later test which tests an invalid SHA which looks like a
valid one, to stress the "We refuse to tag something we can't
verify[...]" logic in mktag.c.

But here we're testing for a SHA-length string which contains
characters outside of the /[0-9a-f]/i set. Let's just do that with a
ROT13 invocation.

We could get really unlucky and switch to a future hash function that
just happens to produce all [0-9] output for this particular input,
but that's very unlikely.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 0e411e3c45..b5013af2aa 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -43,7 +43,7 @@ check_verify_failure 'Tag object length check' \
 #  2. object line label check
 
 cat >tag.sig <<EOF
-xxxxxx 139e9b33986b1c2670fff52c5067603117b3e895
+xxxxxx $head
 type tag
 tag mytag
 tagger . <> 0 +0000
@@ -53,10 +53,11 @@ EOF
 check_verify_failure '"object" line label check' '^error: char0: .*"object "$'
 
 ############################################################
-#  3. object line SHA1 check
+#  3. object line SHA check
 
+invalid_sha=$(echo $head | tr A-Za-z N-ZA-Mn-za-m)
 cat >tag.sig <<EOF
-object zz9e9b33986b1c2670fff52c5067603117b3e895
+object $invalid_sha
 type tag
 tag mytag
 tagger . <> 0 +0000
-- 
2.29.2.222.g5d2a92d10f8

