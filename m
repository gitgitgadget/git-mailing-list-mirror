Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E005C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86DB361A40
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354519AbhJAObI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 10:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354517AbhJAObH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 10:31:07 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3948C061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 07:29:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a18so3727230wru.4
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 07:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xqa/wFsDXWzZBwSmsUM9J1d/PhaCOTsAhzNHv7RYTzc=;
        b=JMpX9W4zQLEsth+ZQnV9Uokw4s7sBY8kv+cmibAEJwY/1ARe0Aa9eH47RaQxg5ejFg
         dfcIuR4DU4NxSxiadFpGbdKVPzGOcVO8I8z2XY8wggx0EKrlp5baPFTKmG/4QOAxlFXM
         RJtkOADsXoDyRfkbofy0xF0iU+K+Ok9yKwcEyz/2ecJY/6qQOBaun50foQSs8XWrf+cu
         iHF62zj8nsTE7beb0Hyanxq1YQMB+xWwa21h4POqxDDvGsRsi80NK9AH8OoQ9woSaNxn
         wFW9LU20+qcAL/WTqxisLrQnwtgbxCEei5op8PpYacbL1nZ5xlFlJKWfQPknCOHKuu7N
         jBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xqa/wFsDXWzZBwSmsUM9J1d/PhaCOTsAhzNHv7RYTzc=;
        b=i3ct36Mb8AHiCnthW3KT7yGsCttL207Lj1DwtfoDHvZSntUc2VXlt8X1q4iPORXG/M
         XUdtZl9SfoCzVw3H1ublu0aBdb9o+ks3D0IiE6IRjm1LB56torxB3JlOOen7qdrYUltT
         eFew9wwWRCJuJOtMUuG63Mg4czHIZNCRcn2sv1rNIS7ZMTUlkNNp3ct3fY76B1YtMyG9
         P/ny70qaSv2v1NIAaWjzBRqJda4IBTPUwP25p5XvUo/qqEWLh64MZ1n4sWcn2e81G1mz
         VsH9GoPsyfpri9qYpxpeGiBott+DW52cHD5Y/YLZ9K5zO7yidZujjsfaeyPHBVg9wVDx
         V5TA==
X-Gm-Message-State: AOAM531Eu50oxCdpURtezgn2mIbJ0zwXHnY8+zVYnxIZPaA4l9YAsLSE
        tLtVJbQmxH4HgUKSMpw7wfYJy3R7PEQWeg==
X-Google-Smtp-Source: ABdhPJyOYVJy30QGdxb5HalaP3UxYv7Fq20L3h8uMrJ+MBPLg82Xi+7iclykY7ZRn+Edbv/HE6YlwA==
X-Received: by 2002:adf:fe89:: with SMTP id l9mr12796756wrr.0.1633098561349;
        Fri, 01 Oct 2021 07:29:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 189sm9042069wmz.27.2021.10.01.07.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:29:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/11] parse-options.h: move PARSE_OPT_SHELL_EVAL between enums
Date:   Fri,  1 Oct 2021 16:29:07 +0200
Message-Id: <patch-v2-01.11-553931702df-20211001T142631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1374.gc8f4fa74caf
In-Reply-To: <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bad landmine of a bug which has been with us ever since
PARSE_OPT_SHELL_EVAL was added in 47e9cd28f8a (parseopt: wrap
rev-parse --parseopt usage for eval consumption, 2010-06-12).

It's an argument to parse_options() and should therefore be in "enum
parse_opt_flags", but it was added to the per-option "enum
parse_opt_option_flags" by mistake.

Therefore as soon as we'd have an enum member in the former that
reached its value of "1 << 8" we'd run into a seemingly bizarre bug
where that new option would turn on the unrelated PARSE_OPT_SHELL_EVAL
in "git rev-parse --parseopt" by proxy.

I manually checked that no other enum members suffered from such
overlap, by setting the values to non-overlapping values, and making
the relevant codepaths BUG() out if the given value was above/below
the expected (excluding flags=0 in the case of "enum
parse_opt_flags").

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.h b/parse-options.h
index 39d90882548..3a3176ae65c 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -33,6 +33,7 @@ enum parse_opt_flags {
 	PARSE_OPT_KEEP_UNKNOWN = 1 << 3,
 	PARSE_OPT_NO_INTERNAL_HELP = 1 << 4,
 	PARSE_OPT_ONE_SHOT = 1 << 5,
+	PARSE_OPT_SHELL_EVAL = 1 << 6,
 };
 
 enum parse_opt_option_flags {
@@ -44,7 +45,6 @@ enum parse_opt_option_flags {
 	PARSE_OPT_NODASH = 1 << 5,
 	PARSE_OPT_LITERAL_ARGHELP = 1 << 6,
 	PARSE_OPT_FROM_ALIAS = 1 << 7,
-	PARSE_OPT_SHELL_EVAL = 1 << 8,
 	PARSE_OPT_NOCOMPLETE = 1 << 9,
 	PARSE_OPT_COMP_ARG = 1 << 10,
 	PARSE_OPT_CMDMODE = 1 << 11,
-- 
2.33.0.1374.gc8f4fa74caf

