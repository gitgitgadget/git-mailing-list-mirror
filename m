Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE434C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 11:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiGKLnQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 07:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiGKLmx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 07:42:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A27F20
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 04:37:42 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id z23-20020a7bc7d7000000b003a2e00222acso1684362wmk.0
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 04:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HVb5KZOcIQ0eUZwjdnTaXox4lZXWwuAVKutP2mZTYes=;
        b=DFStYf+gFzS7Ip2r7PTH2Qwog0MmW3Jxtw7K+TCXm8MEz+8PQqYJ3mN8Y1OOLMn0zV
         IRzIaYUyd55BRn6Vsko7oyd5auOKfAL885MwZd7o6a8NjIufVyPvPguxmQRAZn49SG5A
         u7P9dVyYmwGwXTDngHnt4nYGhI1MpklVgDNjM5ObvprpvJfoQWSjMdn0skerkzE3zLvJ
         3WTBRH5wgWwaskYOq6aXSy16q2jH7yd0RWPuKFZDn8PqW6AaVY6RtWFo8orIePU8KWOm
         8BnH7GgeJ1/K9mo+zfFYA2o9gsw7NjLOnih6T9w3RJk85kpVk2F9gxrpXWDYAtTWNmNF
         JxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HVb5KZOcIQ0eUZwjdnTaXox4lZXWwuAVKutP2mZTYes=;
        b=8GuxYgnumxDrJdmyMYOoGA26mL6k2ytRWns8vpM/52AN+KWTMZrs5dtC000rnxHh2U
         fou0oxKaCesgirHwVu/nWaFcSrVOWO224MdALE6idmu9lavgqn/fbLCFHHnfF5RDSlDz
         wJV05DXfvEFsD/zLM5lPbDSabczl9W4RrFkqfBHGSvhm9Fpm4kCRpYqSp91XITjiQXL/
         NXRlAnDsT0vYBLKgSJc0H3Y4crl2+8yv26kLZTDUgTQXrrov4voDU6kQq0Rvs3rMWYTK
         FvP2IUjMdgDgeYrj9Mul0Sp4D4Dy65ZpcLHkVpBwusjz69VvKK2BsRqsSIpj+fO4S1PW
         k6hw==
X-Gm-Message-State: AJIora+HPvH2PjXCIzm2XFqe0+yPYm79MyLyrozCsykXu/oAV6K1ELrP
        gcOc1TNa1MDweJ40qFBm3ztqgyXZDkTsKg==
X-Google-Smtp-Source: AGRyM1ubEmX5ZbaQ76ViuMAErihNPK7DYUmBh4N/lK+FvqKgpT76mIWub1Xi3M86GxUlf2VrXNRbYg==
X-Received: by 2002:a05:600c:3494:b0:3a0:37f0:86ad with SMTP id a20-20020a05600c349400b003a037f086admr15805479wmq.65.1657539460345;
        Mon, 11 Jul 2022 04:37:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b17-20020adff911000000b0021d819c8f6dsm5562463wrr.39.2022.07.11.04.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 04:37:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 2/4] .clang-format: Add a BitFieldColonSpacing=None rule
Date:   Mon, 11 Jul 2022 13:37:26 +0200
Message-Id: <RFC-patch-2.4-cb69bfa0d0d-20220711T110019Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.913.g189dca38629
In-Reply-To: <RFC-cover-0.4-00000000000-20220711T110019Z-avarab@gmail.com>
References: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net> <RFC-cover-0.4-00000000000-20220711T110019Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Formatting bitfield as "unsigned foo:1" is the usual style in this
project, not "unsigned foo : 1", which clang-format will use by
default.

Before & after this change running "make style-all-diff-apply" will
yield:

	582 files changed, 32029 insertions(+), 29794 deletions(-)
	579 files changed, 32065 insertions(+), 29818 deletions(-)

However this highlights a major limitation in this approach, because
clang-format v12 or newer is required for this rule, but that version
was only released in April 2021.

This change therefore cuts off anyone using an older clang-format. We
could decide to dynamically detect the version, and only supply this
as a --style="" rule on the command-line for older versions, but then
users on older versions would get different results.

So what do we do about that? Declare that "make style" is what mortal
users should run, but that we're going to run "make style-all-diff-ok"
on some blessed version of clang-format?

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .clang-format | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.clang-format b/.clang-format
index 3f536c49f24..87398d24d4f 100644
--- a/.clang-format
+++ b/.clang-format
@@ -144,6 +144,10 @@ SpacesInParentheses: false
 # int a[5];    not    int a[ 5 ];
 SpacesInSquareBrackets: false
 
+# Use "unsigned bf:2;", not "bf : 2" or whatever. Requires
+# clang-format 12.
+BitFieldColonSpacing: None
+
 # Insert a space after '{' and before '}' in struct initializers
 Cpp11BracedListStyle: false
 
-- 
2.37.0.913.g189dca38629

