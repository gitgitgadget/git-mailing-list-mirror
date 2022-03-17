Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763E1C433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 14:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbiCQO47 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 10:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiCQO46 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 10:56:58 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4B41DBABC
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 07:55:40 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so2458717wmb.4
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 07:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qqA88+X8yLZ7BXZ8sNRBJCe48jmCH6kKzo0dpLKmLGM=;
        b=Fc3QVHOGqXa8JNntpiT5Hyxv4JT4c4Glm03JtNibr1p/+aA5QvoeblD3+cYmflSa4A
         EbIBMg1Sf6I1WH83hmNVdWgjkcGvVCvm6WBidVAdW+VFe+YzA4UEvAj5djzOn5WTkoEt
         IqI7PZ7px2s1wiAMiuJQ+n6Ou7C3OQzAJ2bmUwUM/FCv+LjLRCaf/PXrFhCblnlKldSK
         yw15D4B9J8OwWo8mOUF5h031eEg9w1lQPFR2lEMsxrT513mZPhqOhkOCSI9NsFg35uDF
         +R8NTcCYzYFe+vTWHG8DWAwwb5/uO4cgP6FiV5I4tg6NSuR/TLyq9SHSaX2zmHcpxuCh
         Pz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qqA88+X8yLZ7BXZ8sNRBJCe48jmCH6kKzo0dpLKmLGM=;
        b=BacVzgdHZolONFsurWzklQaROn4jjeYYqMaj5J965NewtYWqjp+YAcF0uUdPvOEp2W
         kQJhMDP/HIoJDsmQ+6RhISXHoqwrThrCugunwt6xDNFmuVcEI6aKqJq9daKQjjLDjO7c
         DXCMClcZFI9KVmvHOmzjg4WcU16RhnHwdGx8Ka4lI5nxRg93mC/g2CuAPDXC5Oh3/aGW
         YuSfnyzc3RtRjOeJhUUDSRIfunfbJAu9YQ/aV+5rpQeAGrmpjqTL2zIXZtOCRlqNxap5
         eQTJY1WFcIBAaZD20Q2+mzELZd7i/CeHRM6AiR4eyMkP/86SkQ7+jiEoxNaHkupuY3zL
         HQuA==
X-Gm-Message-State: AOAM531J/+hWF5Y/PiByaH+R7DX4OoC5REc6G+vQPFHSFIPUnfKS2Vio
        Mgr1sqv3A+ZcrHE7qQb6jgjeu2Rv6KNPxQ==
X-Google-Smtp-Source: ABdhPJztQhQTDRQQVQkKdAQjhmtPS5+LeyN7S1lf0xFbtFFxTFoJVKrmjt1oXk2OkcGsTCFeHuLqrg==
X-Received: by 2002:a05:600c:21ce:b0:389:9052:a1ca with SMTP id x14-20020a05600c21ce00b003899052a1camr12075910wmj.123.1647528939069;
        Thu, 17 Mar 2022 07:55:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d4bcd000000b001f0620ecb3csm4340071wrt.40.2022.03.17.07.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 07:55:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] diff.c: fix a double-free regression in a18d66cefb
Date:   Thu, 17 Mar 2022 15:55:35 +0100
Message-Id: <patch-v2-2.2-cae11491599-20220317T144838Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <cover-v2-0.2-00000000000-20220317T144838Z-avarab@gmail.com>
References: <a5e5cdd4658d457ffbd80f7263e352cbf3141a1a.1647520853.git.git@grubix.eu> <cover-v2-0.2-00000000000-20220317T144838Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My a18d66cefb9 (diff.c: free "buf" in diff_words_flush(), 2022-03-04)
has what it retrospect is a rather obvious bug (I don't know what I
was thinking, if it all): We use the "emitted_symbols" allocation in
append_emitted_diff_symbol() N times, but starting with a18d66cefb9
we'd free it after its first use!

The correct way to free this data would have been to add the free() to
the existing free_diff_words_data() function, so let's do that. The
"ecbdata->diff_words->opt->emitted_symbols" might be NULL, so let's
add a trivial free_emitted_diff_symbols() helper next to the function
that appends to it.

This fixes the "no effect on show from" leak tested for in the
preceding commit. Perhaps confusingly this change will skip that test
under SANITIZE=leak, but otherwise opt-in the
"t4015-diff-whitespace.sh" test.

The reason is that a18d66cefb9 "fixed" the leak in the preceding "no
effect on diff" test, but for the first call to diff_words_flush() the
"wol->buf" would be NULL, so we wouldn't double-free (and
SANITIZE=address would see nothing amiss). With this change we'll
still pass that test, showing that we've also fixed leaks on this
codepath.

We then have to skip the new "no effect on show" test because it
happens to trip over an unrelated memory leak (in revision.c). The
same goes for "move detection with submodules". Both of them pass with
SANITIZE=address though, which would error on the "no effect on show"
test before this change.

Reported-by: Michael J Gruber <git@grubix.eu>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diff.c                     | 11 +++++++++--
 t/t4015-diff-whitespace.sh |  6 ++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 6b22946cd0e..ef7159968b6 100644
--- a/diff.c
+++ b/diff.c
@@ -800,6 +800,14 @@ static void append_emitted_diff_symbol(struct diff_options *o,
 	f->line = e->line ? xmemdupz(e->line, e->len) : NULL;
 }
 
+static void free_emitted_diff_symbols(struct emitted_diff_symbols *e)
+{
+	if (!e)
+		return;
+	free(e->buf);
+	free(e);
+}
+
 struct moved_entry {
 	const struct emitted_diff_symbol *es;
 	struct moved_entry *next_line;
@@ -2150,7 +2158,6 @@ static void diff_words_flush(struct emit_callback *ecbdata)
 
 		for (i = 0; i < wol->nr; i++)
 			free((void *)wol->buf[i].line);
-		free(wol->buf);
 
 		wol->nr = 0;
 	}
@@ -2228,7 +2235,7 @@ static void free_diff_words_data(struct emit_callback *ecbdata)
 {
 	if (ecbdata->diff_words) {
 		diff_words_flush(ecbdata);
-		free (ecbdata->diff_words->opt->emitted_symbols);
+		free_emitted_diff_symbols(ecbdata->diff_words->opt->emitted_symbols);
 		free (ecbdata->diff_words->opt);
 		free (ecbdata->diff_words->minus.text.ptr);
 		free (ecbdata->diff_words->minus.orig);
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index ff8a0426ca5..f3e20dd5bba 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -6,6 +6,8 @@
 test_description='Test special whitespace in diff engine.
 
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
@@ -1636,7 +1638,7 @@ test_expect_success 'no effect on diff from --color-moved with --word-diff' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'no effect on show from --color-moved with --word-diff' '
+test_expect_success !SANITIZE_LEAK 'no effect on show from --color-moved with --word-diff' '
 	git show --color-moved --word-diff >actual &&
 	git show --word-diff >expect &&
 	test_cmp expect actual
@@ -2022,7 +2024,7 @@ test_expect_success '--color-moved rewinds for MIN_ALNUM_COUNT' '
 	test_cmp expected actual
 '
 
-test_expect_success 'move detection with submodules' '
+test_expect_success !SANITIZE_LEAK 'move detection with submodules' '
 	test_create_repo bananas &&
 	echo ripe >bananas/recipe &&
 	git -C bananas add recipe &&
-- 
2.35.1.1384.g7d2906948a1

