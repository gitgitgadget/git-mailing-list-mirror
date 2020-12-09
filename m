Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15603C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 06:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D557523B84
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 06:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgLIG4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 01:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbgLIG4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 01:56:24 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8970C061793
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 22:55:43 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id b18so405765ots.0
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 22:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6XcDULwjuUAB1ZjqP9P+uO0FTelX6YwLh029u9+CV5o=;
        b=Qo9kWJRjWH8jhgzdGoywMhBrWMWSFNjxCYupdxnDlC/U1VSxJ/N82GigyHKcOx0U4y
         UM7P/4KQrbkKG73zGfVsF+02mj/joHQF42jQoC0HtFanqbMFlnXRT52ct5vgdHE+Ect7
         3//35HJc7dSRjJ7t9/31w1qBqb96sWazmFZMnSvORG9B0qf9kJgf0fwSC/ehYCZxPvIC
         pPlyFw4LTOQACIeRPKa40IHQVF+yejXj6jDPoZYija07oAFt0Wb9+EVP/rbTiYqNYHbO
         Rz6mpcBl4W6/28EJxntY7JmT2I7dAx7r2jqysmRqkzMnPoQA5Y3wsL570heVgGEP/Wa8
         fbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6XcDULwjuUAB1ZjqP9P+uO0FTelX6YwLh029u9+CV5o=;
        b=mC3sVLaMExeRps8YU3oF8aQ/zgoZ7DaoIsS/bxZ5iwQqdump1ds9T4fyFQSnBJoZhF
         Kyy2QyOuHsZWoGzXmGz3jrG8QNUMANhc+vM/794Ei74sIW0MiT0xEn0/rO46By7GWjGI
         5jsBBdTwWW3wFbDSyF0Mey6Io5jjZWUkDzbF6WF+wvs809m0hCGA3vzaEktSEa3Tb7uv
         AbudbfPhGCO79eJGCADZrLzhIoQ7vB1/E7NusaR5fxDeaBuBeWKt93OMdlw98Ne43bd1
         7aHLKktlb6/xm6rn1Us098xgCpoE2M3+lHMIxTS6tRkF+88x/+Gpu7JBz6LfQe/kloVx
         Q6Ew==
X-Gm-Message-State: AOAM533pAT47T2yHuna6g7UdTvCsa/OwWUbNdbKUKtgRE18z9LnSp8OA
        mg6KtvU1HZ+zJY3cTPFSEME8W4CksQ32PA==
X-Google-Smtp-Source: ABdhPJx7qfFRjRjOi5dvCU5VLZnLdXt8XmsymwJWn+qD1pSRK8yg95wZOxp71bqIBFz16Qfyco2Mkg==
X-Received: by 2002:a9d:39f5:: with SMTP id y108mr597805otb.63.1607496943061;
        Tue, 08 Dec 2020 22:55:43 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id a24sm156857oop.40.2020.12.08.22.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 22:55:42 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Aaron Schrab <aaron@schrab.com>,
        Denton Liu <liu.denton@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/2] contrib: vim: add sharness syntax file
Date:   Wed,  9 Dec 2020 00:55:37 -0600
Message-Id: <20201209065537.48802-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209065537.48802-1-felipe.contreras@gmail.com>
References: <20201209065537.48802-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It gets a bit tedious to see all the tests in the same color, so I
wrote a vim syntax file to relax my eyes.

I've tried to make it work in as many situations as possible, yet there
are still some issues with HEREDOC strings.

Much better than nothing though.

