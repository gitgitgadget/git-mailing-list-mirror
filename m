Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BB2C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 20:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392268AbiDUURj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 16:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392298AbiDUURd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 16:17:33 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B93163C8
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 13:14:43 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m14so8182334wrb.6
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 13:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8biSKho1+OKVOIB8CCTd48exGbAiqISG8dmbrNrlW+E=;
        b=YC0eLDCwL+kPb2m54F3/vYG2lTT7VPzFZKy/DtHxtC1ylnbHibJAhFAQy3BnwX7X7l
         43ZKGAu4z+azw+1v13nqsdDXpOVLK+mpD97UEUCI6NJtV2w+UBXYXv/qVhXPwVvpJBvP
         OeQvTemMYFZuelm29e97j7lkZiMYnjLbBTqQGtKD5t0DGEiM6Q80VRn2gQbUq0R4GU3c
         /j0Ae1WCre5r1n2vnuxBJVI4ihaifr9XzuSTzeMzDuvgcATbor9QpUIuaJJU1s+56WbI
         xFSN+bsW0FDmNNm7ucCS8Mx7RGuiZ3KEsHXBkwgYsY6h1B5tkImB5/0z/Ci0hCMwXrgD
         IqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8biSKho1+OKVOIB8CCTd48exGbAiqISG8dmbrNrlW+E=;
        b=zM7PfRmiqyeuY1k2HJ2iNHXgoNEVJYy4VZlYsmLNqlQZkbL23NHbq3NcC7Fdyu54Ny
         f3qJj0lR7PcSepSqrXg3cX5o8BvOhq5aPYHuoowO6oukl1ZUep1GZGOb8QXi6P9wkYLU
         OuyfADZoNbr59PVOeEz89FaqMi/GMMDiXVZbD8yIkMECC0KHpuNtRBtXYxf8bt9ZH352
         7oVQ7Xskk3C6s24pVBAiIbCUcwMvaUOIKp02M6bTJ2we3xU53EXBzX6KSV36plXVq0IG
         vpbK+nDNcoHWOaQhbrrc3Sjc/K2qTqAi4pJ0Bg5uxuGT7AjJWFYfQJNMdKKAUdBu6nQO
         1Yww==
X-Gm-Message-State: AOAM531FzZCU2RnlSNLzr3MI5E4jfKtSmpOpejb6uIhs3ZMsNBCPGNcD
        MjieYyOT7Etxd81iWB4+CUqvGQZqXv7Png==
X-Google-Smtp-Source: ABdhPJxUExWP8Tx3yJrTYpvRnGxo6v1txXAQy2xQa9VAyhN8gbO74ZLjUqMj3apcgOWjW7n3jyl5kw==
X-Received: by 2002:adf:d1cb:0:b0:20a:880b:13d2 with SMTP id b11-20020adfd1cb000000b0020a880b13d2mr1005386wrd.323.1650572081518;
        Thu, 21 Apr 2022 13:14:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l9-20020a1c7909000000b0038eb8171fa5sm1309wme.1.2022.04.21.13.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 13:14:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/4] log test: skip a failing mkstemp() test under valgrind
Date:   Thu, 21 Apr 2022 22:14:35 +0200
Message-Id: <patch-2.4-0f7d2622541-20220421T200733Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.gd068ac2c328
In-Reply-To: <cover-0.4-00000000000-20220421T200733Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20220421T200733Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Skip a test added in f1e3df31699 (t: increase test coverage of
signature verification output, 2020-03-04) when running under
valgrind. Due to valgrind's interception of mkstemp() this test will
fail with:

	+ pwd
	+ TMPDIR=[...]/t/trash directory.t4202-log/bogus git log --show-signature -n1 plain-fail
	==7696== VG_(mkstemp): failed to create temp file: [...]/t/trash directory.t4202-log/bogus/valgrind_proc_7696_cmdline_d545ddcf
	[... 10 more similar lines omitted ..]
	valgrind: Startup or configuration error:
	valgrind:    Can't create client cmdline file in [...]/t/trash directory.t4202-log/bogus/valgrind_proc_7696_cmdline_6e542d1d
	valgrind: Unable to start up properly.  Giving up.
	error: last command exited with $?=1

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4202-log.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index be07407f855..6e663525582 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1992,10 +1992,13 @@ test_expect_success GPG 'log --show-signature for merged tag with GPG failure' '
 	git tag -s -m signed_tag_msg signed_tag_fail &&
 	git checkout plain-fail &&
 	git merge --no-ff -m msg signed_tag_fail &&
-	TMPDIR="$(pwd)/bogus" git log --show-signature -n1 plain-fail >actual &&
-	grep "^merged tag" actual &&
-	grep "^No signature" actual &&
-	! grep "^gpg: Signature made" actual
+	if ! test_have_prereq VALGRIND
+	then
+		TMPDIR="$(pwd)/bogus" git log --show-signature -n1 plain-fail >actual &&
+		grep "^merged tag" actual &&
+		grep "^No signature" actual &&
+		! grep "^gpg: Signature made" actual
+	fi
 '
 
 test_expect_success GPGSM 'log --graph --show-signature for merged tag x509' '
-- 
2.36.0.879.gd068ac2c328

