Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2035AC433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 21:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241758AbiBDVVD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 16:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241540AbiBDVU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 16:20:59 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067C5C061714
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 13:20:59 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id m14so13506831wrg.12
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 13:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ucLAbwHgzw6Kbb5NQJd0vhydTFqO/4PeoAl9dbORUSI=;
        b=J1526VrkMEme7c2zbPKM7aHNPzpLugqgUZKrIkVZ/1uctLm+vBGIgdqZhZyTjp/P20
         J21eV8mxQxsBnDdYle1Z/hBQo1y0sYZh/2PDV1LGGlj5vPaLXnbJqzyNso56YWr3bSqu
         j4dZqTqX7PzDezjtZMcbhjRGxkIQ/dg4qAFi/3qJ+SS7lTSKt04G7VoQJ1a9D6takQ49
         fTgiVg4SHHLq6Oz6GIGeU1wgUk25AW+tbaZv6l1c/Wq8qvdAwX8Zh/lQDx5UMSj+CJD2
         51umL/se1sztCrsB3EXQSfmBT4TpU9bKbC0y+OttWFXRT8KnUbuOJu8GGNklZltX0qFw
         5yvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ucLAbwHgzw6Kbb5NQJd0vhydTFqO/4PeoAl9dbORUSI=;
        b=pRzcNhWoNeK7bLuakK5iwLDz73suaJBmdX00RKUlEpb2ZM3SN8jWOlq1YArL7xEtan
         E8/LL0EdPzZfs0DQ3hmNxYVOHz+2ksE97cruirtgPGdxFC9k/KhLXHIW+O/0lhETxdY0
         RPa85Tnsbhfe0bSSWf/FqPt0X8qefQoHav+E6YjCieB+SZu99zpBV05r0eKg4b8qmPBt
         oRasTBnar7GQw7CJwrc0bdbpFp2RzxKwJXS9xNjSCmB1LlfZD/nLBhwltxRycNrgEcPj
         iMUHU/wH8XFGkdMB+kbQpWBKC8QSamdJ5YkqCzcw2hujZbCnrR5k61chq+yRpQ2jI8P4
         GD4Q==
X-Gm-Message-State: AOAM5310PNUdE661Pope1ZaLWqsDRzEP6VxfPWdbWkF3bFWcNihylR5p
        EVyjkIGk/CznoA+jH7qpEM8eM9k9wQBCww==
X-Google-Smtp-Source: ABdhPJy3oq01E5RlHBNDMcxXxiFywt+p5sFoZfTRxq9wi8+zl+qf3H5nVg1ULuvZQufhHz4kT5InzQ==
X-Received: by 2002:a5d:5481:: with SMTP id h1mr635170wrv.386.1644009657322;
        Fri, 04 Feb 2022 13:20:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o21sm2321598wmh.36.2022.02.04.13.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 13:20:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 3/9] grep tests: add missing "grep.patternType" config tests
Date:   Fri,  4 Feb 2022 22:20:45 +0100
Message-Id: <patch-v10-3.9-3464c76cfd7-20220204T211534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v10-0.9-00000000000-20220204T211534Z-avarab@gmail.com>
References: <cover-v9-0.9-00000000000-20220127T115058Z-avarab@gmail.com> <cover-v10-0.9-00000000000-20220204T211534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the grep tests to assert that setting
"grep.patternType=extended" followed by "grep.patternType=default"
will behave as if "--basic-regexp" was provided, and not as
"--extended-regexp". In a subsequent commit we'll need to treat
"grep.patternType=default" as a special-case, but let's make sure we
ignore it if it's being set to "default" following an earlier
non-"default" "grep.patternType" setting.

Let's also test what happens when we have a sequence of "extended"
followed by "default" and "fixed". In that case the "fixed" should
prevail, as well as tests to check that a "grep.extendedRegexp=true"
followed by a "grep.extendedRegexp=false" behaves as though
"grep.extendedRegexp" wasn't provided.

See [1] for the source of some of these tests, and their
initial (pseudocode) implementation, and [2] for a later discussion
about a breakage due to missing testing (which had been noted in [1]
all along).

