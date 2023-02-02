Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F09C636D4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjBBJdA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjBBJct (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:32:49 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710BA761F8
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:32:48 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so3249736wma.1
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6f+5TOhdJNpIQCXeYi/I2WdZRWIvNxUTzunIlw3WlI=;
        b=Xc/LHc8BMEBKF1U/jJzI8JP3w7eNSFJ7S5B83eYhYUSustuAYF++3wsCe/rVs2UOL3
         DqgJk6kl1aNISwgnyyX8UwSvM9OXwbEJQGFly5qfH3EEfEn3SXDSNscpb1keNyOyt6mb
         Pu2AuAXLSfLmAXTH1UIeaaH97idrp/c3C3fKOoEuEZ6sqNGyQ6IzfVQU76X21oRfqJ5f
         +Z4tpqGhJlPOT52erfw3lZ3cBZiZ9fKYHE09f36eD8VpC9FzGTq3KXM17h2FcKyykAdw
         zqopVuMigxpH7g+lkF7x6xcZG5BZc6Z6CCsFz6Qhncy74bkeRnblo7TkkRL+b7NkKARS
         rCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6f+5TOhdJNpIQCXeYi/I2WdZRWIvNxUTzunIlw3WlI=;
        b=fhshctdqMqE7OJWSwBcZDyMtco5CEMmSTgpilde+sO7d6ukiEuU49fHPbA2Io9g8bz
         ZWwKYIbxnVZ0lqVhEX2FjoSzCl+nqTXM6fmXuGsbLOYYSBOphkmAglEVB9G6AGDvdGcW
         hejQgUwVUon7/awJBwcM15JZWk8HjXaKE6GMW4unTbbgLAPcT6Fi3KDyKoxkApuRy8T6
         /Zej4ao2fkYTgUopS5tfDXekCNWjBGfeAwFV4ZEfBPwpMoZzSxu6wBAaSmguc/uudP5B
         noFqB+QlQIRg07Qdld7yy0DkNfcjRMW8JBIw3mts2pUA++XI2nDJoD2zDrby+O1tywof
         VUSQ==
X-Gm-Message-State: AO0yUKUzONZJkolV1U+DbpADVty2tlyNL/1NaqA/ToLXtSjgr1yziz0D
        6dKZV2sKyJ86+FlCQtTlAWnIdQ8eFCNH7kyt
X-Google-Smtp-Source: AK7set9JYTUsBJ6hWv3NVws7uZyU4l2IbG0kWqY6+FavugTDvg4Gq/MsgogU9uko+4tcY9VPXCM7WA==
X-Received: by 2002:a05:600c:2141:b0:3de:d52:2cd2 with SMTP id v1-20020a05600c214100b003de0d522cd2mr5292681wml.4.1675330367631;
        Thu, 02 Feb 2023 01:32:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c2cd300b003cf71b1f66csm4238753wmc.0.2023.02.02.01.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:32:46 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eli Schwartz <eschwartz93@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 8/9] archive tests: test for "gzip -cn" and "git archive gzip" stability
Date:   Thu,  2 Feb 2023 10:32:28 +0100
Message-Id: <patch-8.9-62c796da4e2-20230202T093212Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
References: <230131.86357rrtsg.gmgdl@evledraar.gmail.com> <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If our test suite is instrumented to run the first "test_cmp_bin" in
"test_done" it'll mostly pass, but fail on a few tests, such as
"t5319-multi-pack-index.sh". Those tests reveal edge cases where the
output of "gzip -cn" is different than that of "git archive gzip" for
the same input.

Let's extract a minimal version of the part of
"t5319-multi-pack-index.sh" which triggers it, and add a test for
archival stability.

Whatever we ultimately decide to promise when it comes to this
stability (see [1]) it'll be better to go into any behavior difference
knowing that's what we're about to do, rather than discover widespread
breakage due to already released Git versions.

The "GZIP_TRIVIALLY_STABLE" code here is added because on OSX even a
trivial *.tgz generated by the two methods will be different.

1. https://lore.kernel.org/git/a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5005-archive-stability.sh | 70 ++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100755 t/t5005-archive-stability.sh

diff --git a/t/t5005-archive-stability.sh b/t/t5005-archive-stability.sh
new file mode 100755
index 00000000000..c7532886920
--- /dev/null
+++ b/t/t5005-archive-stability.sh
@@ -0,0 +1,70 @@
+#!/bin/sh
+
+test_description='git archive stabilty'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+create_archive_file_with_config () {
+	local file="$1" &&
+	local config="$2" &&
+	shift 2 &&
+
+	test_when_finished "rm -rf \"$file\"" &&
+	git -c tar.tgz.command="$config" archive -o "$file" HEAD
+}
+
+setup_gzip_vs_git_archive_gzip () {
+	create_archive_file_with_config "expect.tgz" "gzip -cn" &&
+	create_archive_file_with_config "actual.tgz" "git archive gzip"
+}
+
+test_lazy_prereq GZIP_TRIVIALLY_STABLE '
+	git clone "$TRASH_DIRECTORY" . &&
+	test_commit P &&
+	setup_gzip_vs_git_archive_gzip &&
+	test_cmp_bin expect.tgz actual.tgz
+'
+
+if ! test_have_prereq GZIP_TRIVIALLY_STABLE
+then
+	skip_all='skipping gzip v.s. git archive gzip tests, even trivial content differs'
+	test_done
+fi
+
+# The first test_expect_success is after the "skip_all" so we'll get
+# the skip summary in prove(1) output.
+test_expect_success 'setup' '
+	test_commit A
+'
+
+test_expect_success GZIP '"gzip -cn" and v.s. "git archive gzip" produce the same output still' '
+	setup_gzip_vs_git_archive_gzip &&
+	test_cmp_bin expect.tgz actual.tgz
+'
+
+generate_objects () {
+	i=$1
+	iii=$(printf '%03i' $i)
+	{
+		echo $iii &&
+		test-tool genrandom "$iii" 8192
+	} >file_$iii &&
+	git update-index --add file_$iii
+}
+
+test_expect_success 'create objects with (stable) random data' '
+	test_commit initial &&
+	for i in $(test_seq 1 5)
+	do
+		generate_objects $i || return 1
+	done &&
+	git commit -m"add objects"
+'
+
+test_expect_success GZIP '"gzip -cn" and v.s. "git archive gzip" have differing output' '
+	setup_gzip_vs_git_archive_gzip &&
+	! test_cmp_bin expect.tgz actual.tgz
+'
+
+test_done
-- 
2.39.1.1392.g63e6d408230

