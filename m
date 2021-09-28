Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E524EC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 17:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD4BB61262
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 17:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241917AbhI1RKP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 13:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240975AbhI1RKP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 13:10:15 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43177C06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 10:08:35 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id cv2so7816660qvb.5
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 10:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=klwCgKc2Gu+8vxeiG6kNU+0xbDaSCub/Om5LbXjlqQA=;
        b=xvXiXZ94nviOdZVLOVSDDlt4XUZqofMqlEg/IBqsBYJuF1hfmwPvv8JmKhXQY2ftUp
         YJUlkVWZShmXWKIHk1SV9gVaKjLYfdQrng82sE5HGuwOYxH6J9tgAUQH+Hy5h9y7lZ/O
         6osQYmmbme7YxGvUAVNkGdsk9Ovs8i6yRiQztOjC4SIlZI5YODbTB9C6ldmVD/Wm4apf
         gjH/vObx6ygIjg5I/eDChhQbnre9jH92bNsQZ2NS6gJJorTurs+vCNYpGGe61SNn3BT2
         MfbozFETRH8xfdmF0RLDALHSQOBm62qUquvhjPUtnho0ACILsfxxL1QFtWA/PwdKd088
         I6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=klwCgKc2Gu+8vxeiG6kNU+0xbDaSCub/Om5LbXjlqQA=;
        b=0e5g22dyBET7vTxsIVGz67SZvWVYS5LwyLHk/mBZ7FJD2pi8Fx7B/XpAKUsowBO5Gn
         4da6eMLvgibrbXgdqRoE6q2Ch2MMTXP/In3xakUQi6RBAzEAEg8sIxriWuLKvRfb8tgk
         0lYt4NH9h08R8RjJqVLPYPX1BV/lVCKelj/mt7Z6+mIc6c1gdlHybarLSenz5j4Y1ouv
         7RkVLOcj9kGlRfwopRRW2dnNEczPD+7j+roaIYwR/9ufe3QNHZwnZOyiNaloC/fgeYk9
         NKzWkmTCOnCotkH6jzjfyKTb3Ok2wgX/+ulRCm4r5sTqnVLCN8ejXGAFcJI4S4FHaGC6
         JhKQ==
X-Gm-Message-State: AOAM531FgzqxLFPLHV15pNPHtZ8LmSu3pdicBtGINLnX9tAv+2jqqCDi
        0DmGu3XBivsFYhy6wsFOMgvrTtDhoKXHmw==
X-Google-Smtp-Source: ABdhPJykFVWUyEeqFDxmVXnT1GPUJZyIPTvHDJgRaJYJoXpFcHsBCpRLjHYbWYtlP6cgcScUGRAHRg==
X-Received: by 2002:a0c:f294:: with SMTP id k20mr6589555qvl.61.1632848914111;
        Tue, 28 Sep 2021 10:08:34 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.116.19])
        by smtp.gmail.com with ESMTPSA id r10sm15350744qkk.95.2021.09.28.10.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 10:08:33 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, jonathantanmy@google.com
Subject: [PATCH] grep: demonstrate bug with textconv attributes and submodules
Date:   Tue, 28 Sep 2021 14:08:27 -0300
Message-Id: <8c266e58dede247b2c97ad2870c7c24c3b35ed55.1632848754.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some circumstances, "git grep --textconv --recurse-submodules"
ignores the textconv attributes from the submodules and erroneuosly
apply the attributes defined in the superproject on the submodules'
files. The textconv cache is also saved on the superproject, even for
submodule objects.

A fix for these problems will probably require at least three changes:

- Some textconv and attributes functions (as well as their callees) will
  have to be adjusted to work with arbitrary repositories. Note that
  "fill_textconv()", for example, already receives a "struct repository"
  but it writes the textconv cache using "write_loose_object()", which
  implicitly works on "the_repository".

- grep.c functions will have to call textconv/userdiff routines passing
  the "repo" field from "struct grep_source" instead of the one from
  "struct grep_opt". The latter always points to "the_repository" on
  "git grep" executions (see its initialization in builtin/grep.c), but
  the former points to the correct repository that each source (an
  object, file, or buffer) comes from.

- "userdiff_find_by_path()" might need to use a different attributes
  stack for each repository it works on or reset its internal static
  stack when the repository is changed throughout the calls.

For now, let's add some tests to demonstrate these problems, and also
update a NEEDSWORK comment in grep.h that mentions this bug to reference
the added tests.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 grep.h                             |   6 +-
 t/t7814-grep-recurse-submodules.sh | 103 +++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+), 3 deletions(-)

