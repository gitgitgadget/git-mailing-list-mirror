Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40B1C433EF
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 14:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbiGEOCH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 10:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbiGEOBu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 10:01:50 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175442180B
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 06:47:12 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id o4so17662377wrh.3
        for <git@vger.kernel.org>; Tue, 05 Jul 2022 06:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7FffJUF6J2N32KwXlkbypj2DPHBEKwgK5LxJU10hDjA=;
        b=BQabdMaVC9JhKJdH1O1orQtn2NBHbWDnu3hnmZJp2+5h3fa56UIFYQJMtFG6L3uxqW
         wrmgdiBgMH29vC6XOouypR8BSbfw0yAPnVL3A2lGIOswZVg+O/zEVD1ptkMvmR6yCe+0
         X63G7lRIlpEQ0Yp8WA2YqbhRFpOAuXxpukkEYwXOytRjyJX6C++SJPAsr6URlLOxkSQ8
         oB4Y6GT/ETV7oqo2gSAHrT1cZArd1QRPNG1xXMX2oVZElGXZBdgWziZ3OAEUoUnwW4E0
         ir/rnNurBp3Oss2g3O72PiS1qCk9bRqAUbXkbZOoWq/6vE8PAm0270I2GIu8gJqiWRwt
         2t8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7FffJUF6J2N32KwXlkbypj2DPHBEKwgK5LxJU10hDjA=;
        b=N8YhE730CmQGxGP4MQ4oqPu5j1lo/P3n7Wqa4igj9hr9XbCYVMPx0j+GxhHrx7w1su
         9IVmUn/xsRpgmynCk3WNhlmRs/Oe/1CwM38bszQCM5ZPRiLlcpQlxELVp7c+dTWKkT9C
         sR/z0K1ThYDDc7EbjBA4U5YiA3udb0tH2KrIdC8LdVSqURDpTKTkt5sgUSsPuE/Rrya/
         TYS2ZZ1Tds5wvEEi/WKNDcQ1fKZe9QEmUh5hm+Co8cet4B6PeQ7Br6KGv8jQ6RZBZ6h/
         JLsCPxAxofXCrdZRA1AGdKmz3w8b/E7Wbf0iRQLoym/pPVKGt5JbyUwVm5aVAFziH56s
         PyHQ==
X-Gm-Message-State: AJIora9ZQddPtWIhTigAQg1pxmIkD6jElfyVBw9v5sl9fs+V1HTMQ2Xt
        l8gKxJ4EWOImq8IztfeP5wW9it82BN87ug==
X-Google-Smtp-Source: AGRyM1siLeZaj+oX0hDfC7BTsDg8g74PvL03fbYoatuKzd7SkcLnZZkzLj2RFI/SPqq4h4rUXw/Zcw==
X-Received: by 2002:a5d:4602:0:b0:21d:6784:cdcb with SMTP id t2-20020a5d4602000000b0021d6784cdcbmr12261501wrq.470.1657028830256;
        Tue, 05 Jul 2022 06:47:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x11-20020adff0cb000000b0021b92171d28sm40786942wro.54.2022.07.05.06.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 06:47:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/6] cocci: add a "coccicheck-test" target and test *.cocci rules
Date:   Tue,  5 Jul 2022 15:46:57 +0200
Message-Id: <patch-v4-3.6-540186e69dc-20220705T134033Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.913.g50625c3f077
In-Reply-To: <cover-v4-0.6-00000000000-20220705T134033Z-avarab@gmail.com>
References: <cover-v3-0.4-00000000000-20220701T102506Z-avarab@gmail.com> <cover-v4-0.6-00000000000-20220705T134033Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a "coccicheck-test" target to test our *.cocci rules, and as a
demonstration add tests for the rules added in 39ea59a2570 (remove
unnecessary NULL check before free(3), 2016-10-08) and
1b83d1251ed (coccinelle: add a rule to make "expression" code use
FREE_AND_NULL(), 2017-06-15).

I considered making use of the "spatch --test" option, and the choice
of a "tests" over a "t" directory is to make these tests compatible
with such a future change.

