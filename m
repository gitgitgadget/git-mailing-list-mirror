Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7C3C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7D706124C
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240255AbhDLLd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237792AbhDLLd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:33:56 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633CDC06174A
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:33:38 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f12so12598101wro.0
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+OC9aKO2RDJfqJlIETUPBimMn3njOsTo/bK8ILtRGVY=;
        b=h856WJX2YP4dK23Q3AJAusnZcF3nKTERtuBbJNnByVLaEzNvg8+fEwBKDy9x+D1UN4
         B8ClgABoUXWCvRoChKJsiB/JUwky+Jty1t4LAKjrES5kWSxinBg9IZDMZAbQH4JWSoBe
         Z/oP5jFF01DXSVvyGlO9FfzvUzAEN7KX1v130anTrQvcjdc2ITz5HeBSmz2Y1fdv9FvP
         OEVjECTpYQtdcKN3XlI3zUk6DCOst6O4KYVuhmZeube6D/qGHUlrmXxg5+TBraJ+iMPt
         nbI6nZXkbCUWSeYZMlDDR3xIfxjwqve1xsBhWpR6M5t/gUolwCJrYAPhPqIdoAd6555c
         w0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+OC9aKO2RDJfqJlIETUPBimMn3njOsTo/bK8ILtRGVY=;
        b=akp4DpNKEFv6Ebni1dA+g8QNkYZOwmqadrnoudkgfMPyHggj3etPJgylIIRsZRPxQr
         1QsXT0Y4nA9pCVTf1A0xPqcvj5oSrhfuojP6HOTDzz5aH05Pl7ShUPf61e3i+xX4BDS/
         Q1ZPegtH8wVECaSpslSPkO6zKI9c7r+1xhUOpDRbVcp/g8fpBjER2XThnr84DGxwtPw0
         gvoRF+eRqubE8mGeTO/It1fxeXqNzxpr28+8/yRzb/ko5+9EmuZCkkffnbzPo3M79/1M
         zKQ9Eh4jWj6TxRuZRDY8HrclMjncvVsVP43C9T9sdjVKks/gzbhGMuE4joS12sOrDBvh
         E2BA==
X-Gm-Message-State: AOAM533aYqbx/2y9Az5DhBN8hLwu5qxgAuuKqykjiGLKe6z2tT0wWlfH
        JvWOQss9Y1juN84rqKvX9cWcY9/4817pew==
X-Google-Smtp-Source: ABdhPJzOOQsmTRCAhJl3ognB0GvkJ3Q4w6Gmj726kPWZJXwzTTNYurRs2FAM+qHL48FRuD8Zh/n/OA==
X-Received: by 2002:a5d:65cd:: with SMTP id e13mr30597480wrw.134.1618227216890;
        Mon, 12 Apr 2021 04:33:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u8sm17210139wrr.42.2021.04.12.04.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:33:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] svn tests: remove legacy re-setup from init-clone test
Date:   Mon, 12 Apr 2021 13:33:25 +0200
Message-Id: <patch-1.2-d08e098ea8d-20210412T113247Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.634.gb41287a30b0
In-Reply-To: <cover-0.2-00000000000-20210412T113247Z-avarab@gmail.com>
References: <20210228195414.21372-1-avarab@gmail.com> <cover-0.2-00000000000-20210412T113247Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the immediate "rm -rf .git" from the start of this test. This
was added back in 41337e22f0 (git-svn: add tests for command-line
usage of init and clone commands, 2007-11-17) when there was a "trash"
directory shared by all the tests, but ever since abc5d372ec (Enable
parallel tests, 2008-08-08) we've had per-test trash directories.

So this setup can simply be removed. We could use
TEST_NO_CREATE_REPO=true, but I don't think it's worth the effort to
go out of our way to be different. It doesn't matter that we now have
a redundant .git at the top-level.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t9117-git-svn-init-clone.sh | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/t/t9117-git-svn-init-clone.sh b/t/t9117-git-svn-init-clone.sh
index 044f65e9166..62de819a44e 100755
--- a/t/t9117-git-svn-init-clone.sh
+++ b/t/t9117-git-svn-init-clone.sh
@@ -7,12 +7,6 @@ test_description='git svn init/clone tests'
 
 . ./lib-git-svn.sh
 
-# setup, run inside tmp so we don't have any conflicts with $svnrepo
-set -e
-rm -r .git
-mkdir tmp
-cd tmp
-
 test_expect_success 'setup svnrepo' '
 	mkdir project project/trunk project/branches project/tags &&
 	echo foo > project/trunk/foo &&
-- 
2.31.1.634.gb41287a30b0

