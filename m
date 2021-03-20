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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECCAC433C1
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 13:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50E7F61946
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 13:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhCTNlj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 09:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhCTNlY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 09:41:24 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5414AC061762
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 06:41:24 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id g20so6914156wmk.3
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 06:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4saU7tF9Zc451g++K8/tbElTPynTsu34snxJp5g/Tnc=;
        b=VYaelxgknC62PhviF6xazpgZEIgP2u0ajgCmbkZ356u5ExRKR0JpYcjNzbO/flhlyH
         U+NPP+8s9TKK4yeprjxk46ffqZ2Zqzu0WO3XbhHyw4MuI8d5nuGkpRhXcUTvamnWhpHO
         HExB7QXOjsky4ui61+vJCHkYJCbf/BOQ5tornGEzohS+X1mBmYXp1rCKzjKp8X+FR5ZA
         EWGXkCRbbYKw/py/3LvfGIaQICL8iUT/RgUkZFNKZfH+RaKod6l66ozCC9t3JQDhSOET
         ToAh+ca8ONwivF2nrZvStQFM0h1iiUJfdynhdTZADK8ys2XXsgmEwN2QP2HpbwZbniZS
         VI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4saU7tF9Zc451g++K8/tbElTPynTsu34snxJp5g/Tnc=;
        b=lXyXQUG1FxPaaHkzRBq39iNCxnbWvBSlFcvbzf0QCiJbNomh9XsUd3AnZRuSywNEom
         xLJ32JT8S1LR2lfYfUhFYMgYBivD5y0af9QrHcN5nFbuEWd20SbPWlgGTFiunmtHsRHs
         i8m01c/A+To7Zth+1nVfgLjwcQwOAB+0X1C+kpjZ6NXAFX74DJB9j9UtLCoAcMhNkdIp
         b941rJ+fy59U/Z99ObRHhXhssxY2dqmT6ORJRBfNjAlbm5+VKzEhmAZOehIgHn5wlzwC
         ymeeb3OeTFMh6VWVuUMg92HDQmHHkM85LvbFtZEX3up7tvnnkXOYRZz6M+ibL/S5+gGz
         y2Fw==
X-Gm-Message-State: AOAM530hbALCMpwsPvV7IsmbfblsZoCX6y96QIgWC1AGJoKOMYGQXZZF
        Zy6gMdlQrdLkMoVaOxlK4IWlqUcmw+4=
X-Google-Smtp-Source: ABdhPJzo1GIsGGTu4UyRm8FvPXe3q/zmKkVwGdLxLldOM37+PTCEMQFZfNzY/aal63jZaKHNkh69Ug==
X-Received: by 2002:a05:600c:214d:: with SMTP id v13mr8037480wml.7.1616247682850;
        Sat, 20 Mar 2021 06:41:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x23sm10394220wmi.33.2021.03.20.06.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 06:41:22 -0700 (PDT)
Message-Id: <pull.901.v12.git.1616247681211.gitgitgadget@gmail.com>
In-Reply-To: <pull.901.v11.git.1616155517590.gitgitgadget@gmail.com>
References: <pull.901.v11.git.1616155517590.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 Mar 2021 13:41:20 +0000
Subject: [PATCH v12] [GSOC] commit: add --trailer option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Historically, Git has supported the 'Signed-off-by' commit trailer
using the '--signoff' and the '-s' option from the command line.
But users may need to provide other trailer information from the
command line such as "Helped-by", "Reported-by", "Mentored-by",

Now implement a new `--trailer <token>[(=|:)<value>]` option to pass
other trailers to `interpret-trailers` and insert them into commit
messages.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC] commit: add --trailer option
    
    Now maintainers or developers can also use commit
    --trailer="Signed-off-by:commiter<email>" from the command line to
    provide trailers to commit messages. This solution may be more
    generalized than v1.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-901%2Fadlternative%2Fcommit-with-multiple-signatures-v12
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-901/adlternative/commit-with-multiple-signatures-v12
Pull-Request: https://github.com/gitgitgadget/git/pull/901

