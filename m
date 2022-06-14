Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993B3CCA47A
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 15:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235828AbiFNPk7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 11:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbiFNPk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 11:40:58 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A72735DFA
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 08:40:57 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w17so4320347wrg.7
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 08:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iB0ff0vblDWWD+ozfdYai6PjSH3WFtBH4eR+pvvpHcQ=;
        b=Ca/7P0zGxgkZ3sfVgO6inWVSslXm5DAE5BQf9MIkXfeBMxy4NFlzUfS7ToyO041Xaq
         gF3zjTc0DZ7QBoILdZG6UABaovJSfJjdokssfiLW0zyyXdFCjqUBoZSGaaUAvLPLoE0V
         /+MHbCpyzeGFqxyArATFt5LNc9QyZFURm4vEs58srhroczt+TTNEiGDSKHO8dnYq229J
         3iweYS/AuwO97AvkFXNKH1FWzcSQ7VLaskDbkkV6A6RwvxitR3CjtcaUe9lDCYmsSYD1
         Ex7h7cO1HSwBQCAm6ao6h7Q3eBSJS0kGyyxBNgcV/K4yVMkmERZNTMBRGq0JOwM5m+eB
         Vqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iB0ff0vblDWWD+ozfdYai6PjSH3WFtBH4eR+pvvpHcQ=;
        b=dFSesWkCHCoRny4jrTHt7cXyJyL28zjFkk24FZCxF5jhQlSvIs3VrDpo7qagIqQHXp
         q4zO9WuuVsCt+Sg+zpcRThHE8uHz6jHECXG5Hp2dOCCHFN1xAE/SvKLS87cElj++a41X
         jB8NixzIXx4BDpplPRJnF2B38Y8XG9CACNSUY32R3aIhixHlF4CG7avVQWDvLvgKznFk
         X9RBw1PATSYjnjvrov+/u1UuHsQXjIPirinnCPfyJk+TmD5JenV9Y+G3XYz8nlpwUzNl
         7rGCbUQaMjXuquQGTtaxgWm3X06ogO63NXQmaDkD9qRfztAGZoGz55+HVvfJrl+HeFrs
         c5vQ==
X-Gm-Message-State: AJIora/tHUQT9hg96Z4AVCXsnX7ky+XGzbexEFMn00a1b2RJXvsSLO1T
        54SNIsF8SWdEonG7InAQU3HT4Tz5YrBNMQ==
X-Google-Smtp-Source: AGRyM1vIJkwfaJR/qANVUtFLHb6BXTzYeeujcP26lm5si4Lc+13NbCBbA5b+KBh4rAyEUtL/e8e5ww==
X-Received: by 2002:a05:6000:1a41:b0:20e:687f:1c3 with SMTP id t1-20020a0560001a4100b0020e687f01c3mr5475387wry.415.1655221255688;
        Tue, 14 Jun 2022 08:40:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l188-20020a1c25c5000000b0039c6390730bsm17833569wml.29.2022.06.14.08.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 08:40:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] add -i tests: mark "TODO" depending on GIT_TEST_ADD_I_USE_BUILTIN
Date:   Tue, 14 Jun 2022 17:40:07 +0200
Message-Id: <patch-v2-1.1-13c26e546f6-20220614T153746Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cf6aee9acadfb666de6b24b9ed63e1a65bfc009e.1655220242.git.git@grubix.eu>
References: <cf6aee9acadfb666de6b24b9ed63e1a65bfc009e.1655220242.git.git@grubix.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix an issue that existed before 0527ccb1b55 (add -i: default to the
built-in implementation, 2021-11-30), but which became the default
with that change, we should not be marking tests that are known to
pass as "TODO" tests.

When GIT_TEST_ADD_I_USE_BUILTIN=1 was made the default we started
passing the tests added in 0f0fba2cc87 (t3701: add a test for advanced
split-hunk editing, 2019-12-06) and 1bf01040f0c (add -p: demonstrate
failure when running 'edit' after a split, 2015-04-16).

