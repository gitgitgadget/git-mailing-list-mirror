Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A80FC433EF
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 19:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbiAUTMo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 14:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiAUTMi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 14:12:38 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D9BC061753
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 11:12:33 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r14so1409687wrp.2
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 11:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s2JPqRuN+jwFI7QheNwS1Q7ImdG548HewkzmJnYY9u8=;
        b=YSxSHOl6ARLKMOui45hVHfteqkGPEy/dmT6cz3clX+0Y7GkA6lj6H1HXsJPTQA7ybQ
         +hWhTCGKQE+cGVak22TZOET86Ya8jnS50yzV1tSKaeaTVeSDjS5o8Lo5IpPId+JyQrTa
         vQr8VHng9xTpqD2NNMcEfFvUpStY9eH4WHcu4W+9ks32sH0iKiVQaKMw3psY05RwwCQl
         u3hU3mRmRruWUEKBh+IDmU6RSovchTkfgwJ6Hi0aGSgxgvnA4N/LvvJRpaUs7EOrnAcW
         gXsm4718Jg7GLa4oZcjKBGWTP58W/FmcceNvlyCdwsn1W311GZhRUwMwTozGmXC+vweN
         192g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s2JPqRuN+jwFI7QheNwS1Q7ImdG548HewkzmJnYY9u8=;
        b=dhjQ5xA+H0UhSxU1gUXIwr/h0Ax2vXec2t0lag+mHOZSrj0RBnLyh6Fl5x2oAiilEu
         9ZbF5bc08QB52f2iFos2FsUlruxG2B5UiD5aERQ7IdbjRrWdgprA6Kvisu/oItuApUi6
         io5l+oVo32x5Kdo6ZgRLep32W1OgPpIbU1+Zn0z4SwlT2BGWe7cif7fCw0KJlwZHMOT8
         A/KFWk81B4qTJcaQ5jXLcIFFY4Gh5y0UGBfW8BNOyS4A4qBuCKiKA46RMKd+zndAEjAc
         wpl5pH/CQHMFbxdRzSm3XNtIX6+jlQ3bBcoMFtwGqT4j7i+arrrP3YfFoxoyZSI53hZS
         pTUw==
X-Gm-Message-State: AOAM5334tOh0ie4iBvEIVDZRHf+CHsy7YRdApxkkkl3kN8tUo/ERb+0G
        eSWXizwuhcssbqIYRgOspDsOEDJNkmk=
X-Google-Smtp-Source: ABdhPJzH0WwjHX720mplRKwGuETVcf3JVgSfEn4rsH4A+dbBttNQax9n0RCflp/Q2Z4LaY8QmdhBBQ==
X-Received: by 2002:a05:6000:1549:: with SMTP id 9mr4862979wry.704.1642792352201;
        Fri, 21 Jan 2022 11:12:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i19sm5731146wml.29.2022.01.21.11.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 11:12:31 -0800 (PST)
Message-Id: <ea5df61cf358d3c831189e2f04863abc2157e3e1.1642792341.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.v4.git.1642792341.gitgitgadget@gmail.com>
References: <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
        <pull.1103.v4.git.1642792341.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Jan 2022 19:12:20 +0000
Subject: [PATCH v4 10/10] diff-merges: avoid history simplifications when
 diffing merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Neeraj Singh <nksingh85@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Doing diffs for merges are special; they should typically avoid history
simplification.  For example, with

    git log --diff-merges=first-parent -- path

the default history simplification would remove merge commits from
consideration if the file "path" matched the second parent.  That is
counter to what the user wants when looking for first-parent diffs.
Similar comments can be made for --diff-merges=separate (which diffs
against both parents) and --diff-merges=remerge (which diffs against a
remerge of the merge commit).

However, history simplification still makes sense if not doing diffing
merges, and it also makes sense for the combined and dense-combined
forms of diffing merges (because both of those are defined to only show
a diff when the merge result at the relevant paths differs from *both*
parents).

So, for separate, first-parent, and remerge styles of diff-merges, turn
off history simplification.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff-merges.c           |  2 ++
 t/t4069-remerge-diff.sh | 58 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/diff-merges.c b/diff-merges.c
index 0af4b3f9191..a833fd747ad 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -24,6 +24,7 @@ static void set_separate(struct rev_info *revs)
 {
 	suppress(revs);
 	revs->separate_merges = 1;
+	revs->simplify_history = 0;
 }
 
 static void set_first_parent(struct rev_info *revs)
@@ -50,6 +51,7 @@ static void set_remerge_diff(struct rev_info *revs)
 {
 	suppress(revs);
 	revs->remerge_diff = 1;
+	revs->simplify_history = 0;
 }
 
 static diff_merges_setup_func_t func_by_opt(const char *optarg)
diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
index 86c5a33bd77..962888cc7fb 100755
--- a/t/t4069-remerge-diff.sh
+++ b/t/t4069-remerge-diff.sh
@@ -226,7 +226,63 @@ test_expect_success 'remerge-diff w/ pathspec: limits to relevant file including
 	# with sha256
 	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >expect &&
 
-	git show --oneline --remerge-diff --full-history resolution -- "letters*" >tmp &&
+	git show --oneline --remerge-diff resolution -- "letters*" >tmp &&
+	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'setup non-content conflicts' '
+	git switch --orphan newbase &&
+
+	test_write_lines 1 2 3 4 5 6 7 8 9 >numbers &&
+	git add numbers &&
+	git commit -m base &&
+
+	git branch newside1 &&
+	git branch newside2 &&
+
+	git checkout newside1 &&
+	test_write_lines 1 2 three 4 5 6 7 8 9 >numbers &&
+	git add numbers &&
+	git commit -m side1 &&
+
+	git checkout newside2 &&
+	test_write_lines 1 2 drei 4 5 6 7 8 9 >numbers &&
+	git add numbers &&
+	git commit -m side2 &&
+
+	git checkout -b newresolution newside1 &&
+	test_must_fail git merge newside2 &&
+	git checkout --theirs numbers &&
+	git add -u numbers &&
+	git commit -m resolved
+'
+
+test_expect_success 'remerge-diff turns off history simplification' '
+	git log -1 --oneline newresolution >tmp &&
+	cat <<-EOF >>tmp &&
+	diff --git a/numbers b/numbers
+	remerge CONFLICT (content): Merge conflict in numbers
+	index 070e9e7..5335e78 100644
+	--- a/numbers
+	+++ b/numbers
+	@@ -1,10 +1,6 @@
+	 1
+	 2
+	-<<<<<<< 96f1e45 (side1)
+	-three
+	-=======
+	 drei
+	->>>>>>> 4fd522f (side2)
+	 4
+	 5
+	 6
+	EOF
+	# We still have some sha1 hashes above; rip them out so test works
+	# with sha256
+	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >expect &&
+
+	git show --oneline --remerge-diff newresolution -- numbers >tmp &&
 	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&
 	test_cmp expect actual
 '
-- 
gitgitgadget
