Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AACC43333
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 11:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B223964F2B
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 11:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhCRLQL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 07:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhCRLQA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 07:16:00 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EBAC06174A
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 04:15:59 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so6730829wma.0
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 04:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=7Q6d8fGrj34anzHN8MeRwer9EUYHPG8GsoRWMNn+sXs=;
        b=o5gG3h+ctoyO3WCgoYOBYatw2p8nGaTmYCRTEHcXWAZIlRrZLy7rNWzgXwqTuaKH7z
         Nc77IwUsoUHw0HB5i/4VwTrhKt2SWTYkXLvkpqpG3AgNjx8vaRALTbWiloF3hrIzhLAz
         mJE1Frt4vQKkUyuMld7Wc2TiLDHIdiLI76bd2nh/B0YCgxjA4Gr4HGmkwdKG4KaqG7rg
         z9CiILngYKHcEqSueqPEgkSIbJR+ZT8lPVvkbiO0Sby1IrCfvBvAVT/7wTMPj69L3/UU
         EjK7wc7lUcLyRNGPDSJQWPqWkdodx51uMaqgvcKFSD1YcAEg6JiJJxA/dGmvAXaf44ft
         1SEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=7Q6d8fGrj34anzHN8MeRwer9EUYHPG8GsoRWMNn+sXs=;
        b=HGcHWeNZbxvl6fCIGAda3GPDjvRF6rMx6HCmpwcMqtQ8Rj6YQ7QMICFeYMuRD2SAf/
         9gud1E0tROlsz61mm/HTXPKNkIAh/0RPZ05zhjD7OXCO7E18fIq9VzgMdDjv69KTyCPZ
         KTlH1rAHSTJEs0oJp0mz47M8lswc7Wv2YXeWorDqp4e/NFnI3WuAQKD7bUHi5RVdTHL6
         yQxk+VtMmQ5YzId51Vnsu/ys0HFyqRv5ykCW2XDEuShf6AiT/ugcoleSoaNUQSNzVxQt
         TC4aSC0iL4l3A470H5KmPKm5DUmZEqu656WrM9WmAd4RqrgwKo0FpaHBdmbTl22TmXX4
         tZqA==
X-Gm-Message-State: AOAM533kpWPoO4pH2Hr1XpcldlRZU67t98SLcmj4PA1FEoWz+1bk9HNI
        lPnLqIEmd38cg0BgNEr12xxtql7sRZg=
X-Google-Smtp-Source: ABdhPJxs87w5jX+xRQIJkKGV6LOMML6HY4dn/c68TBS2k1jOjORBfHhBOEu+HOFAlYmDwMWhO68lWw==
X-Received: by 2002:a7b:c4d1:: with SMTP id g17mr3120064wmk.101.1616066158455;
        Thu, 18 Mar 2021 04:15:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b65sm1989931wmh.4.2021.03.18.04.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 04:15:57 -0700 (PDT)
Message-Id: <pull.901.v10.git.1616066156.gitgitgadget@gmail.com>
In-Reply-To: <pull.901.v9.git.1615891183320.gitgitgadget@gmail.com>
References: <pull.901.v9.git.1615891183320.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Mar 2021 11:15:53 +0000
Subject: [PATCH v10 0/3] [GSOC] commit: add --trailer option
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now maintainers or developers can also use commit
--trailer="Signed-off-by:commiter<email>" from the command line to provide
trailers to commit messages. This solution may be more generalized than v1.

ZheNing Hu (3):
  [GSOC] commit: add --trailer option
  interpret-trailers: add own-identity option
  commit: add own-identity option

 Documentation/git-commit.txt             |  25 +-
 Documentation/git-interpret-trailers.txt |  14 +
 builtin/commit.c                         |  31 ++
 builtin/interpret-trailers.c             |   6 +-
 t/t7501-commit-basic-functionality.sh    |  91 ++++++
 t/t7502-commit-porcelain.sh              | 356 +++++++++++++++++++++++
 t/t7513-interpret-trailers.sh            |  12 +
 trailer.c                                |  18 +-
 trailer.h                                |   3 +-
 9 files changed, 550 insertions(+), 6 deletions(-)


base-commit: 13d7ab6b5d7929825b626f050b62a11241ea4945
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-901%2Fadlternative%2Fcommit-with-multiple-signatures-v10
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-901/adlternative/commit-with-multiple-signatures-v10
Pull-Request: https://github.com/gitgitgadget/git/pull/901

