Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6506FC433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJDNVl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiJDNV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:21:29 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159D550513
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:21:28 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b4so14339018wrs.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dVodM6Mq41nOjnuweYMPZnn79wFF8vKTSsZTpAioH0=;
        b=nP9mUBwG1QNZSiw0Lr8OwKN3rvDwxXvDcPAAgvYgvXUtfqgcqwuhP5oFNCRVAYuo8S
         tK194Bi2w+VKv7H40njLRcF85AT1Km59oJagTIVSPllu+oTzHC679T3rH+8CbcYRstEV
         XXz4vdVVd7HEXJRvjV5fKDCEQsRN1xII9ObB09d5ETc61EOW+BeG59eY+5V3YDS6HoAA
         IZl4ULYGB3vMFODe7y692hhOr7bwBalghquhQva40T1LMfCyjocKC813KoaLFQmqiuZN
         mm8jPaTB2CXI9O9r2VsNbYkH0Es1fKrK3nPxMyr0fsb2wMwPdv4K3nDnnfRELeXkZ0Cs
         AAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dVodM6Mq41nOjnuweYMPZnn79wFF8vKTSsZTpAioH0=;
        b=d5vvrZeSiOjqlVqHsxoY07oxxQBYVCYcNRjUV2MCxCFk2UzrfG6VNV4mYrVCys7cIy
         ZAprYzLnj4sDzbZiyTB7TA+tNMvyiqk5ggG4Xe+kvJ/ARrCjdAv2KEXFan4/SG83S1rw
         fSCvSXjqBo4UvMR3/33aZdcJ+ZfyvFuvbG495xnygUaTE5oGQT5Ng91gPca+aYTRAJM+
         Z2yhZi/kOSf9UoGQWDnbElfg25yLhJDZIHIbxEjCNw/2NxlW66RJsF6YjEulqqyA8SxB
         LaOQvc8hZV91eZuwUN9JUpnSNNaI8KqJYLBgyNkHRmeYjkyPgBuPzD7+b2q8CngBtg+y
         ZsoA==
X-Gm-Message-State: ACrzQf3OlPfSaRFk6S86nbnzZPVdLXhXxqbEG5PytyiFNhp1orAMgdOx
        2WUKXNQf4apLT1qhf3rY7xekbPvs56QQTA==
X-Google-Smtp-Source: AMsMyM6ADmw0SvdepKSRh/92ZW9NHbpDud1HS5yIg/D4jk6uPCQk6pQBVvobs5VpUSDkTJirKP3/aQ==
X-Received: by 2002:a05:6000:1842:b0:22a:4d1d:4bd6 with SMTP id c2-20020a056000184200b0022a4d1d4bd6mr16032104wri.603.1664889686277;
        Tue, 04 Oct 2022 06:21:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f7-20020adfdb47000000b00228cbac7a25sm12429205wrj.64.2022.10.04.06.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:21:25 -0700 (PDT)
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
Subject: [PATCH v3 02/34] CodingGuidelines: update and clarify command-line conventions
Date:   Tue,  4 Oct 2022 15:20:47 +0200
Message-Id: <patch-v3-02.34-c95d3b9ad42-20221004T131009Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com>
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