diff --git a/grep.h b/grep.h
index 128007db65..3b63bd0253 100644
--- a/grep.h
+++ b/grep.h
@@ -128,9 +128,9 @@ struct grep_opt {
 	 * instead.
 	 *
 	 * This is potentially the cause of at least one bug - "git grep"
-	 * ignoring the textconv attributes from submodules. See [1] for more
-	 * information.
-	 * [1] https://lore.kernel.org/git/CAHd-oW5iEQarYVxEXoTG-ua2zdoybTrSjCBKtO0YT292fm0NQQ@mail.gmail.com/
+	 * using the textconv attributes from the superproject on the
+	 * submodules. See the failing "git grep --textconv" tests in
+	 * t7814-grep-recurse-submodules.sh for more information.
 	 */
 	struct repository *repo;
 
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 3172f5b936..cfbaee3851 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -441,4 +441,107 @@ test_expect_success 'grep --recurse-submodules with --cached ignores worktree mo
 	test_must_fail git grep --recurse-submodules --cached "A modified line in submodule" >actual 2>&1 &&
 	test_must_be_empty actual
 '
+
+test_expect_failure 'grep --textconv: superproject .gitattributes does not affect submodules' '
+	reset_and_clean &&
+	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
+	echo "a diff=d2x" >.gitattributes &&
+
+	cat >expect <<-\EOF &&
+	a:(1|2)x(3|4)
+	EOF
+	git grep --textconv --recurse-submodules x >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'grep --textconv: superproject .gitattributes (from index) does not affect submodules' '
+	reset_and_clean &&
+	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
+	echo "a diff=d2x" >.gitattributes &&
+	git add .gitattributes &&
+	rm .gitattributes &&
+
+	cat >expect <<-\EOF &&
+	a:(1|2)x(3|4)
+	EOF
+	git grep --textconv --recurse-submodules x >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'grep --textconv: superproject .git/info/attributes does not affect submodules' '
+	reset_and_clean &&
+	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
+	super_attr="$(git rev-parse --git-path info/attributes)" &&
+	test_when_finished "rm -f \"$super_attr\"" &&
+	echo "a diff=d2x" >"$super_attr" &&
+
+	cat >expect <<-\EOF &&
+	a:(1|2)x(3|4)
+	EOF
+	git grep --textconv --recurse-submodules x >actual &&
+	test_cmp expect actual
+'
+
+# Note: what currently prevents this test from passing is not that the
+# .gitattributes file from "./submodule" is being ignored, but that it is being
+# propagated to the nested "./submodule/sub" files.
+#
+test_expect_failure 'grep --textconv corectly reads submodule .gitattributes' '
+	reset_and_clean &&
+	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
+	echo "a diff=d2x" >submodule/.gitattributes &&
+
+	cat >expect <<-\EOF &&
+	submodule/a:(1|2)x(3|4)
+	EOF
+	git grep --textconv --recurse-submodules x >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'grep --textconv corectly reads submodule .gitattributes (from index)' '
+	reset_and_clean &&
+	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
+	echo "a diff=d2x" >submodule/.gitattributes &&
+	git -C submodule add .gitattributes &&
+	rm submodule/.gitattributes &&
+
+	cat >expect <<-\EOF &&
+	submodule/a:(1|2)x(3|4)
+	EOF
+	git grep --textconv --recurse-submodules x >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'grep --textconv corectly reads submodule .git/info/attributes' '
+	reset_and_clean &&
+	test_config_global diff.d2x.textconv "sed -e \"s/d/x/\"" &&
+
+	submodule_attr="$(git -C submodule rev-parse --path-format=absolute --git-path info/attributes)" &&
+	test_when_finished "rm -f \"$submodule_attr\"" &&
+	echo "a diff=d2x" >"$submodule_attr" &&
+
+	cat >expect <<-\EOF &&
+	submodule/a:(1|2)x(3|4)
+	EOF
+	git grep --textconv --recurse-submodules x >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'grep saves textconv cache in the appropriated repository' '
+	reset_and_clean &&
+	test_config_global diff.d2x_cached.textconv "sed -e \"s/d/x/\"" &&
+	test_config_global diff.d2x_cached.cachetextconv true &&
+	echo "a diff=d2x_cached" >submodule/.gitattributes &&
+
+	# We only read/write to the textconv cache when grepping from an OID,
+	# as the working tree file might have modifications.
+	git grep --textconv --cached --recurse-submodules x &&
+
+	super_textconv_cache="$(git rev-parse --git-path refs/notes/textconv/d2x_cached)" &&
+	sub_textconv_cache="$(git -C submodule rev-parse \
+			--path-format=absolute --git-path refs/notes/textconv/d2x_cached)" &&
+	test_path_is_missing "$super_textconv_cache" &&
+	test_path_is_file "$sub_textconv_cache"
+'
+
 test_done
-- 
2.33.0

