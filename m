Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE101C433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 20:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239231AbiBAUf4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 15:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiBAUfz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 15:35:55 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651C3C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 12:35:55 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id f17so34323543wrx.1
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 12:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j+DgR5GXimpiJ3ODwpSJ5gq2Cea49M4SXXqLK9TO/PI=;
        b=Bsm7oKMhSXBsGYPGOVyycnLQwLhL6YR3Ou916ZB+rsvyNRJ3/Y7b3f3A/70Ahu3NZj
         QNCwasK5Qgx4w3k6UcszxH9ASkhKWUCZIqSVUsGf9WLLKgXIjZat4Mm1D7bCqMG6oj42
         Gx3ke43a31AG0PtnjJAtw40WeqGyoAdQ0Tbt+71i12yg5sR9lxwW7hgjCKud4Rvna5Cb
         q1E3CHpixYD44CmBFWKbJzklZX/u3I9ujf8pApZ8D91UvBwtr72n35gdJcxiqLC972F2
         jUmfLq3lNPyhpSQyT/ewXOQOjilZVZjy3t8mppwQF+JAks1vfyFeUaofGxYGt3LP2pFt
         oFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j+DgR5GXimpiJ3ODwpSJ5gq2Cea49M4SXXqLK9TO/PI=;
        b=nIcfo0zcpD6kv7RdZ3Yp/JzffSev5ZZMaPJAIRTMJYsbqNtto0GOAtbQQE92cWKcI4
         hGoLcb0rtSXNlhIecr66Wu3JzG/l7hPQPnZzDurd9qoNhFAIQZaofecKG5a17bpiuSrp
         81HshWrhT1ESZixnHbfXefsIvsVVMzzQMCscXZ5Hj1XDj2i1nLckCu9jOyIltrSg837K
         YltL6fT3oQxcnxM7Vt4srAvew8KQVHBy7P57vx4GL0eqA1czbfrHNxG0TouOjxW9C0Oy
         Ow9QuFU59NhCSRrxOvLwjDcMu9fO2hqoWzI1fa/baGh1COM+b5ib85lkdaKe/tht7Tjk
         a5ww==
X-Gm-Message-State: AOAM532bLdSRW0Z8rORcU3d11ZgSyb+sN5UnFGi7s4cIQ5YFQQj7kht8
        mKByoaR8eIWMNiGrNH0vvpLub0LDHfjyTg==
X-Google-Smtp-Source: ABdhPJw7/R8QCwSZjOq/0W3xZz+pYqXXSGfOuQ0kNseaVfwRpw7Ui94foQSFHD1sQCcZOyRs8tidDA==
X-Received: by 2002:a5d:4390:: with SMTP id i16mr13619242wrq.516.1643747753646;
        Tue, 01 Feb 2022 12:35:53 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j12sm15252246wru.38.2022.02.01.12.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 12:35:53 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] t0051: use "skip_all" under !MINGW in single-test file
Date:   Tue,  1 Feb 2022 21:35:51 +0100
Message-Id: <patch-1.1-34ff968dcb8-20220201T203428Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.913.g12b4baa2536
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Have this file added in 06ba9d03e34 (t0051: test GIT_TRACE to a
windows named pipe, 2018-09-11) use the same "skip_all" pattern as an
existing Windows-only test added in 0e218f91c29 (mingw: unset PERL5LIB
by default, 2018-10-30) uses.

This way TAP consumers like "prove" will show a nice summary when the
test is skipped, e.g.:

    $ prove t0051-windows-named-pipe.sh
    [...]
    t0051-windows-named-pipe.sh ... skipped: skipping Windows-specific tests
    [...]

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

A trivial UX improvement for the "prove" output, so that we'll show a
notice in the same way as e.g. t0029-core-unsetenvvars.sh and
t5580-unc-paths.sh do (which are both Windows-specific).

 t/t0051-windows-named-pipe.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/t0051-windows-named-pipe.sh b/t/t0051-windows-named-pipe.sh
index 10ac92d2250..412f413360d 100755
--- a/t/t0051-windows-named-pipe.sh
+++ b/t/t0051-windows-named-pipe.sh
@@ -3,8 +3,13 @@
 test_description='Windows named pipes'
 
 . ./test-lib.sh
+if ! test_have_prereq MINGW
+then
+	skip_all='skipping Windows-specific tests'
+	test_done
+fi
 
-test_expect_success MINGW 'o_append write to named pipe' '
+test_expect_success 'o_append write to named pipe' '
 	GIT_TRACE="$(pwd)/expect" git status >/dev/null 2>&1 &&
 	{ test-tool windows-named-pipe t0051 >actual 2>&1 & } &&
 	pid=$! &&
-- 
2.35.0.913.g12b4baa2536

