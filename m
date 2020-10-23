Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE711C5517A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4199B208C3
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZXPi/8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750231AbgJWOAK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 10:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750228AbgJWOAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 10:00:09 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C4AC0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 07:00:09 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a72so1580305wme.5
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 07:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b1AT7RwLtpI62zICegS/eZm4EEVSMdhJUJLZ33iZV1I=;
        b=lZXPi/8Fm7mxGet4pA6ajD6hEoVO1RuLx7kkRx3RCd9u8SaQtN/6vqtETngQ7X97Fu
         E4OAZhjICFj6zLesm7lMilYZlK3PMiw+DA/1EBz8xCHsaQ1rrVjKrQKa6mLWCDYUBbl2
         iEUuuuuRkLUDUUTn7C5JWA6KSuerc3MCbIno1hJuEAtvcQlxiGfBo34ytISA46xmvMGR
         tNhr4kW4wkLfnB3jFRcFYKDwVU70wkyo6Gt5KWtRhlEtSAXtRGBwQe8ubBIhw0vEUhXM
         2pqbFoplSfG2DF0iANURgJ+RRiKMB0T7VDtHP8D4bKVesgzVAA1q8rn0k8PGQpFOVCih
         TXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=b1AT7RwLtpI62zICegS/eZm4EEVSMdhJUJLZ33iZV1I=;
        b=jOXwmGuygI+ItkLgiYjRJBQG1rcQX962OmLXxZX4boJR9r8ViwK5Rk1uE2PAsTIfG1
         fVks3QYet8K3OYCaPPP1O630/CKge4llT1KsvtqYcofeEhNvrpHgj7UhcXx6qot3xpIx
         nDKghxIp6YiKUu6rt3iQl5WhTonO6v+cU/IJeJsbOtYfpU2OBO02EgNELFf/g6hnGfSm
         W/DV+EGWaE1gLQY4w5+qtGQBCp0ekoOu76SlTTr4DyVVItPnHVJMTkv46eo8iAa0Qr82
         3v8sqVI+KX8uk08AHmaLU0OaTgGZUIQgkIWfHsMiA3d4sdCITc1Bv0bcJtS44ttX7pTY
         yI9w==
X-Gm-Message-State: AOAM53185gSFaGMsOpEM5RZVGSSjWmhpDAC6ZZqVS28yTTPWufjWqRXe
        8IDt8NAQxA7+hBH/EenyfX9XOrc7Ao0=
X-Google-Smtp-Source: ABdhPJzozOaRUUkbH9ntKBlFQCgN0ZYv0E01XZfsaYhib+x9rXwDAJmNaMeUDq7laYJu6xt3+6UZfg==
X-Received: by 2002:a1c:20ce:: with SMTP id g197mr2459833wmg.18.1603461607846;
        Fri, 23 Oct 2020 07:00:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d20sm3889552wra.38.2020.10.23.07.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 07:00:07 -0700 (PDT)
Message-Id: <pull.758.v2.git.1603461606.gitgitgadget@gmail.com>
In-Reply-To: <pull.758.git.1603135902.gitgitgadget@gmail.com>
References: <pull.758.git.1603135902.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Oct 2020 13:59:57 +0000
Subject: [PATCH v2 0/9] Prepare for changing the default branch name main (last manual part)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for changing the default of init.defaultBranch to main, here
are a couple of manual adjustments that cannot be automated (i.e., these
adjustments are not mere search-and-replaces).

This patch series is based on js/default-branch-name-part-3, and is part of
the larger effort tracked at https://github.com/gitgitgadget/git/pull/655.

The next patch series will be largely automated search-and-replaces;
Obviously, the search-and-replace was the easy part, the manual inspection
whether the changes are actually correct was much more involved.

What to expect next, after this patch series? Essentially, there is the
large patch series that adjusts the entire test suite, with two patch series
extracted from that effort: t5411 and t5515 simply require too large
patches, and will therefore be presented as the next patch series after this
one.

Changes since v1:

 * The t4013 patch was moved out of this patch series, to be re-submitted at
   a later date, to avoid clashing with other patches in seen.
 * The commit message of 'fmt-merge-msg: also suppress "into main" by
   default' was adjusted to mention that we do the same for main as we do
   for master.
 * The t5703 patch now uses rain instead of none, to be closer to the
   default branch name.
 * The glob in t6200 was tightened to avoid matching maint.
 * The commit message of 't3200: prepare for main being shorter than master'
   stopped talking about main2 (which itself was a left-over from a previous
   iteration of a previous patch series).

