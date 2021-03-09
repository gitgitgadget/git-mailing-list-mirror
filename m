Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AD3C433E9
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 16:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7CD96527D
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 16:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhCIQCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 11:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbhCIQCi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 11:02:38 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021D0C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 08:02:38 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e10so16638819wro.12
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 08:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Toc9BjoJryEIP+exMGFtHV7tDclhRrOML+/yqJ1EY8Y=;
        b=I6RvnIOksPnUTPdfFkKiMJMHqjDr+gAkIXGrmIkDeQyBwpbMeCi6s+867MnxBnXZUJ
         z4NtVn+sfqt4VVeEW1zq5JyzbQvGOYHCTxJEGQ6TvRZu2ZXFgQGvZ72tc/ayUdc4+KQ3
         WUu9olsShQSLVklYFO+xYUEZk/LO8MqlsZ1xDkO4jwTuxmPpkk+wHfZcYye4aHY++yrC
         epcJ+XGsEqhhVTZqTOUa1FgKDEiE9lKIACJ0SLJ25dH3/Q4AeP9kSwZGdxDwaMq+ql7y
         nyqpTMKOvDlQyZaH+x11a6oiEGze+Sxs/zSexfOZ0I9faHVPDnd5hJYnO4SPdbh/21c4
         SGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Toc9BjoJryEIP+exMGFtHV7tDclhRrOML+/yqJ1EY8Y=;
        b=nszS6an7Fn8Av0cksgcf5zrh+0uo8r0JXlDRKLpF/tpV6Wp5RecnDUVL37YTovVaZn
         57bmjnn9sbjT5EKMN90eewPeD0bj3OgcSGiSAQIY+JwMVwyrHEzJmKN/h7/0bVANNUaB
         myChTh6QddWJRiAeQBkMb80sjZN5wNH+uFkskxd7NPP4kQnty2gK6KFN1io5gmmmrp3d
         uvZ/BWcp2opn68EEzLn/7yeQwyR9m6JFTcCR5nb5r5f+whBijeynU+vI2vrjqchdlOWJ
         TnMjgcTkfPHIAvMU9cErN5i0uqCHNceqdsJDaifqTZ23GOuD7Lwu6VlbpB1NrGFIRsW/
         Pzhg==
X-Gm-Message-State: AOAM533tsuR3yngi5KU8vSUkx5i2fz+CkMbRJi5O0zetzb0iuQnJoP3E
        wjwhxrwszpLCYzPGYUenuFwARJHpfKaucA==
X-Google-Smtp-Source: ABdhPJzrt3U3v10ZIFYZg7veF+CkuCsUJhch6rU6DNAsGHlEH6DHs5lZQIQ5o9bSyPaO7ZenR9cHmA==
X-Received: by 2002:a05:6000:245:: with SMTP id m5mr29694703wrz.284.1615305753739;
        Tue, 09 Mar 2021 08:02:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n6sm5089223wmd.27.2021.03.09.08.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 08:02:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/7] test-lib: color "ok" TAP directives green under --verbose (or -x)
Date:   Tue,  9 Mar 2021 17:02:15 +0100
Message-Id: <20210309160219.13779-4-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc1.210.g0f8085a843c
In-Reply-To: <87r1kzj7xi.fsf@evledraar.gmail.com>
References: <87r1kzj7xi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the color of "ok" lines to be green when we run under --verbose
or -x.

When a test fails we color the "not ok" line red, but the "ok" lines
are not colored.

I think that's the right thing to do in the default output, which is
e.g.:

    $ ./t0000-basic.sh
    ok 1 - verify that the running shell supports "local"
    ok 2 - .git/objects should be empty after git init in an empty repo
    ok 3 - .git/objects should have 3 subdirectories
    [...]

Having almost every line colored green in that output would be
distracting.

However, under --verbose we'll typically might emit 10-20 lines of
non-colored stderr and "info" colored output describing the test
itself.

When paging through that output always having the boundaries between
tests highlighted makes the output more readable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9a3a3d8d16d..8562b11b817 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -545,6 +545,7 @@ then
 	say_color_skip=$(tput setaf 4) # blue
 	say_color_warn=$(tput setaf 3) # brown/yellow
 	say_color_pass=$(tput setaf 2) # green
+	say_color_pass_all=$(tput bold; tput setaf 2) # bold green
 	say_color_info=$(tput setaf 6) # cyan
 	say_color_reset=$(tput sgr0)
 	say_color_="" # no formatting for normal text
@@ -673,7 +674,7 @@ test_ok_ () {
 		write_junit_xml_testcase "$*"
 	fi
 	test_success=$(($test_success + 1))
-	say_color_tap "" "ok $test_count - $@"
+	say_color_tap "${verbose:+pass}" "ok $test_count - $@"
 }
 
 test_failure_ () {
-- 
2.31.0.rc1.210.g0f8085a843c