Thus we've been emitting this sort of output:

	$ prove ./t3701-add-interactive.sh
	./t3701-add-interactive.sh .. ok
	All tests successful.

	Test Summary Report
	-------------------
	./t3701-add-interactive.sh (Wstat: 0 Tests: 70 Failed: 0)
	  TODO passed:   45, 47
	Files=1, Tests=70,  2 wallclock secs ( 0.03 usr  0.00 sys +  0.86 cusr  0.33 csys =  1.22 CPU)
	Result: PASS

Which isn't just cosmetic, but due to issues with
test_expect_failure (see [1]) we could e.g. be hiding something as bad
as a segfault in the new implementation. It makes sense catch that,
especially before we put out a release with the built-in "add -i", so
let's generalize the check we were already doing in 0527ccb1b55 with a
new "ADD_I_USE_BUILTIN" prerequisite.

1. https://lore.kernel.org/git/patch-1.7-4624abc2591-20220318T002951Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Tue, Jun 14 2022, Michael J Gruber wrote:

> 0527ccb1b5 ("add -i: default to the built-in implementation", 2021-11-30)
> switched to the implementation which fixed to subtest. Mark them as
> expect_success now.
>
> Signed-off-by: Michael J Gruber <git@grubix.eu>
> ---
> I did check the ML but may have missed a series which contains this. (I
> only found one which tries to make the test output clearer in CI.)

I was looking at the same earlier and came up with this (before seeing
your patch here), so a proposed v2 I suppose.

Just converting it to "test_expect_success" will break CI and other
setups that are testing with GIT_TEST_ADD_I_USE_BUILTIN=false.

The below fixes it, however.

 t/t2016-checkout-patch.sh  |  2 +-
 t/t3701-add-interactive.sh | 12 ++++++++++--
 t/test-lib.sh              |  4 ++++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
index bc3f69b4b1d..a5822e41af2 100755
--- a/t/t2016-checkout-patch.sh
+++ b/t/t2016-checkout-patch.sh
@@ -4,7 +4,7 @@ test_description='git checkout --patch'
 
 . ./lib-patch-mode.sh
 
-if ! test_bool_env GIT_TEST_ADD_I_USE_BUILTIN true && ! test_have_prereq PERL
+if ! test_have_prereq ADD_I_USE_BUILTIN && ! test_have_prereq PERL
 then
 	skip_all='skipping interactive add tests, PERL not set'
 	test_done
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 94537a6b40a..fc26cb8bae8 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -538,7 +538,15 @@ test_expect_success 'split hunk "add -p (edit)"' '
 	! grep "^+15" actual
 '
 
-test_expect_failure 'split hunk "add -p (no, yes, edit)"' '
+test_expect_success 'setup ADD_I_USE_BUILTIN check' '
+	result=success &&
+	if ! test_have_prereq ADD_I_USE_BUILTIN
+	then
+		result=failure
+	fi
+'
+
+test_expect_$result 'split hunk "add -p (no, yes, edit)"' '
 	test_write_lines 5 10 20 21 30 31 40 50 60 >test &&
 	git reset &&
 	# test sequence is s(plit), n(o), y(es), e(dit)
@@ -562,7 +570,7 @@ test_expect_success 'split hunk with incomplete line at end' '
 	test_must_fail git grep --cached before
 '
 
-test_expect_failure 'edit, adding lines to the first hunk' '
+test_expect_$result 'edit, adding lines to the first hunk' '
 	test_write_lines 10 11 20 30 40 50 51 60 >test &&
 	git reset &&
 	tr _ " " >patch <<-EOF &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 736c6447ecf..f5291ef56ef 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1759,6 +1759,10 @@ test_lazy_prereq SHA1 '
 	esac
 '
 
+test_lazy_prereq ADD_I_USE_BUILTIN '
+	test_bool_env GIT_TEST_ADD_I_USE_BUILTIN true
+'
+
 # Ensure that no test accidentally triggers a Git command
 # that runs the actual maintenance scheduler, affecting a user's
 # system permanently.
-- 
2.36.1.1239.gfba91521d90

