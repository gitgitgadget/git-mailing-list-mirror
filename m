Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA6AC43461
	for <git@archiver.kernel.org>; Sat,  8 May 2021 19:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CC3F613CE
	for <git@archiver.kernel.org>; Sat,  8 May 2021 19:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhEHUAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 16:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhEHUAO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 16:00:14 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C973C061760
        for <git@vger.kernel.org>; Sat,  8 May 2021 12:59:11 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v12so12546352wrq.6
        for <git@vger.kernel.org>; Sat, 08 May 2021 12:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0e4RrCJuKuAV6s9KmC98iAx1qWZSkyg2U2VQQvqOO0E=;
        b=fvpoERXfhPE+XbH3H2SbhwBW1ExMCIPqS9MLV5ZuvWPiQt3NUJ+6sRXEocAOiI/ihe
         MLf/eAKFzDMbbpkEq4C0oRNRbOK9uhhrmTlsHmOD8/h5B4kjMTzGZHyNTGpVwzC/4NeL
         riuuCvpx4QDIstsYrzIDIjAoLTaLmQHhlb2W1i1632oTkp1srrmfolBA0nD9HIGdPEFI
         mmxoi+amO2JIFYpsy/b6ltm9m/c81BW7u3Aj+uE3bmi68Q6tluYYX0CT2lz/NB05KQc1
         xATlUPLvWO/wVngTiZEHhvRlp2ZYSry8rHa6I3mzcfPv6+Nvq39YiVtHhdB1XV7T1So+
         43ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0e4RrCJuKuAV6s9KmC98iAx1qWZSkyg2U2VQQvqOO0E=;
        b=muizO9FqVcuPHA1K/b4pJBkTGh7gd/Af/vygUwEQ26XI9T/pb1mAKmSC38HQxtC92h
         iDdsnx6dRfLGyYFm6qfciwrpnqCz9lXtmPygXm7rEMov95zDh6flQBHxNCM553moTH8E
         bKDQJcYwiQbHw0qb1GSjxOScqCBRj87iyLHcCaauGVPhZUIkgOzcTT0lwKJibgqBUYfH
         wjnefcn6/FZUTTPOsQMcessC+3pzgnyj/vLvnqOU7+vU8kpHMV81bMGYFrkCExMnnWVu
         A9JdG54eGEx28rY52VeGfeUO+SBWip9nmDmA4hEgKQfRQc+efZfJyJXwcvcs0Vn67f0+
         iI2Q==
X-Gm-Message-State: AOAM533CmrnhEU6+OLdlcwDZ3lp3zgDShtL8vsakLfLQwdAO+dc1QYXN
        L4fdKKieAdkq/pqgTAMDpLooHpARr6s=
X-Google-Smtp-Source: ABdhPJzm/H6x6kV42K4od/w0Tg3kATLHqedX94q5Cwnv1pYum2fAOtz9Y3bjpczY6+kxub1J13S9DQ==
X-Received: by 2002:adf:f991:: with SMTP id f17mr20308029wrr.160.1620503949877;
        Sat, 08 May 2021 12:59:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f6sm16409352wru.72.2021.05.08.12.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 12:59:09 -0700 (PDT)
Message-Id: <44a1322c44026e675ea254a00f3b50d4955ac56e.1620503945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
References: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
        <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 May 2021 19:58:59 +0000
Subject: [PATCH v3 3/8] [RFC] ls-files: error out on -i unless -o or -c are
 specified
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

ls-files --ignored can be used together with either --others or
--cached.  After being perplexed for a bit and digging in to the code, I
assumed that ls-files -i was just broken and not printing anything and
had a nice patch ready to submit when I finally realized that -i can be
used with --cached to find tracked ignores.

While that was a mistake on my part, and a careful reading of the
documentation could have made this more clear, I suspect this is an
error others are likely to make as well.  In fact, of two uses in our
testsuite, I believe one of the two did make this error.  In t1306.13,
there are NO tracked files, and all the excludes built up and used in
that test and in previous tests thus have to be about untracked files.
However, since they were looking for an empty result, the mistake went
unnoticed as their erroneous command also just happened to give an empty
answer.

-i will most the time be used with -o, which would suggest we could just
make -i imply -o in the absence of either a -o or -c, but that would be
a backward incompatible break.  Instead, let's just flag -i without
either a -o or -c as an error, and update the two relevant testcases to
specify their intent.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/ls-files.c          | 3 +++
 t/t1306-xdg-files.sh        | 2 +-
 t/t3003-ls-files-exclude.sh | 4 ++--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 60a2913a01e9..9f74b1ab2e69 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -748,6 +748,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (pathspec.nr && error_unmatch)
 		ps_matched = xcalloc(pathspec.nr, 1);
 
+	if ((dir.flags & DIR_SHOW_IGNORED) && !show_others && !show_cached)
+		die("ls-files --ignored is usually used with --others, but --cached is the default.  Please specify which you want.");
+
 	if ((dir.flags & DIR_SHOW_IGNORED) && !exc_given)
 		die("ls-files --ignored needs some exclude pattern");
 
diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
index dd87b43be1a6..40d3c42618c0 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -116,7 +116,7 @@ test_expect_success 'Exclusion in a non-XDG global ignore file' '
 test_expect_success 'Checking XDG ignore file when HOME is unset' '
 	(sane_unset HOME &&
 	 git config --unset core.excludesfile &&
-	 git ls-files --exclude-standard --ignored >actual) &&
+	 git ls-files --exclude-standard --ignored --others >actual) &&
 	test_must_be_empty actual
 '
 
diff --git a/t/t3003-ls-files-exclude.sh b/t/t3003-ls-files-exclude.sh
index d5ec333131f9..c41c4f046abf 100755
--- a/t/t3003-ls-files-exclude.sh
+++ b/t/t3003-ls-files-exclude.sh
@@ -29,11 +29,11 @@ test_expect_success 'add file to gitignore' '
 '
 check_all_output
 
-test_expect_success 'ls-files -i lists only tracked-but-ignored files' '
+test_expect_success 'ls-files -i -c lists only tracked-but-ignored files' '
 	echo content >other-file &&
 	git add other-file &&
 	echo file >expect &&
-	git ls-files -i --exclude-standard >output &&
+	git ls-files -i -c --exclude-standard >output &&
 	test_cmp expect output
 '
 
-- 
gitgitgadget

