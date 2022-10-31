Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FF9FA3741
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 22:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiJaW2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 18:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJaW2o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 18:28:44 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EA21094
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 15:28:43 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y14so32960402ejd.9
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 15:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRZbMWIeG0ZQd7cP5Bk/J3hFHudDvHnhwDyVqoFTsnc=;
        b=qKMOLnQOYi/l3Zo12RBQKsaZWdgiyQgdPjpsXUt5eNee53u9OUm7NW4+G+xEOJZVPa
         eiWIQN3GYqUj2EankUKE2o+YSfGjU5QGyR1r8ogMxVY914bzJfvAW3iwwX3AapB2meR+
         o57p0BBlONvpnCgLPDrfusd9cmYWRQtQXO4zqugry/sozvkI7sLCY/ulTL9Z9A4QW0OI
         LGPgTdFrlIlAaiHKRuw5CFBjw0ZpFeqmk6zxctrpeTvwJH/Gwd/JHWD5DYSyrWnPYlMB
         w5epb3HMIg+bWYPeuQByQsTXTZnknvKUQ9hq4ckQJtlghtTa888r1SfW674tCbLMl+Ec
         0BvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRZbMWIeG0ZQd7cP5Bk/J3hFHudDvHnhwDyVqoFTsnc=;
        b=1oQz4Lqf6VlU3Zj8O2rIK3DCdO2Gl+QLbWgeOMt++KSQvhlTapJFc79QPKrEeqtlVe
         5J5Ebnh7/BRirYHDbZ45ho9Ja4xtI+a/rEykDpTjr8aYYjAnJHtclc8Z5+Cw3F1uSHKg
         sya82DgHLjp0qVzwbHsgpICX6xOAJte2lN9eBBP2Xkd2ZUmpCXpK8Zzkgxawe1sELapp
         qJsY9lwNeZGsuzwz+C0V6KRYwaxCjNVYsGG9tU7zUQZibGCIQkLLBjOdAbVbvSnnjp94
         n0aoFwZSYTGVkdYJoXKy/vQliiqA2/5ObN9Wbfrwh5+dXSGrl/zFekoNSFOCTRRjX3Kz
         hv+A==
X-Gm-Message-State: ACrzQf3UDWhI1E/xa/+jnAidd+o5yB7mHRrJK07DdrYJiyN7jHR05WSz
        xhQok/obgJTYIKdm1Jv26eoxSJw84iKrGg==
X-Google-Smtp-Source: AMsMyM7bSQn3Fvfdz53Sdu84Pz8i0ywDsBf7be4MZqLVdX5aWyqwePssxG5T5KBMnB54LEQbXU31uw==
X-Received: by 2002:a17:906:a4a:b0:782:686d:a1b6 with SMTP id x10-20020a1709060a4a00b00782686da1b6mr15260715ejf.232.1667255321605;
        Mon, 31 Oct 2022 15:28:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a14-20020a1709066d4e00b00781e7d364ebsm3503668ejt.144.2022.10.31.15.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 15:28:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/4] Makefile: simplify $(test_bindir_programs) rule by splitting it up
Date:   Mon, 31 Oct 2022 23:28:09 +0100
Message-Id: <patch-v3-4.4-0ff09495476-20221031T222249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v3-0.4-00000000000-20221031T222249Z-avarab@gmail.com>
References: <cover-v2-0.3-00000000000-20221026T143533Z-avarab@gmail.com> <cover-v3-0.4-00000000000-20221031T222249Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the @@PROG@@ substitution was added in [1] it was a simple matter
of doing a:

	's|@@PROG@@|$(@F)|'

Then when t/helpers were added in [2] followed by the ".exe" needing
to be appended in [3] this previously simple rule ended up as a dense
one-liner.

It has been pointed out that this is hard to read[4], but the problem
isn't the "design of the Makefile syntax". It's we now have to
after-the-fact determine if we were dealing with a bin-wrapper/ that
needed to have $(X) appended, a t/helper/, or a non-binary (currently
only git-cvsserver).

That would be a problem in any language. We're starting out with three
lists, and then end up having to heuristically determine given a
member of any of those lists which list that member came from. Let's
just stop doing that and keep track of what member belongs to which
list.

We can do this by splitting up the single "bin-wrappers/%" rule into a
rule for each of the three lists. With the
"cmd_munge_script_sed_shell_path_arg" define added in a preceding
commit this is easy, we just need to add a sister template to the
existing "cmd_munge_script" added in [5].