This can be enabled with the following pattern:

  au BufRead,BufNewFile */t/*.sh set filetype=3Dsh.sharness

Whoever, that's already added to the project .vimrc.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 .vimrc                          |  1 +
 contrib/vim/syntax/sharness.vim | 34 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 contrib/vim/syntax/sharness.vim

diff --git a/.vimrc b/.vimrc
index 602c746477..31600aaeca 100644
--- a/.vimrc
+++ b/.vimrc
@@ -11,6 +11,7 @@
 "
=20
 augroup git
+	au BufRead,BufNewFile */t/*.sh set filetype=3Dsh.sharness
 	au BufRead,BufNewFile */Documentation/*.txt set filetype=3Dasciidoc
=20
 	au FileType c setl noexpandtab tabstop=3D8 shiftwidth=3D0 cino=3D(s,:0,l1=
,t0
diff --git a/contrib/vim/syntax/sharness.vim b/contrib/vim/syntax/sharness.=
vim
new file mode 100644
index 0000000000..6ffc64ff06
--- /dev/null
+++ b/contrib/vim/syntax/sharness.vim
@@ -0,0 +1,34 @@
+let b:is_bash=3D1
+runtime! syntax/sh.vim
+
+syn keyword shsStatement test_done
+syn keyword shsStatement test_set_editor test_set_index_version test_decod=
e_color lf_to_nul nul_to_q q_to_nul q_to_cr q_to_tab qz_to_tab_space append=
_cr remove_cr generate_zero_bytes sane_unset test_tick test_pause debug tes=
t_commit test_merge test_commit_bulk test_chmod test_modebits test_unconfig=
 test_config test_config_global write_script test_unset_prereq test_set_pre=
req test_have_prereq test_declared_prereq test_verify_prereq test_external =
test_external_without_stderr test_path_is_file test_path_is_dir test_path_e=
xists test_dir_is_empty test_file_not_empty test_path_is_missing test_line_=
count test_file_size list_contains test_must_fail_acceptable test_must_fail=
 test_might_fail test_expect_code test_i18ncmp test_i18ngrep verbose test_m=
ust_be_empty test_cmp_rev test_cmp_fspath test_seq test_when_finished test_=
atexit test_create_repo test_ln_s_add test_write_lines perl test_bool_env t=
est_skip_or_die mingw_test_cmp test_env test_match_signal test_copy_bytes n=
ongit depacketize hex2oct test_set_hash test_detect_hash test_oid_init test=
_oid_cache test_oid test_oid_to_path test_set_port test_bitmap_traversal te=
st_path_is_hidden test_subcommand
+syn keyword shsStatement test_cmp test_cmp_config test_cmp_bin packetize
+
+syn region shsTest fold start=3D"\<test_expect_\w\+\>" end=3D"$" contains=
=3DshsTestTitle
+syn region shsTest fold start=3D"\<test_expect_\w\+\>\s\+\<[A-Z_,]\+\>" en=
d=3D"$" contains=3DshsPrereq
+syn region shsTest fold start=3D"\<test_lazy_prereq\>\s\+\<[A-Z_,]\+\>" en=
d=3D"$" contains=3DshsPrereqLazy
+
+syn keyword shsTestStatement contained containedin=3DshsTest test_expect_s=
uccess test_expect_failure test_expect_unstable test_lazy_prereq
+
+syn region shsTestTitle contained start=3D' 'hs=3Ds+1 end=3D' 'me=3De-1 ne=
xtgroup=3DshsTestBody contains=3DshSingleQuote,shDoubleQuote
+
+" multiple line body
+syn region shsTestBody contained transparent excludenl matchgroup=3DshQuot=
e start=3D+ '$+hs=3Ds+1,rs=3De end=3D+'$+ contains=3D@shSubShList
+syn region shsTestBody contained transparent excludenl matchgroup=3DshQuot=
e start=3D+ "$+hs=3Ds+1,rs=3De end=3D+"$+ contains=3D@shSubShList
+
+" single line body
+syn region shsTestBody contained oneline transparent excludenl keepend mat=
chgroup=3DshQuote start=3D+ '+hs=3Ds+1 end=3D+'$+ contains=3D@shSubShList
+syn region shsTestBody contained oneline transparent excludenl keepend mat=
chgroup=3DshQuote start=3D+ "+hs=3Ds+1 end=3D+"$+ contains=3D@shSubShList
+
+syn match shsPrereq contained "\<[A-Z_,]\+\>" nextgroup=3DshsTestTitle
+syn match shsPrereqLazy contained "\<[A-Z_,]\+\>" nextgroup=3DshsTestBody
+
+syn cluster shCommandSubList add=3DshsTest,shsStatement
+
+hi def link shsStatement Statement
+hi def link shsTestStatement Function
+hi def link shsPrereq Identifier
+hi def link shsPrereqLazy shsPrereq
+
+let b:current_syntax=3D'sharness'
--=20
2.29.2

