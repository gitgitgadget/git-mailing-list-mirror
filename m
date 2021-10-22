Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA571C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 10:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D176F61059
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 10:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhJVKel (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 06:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbhJVKek (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 06:34:40 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DC3C061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 03:32:22 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id y22-20020a1c7d16000000b003231ea3d705so2836775wmc.4
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 03:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Hxtx3/vWwLiDI/tg1/emTcupQbQEAa7LVuybXEKP+Q=;
        b=az7SqpryQi/h7aTguAvTSeVhTCH90+urf2Hlh07auxMl8eK/0s01UOdo1UqjhhlAVS
         kDorabU3Mmc/p+3a6EtaLBDPp/ZjL6YA3oPVSlL3HrmKcVdhWa975KpPxEmrQ0Mh1ZNV
         lTxldmlWrHEh0uyxgRuQ2PBR0gYB218yVKSh5YRJhQjZQ/WW7yHxBe5D62B3jkCh7yCc
         cKBRerdFBBPvQMxFgr+5HDbeM7mQroPa860xmZLdYfODI2dn4O3yHISgL8Ac27MDbD+9
         JkXUtoI6Meldu/jm9G0n28pb0R52ttSZ4MbTjfGqagWTER7QCpeU4P7PDkL9mxghOHbI
         z/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Hxtx3/vWwLiDI/tg1/emTcupQbQEAa7LVuybXEKP+Q=;
        b=aaPU55ObYXj1enUKxfRXmDthq9opXGMfTq8qOj5PEvQ+5/EbF/BnxkkxfjoWsx/bNs
         mWDVq1DymoFItASmOrmKibqeoUzI4kmhlwcBMnqwYQs3mLf7FIDJGW4GRqC8XL24eKrt
         ZO6veSLqkV7MI7I2glCtncL6RSH0d8pNOT63Tp2bvYwB3gfcTdri/eJHd0NCTOlA2xp1
         ElcwD0hIXhKYypJ+9lITIA6i7hzPgi6FHJxjuRNDL5pAyuVQpi3B9ll/TlRNXoVuFFXq
         i1boo+XFZqcs2dt/Jl/QQFElrlVrOGQQSIrbjAanJZuV7ow03VdCaVYkdvd76Z4o+J6v
         imvQ==
X-Gm-Message-State: AOAM5332Sh61QrSZDZ19MIus2aiz0eIgb1RWcP/Ff0Tq80zDCEABq/qu
        2vxhyg9RwnEn44orJjuXxbzCibDPrpgfMw==
X-Google-Smtp-Source: ABdhPJwnymruYb129tczfc3BOn89y+XGa7eQMLtt2fGTuEu+Pu4OUipIg7J2IorhKwv4Vy3tvTndrw==
X-Received: by 2002:a7b:c30c:: with SMTP id k12mr27997005wmj.38.1634898740952;
        Fri, 22 Oct 2021 03:32:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y8sm7081747wmi.43.2021.10.22.03.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 03:32:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] leak tests: add an interface to the LSAN_OPTIONS "suppressions"
Date:   Fri, 22 Oct 2021 12:32:17 +0200
Message-Id: <patch-1.1-9190f3c128f-20211022T102725Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
In-Reply-To: <211022.86sfwtl6uj.gmgdl@evledraar.gmail.com>
References: <211022.86sfwtl6uj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the SANITIZE=leak testing mode added in 956d2e4639b (tests: add
a test mode for SANITIZE=leak, run it in CI, 2021-09-23) to optionally
be able to add a "suppressions" file to the $LSAN_OPTIONS.

This allows for marking tests as passing with
"TEST_PASSES_SANITIZE_LEAK=true" when they still have failure due more
general widespread memory leaks, such as from the "git log" family of
commands. We can now mark the "git -C" tests as passing.

For getting specific tests to pass this is preferable to using
UNLEAK() in these codepaths, as I'll have fixes for those leaks soon,
and being able to atomically mark relevant tests as passing with
"TEST_PASSES_SANITIZE_LEAK=true" helps to explain those changes. See
[1] for more details.

1. https://lore.kernel.org/git/211022.86sfwtl6uj.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Fri, Oct 22 2021, Ævar Arnfjörð Bjarmason wrote:

> On Fri, Oct 22 2021, Taylor Blau wrote:
>
>> On Thu, Oct 21, 2021 at 01:50:55PM +0200, Ævar Arnfjörð Bjarmason wrote:
>>>
>>> On Wed, Oct 20 2021, Taylor Blau wrote:
[...]
> If you want to pick that approach up and run with it I think it would
> probably make sense to factor that suggested test_expect_success out
> into a function in test-lib-functions.sh or whatever, and call it as
> e.g.:
>     
>     TEST_PASSES_SANITIZE_LEAK=true
>      . ./test-lib.sh
>     declare_known_leaks <<-\EOF
>     add_rev_cmdline
>     [...]
>     EOF
>
> Then pipe it through sed 's/^/leak:/' and have it set LSAN_OPTIONS for
> you.
>
> Doing it that way would be less boilerplate for each test that wants it,
> and is also more likely to work with other non-LSAN leak appoaches,
> i.e. as long as something can take a list of lines matching stack traces
> we can feed that to that leak checker's idea of a whitelist.

I just went ahead and hacked that up. If you're OK with that approach
it would really help reduce the work for leak changes I've got
planned, and as noted gives you the end-state of a passing 5319.

I don't know if it makes more sense for you to base on top of this
if/when Junio picks it up, or to integrate it into your series
etc. Maybe Junio will chime in ...

 t/t0056-git-C.sh        |  4 ++++
 t/test-lib-functions.sh | 42 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/t/t0056-git-C.sh b/t/t0056-git-C.sh
index 2630e756dab..490aefa81a1 100755
--- a/t/t0056-git-C.sh
+++ b/t/t0056-git-C.sh
@@ -2,7 +2,11 @@
 
 test_description='"-C <path>" option and its effects on other path-related options'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
+todo_leaks <<-\EOF
+^cmd_log_init_finish$
+EOF
 
 test_expect_success '"git -C <path>" runs git from the directory <path>' '
 	test_create_repo dir1 &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index eef2262a360..d89bf5da7dc 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -243,6 +243,48 @@ debug () {
 	done
 }
 
+# Declare known "general" memory leaks, for use with TEST_PASSES_SANITIZE_LEAK=true.
+#
+# Matches lines in a stack trace that leaks. Intended for
+# LSAN_OPTIONS, but the format is intended to be easy to use with
+# other leak checkers, so the "leak:" prefix is omitted (and added for
+# you).
+#
+# Use it immediately after sourcing test-lib.sh (or equivalent), and
+# after a "TEST_PASSES_SANITIZE_LEAK=true" has been set. E.g:
+#
+#    TEST_PASSES_SANITIZE_LEAK=true
+#    . ./test-lib.sh
+#    todo_leaks <<-\EOF
+#    ^cmd_log_init_finish$
+#    EOF
+#
+# The "^" and "$" anchors don't suggest full regex syntax support,
+# that's the only anchoring (or other metacharacter) understood by
+# LSAN_OPTIONS,.
+#
+# See
+# https://github.com/google/sanitizers/wiki/AddressSanitizerLeakSanitizer#suppressions
+# for the relevant LSAN_OPTIONS documentation.
+todo_leaks () {
+	if ! test_have_prereq SANITIZE_LEAK
+	then
+		return 0
+	fi
+
+	# Try not to interfere with any test logic
+	suppressions=.lsan-suppressions.txt
+	if test -d .git
+	then
+		suppressions=".git/$suppressions"
+	fi
+	suppressions="$PWD/$suppressions"
+
+	sed 's/^/leak:/' >"$suppressions" &&
+	LSAN_OPTIONS="$LSAN_OPTIONS:suppressions=\"$suppressions\"" &&
+	export LSAN_OPTIONS
+}
+
 # Usage: test_commit [options] <message> [<file> [<contents> [<tag>]]]
 #   -C <dir>:
 #	Run all git commands in directory <dir>
-- 
2.33.1.1494.g88b39a443e1

