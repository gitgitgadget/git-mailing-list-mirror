Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2238C433EF
	for <git@archiver.kernel.org>; Sun, 26 Dec 2021 22:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbhLZWhc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Dec 2021 17:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbhLZWh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Dec 2021 17:37:29 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749B8C06173E
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 14:37:29 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r17so29079293wrc.3
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 14:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g7rwrh2AYMbxdldVBZrU/QwvUAzHCsNu10rJowXIqP8=;
        b=N4mCcqqYqwz26RGOW3J78w0yJpb4/7dqlDa7YhFb5/HiwnZviL6mPaCIlNOd8ucCqt
         LV8yof4DzwKdfxk6IynIRVBd2PyAb3GyT1D5Rq9jPw2ARJ+Brvw5FdIrYBUpu412H8Om
         loL1SraLaBt9Y5gGfnfs4B5MSfBZHzbApyeKTl6d5qs6Za0idgIo4wOBMNK8kEsY4DG+
         MvMUGHQq3m7lFK71Au4ru9etfVhOWjMV7Q4PSSz8BN+AAi5aDUlIdbUl0MGsBPZzAJsq
         JcPz9TlU33OGpDCXeh/Vd27ezPtEMfAs1Yqr7i3tOvkVeIsXrAaeEW33HkNZR8fB6ACm
         XwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g7rwrh2AYMbxdldVBZrU/QwvUAzHCsNu10rJowXIqP8=;
        b=UMcqRj6kodI7wjSpswkAnO9/Bjoku5+GcnvB9TiLYflKPGd2T6yb1KWE0qgXcx7pA0
         VmpeDqC0A5WnF6cQF2x78EQ8N97R03WB4dyE5OWnYckqKiFy+ASZAxc9sf81yvpc++X+
         rdmFCsFFpBm2WMRkh8sms/+2sswuZy3yn3wWebZNQgBU6r0dfgnFmCsJuqq8mhl7EhCe
         rnmFUxVI865gmEAPEpnE68uEZL4F/tQyjHbT/xOsP0usb9AQoefK5W0apNNkxL4+c40j
         mwfPNyVeenOMHwoW8eoSRCNp7qZb8Z5k+ygAofDzyAhFAXIchYp037E83QPEhFw/mmbN
         BIUg==
X-Gm-Message-State: AOAM531XgBW/kag4On6nxWMuHSUrIxlQIbPeCDmAGBec3SSJBw5fYYsw
        eXrZx+pmzVGRcauNtHpBIX48RYx2j8/g8x44
X-Google-Smtp-Source: ABdhPJzh5TUNnSjIHy91kNwngdsE83wF9J1HXFbF8CAL3nlzoiErW7Lw2T2LULxts/g7kwNWm7N8cw==
X-Received: by 2002:a5d:648b:: with SMTP id o11mr8233074wri.227.1640558247672;
        Sun, 26 Dec 2021 14:37:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay29sm16289861wmb.13.2021.12.26.14.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 14:37:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 3/7] grep tests: add missing "grep.patternType" config tests
Date:   Sun, 26 Dec 2021 23:37:15 +0100
Message-Id: <patch-v6-3.7-1b724d5e2e9-20211226T223035Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1239.g84ae229c870
In-Reply-To: <cover-v6-0.7-00000000000-20211226T223035Z-avarab@gmail.com>
References: <cover-v5-0.7-00000000000-20211222T025214Z-avarab@gmail.com> <cover-v6-0.7-00000000000-20211226T223035Z-avarab@gmail.com>
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

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7810-grep.sh | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 6b6423a07c3..664f884e12a 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -451,6 +451,45 @@ do
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
-- 
2.34.1.1239.g84ae229c870

