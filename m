Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D841CC433EF
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 23:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3F59610A6
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 23:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240613AbhIRXEM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 19:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240549AbhIRXEL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 19:04:11 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79833C061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 16:02:47 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t8so14499269wri.1
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 16:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=DzYlR2iKIWB79e8q53Q6Uz3W+eAe/ZIbBO4Ak+SSOkI=;
        b=Bo8yv5Vi3Z03SMndFU1T+ue6ulQQ2dO+EoNdu3650uF3daWeRVfZ69euD1A5jAyn1q
         nTfKgSNAKK/YW3lhaEI7yiV4vAJ1f3mUEw8Xa8DRuOREvHtkqir2WWd9vrI7s9A9I89h
         cevjgOkm+ldFdbvkJpY1aRXdaI0pCUJsu4rQwaDR1wjhmkTm+PLqLdYZFMvjqRJlfwU5
         SKt1sdNfh6dfGph0SdWhH0YoSMP/Mto86Eo1GCF+jwq9YcLWXhaUz0DzbwWOqIkso9ZH
         ASAxCoeSS94WQWBMGpVMryrW5ZwJCkGjeILSne6cgMEdObrzwNdkVAMlaPxZHRhwc9Ob
         jsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=DzYlR2iKIWB79e8q53Q6Uz3W+eAe/ZIbBO4Ak+SSOkI=;
        b=bGtWaO5IBx8FfjRqAgGdFyLFlJMna4gl2mLH5aEBV9HszvA3YXCN38ThJShy/FiM/a
         HLofk7f7VDX4djkWs5fuyUJoj214cKVv7/cKuQqz/Y2qHiyW29WIMsduGpTwcG/Vf1qe
         LjQRzGv4IuVpjgI/K4j7aqKOnB9VCRhZ53oQDNd/rfQp3f3UwNKclREsd5iyDI4tb7tB
         /yUigeO7OH0ABMfttFX881A+PGUGPRA1VylRHp6Emk0vWM7hgzf9QwU1Juw+c88oYDi/
         oc4s0iDamIyv1eMC+ICk3h6efpkjnOhrIOAut6mSpQNKnQ9ifW5cIN/YhdsiwHjE2w59
         zEuw==
X-Gm-Message-State: AOAM531RxsmRioiKEZYObpWZ/HhTWfT37khFDmo+xmG7XANF6CkzVRav
        LGv8TXccvrxwdKQ3pwDQXVLPLYMEZKo=
X-Google-Smtp-Source: ABdhPJwrV8NmE3RxSjDjrzCQVBU4Th2Q7rV97DegJ+jT+R4uoHLcIXNODEnLaUR9QvQHBJD1HbvCEg==
X-Received: by 2002:a5d:58ec:: with SMTP id f12mr20246646wrd.24.1632006165904;
        Sat, 18 Sep 2021 16:02:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12sm9237276wms.15.2021.09.18.16.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 16:02:45 -0700 (PDT)
Message-Id: <pull.1036.v3.git.git.1632006164.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.v2.git.git.1631379829.gitgitgadget@gmail.com>
References: <pull.1036.v2.git.git.1631379829.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Sep 2021 23:02:42 +0000
Subject: [PATCH v3 0/2] RFC: implement new zdiff3 conflict style
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implement a zealous diff3, or "zdiff3". This new mode is identical to
ordinary diff3 except that it allows compaction of common lines between the
two sides of history, if those common lines occur at the beginning or end of
a conflict hunk.

This is still just RFC, because a testcase provided by Phillip fails. I
think we should get it working first.

Changes since v2:

 * Included more fixes from Phillip, and a new testcase

Changes since v1:

 * Included fixes from Phillip (thanks!)
 * Added some testcases

Elijah Newren (2):
  xdiff: implement a zealous diff3, or "zdiff3"
  update documentation for new zdiff3 conflictStyle

 Documentation/config/merge.txt         |  9 ++-
 Documentation/git-checkout.txt         |  3 +-
 Documentation/git-merge-file.txt       |  3 +
 Documentation/git-merge.txt            | 32 +++++++--
 Documentation/git-rebase.txt           |  6 +-
 Documentation/git-restore.txt          |  3 +-
 Documentation/git-switch.txt           |  3 +-
 Documentation/technical/rerere.txt     | 10 +--
 builtin/checkout.c                     |  2 +-
 builtin/merge-file.c                   |  2 +
 contrib/completion/git-completion.bash |  6 +-
 t/t6427-diff3-conflict-markers.sh      | 90 ++++++++++++++++++++++++++
 xdiff-interface.c                      |  2 +
 xdiff/xdiff.h                          |  1 +
 xdiff/xmerge.c                         | 68 +++++++++++++++++--
 15 files changed, 210 insertions(+), 30 deletions(-)


base-commit: 4c719308ce59dc70e606f910f40801f2c6051b24
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1036%2Fnewren%2Fzdiff3-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1036/newren/zdiff3-v3
Pull-Request: https://github.com/git/git/pull/1036

