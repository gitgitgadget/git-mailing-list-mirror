Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C545C6FA82
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbiI1Ij4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbiI1Ijl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:39:41 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F5F11148
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:38 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u16-20020a05600c211000b003b5152ebf09so707933wml.5
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=qSCPsaHOAA1ikvoT+hkefK/2NQYBEkLgLHRVfqy65v0=;
        b=XQEMfZ/P2wckKgh3cBOual6/5OZlDRN9UEEoL7dvhmKt3auW/iIeyPd5z7Z6MRO6NR
         9YQAL1aUppbT9STVTTW3HudYIAEjWv/zx0w7MEXGWc5eDMyt6g6P9wy2iHlQ2tKc/Rmm
         V/e4es+skpd89wlJQxW0/uFkACLqjVkWGHhCVg8i5dTpJMHtsA55NjVNEir8UT2mFS/C
         QgOPOkLKYDBtAuh2S4k0X0Huxix3ZiA+HtXFqAobruj6xXBk+Sw2YJjeXu/i7o00Auh5
         yIpvzPF1AdVLGHkfh7pC6NcYLSXLH0HLb84F6RlBkl+P7aRcwUi3lItn4M1fd4Y5i29n
         DljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qSCPsaHOAA1ikvoT+hkefK/2NQYBEkLgLHRVfqy65v0=;
        b=X7JzfYWaarzqxVsIK8BGyPo7mvduYiLyrqoFWhMOr2bj0gsFdisdm/E8zIgkpCZt0f
         RJa0Agdp7QNupYCQfDHI6bVL2uGJP1Lq+zyLgIW1K5qulxW3A5eiS3AOVUpHjDQWzOhw
         9F1I6i0oKHq1kybaY3shqyy2EpKSsLz+PfAYbdzZmtIvoePx/ZsYZWG0248ql4pVzbgF
         4ZlsizO1MTkbMnCYeiTArcG9Y98zzq3WEw3xEd3vHQdynn/Q9Bsge99RD9/zEn2eiMAq
         Bhv04CVrq+CR0Mw5XgauvptaGahCGUqRR9niHdC2MeNj9kGB2MAlffTIclrmMSm1lJC8
         YsQw==
X-Gm-Message-State: ACrzQf1tO/kRDnFNIWvigtr9e5SCjluajYAx3Y6IF6Oqm9XIzGqmcdzR
        3fRDMZ5pbCH+bbdtY7wKUb39S5pl7Em6sg==
X-Google-Smtp-Source: AMsMyM5cOd11l+OvvgUm/98F1hZjP8KDB1t4K7wdycEHFSPgtWHA4OShifqx/2Bh+ARzVX0tYzmLDQ==
X-Received: by 2002:a1c:440b:0:b0:3b3:330d:88d8 with SMTP id r11-20020a1c440b000000b003b3330d88d8mr6007081wma.31.1664354376694;
        Wed, 28 Sep 2022 01:39:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:39:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/35] CodingGuidelines: update and clarify command-line conventions
Date:   Wed, 28 Sep 2022 10:38:56 +0200
Message-Id: <patch-v2-01.35-aecd3ff41f2-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edit the section which explains how to create a good SYNOPSIS section
for clarity and accuracy, it was mostly introduced in
c455bd8950e (CodingGuidelines: Add a section on writing documentation,
2010-11-04):

 * Change "extra" example to "file", which now naturally follows from
   previous "<file>..." example (one or more) to "[<file>...]" (zero or
   more).

 * Explain how we prefer spacing around "[]()" tokens and "|"
   alternatives, this is not a new policy, but just codifies what's
   already the pattern in the most wide use in the documentation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/CodingGuidelines | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 9fca21cc5f9..3d3bdeba9e4 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -650,8 +650,8 @@ Writing Documentation:
    (One or more of <file>.)
 
  Optional parts are enclosed in square brackets:
-   [<extra>]
-   (Zero or one <extra>.)
+   [<file>...]
+   (Zero or more of <file>.)
 
    --exec-path[=<path>]
    (Option with an optional argument.  Note that the "=" is inside the
@@ -665,6 +665,16 @@ Writing Documentation:
    [-q | --quiet]
    [--utf8 | --no-utf8]
 
+ Use spacing around "|" token(s), but not immediately after opening or
+ before closing a [] or () pair:
+   Do: [-q | --quiet]
+   Don't: [-q|--quiet]
+
+ Don't use spacing around "|" tokens when they're used to seperate the
+ alternate arguments of an option:
+    Do: --track[=(direct|inherit)]
+    Don't: --track[=(direct | inherit)]
+
  Parentheses are used for grouping:
    [(<rev> | <range>)...]
    (Any number of either <rev> or <range>.  Parens are needed to make
-- 
2.38.0.rc1.925.gb61c5ccd7da

