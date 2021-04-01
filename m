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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4812FC43460
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1678E60FEE
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbhDARxX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236854AbhDARrg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 13:47:36 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DDAC08EC97
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 06:56:39 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so2903229wml.2
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 06:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tl6bubXoKoHJXkNLFtOaaDIbI4NaaaAehNk92OsY82E=;
        b=fOBSGACqEKc9PydIR5prQ15R1QV9Xr4ky3xGmkbtpiFnKH7OcX/qQg5AQ3bVVgKcZk
         NP+3fwXju76XW/UpVDgm/F1zCGW+wfm/ebdc6pIp9x0koRm5OoWvw/7yQrNzOjvuSsfU
         hVeSXc9azQ1O1L73OKfZCXABGrCWxaK61Bsiqz5mZzWWvXZ5QCsB7psZuAfR9l3U3y8l
         yCGk5eTvvQuz1C57j1/JMh2qw3ZZEehwGNPTpdcCQ3dczpzaFj2r2NmAtAnU5j3Joc79
         6HOVCUXsf+fiVo9SH/PFkYZrXXFlFYVf0zwXRsFBEd/0P9KtOXf08tWmWQ8wE1rW7ZjO
         dTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tl6bubXoKoHJXkNLFtOaaDIbI4NaaaAehNk92OsY82E=;
        b=C5QzKXZBcf3oks+Hm3wJIxkJ9NyrCOedExyQcMRI9SD9dqPPj/DOoPSwu70SzHtETQ
         xbW/IRt5pI0xB4XD5iq/de+Uz6AunQsSsxJIeBLy8nBsJLrO43MtZghXuj1qo9tXGqTi
         eTOipoNwPEyDc7d4tMGejsVSM+lPP0ntbFYvQJJW3lqhXDY3HaB8w9mBsRd7lZISDtmj
         /Dd5soKH2blQsoD/D8yLxAw2fB9QIZ/PMhVUd6/xZK9EC8d4lleLZZCEX6bGHT76xRi4
         +xhOFqqKtQfzsVyyhY11SDAsXdPzjnl3lo5Yrzsin60Q+eiYyWZ7wNMo8MhWN6mKkOEm
         B/xw==
X-Gm-Message-State: AOAM533uhT8YgkX6tMbFXiCFgt+93cQ3hKzBhm5gpAZ7fWK7J5mgl4J3
        j4WLrTU9wa0oOfyN0e3wV+T6OURwHujaLA==
X-Google-Smtp-Source: ABdhPJx8t/zX+LsPuUGtzoQPRetlZo0iJLdvdxZFJoF5oJi4GPh9kgbHEYWBwFV+DfQMAn47CrifyA==
X-Received: by 2002:a1c:a916:: with SMTP id s22mr8390852wme.82.1617285397828;
        Thu, 01 Apr 2021 06:56:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n7sm10145770wrv.71.2021.04.01.06.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 06:56:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/5] ref-filter: fix NULL check for parse object failure
Date:   Thu,  1 Apr 2021 15:56:30 +0200
Message-Id: <patch-5.6-2ffe8f9fe3c-20210401T135419Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.474.g72d45d12706
In-Reply-To: <cover-0.6-00000000000-20210401T135419Z-avarab@gmail.com>
References: <YGWFGMdGcKeaqCQF@coredump.intra.peff.net> <cover-0.6-00000000000-20210401T135419Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

After we run parse_object_buffer() to get an object's contents, we try
to check that the return value wasn't NULL. However, since our "struct
object" is a pointer-to-pointer, and we assign like:

  *obj = parse_object_buffer(...);

it's not correct to check:

  if (!obj)

That will always be true, since our double pointer will continue to
point to the single pointer (which is itself NULL). This is a regression
that was introduced by aa46a0da30 (ref-filter: use oid_object_info() to
get object, 2018-07-17); since that commit we'll segfault on a parse
failure, as we try to look at the NULL object pointer.

There are many ways a parse could fail, but most of them are hard to set
up in the tests (it's easy to make a bogus object, but update-ref will
refuse to point to it).

A minimal stand-alone test can be found at, but let's use the newly
amended t3800-mktag.sh tests to test these cases exhaustively on all
sorts of bad tags.

1. http://lore.kernel.org/git/YGWFGMdGcKeaqCQF@coredump.intra.peff.net

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ref-filter.c     | 2 +-
 t/t3800-mktag.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index f0bd32f7141..a0adb4551d8 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1608,7 +1608,7 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 
 	if (oi->info.contentp) {
 		*obj = parse_object_buffer(the_repository, &oi->oid, oi->type, oi->size, oi->content, &eaten);
-		if (!obj) {
+		if (!*obj) {
 			if (!eaten)
 				free(oi->content);
 			return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 10e4fde28de..b175d639013 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -64,7 +64,7 @@ check_verify_failure () {
 		git -C bad-tag for-each-ref "$tag_ref" >actual &&
 		test_cmp expected actual &&
 		# segfaults!
-		! git -C bad-tag for-each-ref --format="%(*objectname)"
+		test_must_fail git -C bad-tag for-each-ref --format="%(*objectname)"
 	'
 }
 
-- 
2.31.1.474.g72d45d12706