Range-diff vs v9:

 1:  e524c4ba5dc1 ! 1:  949faf9ee56a [GSOC] commit: add --trailer option
     @@ Documentation/git-commit.txt: The `-m` option is mutually exclusive with `-c`, `
      +	<committer@example.com>" --trailer "Helped-by:C O Mitter \
      +	<committer@example.com>"` will add the "Signed-off-by" trailer
      +	and the "Helped-by" trailer in the commit message.)
     -+	See linkgit:git-interpret-trailers[1] for details.
     ++	Use `git -c trailer.* commit --trailer` to make the appropriate
     ++	configuration. See linkgit:git-interpret-trailers[1] for details.
       -n::
       --no-verify::
       	This option bypasses the pre-commit and commit-msg hooks.
     @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const cha
      +			     "--in-place", git_path_commit_editmsg(), NULL);
      +		strvec_pushv(&run_trailer.args, trailer_args.v);
      +		run_trailer.git_cmd = 1;
     -+		if (run_command(&run_trailer))
     -+			strvec_clear(&run_trailer.args);
     ++		if (run_command(&run_trailer)) {
     ++			die(_("unable to pass tailers to --trailers"));
     ++		}
      +		strvec_clear(&trailer_args);
      +	}
      +
     @@ builtin/commit.c: int cmd_commit(int argc, const char **argv, const char *prefix
       		OPT_STRING(0, "fixup", &fixup_message, N_("commit"), N_("use autosquash formatted message to fixup specified commit")),
       		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
       		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
     -+		OPT_CALLBACK_F(0, "trailer", NULL, N_("trailer"), N_("trailer(s) to add"), PARSE_OPT_NONEG, opt_pass_trailer),
     ++		OPT_CALLBACK_F(0, "trailer", NULL, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG, opt_pass_trailer),
       		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
       		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
       		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
     @@ t/t7502-commit-porcelain.sh: test_expect_success 'sign off' '
       
       '
       
     -+test_expect_success 'trailer' '
     -+	>file1 &&
     -+	git add file1 &&
     -+	git commit -s --trailer "Signed-off-by:C O Mitter1 <committer1@example.com>" \
     -+		--trailer "Helped-by:C O Mitter2 <committer2@example.com>"  \
     -+		--trailer "Reported-by:C O Mitter3 <committer3@example.com>" \
     -+		--trailer "Mentored-by:C O Mitter4 <committer4@example.com>" \
     ++test_expect_success 'commit --trailer without -c' '
     ++	echo "fun" >>file &&
     ++	git add file &&
     ++	cat >expected <<-\EOF &&
     ++
     ++	Signed-off-by: C O Mitter <committer@example.com>
     ++	Signed-off-by: C1 E1
     ++	Helped-by: C2 E2
     ++	Reported-by: C3 E3
     ++	Mentored-by: C4 E4
     ++	EOF
     ++	git commit -s --trailer "Signed-off-by:C1 E1 " \
     ++		--trailer "Helped-by:C2 E2 " \
     ++		--trailer "Reported-by:C3 E3" \
     ++		--trailer "Mentored-by:C4 E4" \
      +		-m "hello" &&
      +	git cat-file commit HEAD >commit.msg &&
     -+	sed -e "1,7d" commit.msg >actual &&
     ++	sed -e "1,6d" commit.msg >actual &&
     ++	test_cmp expected actual
     ++'
     ++
     ++test_expect_success 'commit --trailer with -c and "replace" as ifexists' '
     ++	echo "fun" >>file1 &&
     ++	git add file1 &&
     ++	cat >expected <<-\EOF &&
     ++
     ++	Signed-off-by: C O Mitter <committer@example.com>
     ++	Signed-off-by: C1 E1
     ++	Reported-by: C3 E3
     ++	Mentored-by: C4 E4
     ++	Helped-by: C3 E3
     ++	EOF
     ++	git -c trailer.ifexists="replace" \
     ++		commit --trailer "Mentored-by: C4 E4" \
     ++		 --trailer "Helped-by: C3 E3" \
     ++		--amend &&
     ++	git cat-file commit HEAD >commit.msg &&
     ++	sed -e "1,6d" commit.msg >actual &&
     ++	test_cmp expected actual
     ++'
     ++
     ++test_expect_success 'commit --trailer with -c and "add" as ifexists' '
     ++	echo "fun" >>file1 &&
     ++	git add file1 &&
     ++	cat >expected <<-\EOF &&
     ++
     ++	Signed-off-by: C O Mitter <committer@example.com>
     ++	Signed-off-by: C1 E1
     ++	Reported-by: C3 E3
     ++	Mentored-by: C4 E4
     ++	Helped-by: C3 E3
     ++	Helped-by: C3 E3
     ++	Helped-by: C3 E3
     ++	EOF
     ++	git -c trailer.ifexists="add" \
     ++		commit --trailer "Helped-by: C3 E3" \
     ++		--trailer "Helped-by: C3 E3" \
     ++		--amend &&
     ++	git cat-file commit HEAD >commit.msg &&
     ++	sed -e "1,6d" commit.msg >actual &&
     ++	test_cmp expected actual
     ++'
     ++
     ++test_expect_success 'commit --trailer with -c and "donothing" as ifexists' '
     ++	echo "fun" >>file1 &&
     ++	git add file1 &&
      +	cat >expected <<-\EOF &&
     ++
      +	Signed-off-by: C O Mitter <committer@example.com>
     -+	Signed-off-by: C O Mitter1 <committer1@example.com>
     -+	Helped-by: C O Mitter2 <committer2@example.com>
     -+	Reported-by: C O Mitter3 <committer3@example.com>
     -+	Mentored-by: C O Mitter4 <committer4@example.com>
     ++	Signed-off-by: C1 E1
     ++	Reported-by: C3 E3
     ++	Mentored-by: C4 E4
     ++	Helped-by: C3 E3
     ++	Helped-by: C3 E3
     ++	Helped-by: C3 E3
     ++	Reviewed-by: C6 E6
      +	EOF
     ++	git -c trailer.ifexists="donothing" \
     ++		commit --trailer "Mentored-by: C5 E5" \
     ++		--trailer "Reviewed-by: C6 E6" \
     ++		--amend &&
     ++	git cat-file commit HEAD >commit.msg &&
     ++	sed -e "1,6d" commit.msg >actual &&
     ++	test_cmp expected actual
     ++'
     ++
     ++test_expect_success 'commit --trailer with -c and "addIfDifferent" as ifexists' '
     ++	echo "fun" >>file1 &&
     ++	git add file1 &&
     ++	cat >expected <<-\EOF &&
     ++
     ++	Signed-off-by: C O Mitter <committer@example.com>
     ++	Signed-off-by: C1 E1
     ++	Reported-by: C3 E3
     ++	Mentored-by: C4 E4
     ++	Helped-by: C3 E3
     ++	Helped-by: C3 E3
     ++	Helped-by: C3 E3
     ++	Reviewed-by: C6 E6
     ++	Reported-by: C5 E5
     ++	EOF
     ++	git -c trailer.ifexists="addIfDifferent" \
     ++		commit --trailer "Reviewed-by: C6 E6" \
     ++		--trailer "Reported-by: C5 E5" \
     ++		--amend &&
     ++	git cat-file commit HEAD >commit.msg &&
     ++	sed -e "1,6d" commit.msg >actual &&
     ++	test_cmp expected actual
     ++'
     ++
     ++test_expect_success 'commit --trailer with -c and "addIfDifferentNeighbor" as ifexists' '
     ++	echo "fun" >>file1 &&
     ++	git add file1 &&
     ++	cat >expected <<-\EOF &&
     ++
     ++	Signed-off-by: C O Mitter <committer@example.com>
     ++	Signed-off-by: C1 E1
     ++	Reported-by: C3 E3
     ++	Mentored-by: C4 E4
     ++	Helped-by: C3 E3
     ++	Helped-by: C3 E3
     ++	Helped-by: C3 E3
     ++	Reviewed-by: C6 E6
     ++	Reported-by: C5 E5
     ++	EOF
     ++	git -c trailer.ifexists="addIfDifferent" \
     ++		commit --trailer "Reported-by: C5 E5" \
     ++		--trailer "Reviewed-by: C6 E6" \
     ++		--amend &&
     ++	git cat-file commit HEAD >commit.msg &&
     ++	sed -e "1,6d" commit.msg >actual &&
     ++	test_cmp expected actual
     ++'
     ++
     ++test_expect_success 'commit --trailer with -c and "end" as where' '
     ++	echo "fun" >>file1 &&
     ++	git add file1 &&
     ++	cat >expected <<-\EOF &&
     ++
     ++	Signed-off-by: C O Mitter <committer@example.com>
     ++	Signed-off-by: C1 E1
     ++	Reported-by: C3 E3
     ++	Mentored-by: C4 E4
     ++	Helped-by: C3 E3
     ++	Helped-by: C3 E3
     ++	Helped-by: C3 E3
     ++	Reviewed-by: C6 E6
     ++	Reported-by: C5 E5
     ++	Reported-by: C7 E7
     ++	EOF
     ++	git -c trailer.where="end" \
     ++		commit --trailer "Reported-by: C5 E5" \
     ++		--trailer "Reported-by: C7 E7" \
     ++		--amend &&
     ++	git cat-file commit HEAD >commit.msg &&
     ++	sed -e "1,6d" commit.msg >actual &&
     ++	test_cmp expected actual
     ++'
     ++
     ++test_expect_success 'commit --trailer with -c and "start" as where' '
     ++	echo "fun" >>file1 &&
     ++	git add file1 &&
     ++	cat >expected <<-\EOF &&
     ++
     ++	Signed-off-by: C8 E8
     ++	Signed-off-by: C O Mitter <committer@example.com>
     ++	Signed-off-by: C1 E1
     ++	Reported-by: C3 E3
     ++	Mentored-by: C4 E4
     ++	Helped-by: C3 E3
     ++	Helped-by: C3 E3
     ++	Helped-by: C3 E3
     ++	Reviewed-by: C6 E6
     ++	Reported-by: C5 E5
     ++	Reported-by: C7 E7
     ++	EOF
     ++	git -c trailer.where="start" \
     ++		commit --trailer "Signed-off-by: C8 E8" \
     ++		--trailer "Signed-off-by: C8 E8" \
     ++		--amend &&
     ++	git cat-file commit HEAD >commit.msg &&
     ++	sed -e "1,6d" commit.msg >actual &&
     ++	test_cmp expected actual
     ++'
     ++
     ++test_expect_success 'commit --trailer with -c and "after" as where' '
     ++	echo "fun" >>file1 &&
     ++	git add file1 &&
     ++	cat >expected <<-\EOF &&
     ++
     ++	Signed-off-by: C8 E8
     ++	Signed-off-by: C O Mitter <committer@example.com>
     ++	Signed-off-by: C1 E1
     ++	Reported-by: C3 E3
     ++	Mentored-by: C4 E4
     ++	Mentored-by: C9 E9
     ++	Helped-by: C3 E3
     ++	Helped-by: C3 E3
     ++	Helped-by: C3 E3
     ++	Reviewed-by: C6 E6
     ++	Reported-by: C5 E5
     ++	Reported-by: C7 E7
     ++	Reported-by: C10 E10
     ++	EOF
     ++	git -c trailer.where="after" \
     ++		commit --trailer "Mentored-by: C9 E9" \
     ++		--trailer "Reported-by: C10 E10" \
     ++		--amend &&
     ++	git cat-file commit HEAD >commit.msg &&
     ++	sed -e "1,6d" commit.msg >actual &&
     ++	test_cmp expected actual
     ++'
     ++
     ++test_expect_success 'commit --trailer with -c and "before" as where' '
     ++	echo "fun" >>file1 &&
     ++	git add file1 &&
     ++	cat >expected <<-\EOF &&
     ++
     ++	Signed-off-by: C8 E8
     ++	Signed-off-by: C O Mitter <committer@example.com>
     ++	Signed-off-by: C1 E1
     ++	Reported-by: C11 E11
     ++	Reported-by: C3 E3
     ++	Mentored-by: C4 E4
     ++	Mentored-by: C9 E9
     ++	Helped-by: C12 E12
     ++	Helped-by: C3 E3
     ++	Helped-by: C3 E3
     ++	Helped-by: C3 E3
     ++	Reviewed-by: C6 E6
     ++	Reported-by: C5 E5
     ++	Reported-by: C7 E7
     ++	Reported-by: C10 E10
     ++	EOF
     ++	git -c trailer.where="before" \
     ++		commit --trailer "Helped-by: C12 E12" \
     ++		--trailer "Reported-by: C11 E11" \
     ++		--amend &&
     ++	git cat-file commit HEAD >commit.msg &&
     ++	sed -e "1,6d" commit.msg >actual &&
     ++	test_cmp expected actual
     ++'
     ++
     ++test_expect_success 'commit --trailer with -c and "donothing" as ifmissing' '
     ++	echo "fun" >>file1 &&
     ++	git add file1 &&
     ++	cat >expected <<-\EOF &&
     ++
     ++	Signed-off-by: C8 E8
     ++	Signed-off-by: C O Mitter <committer@example.com>
     ++	Signed-off-by: C1 E1
     ++	Reported-by: C11 E11
     ++	Reported-by: C3 E3
     ++	Mentored-by: C4 E4
     ++	Mentored-by: C9 E9
     ++	Helped-by: C12 E12
     ++	Helped-by: C3 E3
     ++	Helped-by: C3 E3
     ++	Helped-by: C3 E3
     ++	Reviewed-by: C6 E6
     ++	Reported-by: C5 E5
     ++	Reported-by: C7 E7
     ++	Reported-by: C10 E10
     ++	Helped-by: C12 E12
     ++	EOF
     ++	git -c trailer.ifmissing="donothing" \
     ++		commit --trailer "Helped-by: C12 E12" \
     ++		--trailer "Based-by: C13 E13" \
     ++		--amend &&
     ++	git cat-file commit HEAD >commit.msg &&
     ++	sed -e "1,6d" commit.msg >actual &&
     ++	test_cmp expected actual
     ++'
     ++
     ++test_expect_success 'commit --trailer with -c and "add" as ifmissing' '
     ++	echo "fun" >>file1 &&
     ++	git add file1 &&
     ++	cat >expected <<-\EOF &&
     ++
     ++	Signed-off-by: C8 E8
     ++	Signed-off-by: C O Mitter <committer@example.com>
     ++	Signed-off-by: C1 E1
     ++	Reported-by: C11 E11
     ++	Reported-by: C3 E3
     ++	Mentored-by: C4 E4
     ++	Mentored-by: C9 E9
     ++	Helped-by: C12 E12
     ++	Helped-by: C3 E3
     ++	Helped-by: C3 E3
     ++	Helped-by: C3 E3
     ++	Reviewed-by: C6 E6
     ++	Reported-by: C5 E5
     ++	Reported-by: C7 E7
     ++	Reported-by: C10 E10
     ++	Helped-by: C12 E12
     ++	Based-by: C13 E13
     ++	EOF
     ++	git -c trailer.ifmissing="add" \
     ++		commit --trailer "Helped-by: C12 E12" \
     ++		--trailer "Based-by: C13 E13" \
     ++		--amend &&
     ++	git cat-file commit HEAD >commit.msg &&
     ++	sed -e "1,6d" commit.msg >actual &&
     ++	test_cmp expected actual
     ++'
     ++
     ++test_expect_success 'commit --trailer with -c and "=" as separators' '
     ++	echo "fun" >>file1 &&
     ++	git add file1 &&
     ++	cat >expected <<-\EOF &&
     ++
     ++		Acked-by= Peff
     ++	EOF
     ++	git -c trailer.separators="=" \
     ++		-c trailer.ack.key="Acked-by= " \
     ++		commit --trailer "ack = Peff" -m "hello" &&
     ++	git cat-file commit HEAD >commit.msg &&
     ++	sed -e "1,6d" commit.msg >actual &&
     ++	test_cmp expected actual
     ++'
     ++
     ++test_expect_success 'commit --trailer with -c and ":=#" as separators' '
     ++	echo "fun" >>file1 &&
     ++	git add file1 &&
     ++	cat >expected <<-\EOF &&
     ++
     ++		Bug #42
     ++	EOF
     ++	git -c trailer.separators=":=#" \
     ++		-c trailer.bug.key="Bug #" \
     ++		commit --trailer "bug = 42" -m "I hate bug" &&
     ++	git cat-file commit HEAD >commit.msg &&
     ++	sed -e "1,6d" commit.msg >actual &&
      +	test_cmp expected actual
      +'
      +
 -:  ------------ > 2:  42590e95deee interpret-trailers: add own-identity option
 -:  ------------ > 3:  2dfcc20f0e9f commit: add own-identity option

-- 
gitgitgadget
