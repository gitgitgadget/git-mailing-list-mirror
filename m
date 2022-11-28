Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52980C43217
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 12:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiK1MA7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 07:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiK1MAW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 07:00:22 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332F0186D3
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 04:00:21 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id gu23so6952040ejb.10
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 04:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SS1zoQQ1VoLCB7sz/rlf3lK6RRHrcxwTkGe21CzW6dg=;
        b=W2vl3xNLraPj5vJZ7JY7G2bKBJj0atJn/UTGTAmy0JvIE5HQU1nZ/pyNqb0JLFPi5h
         gzH66Gd4EdZ2uJefLzVYrBhIUwT9g02ufWexodAhQd54xOiabaaMXObhie/4pNU37RU5
         vL2HFq1Au4IU7mhc0Wqn5rT4iMYLmUE6dZaz13X8OV60YmlRDM8Tkmxf7Q2mZKqRuv5t
         ZnfxSPEtlmhKIPKSe6ZVGEOTb48pICqwRmrczJUSYqfPIvheAv18gQdEhQ33E/KsUcG0
         H0SXo6aCiTqFZRNhaEWnCq1ZDP0zHNatV//jmQUcqku5zanVyGadOOJu/9+NkWE7nQq1
         +/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SS1zoQQ1VoLCB7sz/rlf3lK6RRHrcxwTkGe21CzW6dg=;
        b=7FFM1Rp5HdsqGM/Kk6bBLEK+zIGlzizM2g/PZUULTT0zc+rcKVmbZ1pAi+J78vmTdc
         zkiihoIiUplgg390a/BcGDx1AXvDszLsEufhQDJXlGm2NbcwEnm6w8EasVM5QUvGtk6y
         7bUTROospzb+YWI4KAVxKzjT9zJxF203jTahFcW5dYcQeFiQIYwhemdQFW/87Zh+E3yq
         adAm8+S1hISnVKvHEHvA9zCYsXFEh4c5IHA7HV9Bu0l6E30Qcl7TCwSy2H9OtzDbSLW/
         OAXBsdWxpdWARhesKc7BOeMwMN6KyvK9jVLI52vKslGOT8RmwJ4/xbxG6xKFnfvH7alZ
         GE1A==
X-Gm-Message-State: ANoB5pkC+qmefJKZaF0ci2y1z6NCixDTQpjN3Cwr0t3aRzU+eJuVt1rD
        7mSnIkePYjtXILjDZYqVe2X47eypbfw=
X-Google-Smtp-Source: AA0mqf7Qoeg88HA3TmvI/FpWdP8R48eNaKFBFw438q7mT8o6z8gCcdhJbP4weR0BfAX5ocz9wxXSgg==
X-Received: by 2002:a17:906:6d8e:b0:7ad:a2e9:a48c with SMTP id h14-20020a1709066d8e00b007ada2e9a48cmr31481709ejt.77.1669636819254;
        Mon, 28 Nov 2022 04:00:19 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d14-20020a17090694ce00b007aed2057eacsm4833209ejy.221.2022.11.28.04.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 04:00:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] t5314: check exit code of "rev-parse"
Date:   Mon, 28 Nov 2022 13:00:16 +0100
Message-Id: <patch-1.1-45b240740eb-20221128T115740Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc0.962.g4ca4168c9ac
In-Reply-To: <221128.868rjvmi3l.gmgdl@evledraar.gmail.com>
References: <221128.868rjvmi3l.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the test added in [1] to check the exit code of the "rev-parse"
invocations. An in-flight change[2] introduced a memory leak in these
invocations, which went undetected unless we were running under
"GIT_TEST_SANITIZE_LEAK_LOG=true".

Note that the in-flight change made 8 test files fail, but as far as I
can tell only this one would have had its exit code hidden unless
under "GIT_TEST_SANITIZE_LEAK_LOG=true". The rest would be caught
without it.

1. 4cf2143e029 (pack-objects: break delta cycles before delta-search
   phase, 2016-08-11)
2. https://lore.kernel.org/git/221128.868rjvmi3l.gmgdl@evledraar.gmail.com/
3. faececa53f9 (test-lib: have the "check" mode for SANITIZE=leak
   consider leak logs, 2022-07-28)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Aside from rs/multi-filter-args, we should be checking the return code
of "git" in these cases.

 t/t5314-pack-cycle-detection.sh | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/t/t5314-pack-cycle-detection.sh b/t/t5314-pack-cycle-detection.sh
index 73a241743aa..169d8198641 100755
--- a/t/t5314-pack-cycle-detection.sh
+++ b/t/t5314-pack-cycle-detection.sh
@@ -63,13 +63,16 @@ TEST_PASSES_SANITIZE_LEAK=true
 # Note that the two variants of "file" must be similar enough to convince git
 # to create the delta.
 make_pack () {
-	{
-		printf '%s\n' "-$(git rev-parse $2)"
-		printf '%s dummy\n' "$(git rev-parse $1:dummy)"
-		printf '%s file\n' "$(git rev-parse $1:file)"
-	} |
-	git pack-objects --stdout |
-	git index-pack --stdin --fix-thin
+	grp1=$(git rev-parse "$2") &&
+	grp2=$(git rev-parse "$1:dummy") &&
+	grp3=$(git rev-parse "$1:file") &&
+	cat >list <<-EOF
+	-$grp1
+	$grp2 dummy
+	$grp3 file
+	EOF
+	git pack-objects --stdout <list >pack &&
+	git index-pack --stdin --fix-thin <pack
 }
 
 test_expect_success 'setup' '
-- 
2.39.0.rc0.962.g4ca4168c9ac