Range-diff vs v11:

 1:  0db1210ffd6d ! 1:  2378e3b4c1ae [GSOC] commit: add --trailer option
     @@ Documentation/git-commit.txt: The `-m` option is mutually exclusive with `-c`, `
      +	trailer. (e.g. `git commit --trailer "Signed-off-by:C O Mitter \
      +	<committer@example.com>" --trailer "Helped-by:C O Mitter \
      +	<committer@example.com>"` will add the "Signed-off-by" trailer
     -+	and the "Helped-by" trailer in the commit message.)
     -+	Use `git -c trailer.* commit --trailer` to make the appropriate
     -+	configuration. See linkgit:git-interpret-trailers[1] for details.
     ++	and the "Helped-by" trailer to the commit message.)
     ++	The `trailer.*` configuration variables
     ++	(linkgit:git-interpret-trailers[1]) can be used to define if
     ++	a duplicated trailer is omitted, where in the run of trailers
     ++	each trailer would appear, and other details.
     ++
       -n::
       --no-verify::
       	This option bypasses the pre-commit and commit-msg hooks.
     @@ builtin/commit.c: int cmd_commit(int argc, const char **argv, const char *prefix
       		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
      
       ## t/t7502-commit-porcelain.sh ##
     +@@ t/t7502-commit-porcelain.sh: check_summary_oneline() {
     + 	test_cmp exp act
     + }
     + 
     ++trailer_commit_base () {
     ++	echo "fun" >>file &&
     ++	git add file &&
     ++	git commit -s --trailer "Signed-off-by=C1 E1 " \
     ++		--trailer "Helped-by:C2 E2 " \
     ++		--trailer "Reported-by=C3 E3" \
     ++		--trailer "Mentored-by:C4 E4" \
     ++		-m "hello"
     ++}
     ++
     + test_expect_success 'output summary format' '
     + 
     + 	echo new >file1 &&
      @@ t/t7502-commit-porcelain.sh: test_expect_success 'sign off' '
       
       '
       
     -+test_expect_success 'commit --trailer without -c' '
     -+	echo "fun" >>file &&
     -+	git add file &&
     ++test_expect_success 'commit --trailer with "="' '
     ++	trailer_commit_base &&
      +	cat >expected <<-\EOF &&
     ++	hello
      +
      +	Signed-off-by: C O Mitter <committer@example.com>
      +	Signed-off-by: C1 E1
     @@ t/t7502-commit-porcelain.sh: test_expect_success 'sign off' '
      +	Reported-by: C3 E3
      +	Mentored-by: C4 E4
      +	EOF
     -+	git commit -s --trailer "Signed-off-by:C1 E1 " \
     -+		--trailer "Helped-by:C2 E2 " \
     -+		--trailer "Reported-by:C3 E3" \
     -+		--trailer "Mentored-by:C4 E4" \
     -+		-m "hello" &&
      +	git cat-file commit HEAD >commit.msg &&
     -+	sed -e "1,6d" commit.msg >actual &&
     ++	sed -e "1,/^\$/d" commit.msg >actual &&
      +	test_cmp expected actual
      +'
      +
      +test_expect_success 'commit --trailer with -c and "replace" as ifexists' '
     -+	echo "fun" >>file1 &&
     -+	git add file1 &&
     ++	trailer_commit_base &&
      +	cat >expected <<-\EOF &&
     ++	hello
      +
      +	Signed-off-by: C O Mitter <committer@example.com>
      +	Signed-off-by: C1 E1
     @@ t/t7502-commit-porcelain.sh: test_expect_success 'sign off' '
      +		 --trailer "Helped-by: C3 E3" \
      +		--amend &&
      +	git cat-file commit HEAD >commit.msg &&
     -+	sed -e "1,6d" commit.msg >actual &&
     ++	sed -e "1,/^\$/d"  commit.msg >actual &&
      +	test_cmp expected actual
      +'
      +
      +test_expect_success 'commit --trailer with -c and "add" as ifexists' '
     -+	echo "fun" >>file1 &&
     -+	git add file1 &&
     ++	trailer_commit_base &&
      +	cat >expected <<-\EOF &&
     ++	hello
      +
      +	Signed-off-by: C O Mitter <committer@example.com>
      +	Signed-off-by: C1 E1
     ++	Helped-by: C2 E2
     ++	Reported-by: C3 E3
     ++	Mentored-by: C4 E4
      +	Reported-by: C3 E3
      +	Mentored-by: C4 E4
     -+	Helped-by: C3 E3
     -+	Helped-by: C3 E3
     -+	Helped-by: C3 E3
      +	EOF
      +	git -c trailer.ifexists="add" \
     -+		commit --trailer "Helped-by: C3 E3" \
     -+		--trailer "Helped-by: C3 E3" \
     ++		commit --trailer "Reported-by: C3 E3" \
     ++		--trailer "Mentored-by: C4 E4" \
      +		--amend &&
      +	git cat-file commit HEAD >commit.msg &&
     -+	sed -e "1,6d" commit.msg >actual &&
     ++	sed -e "1,/^\$/d"  commit.msg >actual &&
      +	test_cmp expected actual
      +'
      +
      +test_expect_success 'commit --trailer with -c and "donothing" as ifexists' '
     -+	echo "fun" >>file1 &&
     -+	git add file1 &&
     ++	trailer_commit_base &&
      +	cat >expected <<-\EOF &&
     ++	hello
      +
      +	Signed-off-by: C O Mitter <committer@example.com>
      +	Signed-off-by: C1 E1
     ++	Helped-by: C2 E2
      +	Reported-by: C3 E3
      +	Mentored-by: C4 E4
     -+	Helped-by: C3 E3
     -+	Helped-by: C3 E3
     -+	Helped-by: C3 E3
      +	Reviewed-by: C6 E6
      +	EOF
      +	git -c trailer.ifexists="donothing" \
     @@ t/t7502-commit-porcelain.sh: test_expect_success 'sign off' '
      +		--trailer "Reviewed-by: C6 E6" \
      +		--amend &&
      +	git cat-file commit HEAD >commit.msg &&
     -+	sed -e "1,6d" commit.msg >actual &&
     ++	sed -e "1,/^\$/d"  commit.msg >actual &&
      +	test_cmp expected actual
      +'
      +
      +test_expect_success 'commit --trailer with -c and "addIfDifferent" as ifexists' '
     -+	echo "fun" >>file1 &&
     -+	git add file1 &&
     ++	trailer_commit_base &&
      +	cat >expected <<-\EOF &&
     ++	hello
      +
      +	Signed-off-by: C O Mitter <committer@example.com>
      +	Signed-off-by: C1 E1
     ++	Helped-by: C2 E2
      +	Reported-by: C3 E3
      +	Mentored-by: C4 E4
     -+	Helped-by: C3 E3
     -+	Helped-by: C3 E3
     -+	Helped-by: C3 E3
     -+	Reviewed-by: C6 E6
     -+	Reported-by: C5 E5
     ++	Mentored-by: C5 E5
      +	EOF
      +	git -c trailer.ifexists="addIfDifferent" \
     -+		commit --trailer "Reviewed-by: C6 E6" \
     -+		--trailer "Reported-by: C5 E5" \
     ++		commit --trailer "Reported-by: C3 E3" \
     ++		--trailer "Mentored-by: C5 E5" \
      +		--amend &&
      +	git cat-file commit HEAD >commit.msg &&
     -+	sed -e "1,6d" commit.msg >actual &&
     ++	sed -e "1,/^\$/d"  commit.msg >actual &&
      +	test_cmp expected actual
      +'
      +
      +test_expect_success 'commit --trailer with -c and "addIfDifferentNeighbor" as ifexists' '
     -+	echo "fun" >>file1 &&
     -+	git add file1 &&
     ++	trailer_commit_base &&
      +	cat >expected <<-\EOF &&
     ++	hello
      +
      +	Signed-off-by: C O Mitter <committer@example.com>
      +	Signed-off-by: C1 E1
     ++	Helped-by: C2 E2
      +	Reported-by: C3 E3
      +	Mentored-by: C4 E4
     -+	Helped-by: C3 E3
     -+	Helped-by: C3 E3
     -+	Helped-by: C3 E3
     -+	Reviewed-by: C6 E6
     -+	Reported-by: C5 E5
     ++	Reported-by: C3 E3
      +	EOF
     -+	git -c trailer.ifexists="addIfDifferent" \
     -+		commit --trailer "Reported-by: C5 E5" \
     -+		--trailer "Reviewed-by: C6 E6" \
     ++	git -c trailer.ifexists="addIfDifferentNeighbor" \
     ++		commit --trailer "Mentored-by: C4 E4" \
     ++		--trailer "Reported-by: C3 E3" \
      +		--amend &&
      +	git cat-file commit HEAD >commit.msg &&
     -+	sed -e "1,6d" commit.msg >actual &&
     ++	sed -e "1,/^\$/d"  commit.msg >actual &&
      +	test_cmp expected actual
      +'
      +
      +test_expect_success 'commit --trailer with -c and "end" as where' '
     -+	echo "fun" >>file1 &&
     -+	git add file1 &&
     ++	trailer_commit_base &&
      +	cat >expected <<-\EOF &&
     ++	hello
      +
      +	Signed-off-by: C O Mitter <committer@example.com>
      +	Signed-off-by: C1 E1
     ++	Helped-by: C2 E2
     ++	Reported-by: C3 E3
     ++	Mentored-by: C4 E4
      +	Reported-by: C3 E3
      +	Mentored-by: C4 E4
     -+	Helped-by: C3 E3
     -+	Helped-by: C3 E3
     -+	Helped-by: C3 E3
     -+	Reviewed-by: C6 E6
     -+	Reported-by: C5 E5
     -+	Reported-by: C7 E7
      +	EOF
      +	git -c trailer.where="end" \
     -+		commit --trailer "Reported-by: C5 E5" \
     -+		--trailer "Reported-by: C7 E7" \
     ++		commit --trailer "Reported-by: C3 E3" \
     ++		--trailer "Mentored-by: C4 E4" \
      +		--amend &&
      +	git cat-file commit HEAD >commit.msg &&
     -+	sed -e "1,6d" commit.msg >actual &&
     ++	sed -e "1,/^\$/d" commit.msg >actual &&
      +	test_cmp expected actual
      +'
      +
      +test_expect_success 'commit --trailer with -c and "start" as where' '
     -+	echo "fun" >>file1 &&
     -+	git add file1 &&
     ++	trailer_commit_base &&
      +	cat >expected <<-\EOF &&
     ++	hello
      +
     -+	Signed-off-by: C8 E8
     ++	Signed-off-by: C1 E1
      +	Signed-off-by: C O Mitter <committer@example.com>
      +	Signed-off-by: C1 E1
     ++	Helped-by: C2 E2
      +	Reported-by: C3 E3
      +	Mentored-by: C4 E4
     -+	Helped-by: C3 E3
     -+	Helped-by: C3 E3
     -+	Helped-by: C3 E3
     -+	Reviewed-by: C6 E6
     -+	Reported-by: C5 E5
     -+	Reported-by: C7 E7
      +	EOF
      +	git -c trailer.where="start" \
     -+		commit --trailer "Signed-off-by: C8 E8" \
     -+		--trailer "Signed-off-by: C8 E8" \
     ++		commit --trailer "Signed-off-by: C O Mitter <committer@example.com>" \
     ++		--trailer "Signed-off-by: C1 E1" \
      +		--amend &&
      +	git cat-file commit HEAD >commit.msg &&
     -+	sed -e "1,6d" commit.msg >actual &&
     ++	sed -e "1,/^\$/d" commit.msg >actual &&
      +	test_cmp expected actual
      +'
      +
      +test_expect_success 'commit --trailer with -c and "after" as where' '
     -+	echo "fun" >>file1 &&
     -+	git add file1 &&
     ++	trailer_commit_base &&
      +	cat >expected <<-\EOF &&
     ++	hello
      +
     -+	Signed-off-by: C8 E8
      +	Signed-off-by: C O Mitter <committer@example.com>
      +	Signed-off-by: C1 E1
     ++	Helped-by: C2 E2
      +	Reported-by: C3 E3
      +	Mentored-by: C4 E4
     -+	Mentored-by: C9 E9
     -+	Helped-by: C3 E3
     -+	Helped-by: C3 E3
     -+	Helped-by: C3 E3
     -+	Reviewed-by: C6 E6
     -+	Reported-by: C5 E5
     -+	Reported-by: C7 E7
     -+	Reported-by: C10 E10
     ++	Mentored-by: C5 E5
      +	EOF
      +	git -c trailer.where="after" \
     -+		commit --trailer "Mentored-by: C9 E9" \
     -+		--trailer "Reported-by: C10 E10" \
     ++		commit --trailer "Mentored-by: C4 E4" \
     ++		--trailer "Mentored-by: C5 E5" \
      +		--amend &&
      +	git cat-file commit HEAD >commit.msg &&
     -+	sed -e "1,6d" commit.msg >actual &&
     ++	sed -e "1,/^\$/d" commit.msg >actual &&
      +	test_cmp expected actual
      +'
      +
      +test_expect_success 'commit --trailer with -c and "before" as where' '
     -+	echo "fun" >>file1 &&
     -+	git add file1 &&
     ++	trailer_commit_base &&
      +	cat >expected <<-\EOF &&
     ++	hello
      +
     -+	Signed-off-by: C8 E8
      +	Signed-off-by: C O Mitter <committer@example.com>
      +	Signed-off-by: C1 E1
     -+	Reported-by: C11 E11
     ++	Helped-by: C2 E2
      +	Reported-by: C3 E3
     ++	Mentored-by: C2 E2
     ++	Mentored-by: C3 E3
      +	Mentored-by: C4 E4
     -+	Mentored-by: C9 E9
     -+	Helped-by: C12 E12
     -+	Helped-by: C3 E3
     -+	Helped-by: C3 E3
     -+	Helped-by: C3 E3
     -+	Reviewed-by: C6 E6
     -+	Reported-by: C5 E5
     -+	Reported-by: C7 E7
     -+	Reported-by: C10 E10
      +	EOF
      +	git -c trailer.where="before" \
     -+		commit --trailer "Helped-by: C12 E12" \
     -+		--trailer "Reported-by: C11 E11" \
     ++		commit --trailer "Mentored-by: C3 E3" \
     ++		--trailer "Mentored-by: C2 E2" \
      +		--amend &&
      +	git cat-file commit HEAD >commit.msg &&
     -+	sed -e "1,6d" commit.msg >actual &&
     ++	sed -e "1,/^\$/d" commit.msg >actual &&
      +	test_cmp expected actual
      +'
      +
      +test_expect_success 'commit --trailer with -c and "donothing" as ifmissing' '
     -+	echo "fun" >>file1 &&
     -+	git add file1 &&
     ++	trailer_commit_base &&
      +	cat >expected <<-\EOF &&
     ++	hello
      +
     -+	Signed-off-by: C8 E8
      +	Signed-off-by: C O Mitter <committer@example.com>
      +	Signed-off-by: C1 E1
     -+	Reported-by: C11 E11
     ++	Helped-by: C2 E2
      +	Reported-by: C3 E3
      +	Mentored-by: C4 E4
     -+	Mentored-by: C9 E9
     -+	Helped-by: C12 E12
     -+	Helped-by: C3 E3
     -+	Helped-by: C3 E3
     -+	Helped-by: C3 E3
     -+	Reviewed-by: C6 E6
     -+	Reported-by: C5 E5
     -+	Reported-by: C7 E7
     -+	Reported-by: C10 E10
     -+	Helped-by: C12 E12
     ++	Helped-by: C5 E5
      +	EOF
      +	git -c trailer.ifmissing="donothing" \
     -+		commit --trailer "Helped-by: C12 E12" \
     -+		--trailer "Based-by: C13 E13" \
     ++		commit --trailer "Helped-by: C5 E5" \
     ++		--trailer "Based-by: C6 E6" \
      +		--amend &&
      +	git cat-file commit HEAD >commit.msg &&
     -+	sed -e "1,6d" commit.msg >actual &&
     ++	sed -e "1,/^\$/d" commit.msg >actual &&
      +	test_cmp expected actual
      +'
      +
      +test_expect_success 'commit --trailer with -c and "add" as ifmissing' '
     -+	echo "fun" >>file1 &&
     -+	git add file1 &&
     ++	trailer_commit_base &&
      +	cat >expected <<-\EOF &&
     ++	hello
      +
     -+	Signed-off-by: C8 E8
      +	Signed-off-by: C O Mitter <committer@example.com>
      +	Signed-off-by: C1 E1
     -+	Reported-by: C11 E11
     ++	Helped-by: C2 E2
      +	Reported-by: C3 E3
      +	Mentored-by: C4 E4
     -+	Mentored-by: C9 E9
     -+	Helped-by: C12 E12
     -+	Helped-by: C3 E3
     -+	Helped-by: C3 E3
     -+	Helped-by: C3 E3
     -+	Reviewed-by: C6 E6
     -+	Reported-by: C5 E5
     -+	Reported-by: C7 E7
     -+	Reported-by: C10 E10
     -+	Helped-by: C12 E12
     -+	Based-by: C13 E13
     ++	Helped-by: C5 E5
     ++	Based-by: C6 E6
      +	EOF
      +	git -c trailer.ifmissing="add" \
     -+		commit --trailer "Helped-by: C12 E12" \
     -+		--trailer "Based-by: C13 E13" \
     ++		commit --trailer "Helped-by: C5 E5" \
     ++		--trailer "Based-by: C6 E6" \
      +		--amend &&
      +	git cat-file commit HEAD >commit.msg &&
     -+	sed -e "1,6d" commit.msg >actual &&
     ++	sed -e "1,/^\$/d" commit.msg >actual &&
      +	test_cmp expected actual
      +'
      +
     -+test_expect_success 'commit --trailer with "=" ' '
     ++test_expect_success 'commit --trailer with -c ack.key ' '
      +	echo "fun" >>file1 &&
      +	git add file1 &&
      +	cat >expected <<-\EOF &&
     ++		hello
      +
      +		Acked-by: Peff
      +	EOF
      +	git -c trailer.ack.key="Acked-by" \
      +		commit --trailer "ack = Peff" -m "hello" &&
      +	git cat-file commit HEAD >commit.msg &&
     -+	sed -e "1,6d" commit.msg >actual &&
     ++	sed -e "1,/^\$/d" commit.msg >actual &&
      +	test_cmp expected actual
      +'
      +
     @@ t/t7502-commit-porcelain.sh: test_expect_success 'sign off' '
      +	echo "fun" >>file1 &&
      +	git add file1 &&
      +	cat >expected <<-\EOF &&
     ++		I hate bug
      +
      +		Bug #42
      +	EOF
     @@ t/t7502-commit-porcelain.sh: test_expect_success 'sign off' '
      +		-c trailer.bug.key="Bug #" \
      +		commit --trailer "bug = 42" -m "I hate bug" &&
      +	git cat-file commit HEAD >commit.msg &&
     -+	sed -e "1,6d" commit.msg >actual &&
     ++	sed -e "1,/^\$/d" commit.msg >actual &&
      +	test_cmp expected actual
      +'
      +


 Documentation/git-commit.txt |  14 +-
 builtin/commit.c             |  22 +++
 t/t7502-commit-porcelain.sh  | 291 +++++++++++++++++++++++++++++++++++
 3 files changed, 326 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 17150fa7eabe..3fe7ef33cb07 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -14,7 +14,8 @@ SYNOPSIS
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
 	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
-	   [-S[<keyid>]] [--] [<pathspec>...]
+	   [(--trailer <token>[(=|:)<value>])...] [-S[<keyid>]]
+	   [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -166,6 +167,17 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 
 include::signoff-option.txt[]
 
+--trailer <token>[(=|:)<value>]::
+	Specify a (<token>, <value>) pair that should be applied as a
+	trailer. (e.g. `git commit --trailer "Signed-off-by:C O Mitter \
+	<committer@example.com>" --trailer "Helped-by:C O Mitter \
+	<committer@example.com>"` will add the "Signed-off-by" trailer
+	and the "Helped-by" trailer to the commit message.)
+	The `trailer.*` configuration variables
+	(linkgit:git-interpret-trailers[1]) can be used to define if
+	a duplicated trailer is omitted, where in the run of trailers
+	each trailer would appear, and other details.
+
 -n::
 --no-verify::
 	This option bypasses the pre-commit and commit-msg hooks.
diff --git a/builtin/commit.c b/builtin/commit.c
index 739110c5a7f6..4b06672bd07d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -113,6 +113,7 @@ static int config_commit_verbose = -1; /* unspecified */
 static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
 static char *sign_commit, *pathspec_from_file;
+static struct strvec trailer_args = STRVEC_INIT;
 
 /*
  * The default commit message cleanup mode will remove the lines
@@ -131,6 +132,14 @@ static struct strbuf message = STRBUF_INIT;
 
 static enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
 
+static int opt_pass_trailer(const struct option *opt, const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+
+	strvec_pushl(&trailer_args, "--trailer", arg, NULL);
+	return 0;
+}
+
 static int opt_parse_porcelain(const struct option *opt, const char *arg, int unset)
 {
 	enum wt_status_format *value = (enum wt_status_format *)opt->value;
@@ -958,6 +967,18 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 
 	fclose(s->fp);
 
+	if (trailer_args.nr) {
+		struct child_process run_trailer = CHILD_PROCESS_INIT;
+
+		strvec_pushl(&run_trailer.args, "interpret-trailers",
+			     "--in-place", git_path_commit_editmsg(), NULL);
+		strvec_pushv(&run_trailer.args, trailer_args.v);
+		run_trailer.git_cmd = 1;
+		if (run_command(&run_trailer))
+			die(_("unable to pass trailers to --trailers"));
+		strvec_clear(&trailer_args);
+	}
+
 	/*
 	 * Reject an attempt to record a non-merge empty commit without
 	 * explicit --allow-empty. In the cherry-pick case, it may be
@@ -1507,6 +1528,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "fixup", &fixup_message, N_("commit"), N_("use autosquash formatted message to fixup specified commit")),
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
+		OPT_CALLBACK_F(0, "trailer", NULL, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG, opt_pass_trailer),
 		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
 		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index 6396897cc818..74b1602c0ce6 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -38,6 +38,16 @@ check_summary_oneline() {
 	test_cmp exp act
 }
 
+trailer_commit_base () {
+	echo "fun" >>file &&
+	git add file &&
+	git commit -s --trailer "Signed-off-by=C1 E1 " \
+		--trailer "Helped-by:C2 E2 " \
+		--trailer "Reported-by=C3 E3" \
+		--trailer "Mentored-by:C4 E4" \
+		-m "hello"
+}
+
 test_expect_success 'output summary format' '
 
 	echo new >file1 &&
@@ -154,6 +164,287 @@ test_expect_success 'sign off' '
 
 '
 
+test_expect_success 'commit --trailer with "="' '
+	trailer_commit_base &&
+	cat >expected <<-\EOF &&
+	hello
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Helped-by: C2 E2
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	EOF
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "replace" as ifexists' '
+	trailer_commit_base &&
+	cat >expected <<-\EOF &&
+	hello
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	Helped-by: C3 E3
+	EOF
+	git -c trailer.ifexists="replace" \
+		commit --trailer "Mentored-by: C4 E4" \
+		 --trailer "Helped-by: C3 E3" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d"  commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "add" as ifexists' '
+	trailer_commit_base &&
+	cat >expected <<-\EOF &&
+	hello
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Helped-by: C2 E2
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	EOF
+	git -c trailer.ifexists="add" \
+		commit --trailer "Reported-by: C3 E3" \
+		--trailer "Mentored-by: C4 E4" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d"  commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "donothing" as ifexists' '
+	trailer_commit_base &&
+	cat >expected <<-\EOF &&
+	hello
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Helped-by: C2 E2
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	Reviewed-by: C6 E6
+	EOF
+	git -c trailer.ifexists="donothing" \
+		commit --trailer "Mentored-by: C5 E5" \
+		--trailer "Reviewed-by: C6 E6" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d"  commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "addIfDifferent" as ifexists' '
+	trailer_commit_base &&
+	cat >expected <<-\EOF &&
+	hello
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Helped-by: C2 E2
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	Mentored-by: C5 E5
+	EOF
+	git -c trailer.ifexists="addIfDifferent" \
+		commit --trailer "Reported-by: C3 E3" \
+		--trailer "Mentored-by: C5 E5" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d"  commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "addIfDifferentNeighbor" as ifexists' '
+	trailer_commit_base &&
+	cat >expected <<-\EOF &&
+	hello
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Helped-by: C2 E2
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	Reported-by: C3 E3
+	EOF
+	git -c trailer.ifexists="addIfDifferentNeighbor" \
+		commit --trailer "Mentored-by: C4 E4" \
+		--trailer "Reported-by: C3 E3" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d"  commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "end" as where' '
+	trailer_commit_base &&
+	cat >expected <<-\EOF &&
+	hello
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Helped-by: C2 E2
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	EOF
+	git -c trailer.where="end" \
+		commit --trailer "Reported-by: C3 E3" \
+		--trailer "Mentored-by: C4 E4" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "start" as where' '
+	trailer_commit_base &&
+	cat >expected <<-\EOF &&
+	hello
+
+	Signed-off-by: C1 E1
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Helped-by: C2 E2
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	EOF
+	git -c trailer.where="start" \
+		commit --trailer "Signed-off-by: C O Mitter <committer@example.com>" \
+		--trailer "Signed-off-by: C1 E1" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "after" as where' '
+	trailer_commit_base &&
+	cat >expected <<-\EOF &&
+	hello
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Helped-by: C2 E2
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	Mentored-by: C5 E5
+	EOF
+	git -c trailer.where="after" \
+		commit --trailer "Mentored-by: C4 E4" \
+		--trailer "Mentored-by: C5 E5" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "before" as where' '
+	trailer_commit_base &&
+	cat >expected <<-\EOF &&
+	hello
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Helped-by: C2 E2
+	Reported-by: C3 E3
+	Mentored-by: C2 E2
+	Mentored-by: C3 E3
+	Mentored-by: C4 E4
+	EOF
+	git -c trailer.where="before" \
+		commit --trailer "Mentored-by: C3 E3" \
+		--trailer "Mentored-by: C2 E2" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "donothing" as ifmissing' '
+	trailer_commit_base &&
+	cat >expected <<-\EOF &&
+	hello
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Helped-by: C2 E2
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	Helped-by: C5 E5
+	EOF
+	git -c trailer.ifmissing="donothing" \
+		commit --trailer "Helped-by: C5 E5" \
+		--trailer "Based-by: C6 E6" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and "add" as ifmissing' '
+	trailer_commit_base &&
+	cat >expected <<-\EOF &&
+	hello
+
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: C1 E1
+	Helped-by: C2 E2
+	Reported-by: C3 E3
+	Mentored-by: C4 E4
+	Helped-by: C5 E5
+	Based-by: C6 E6
+	EOF
+	git -c trailer.ifmissing="add" \
+		commit --trailer "Helped-by: C5 E5" \
+		--trailer "Based-by: C6 E6" \
+		--amend &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c ack.key ' '
+	echo "fun" >>file1 &&
+	git add file1 &&
+	cat >expected <<-\EOF &&
+		hello
+
+		Acked-by: Peff
+	EOF
+	git -c trailer.ack.key="Acked-by" \
+		commit --trailer "ack = Peff" -m "hello" &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit --trailer with -c and ":=#" as separators' '
+	echo "fun" >>file1 &&
+	git add file1 &&
+	cat >expected <<-\EOF &&
+		I hate bug
+
+		Bug #42
+	EOF
+	git -c trailer.separators=":=#" \
+		-c trailer.bug.key="Bug #" \
+		commit --trailer "bug = 42" -m "I hate bug" &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'multiple -m' '
 
 	>negative &&

base-commit: 13d7ab6b5d7929825b626f050b62a11241ea4945
-- 
gitgitgadget