1. https://lore.kernel.org/git/xmqqv8zf6j86.fsf@gitster.g/
2. https://lore.kernel.org/git/xmqqpmoczwtu.fsf@gitster.g/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7810-grep.sh | 96 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 424c31c3287..79884787da2 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -451,6 +451,93 @@ do
 		test_cmp expected actual
 	'
 
+	test_expect_success "grep $L with grep.extendedRegexp is last-one-wins" '
+		echo "${HC}ab:a+bc" >expected &&
+		git \
+			-c grep.extendedRegexp=true \
+			-c grep.patternType=basic \
+			-c grep.extendedRegexp=false \
+			grep "a+b*c" $H ab >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep $L with grep.extendedRegexp is last-one-wins & defers to grep.patternType" '
+		echo "${HC}ab:abc" >expected &&
+		git \
+			-c grep.extendedRegexp=true \
+			-c grep.patternType=extended \
+			-c grep.extendedRegexp=false \
+			grep "a+b*c" $H ab >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep $L with grep.extendedRegexp and grep.patternType are both last-one-wins independently (ERE)" '
+		echo "${HC}ab:abc" >expected &&
+		git \
+			-c grep.patternType=fixed \
+			-c grep.extendedRegexp=true \
+			-c grep.patternType=default \
+			grep "a+b*c" $H ab >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep $L with grep.extendedRegexp and grep.patternType are both last-one-wins independently (ERE)" '
+		echo "${HC}ab:abc" >expected &&
+		git \
+			-c grep.extendedRegexp=false \
+			-c grep.patternType=default \
+			-c grep.extendedRegexp=true \
+			grep "a+b*c" $H ab >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep $L with grep.extendedRegexp and grep.patternType are both last-one-wins independently (BRE)" '
+		echo "${HC}ab:a+bc" >expected &&
+		git \
+			-c grep.extendedRegexp=true \
+			-c grep.extendedRegexp=false \
+			grep "a+b*c" $H ab >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep $L with grep.extendedRegexp and grep.patternType are both last-one-wins independently (BRE)" '
+		echo "${HC}ab:abc" >expected &&
+		git \
+			-c grep.extendedRegexp=false \
+			-c grep.extendedRegexp=true \
+			-c grep.patternType=default \
+			grep "a+b*c" $H ab >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep $L with grep.extendedRegexp and grep.patternType are both last-one-wins independently (BRE)" '
+		echo "${HC}ab:a+bc" >expected &&
+		git \
+			-c grep.patternType=default \
+			-c grep.extendedRegexp=true \
+			-c grep.patternType=basic \
+			grep "a+b*c" $H ab >actual &&
+		test_cmp expected actual
+	'
+	test_expect_success "grep $L with grep.patternType=extended and grep.patternType=default" '
+		echo "${HC}ab:a+bc" >expected &&
+		git \
+			-c grep.patternType=extended \
+			-c grep.patternType=default \
+			grep "a+b*c" $H ab >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep $L with grep.patternType=[extended -> default -> fixed]" '
+		echo "${HC}ab:a+b*c" >expected &&
+		git \
+			-c grep.patternType=extended \
+			-c grep.patternType=default \
+			-c grep.patternType=fixed \
+			grep "a+b*c" $H ab >actual &&
+		test_cmp expected actual
+	'
+
 	test_expect_success "grep $L with grep.patternType=extended and grep.extendedRegexp=false" '
 		echo "${HC}ab:abc" >expected &&
 		git \
@@ -478,6 +565,15 @@ do
 		test_cmp expected actual
 	'
 
+	test_expect_success "grep $L with grep.extendedRegexp=false and grep.patternType=default" '
+		echo "${HC}ab:abc" >expected &&
+		git \
+			-c grep.extendedRegexp=false \
+			-c grep.patternType=extended \
+			grep "a+b*c" $H ab >actual &&
+		test_cmp expected actual
+	'
+
 	test_expect_success "grep $L with grep.extendedRegexp=true and grep.patternType=basic" '
 		echo "${HC}ab:a+bc" >expected &&
 		git \
-- 
2.35.1.940.ge7a5b4b05f2