Range-diff vs v2:

 1:  06e04c88dea ! 1:  798aefbb40a xdiff: implement a zealous diff3, or "zdiff3"
     @@ Commit message
          because zdiff3 shows the base version too and the base version cannot be
          reasonably split.
      
     +    Note also that the removing of lines common to the two sides might make
     +    the remaining text inside the conflict region match the base text inside
     +    the conflict region (for example, if the diff3 conflict had '5 6 E' on
     +    the right side of the conflict, then the common line 'E' would be moved
     +    outside and both the base and right side's remaining conflict text would
     +    be the lines '5' and '6').  This has the potential to surprise users and
     +    make them think there should not have been a conflict, but there
     +    definitely was a conflict and it should remain.
     +
          Based-on-patch-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
     -    Helped-by: Phillip Wood <phillip.wood123@gmail.com>
     +    Co-authored-by: Phillip Wood <phillip.wood123@gmail.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/merge-file.c ##
     @@ t/t6427-diff3-conflict-markers.sh: test_expect_success 'rebase --apply describes
      +		test_write_lines 1 2 3 4 5 6 7 8 9 >basic &&
      +		test_write_lines 1 2 3 AA 4 5 BB 6 7 8 >middle-common &&
      +		test_write_lines 1 2 3 4 5 6 7 8 9 >interesting &&
     ++		test_write_lines 1 2 3 4 5 6 7 8 9 >evil &&
      +
     -+		git add basic middle-common &&
     ++		git add basic middle-common interesting evil &&
      +		git commit -m base &&
      +
      +		git branch left &&
     @@ t/t6427-diff3-conflict-markers.sh: test_expect_success 'rebase --apply describes
      +		test_write_lines 1 2 3 4 A B C D E 7 8 9 >basic &&
      +		test_write_lines 1 2 3 CC 4 5 DD 6 7 8 >middle-common &&
      +		test_write_lines 1 2 3 4 A B C D E F G H I J 7 8 9 >interesting &&
     ++		test_write_lines 1 2 3 4 X A B C 7 8 9 >evil &&
      +		git add -u &&
      +		git commit -m letters &&
      +
     @@ t/t6427-diff3-conflict-markers.sh: test_expect_success 'rebase --apply describes
      +		test_write_lines 1 2 3 4 A X C Y E 7 8 9 >basic &&
      +		test_write_lines 1 2 3 EE 4 5 FF 6 7 8 >middle-common &&
      +		test_write_lines 1 2 3 4 A B C 5 6 G H I J 7 8 9 >interesting &&
     ++		test_write_lines 1 2 3 4 Y A B C B C 7 8 9 >evil &&
      +		git add -u &&
      +		git commit -m permuted
      +	)
     @@ t/t6427-diff3-conflict-markers.sh: test_expect_success 'rebase --apply describes
      +
      +		git checkout left^0 &&
      +
     ++		base=$(git rev-parse --short HEAD^1) &&
      +		test_must_fail git -c merge.conflictstyle=zdiff3 merge -s recursive right^0 &&
      +
     -+		test_write_lines 1 2 3 4 A "<<<<<<< HEAD" B C D "||||||| $(git rev-parse --short HEAD^1)" 5 6 ======= X C Y ">>>>>>> right^0" E 7 8 9 >expect &&
     ++		test_write_lines 1 2 3 4 A \
     ++				 "<<<<<<< HEAD" B C D \
     ++				 "||||||| $base" 5 6 \
     ++				 ======= X C Y \
     ++				 ">>>>>>> right^0" \
     ++				 E 7 8 9 \
     ++				 >expect &&
      +		test_cmp expect basic &&
      +
     -+		test_write_lines 1 2 3 "<<<<<<< HEAD" CC "||||||| $(git rev-parse --short HEAD^1)" AA ======= EE ">>>>>>> right^0" 4 5 "<<<<<<< HEAD" DD "||||||| $(git rev-parse --short HEAD^1)" BB ======= FF ">>>>>>> right^0" 6 7 8 >expect &&
     ++		test_write_lines 1 2 3 \
     ++				 "<<<<<<< HEAD" CC \
     ++				 "||||||| $base" AA \
     ++				 ======= EE \
     ++				 ">>>>>>> right^0" \
     ++				 4 5 \
     ++				 "<<<<<<< HEAD" DD \
     ++				 "||||||| $base" BB \
     ++				 ======= FF \
     ++				 ">>>>>>> right^0" \
     ++				 6 7 8 \
     ++				 >expect &&
      +		test_cmp expect middle-common &&
      +
     -+		# Not passing this one yet.  For some reason, after extracting
     -+		# the common lines "A B C" and "G H I J", the remaining part
     -+		# is comparing "5 6" in the base to "5 6" on the left and
     -+		# "D E F" on the right.  And zdiff3 currently picks the side
     -+		# that matches the base as the merge result.  Weird.
     -+		test_write_lines 1 2 3 4 A B C D E F G H I J 7 8 9 >expect &&
     -+		test_cmp expect interesting
     ++		test_write_lines 1 2 3 4 A B C \
     ++				 "<<<<<<< HEAD" D E F \
     ++				 "||||||| $base" 5 6 \
     ++				 ======= 5 6 \
     ++				 ">>>>>>> right^0" \
     ++				 G H I J 7 8 9 \
     ++				 >expect &&
     ++		test_cmp expect interesting &&
     ++
     ++		# Not passing this one yet; the common "B C" lines is still
     ++		# being left in the conflict blocks on the left and right
     ++		# sides.
     ++		test_write_lines 1 2 3 4 \
     ++				 "<<<<<<< HEAD" X A \
     ++				 "||||||| $base" 5 6 \
     ++				 ======= Y A B C \
     ++				 ">>>>>>> right^0" \
     ++				 B C 7 8 9 \
     ++				 >expect &&
     ++		test_cmp expect evil
      +	)
      +'
      +
 2:  9ce7246c0e9 = 2:  90aee68e14a update documentation for new zdiff3 conflictStyle

-- 
gitgitgadget
