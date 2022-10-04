Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EB4C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiJDNYE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiJDNX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:23:58 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34B450538
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:23:55 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so7530239wmq.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dVodM6Mq41nOjnuweYMPZnn79wFF8vKTSsZTpAioH0=;
        b=FtD2QxIfuhHPQKLbZaaXSWyrg2+a+BvG5QTi8gLyTU+vx81CSooS2lgOP524WffI37
         lzf/xEzBKSRAx5acbt0By2Cct3WcPLAuw3IHkActEQreYd0yWPBLcp+qSnEswvZ3lXkH
         8F2ZteCZmOOsEgm/i1ADkzKMvoQs1EE1UDICe3SoHwF8DaMdEayyrhMk1CeZmJ07FFs2
         W4Ejg2oP6VMQfxXXxCtFfhfO7EHKS5NonR+cgQ6f8EfkWuEVkfTjEmzJ7gOpl0adGVBs
         I2WWzIscuI3qIF6JuN08qTsZ1dkaonrCT5kV5zDcfcvX+BiFzitRHCHtoQDmSygBQC9p
         9/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dVodM6Mq41nOjnuweYMPZnn79wFF8vKTSsZTpAioH0=;
        b=kkJtCd7oisUBLxaY0VhOt8ZkRIvqO8vjNPtBzFDgckHhzKZO/uPVvVFEFrFBpebAmF
         Ne7mAilAXrF+lGUYcDaj2mj6PndyTdKsgIpctPHFu16ixoQw5k2D3ftbbOoOOzHceFrF
         rOWW8h9sMxQkUBPpsdiUaC7+Zy5EQ6+EUh59/CnTZ4bmTk9AYGbkTgDSaG2C/wog8Iix
         a9cecfKkFm51UM9eBx9sKl7Qr5vRSA4ucp14u4Rntqlm9A/mKqg8qLtbCbSpR47dz9QK
         SHqi+YL9yLZUmU4LUAP8jlsOuRC/zOGzIWfUHYhoHpjSiE2HCdMwMj87TuFBQbLjx/Ln
         wufA==
X-Gm-Message-State: ACrzQf3RQiUcYwHeYNXQnBxg6qCA0mlrdNpRiGG4zoscDP8IX/cIo5i+
        9BNKVwK0mQOqfkAKU8JWWXN500e4evd2Jw==
X-Google-Smtp-Source: AMsMyM4W90sU0mBBDbu+p5HI6fZ4wmC5sYtrMHA0bli+j7NCP8LohW5w66fsdWEyU74qVMMHkFI5fw==
X-Received: by 2002:a05:600c:216:b0:3b4:874c:61e6 with SMTP id 22-20020a05600c021600b003b4874c61e6mr10513720wmi.116.1664889833535;
        Tue, 04 Oct 2022 06:23:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:23:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 02/34] CodingGuidelines: update and clarify command-line conventions
Date:   Tue,  4 Oct 2022 15:23:16 +0200
Message-Id: <patch-v4-02.34-c95d3b9ad42-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
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

Having a space around " | " for flags, but not for flag values is
inconsistent, but this style guide codifies existing
patterns. Grepping shows that we don't have any instance matching the
second "Don't" example:

	git grep -E -h -o '=\([^)]+\)' -- builtin Documentation/

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
2.38.0.rc2.935.g6b421ae1592

