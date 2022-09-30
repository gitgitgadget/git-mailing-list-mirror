Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C1FC433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiI3SI1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiI3SIR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:08:17 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3211E2FDD
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:11 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bk15so7987231wrb.13
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=2dVodM6Mq41nOjnuweYMPZnn79wFF8vKTSsZTpAioH0=;
        b=eiZf2tP9Cp2Yi34ACFwv8L0qmrur9qRudCqeUTBzM2rx5NvJhDUDrbTIk9dPvmykoG
         6Q4DjVI/DJ42RfEBErQMbdyPUXQ2lbLsfcxyYW4Pn+IpfwfZmqzvVHpDqadsq0ywOvg2
         Q4icYh5yNT2e3ldLrTNjJcONLhm8X0p2Tv2/pPh0h23MEwWXYJbBq6WgkZYYwTG0un0Q
         kJzArXcgcn9RckrEEJznD3tE+ebLCfvm51gHW7YyuOHvQRo8I9g2HYBGHQ63vefk6kpm
         eavBhkoqaUw4ElQ+oGvxH6TqUZReEZbt/YkvQSw3jNXSKFwRUczc40iP8mp5HptldzN5
         u01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2dVodM6Mq41nOjnuweYMPZnn79wFF8vKTSsZTpAioH0=;
        b=Wc3VkMqaceDGPdvdjhrmjytugx1G7pcUsIpdIhni1yNouhc7/tmCrrF1tEDn82O6Rn
         ax3dIhzvuIlTdE2bqXnKyO5vp3QnVt6nuqo5A58BbyuboTljqEC7HsRu5Lw4yx4S01QC
         gYyVIbINEfYPh2+CorvpQEtg7+big6Bu2y0OHU8Yu0ApdaCsyc6g4gKLhRRXCZxGPGpD
         /HbqZlcId8wb0VdLKk3qJpdzQV12ZhgdxRaPIwIzm84t6jCN8NDmeh5jCJP58dU2XlFh
         7xRtRkHYKHkx4wYaFyIerSaFFz4K40Qux0K0+no1qi7jrfoTAE5JN9g583UND/sSK20+
         xEkQ==
X-Gm-Message-State: ACrzQf0RgYh4NdFT0A79TiOW7qg/5q1vB+t0Q0bHMv6s9c02L1PZXEXt
        pv0HzZQv3CEvkSAr8N5wDsqLzZfoAN4R6g==
X-Google-Smtp-Source: AMsMyM4d4OLEMpg4foO7XbEVF3Jaft5PvSL2IEFr+sUtnTpzIH7fjM8UCchQjJS6Bq+qfvKYxwP1ng==
X-Received: by 2002:adf:f347:0:b0:22c:be39:4e38 with SMTP id e7-20020adff347000000b0022cbe394e38mr6393470wrp.151.1664561289804;
        Fri, 30 Sep 2022 11:08:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:08:08 -0700 (PDT)
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
Subject: [PATCH v3 01/36] CodingGuidelines: update and clarify command-line conventions
Date:   Fri, 30 Sep 2022 20:07:24 +0200
Message-Id: <patch-v3-01.36-1611913e321-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
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