Johannes Schindelin (9):
  fmt-merge-msg: also suppress "into main" by default
  t9801: use `--` in preparation for default branch rename
  tests: start moving to a different default main branch name
  t6200: adjust suppression pattern to also match "main"
  t5703: adjust a test case for the upcoming default branch name
  t3200: prepare for `main` being shorter than `master`
  t9902: prepare a test for the upcoming default branch name
  tests: prepare aligned mentions of the default branch name
  t1400: prepare for `main` being default branch name

 fmt-merge-msg.c                    |  4 +-
 refs.c                             |  5 ++-
 t/lib-submodule-update.sh          |  2 +-
 t/t0001-init.sh                    | 13 ++++--
 t/t1400-update-ref.sh              | 10 ++---
 t/t3200-branch.sh                  | 16 +++----
 t/t3201-branch-contains.sh         |  8 ++--
 t/t3203-branch-output.sh           |  4 +-
 t/t3205-branch-color.sh            |  8 ++--
 t/t5505-remote.sh                  | 30 ++++++-------
 t/t5510-fetch.sh                   |  8 ++--
 t/t5526-fetch-submodules.sh        | 70 +++++++++++++++---------------
 t/t5606-clone-options.sh           |  3 ++
 t/t5703-upload-pack-ref-in-want.sh |  6 +--
 t/t6200-fmt-merge-msg.sh           |  2 +-
 t/t6302-for-each-ref-filter.sh     | 24 +++++-----
 t/t9801-git-p4-branch.sh           | 12 ++---
 t/t9902-completion.sh              |  6 +--
 t/test-lib.sh                      |  7 +++
 19 files changed, 130 insertions(+), 108 deletions(-)


base-commit: 538228ed23a1d5e17e89bb17086d4dda51325bd8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-758%2Fdscho%2Fprepare-for-main-branch-manual-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-758/dscho/prepare-for-main-branch-manual-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/758

Range-diff vs v1:

  1:  cf950c6f6a !  1:  bd2c72a348 fmt-merge-msg: also suppress "into main" by default
     @@ Commit message
          fmt-merge-msg: also suppress "into main" by default
      
          In preparation for changing the default branch name to `main`, let's
     -    skip the suffix "into main" in merge commit messages.
     +    skip the suffix "into main" in merge commit messages, the same way that
     +    "into master" has been skipped by default.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
  2:  5849eda331 =  2:  e819084eb3 t9801: use `--` in preparation for default branch rename
  3:  d9469202c2 =  3:  9c608c311e tests: start moving to a different default main branch name
  4:  baeb01f706 <  -:  ---------- t4013: prepare for the new default branch name "main"
  5:  7860d8d7df !  4:  9bd0a89a79 t6200: adjust suppression pattern to also match "main"
     @@ t/t6200-fmt-merge-msg.sh: test_expect_success 'merge.suppressDest configuration'
       	grep -e "Merge branch .side. into master$" actual &&
       
      -	git -c merge.suppressDest="ma??er" fmt-merge-msg <.git/FETCH_HEAD >full.3 &&
     -+	git -c merge.suppressDest="ma*" fmt-merge-msg <.git/FETCH_HEAD >full.3 &&
     ++	git -c merge.suppressDest="ma?*[rn]" fmt-merge-msg <.git/FETCH_HEAD >full.3 &&
       	head -n1 full.3 >actual &&
       	grep -e "Merge branch .side." actual &&
       	! grep -e " into master$" actual
  6:  0d2511d18f !  5:  b557ea5ac0 t5703: adjust a test case for the upcoming default branch name
     @@ t/t5703-upload-pack-ref-in-want.sh: test_expect_success 'server is initially beh
       	rm -rf local &&
       	cp -r "$LOCAL_PRISTINE" local &&
      -	echo "s/master/raster/" >"$HTTPD_ROOT_PATH/one-time-perl" &&
     -+	echo "s/main/none/" >"$HTTPD_ROOT_PATH/one-time-perl" &&
     ++	echo "s/main/rain/" >"$HTTPD_ROOT_PATH/one-time-perl" &&
       	test_must_fail git -C local fetch 2>err &&
       
      -	test_i18ngrep "fatal: remote error: unknown ref refs/heads/raster" err
     -+	test_i18ngrep "fatal: remote error: unknown ref refs/heads/none" err
     ++	test_i18ngrep "fatal: remote error: unknown ref refs/heads/rain" err
       '
       
       # DO NOT add non-httpd-specific tests here, because the last part of this
  7:  e1740bb7d7 !  6:  959a770c23 t3200: prepare for `main` being shorter than `master`
     @@ Commit message
      
          In the test case adjusted by this patch, we want to cut just after the
          longest shown ref name. Since `main` is shorter than `master`, we need
     -    to decrease the number of characters. Since `main2` is shown, too, and
     +    to decrease the number of characters. Since `topic` is shown, too, and
          since that is only one character shorter than `master`, we decrement the
     -    length by one.
     +    length by one instead of two.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
  8:  1641d1950d =  7:  8db960009d t9902: prepare a test for the upcoming default branch name
  9:  5c29a89d88 =  8:  d15e39bb73 tests: prepare aligned mentions of the default branch name
 10:  66365bce55 =  9:  e542010fdd t1400: prepare for `main` being default branch name

-- 
gitgitgadget
