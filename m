Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8FDC433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 00:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244718AbiBPABc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 19:01:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244755AbiBPAB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 19:01:26 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AD8CFBA0
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 16:01:12 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id k1so645709wrd.8
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 16:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TrDxp8qHkaqfK7C2PNtaI7xXlyWJoAraWPO1wiZrG1E=;
        b=VWIWIhh9tTTI5padUxwpwJkKhcsSxyPMSOQpq4hnS5RwXpfdoq/709pIa+AfXOBpQQ
         QRutttWUYqiQAMtc2jg/AC7dY8ESUzjiX/VHyetQ53zEudqXKHVCkTzw9odK3UJECiQu
         Wq1AuK75e7LJdQt4nOBGoqOXivlTa/dlU6AVn0vBHOMF8Cb+daroiCc3z1I4jzeLSl5y
         qAFyPnEjncA5XE31T356um/35++FsE2GGk8aJFtH6rqbQc9fbq7rtIWBunZWLIGTW0us
         I9Ql9C4JHKF03X3v+5RkmcySiuE8efJS/TAObHLyRnT30gx+GWZ1Y1Q+s4fSGUpaGTUs
         ERzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TrDxp8qHkaqfK7C2PNtaI7xXlyWJoAraWPO1wiZrG1E=;
        b=SEYRGNOtDVJLsN0hcLGdiDWP/QdanXPws4IRMahBiA/CLDOpBW6ZApa/6r4WqOXt+h
         MUvBU9wlAEA1BEIeqfFfNIbInNToSoaW4k7TAFuRWZShEFG0gKNUdQsR8xS3dEpuQHAW
         RVFXl2beR72/SrEO9UEy9iLuygrEYHj+7a4uep/plDeRe5YqbQlQyIVPVikLULUyAF8h
         pPim7WAzGjYJiXvtzsT04zSLVSbM4QMbxXI8LWtIQLbNWN4pgiuj5QfnBqdvurHItpWy
         l8Whub+6phNMwnvCElVS6MnxzgcFzmzCvw01VoNmIcNQEO9/FgTwuXYRUg85wRvZHNZP
         0ZZg==
X-Gm-Message-State: AOAM530ABamSp774dL5yZRj3dsm+5x+AM5BUDGmezcqUJ4HZaE/EkwlP
        XdxRilwTayvRLKIgD/vUYLilHuVTSNHakw==
X-Google-Smtp-Source: ABdhPJzwVMV8wobZRI8Tz7WANWYeeIEG7ecTGpoxtX2EGYPf+URjDnX1g4tyGrJoNBS7kWvj18FDKw==
X-Received: by 2002:a05:6000:3cd:b0:1e5:95c3:35b5 with SMTP id b13-20020a05600003cd00b001e595c335b5mr318776wrg.14.1644969670326;
        Tue, 15 Feb 2022 16:01:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a12sm17260542wru.99.2022.02.15.16.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 16:01:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v11 04/10] grep tests: add missing "grep.patternType" config tests
Date:   Wed, 16 Feb 2022 01:00:33 +0100
Message-Id: <patch-v11-04.10-9906edd4f58-20220216T000006Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1028.g9479bb34b83
In-Reply-To: <cover-v11-00.10-00000000000-20220216T000006Z-avarab@gmail.com>
References: <cover-v10-0.9-00000000000-20220204T211534Z-avarab@gmail.com> <cover-v11-00.10-00000000000-20220216T000006Z-avarab@gmail.com>
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
 t/t7810-grep.sh | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 6f1103b54b9..69356011713 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -461,6 +461,58 @@ do
 		-c grep.extendedRegexp=true \
 		-c grep.patternType=basic
 
+	# grep.extendedRegexp is last-one-wins
+	test_pattern_type "$H" "$HC" "$L" BRE \
+		-c grep.extendedRegexp=true \
+		-c grep.extendedRegexp=false
+
+	# grep.patternType=basic pays no attention to grep.extendedRegexp
+	test_pattern_type "$H" "$HC" "$L" BRE \
+		-c grep.extendedRegexp=true \
+		-c grep.patternType=basic \
+		-c grep.extendedRegexp=false
+
+	# grep.patternType=extended pays no attention to grep.extendedRegexp
+	test_pattern_type "$H" "$HC" "$L" ERE \
+		-c grep.extendedRegexp=true \
+		-c grep.patternType=extended \
+		-c grep.extendedRegexp=false
+
+	# grep.extendedRegexp is used with a last-one-wins grep.patternType=default
+	test_pattern_type "$H" "$HC" "$L" ERE \
+		-c grep.patternType=fixed \
+		-c grep.extendedRegexp=true \
+		-c grep.patternType=default
+
+	# grep.extendedRegexp is used with earlier grep.patternType=default
+	test_pattern_type "$H" "$HC" "$L" ERE \
+		-c grep.extendedRegexp=false \
+		-c grep.patternType=default \
+		-c grep.extendedRegexp=true
+
+	# grep.extendedRegexp is used with a last-one-loses grep.patternType=default
+	test_pattern_type "$H" "$HC" "$L" ERE \
+		-c grep.extendedRegexp=false \
+		-c grep.extendedRegexp=true \
+		-c grep.patternType=default
+
+	# grep.extendedRegexp and grep.patternType are both last-one-wins independently
+	test_pattern_type "$H" "$HC" "$L" BRE \
+		-c grep.patternType=default \
+		-c grep.extendedRegexp=true \
+		-c grep.patternType=basic
+
+	# grep.patternType=extended and grep.patternType=default
+	test_pattern_type "$H" "$HC" "$L" BRE \
+		-c grep.patternType=extended \
+		-c grep.patternType=default
+
+	# grep.patternType=[extended -> default -> fixed] (BRE)" '
+	test_pattern_type "$H" "$HC" "$L" FIX \
+		-c grep.patternType=extended \
+		-c grep.patternType=default \
+		-c grep.patternType=fixed
+
 	test_expect_success "grep --count $L" '
 		echo ${HC}ab:3 >expected &&
 		git grep --count -e b $H -- ab >actual &&
-- 
2.35.1.1028.g9479bb34b83