Unfortunately "spatch --test" doesn't return meaningful exit codes,
AFAICT you need to "grep" its output to see if the *.res is what you
expect. There's "--test-okfailed", but I didn't find a way to sensibly
integrate those (it relies on some in-between status files, but
doesn't help with the status codes).

Instead let's use a "--sp-file" pattern similar to the main
"coccicheck" rule, with the difference that we use and compare the
two *.res files with cmp(1).

The --very-quiet and --no-show-diff options ensure that we don't need
to pipe stdout and stderr somewhere. Unlike the "%.cocci.patch" rule
we're not using the diff.

The "cmp || git diff" is optimistically giving us better output on
failure, but even if we only have POSIX cmp and no system git
installed we'll still fail with the "cmp", just with an error message
that isn't as friendly. The "2>/dev/null" is in case we don't have a
"git" installed.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                          | 19 +++++++++++++++++++
 contrib/coccinelle/tests/free.c   | 11 +++++++++++
 contrib/coccinelle/tests/free.res |  9 +++++++++
 shared.mak                        |  1 +
 4 files changed, 40 insertions(+)
 create mode 100644 contrib/coccinelle/tests/free.c
 create mode 100644 contrib/coccinelle/tests/free.res

diff --git a/Makefile b/Makefile
index 1ccf13595de..c4064f8394f 100644
--- a/Makefile
+++ b/Makefile
@@ -3123,6 +3123,8 @@ check: $(GENERATED_H)
 		exit 1; \
 	fi
 
+COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
+
 %.cocci.patch: %.cocci $(COCCI_SOURCES)
 	$(QUIET_SPATCH) \
 	if test $(SPATCH_BATCH_SIZE) = 0; then \
@@ -3143,6 +3145,22 @@ check: $(GENERATED_H)
 	then \
 		echo '    ' SPATCH result: $@; \
 	fi
+
+COCCI_TEST_RES_GEN = $(addprefix .build/,$(COCCI_TEST_RES))
+$(COCCI_TEST_RES_GEN): .build/%.res : %.c
+$(COCCI_TEST_RES_GEN): .build/%.res : %.res
+$(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinelle/%.cocci
+	$(call mkdir_p_parent_template)
+	$(QUIET_SPATCH_T)$(SPATCH) $(SPATCH_FLAGS) \
+		--very-quiet --no-show-diff \
+		--sp-file $< -o $@ \
+		$(@:.build/%.res=%.c) && \
+	cmp $(@:.build/%=%) $@ || \
+	git -P diff --no-index $(@:.build/%=%) $@ 2>/dev/null; \
+
+.PHONY: coccicheck-test
+coccicheck-test: $(COCCI_TEST_RES_GEN)
+
 coccicheck: $(addsuffix .patch,$(filter-out %.pending.cocci,$(wildcard contrib/coccinelle/*.cocci)))
 
 # See contrib/coccinelle/README
@@ -3404,6 +3422,7 @@ profile-clean:
 	$(RM) $(addsuffix *.gcno,$(addprefix $(PROFILE_DIR)/, $(object_dirs)))
 
 cocciclean:
+	$(RM) -r .build/contrib/coccinelle
 	$(RM) contrib/coccinelle/*.cocci.patch*
 
 clean: profile-clean coverage-clean cocciclean
diff --git a/contrib/coccinelle/tests/free.c b/contrib/coccinelle/tests/free.c
new file mode 100644
index 00000000000..96d4abc0c78
--- /dev/null
+++ b/contrib/coccinelle/tests/free.c
@@ -0,0 +1,11 @@
+int use_FREE_AND_NULL(int *v)
+{
+	free(*v);
+	*v = NULL;
+}
+
+int need_no_if(int *v)
+{
+	if (v)
+		free(v);
+}
diff --git a/contrib/coccinelle/tests/free.res b/contrib/coccinelle/tests/free.res
new file mode 100644
index 00000000000..f90fd9f48e3
--- /dev/null
+++ b/contrib/coccinelle/tests/free.res
@@ -0,0 +1,9 @@
+int use_FREE_AND_NULL(int *v)
+{
+	FREE_AND_NULL(*v);
+}
+
+int need_no_if(int *v)
+{
+	free(v);
+}
diff --git a/shared.mak b/shared.mak
index 4330192e9c3..33f43edbf9a 100644
--- a/shared.mak
+++ b/shared.mak
@@ -70,6 +70,7 @@ ifndef V
 	QUIET_HDR      = @echo '   ' HDR $(<:hcc=h);
 	QUIET_RC       = @echo '   ' RC $@;
 	QUIET_SPATCH   = @echo '   ' SPATCH $<;
+	QUIET_SPATCH_T = @echo '   ' SPATCH TEST $(@:.build/%=%);
 
 ## Used in "Documentation/Makefile"
 	QUIET_ASCIIDOC	= @echo '   ' ASCIIDOC $@;
-- 
2.37.0.913.g50625c3f077