The "filter-out" added in [6] has now become unnecessary per the
above, it was an artifact of us losing track of what was in which of
our lists to begin with.

This change can be tested with e.g.:

	git checkout master &&
	make SHELL_PATH=/bin/bash X=.exe &&
	mv bin-wrappers bin-wrappers.master &&
	<apply this change> &&
	make SHELL_PATH=/bin/bash X=.exe &&
	diff -ru bin-wrappers{.master,}

Which will show an empty diff, i.e. we've correctly dealt with the
combination of $(SHELL_PATH), $(X) and these three variables here.

This also fixes an issue with the "bin-wrappers/" scripts have never
had properly declared dependency information, i.e. this has never
worked:

	make clean &&
	make bin-wrappers/git &&
	# the script is there, but no "./git" is built
	./bin-wrappers/git

There was no reason not to have that work, just as most things
generated by the Makefile have proper dependency information.

Before this commit doing this would have been painful, but now it's
easy to pass this as a parameter to our "bin_wrappers_template"

1. ea925196f1b (build dashless "bin-wrappers" directory similar to
   installed bindir, 2009-12-02)
2. e6e7530d10b (test helpers: move test-* to t/helper/ subdirectory,
   2016-04-13)
3. 3a94cb31d52 (bin-wrappers: append `.exe` to target paths if
   necessary, 2019-07-29)
4. https://lore.kernel.org/git/sso99so6-n28s-rq86-8q20-4456r3pn869r@tzk.qr/
5. 46bac904581 (Do not install shell libraries executable, 2010-01-31)
6. 7b5c93c6c68" (scalar: include in standard Git build & installation,
   2022-09-02)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 032654640c5..d7ab68e3db8 100644
--- a/Makefile
+++ b/Makefile
@@ -3067,16 +3067,42 @@ GIT-PYTHON-VARS: FORCE
             fi
 endif
 
-BIN_WRAPPERS = $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
+define cmd_munge_bin_wrappers_script
+sed \
+	-e $(call cmd_munge_script_sed_shell_path_arg) \
+	-e 's|@@BUILD_DIR@@|$(shell pwd)|' \
+	-e 's|@@PROG@@|$(2)$(1)$(3)|' \
+	<$< >$@ && \
+	chmod +x $@
+endef
 
-all:: $(BIN_WRAPPERS)
+define bin_wrappers_template
+
+### bin_wrappers_template; Parameters:
+## E.g. "BINDIR_PROGRAMS_NEED_X": Variable reference
+# 1='$(1)'
+## E.g. "$(@F)": Passed as $$(1)) to "cmd_munge_bin_wrappers_script"
+# 2='$(2)'
+## E.g. "" or "t/helper": Directory prefix for the wrapped binary
+# 3='$(3)'
+## E.g. "" or "$$X": If $$X: wrapped binary needs X=.exe (for Windows)
+# 4='$(4)'
+BW_$(1) = $$($(1):%=bin-wrappers/%)
+BIN_WRAPPERS += $$(BW_$(1))
+$$(BW_$(1)): bin-wrappers/% : $(3)%$(4)
+$$(BW_$(1)): wrap-for-bin.sh
+	$$(call mkdir_p_parent_template)
+	$$(QUIET_GEN)$$(call cmd_munge_bin_wrappers_script,$(2),$(3),$(4))
+endef
 
-bin-wrappers/%: wrap-for-bin.sh
-	$(call mkdir_p_parent_template)
-	$(QUIET_GEN)sed -e $(call cmd_munge_script_sed_shell_path_arg) \
-	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
-	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%,$(@F))$(if $(filter-out $(BINDIR_PROGRAMS_NO_X),$(@F)),$(X),)|' < $< > $@ && \
-	chmod +x $@
+define bin_wrappers_templates
+$(call bin_wrappers_template,BINDIR_PROGRAMS_NEED_X,'$$(@F)',,$$X)
+$(call bin_wrappers_template,BINDIR_PROGRAMS_NO_X,'$$(@F)')
+$(call bin_wrappers_template,TEST_PROGRAMS_NEED_X,'$$(@F)',t/helper/,$$X)
+endef
+$(eval $(call bin_wrappers_templates))
+
+all:: $(BIN_WRAPPERS)
 
 # GNU make supports exporting all variables by "export" without parameters.
 # However, the environment gets quite big, and some programs have problems
-- 
2.38.0.1280.g8136eb6fab2

