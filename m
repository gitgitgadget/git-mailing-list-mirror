Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C08C4727E
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 03:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 904BA21D43
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 03:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uEoj9XDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgJADqV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 23:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgJADqV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 23:46:21 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4C6C061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 20:46:20 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m6so3967285wrn.0
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 20:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kMKDnHn06oMedf8Zi981Xaj1FxFvUg58m4Kj+4amaPs=;
        b=uEoj9XDRW+iND1FTgyOHHfORtGOgYtGFAg8s+pslFn+J4+Xxm3FsVVyeQhHD3w3xpv
         Id6viCmAuImLcSaY0oHM127UzinKMWcbH0HDMM/JC77S6r72La2xDGlSUZTOuF3FCI1O
         cVJgioOgYBNXGtKQYwCoenfOAJMD5NohzTqbar0lkHgmZGf8iHIorrnH+X1yPSw+SvbN
         1BiGTV2HDZvlV3vsj26rVRYdHoBeHXmeaOoKYebIJOpExbXBsyctGxP8KHyjdvjk0E+z
         OBx8XsBx74h3CE5mtiwdv0zr56n2NQmPjzuWO/xw7HfrgIe5lODdUWnHHi7uopOUcssi
         cz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kMKDnHn06oMedf8Zi981Xaj1FxFvUg58m4Kj+4amaPs=;
        b=UcSVCwNPA2uehCOMFDHrWN2xhcrcfRhOSMVlDTatZNEyyVkLV5WnCB6ynHPJdl6Ioy
         zNY8DRA7H5Fbk2OpQDeF2LTBbWlU8cX8EFQiGg7NzE88x3nYHKZk6p2ZLeIHup4UhoHo
         Nssuw3JRvBZuJ1zRjEA6CbqO3M4R9NOWOs9IhV94Ks8UcfxM+1naEEuMREwgwfcaCmDp
         fZvmqL3b3sljcokujheX8eKnJe4gOQzVPNqr10ABbfpM4hzo+UMgRhgJkEmvvZeUlA6r
         kYsQankTJagK242AYjzHHO3ZwYqToQ2TMCe+zLkBt2bG2vi26o+XBfHedgBdxwIDfO8m
         ZLzA==
X-Gm-Message-State: AOAM530jSglF5mW/GVCSHv4zvFDXopvqzCTa5PSmo6KtmSP7m9YPaGjH
        0CmoEdeVnUO7nMVcsREmI/ri5PC0wsQ=
X-Google-Smtp-Source: ABdhPJx7Q8LOjp5Ms6bD8I44hHo6UivH3x99NnQ0a3DqhQJwvggCMhlkeOI35e5wGNY9TPKM6rw1XA==
X-Received: by 2002:a5d:55c8:: with SMTP id i8mr6362271wrw.331.1601523979388;
        Wed, 30 Sep 2020 20:46:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j10sm6391872wrn.2.2020.09.30.20.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 20:46:18 -0700 (PDT)
Message-Id: <4195dec00c846e2a1ebcd32d0cb5d0ed2626328d.1601523977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.727.v3.git.1601523977.gitgitgadget@gmail.com>
References: <pull.727.v2.git.1601350615.gitgitgadget@gmail.com>
        <pull.727.v3.git.1601523977.gitgitgadget@gmail.com>
From:   "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Oct 2020 03:46:10 +0000
Subject: [PATCH v3 1/7] clone: add tests for --template and some disallowed
 option pairs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>, Sean Barag <sean@barag.org>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Sean Barag <sean@barag.org>, Sean Barag <sean@barag.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Barag <sean@barag.org>

Some combinations of command-line options to `git clone` are invalid,
but there were previously no tests ensuring those combinations reported
errors.  Similarly, `git clone --template` didn't appear to have any
tests.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Sean Barag <sean@barag.org>
---
 t/t5606-clone-options.sh | 46 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index e69427f881..0422b24258 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -15,7 +15,51 @@ test_expect_success 'setup' '
 test_expect_success 'clone -o' '
 
 	git clone -o foo parent clone-o &&
-	(cd clone-o && git rev-parse --verify refs/remotes/foo/master)
+	git -C clone-o rev-parse --verify refs/remotes/foo/master
+
+'
+
+test_expect_success 'disallows --bare with --origin' '
+
+	test_must_fail git clone -o foo --bare parent clone-bare-o 2>err &&
+	test_debug "cat err" &&
+	test_i18ngrep -e "--bare and --origin foo options are incompatible" err
+
+'
+
+test_expect_success 'disallows --bare with --separate-git-dir' '
+
+	test_must_fail git clone --bare --separate-git-dir dot-git-destiation parent clone-bare-sgd 2>err &&
+	test_debug "cat err" &&
+	test_i18ngrep -e "--bare and --separate-git-dir are incompatible" err
+
+'
+
+test_expect_success 'uses "origin" for default remote name' '
+
+	git clone parent clone-default-origin &&
+	git -C clone-default-origin rev-parse --verify refs/remotes/origin/master
+
+'
+
+test_expect_success 'prefers --template config over normal config' '
+
+	template="$TRASH_DIRECTORY/template-with-config" &&
+	mkdir "$template" &&
+	git config --file "$template/config" foo.bar from_template &&
+	test_config_global foo.bar from_global &&
+	git clone "--template=$template" parent clone-template-config &&
+	test "$(git -C clone-template-config config --local foo.bar)" = "from_template"
+
+'
+
+test_expect_success 'prefers -c config over --template config' '
+
+	template="$TRASH_DIRECTORY/template-with-ignored-config" &&
+	mkdir "$template" &&
+	git config --file "$template/config" foo.bar from_template &&
+	git clone "--template=$template" -c foo.bar=inline parent clone-template-inline-config &&
+	test "$(git -C clone-template-inline-config config --local foo.bar)" = "inline"
 
 '
 
-- 
gitgitgadget

