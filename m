Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7BAC28CBC
	for <git@archiver.kernel.org>; Sat,  9 May 2020 19:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C0A020644
	for <git@archiver.kernel.org>; Sat,  9 May 2020 19:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1/8mTvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgEITXn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 15:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727938AbgEITXm (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 May 2020 15:23:42 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916B9C061A0C
        for <git@vger.kernel.org>; Sat,  9 May 2020 12:23:42 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u16so14273500wmc.5
        for <git@vger.kernel.org>; Sat, 09 May 2020 12:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lBt+cOXO4xTBLFqCQVCUOVZomNPsyxyO9m+vwA1+2CE=;
        b=I1/8mTvlLV4uyEcAv/+FZu8b3yrAMkfYXI3PDhJqrbqeM2XRSjI2CDiLOtuSWeglnh
         GivGEbMbtjPhOnO+IDIGnVDlmM05nkR+QAq5ewKs0/KCCCRzi+feMkbFA64aF4KhQnXn
         aBR+PIfpXly1NUFqP/rSg5es16yp1optFCRrwuNYnGJk9BrBHvCEHd/j5eYGnv5wB9h2
         PMuVd3mR+/qtfz5RzZHeoPlnVlhJ2NLcOP4Qup0aCjMmmuKQS5oc1eVQuL6f+CRogcV2
         0WGB6ZH3U8cwQ7TcEtyJyfu1h1OIIrMdBR1UVHsx2q5QZkI0rGV5UE8kIy4H/qVNWTK9
         5MwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lBt+cOXO4xTBLFqCQVCUOVZomNPsyxyO9m+vwA1+2CE=;
        b=F23ezuClZD7y1GhuKGuMjoKZ0u3UORkPRp/7kwXKOnc9jW3fibzS6Rp51SO+nI43im
         fLleYESDjcrSKNHu+5ceoc7jf5kf1gL1wSllSF+FcLxzZ11MvMzy9sn6ZjvahPl9ojyn
         VE4zKg88fRVezkttiLDm7cilHb6LqNbhdcTj++zLeDtnNeBgXsxGybmKonrfSvq/e+dh
         HKRasfLQuh+37n34gd1rYE3XI70vSLYOstd0AgzEr7bf4C5mp4soObsbhHUNeD39XVbQ
         Q9sazzyHUh6NPo9QY0yeeAoyocpnTwPGzGiCL0hZ0ve6+tI5EXdZdJhOzl4RzBjS/LBR
         eixQ==
X-Gm-Message-State: AGi0PuYuIwNKkM5qnZ0dwCswH9ahL67j2OdarxS0UGdkP1ndlB1rXCmh
        P9AZE6HmMMz2+KnTmWYNpEGSHzF+
X-Google-Smtp-Source: APiQypKqorVHPkxT+VVPso3W4z+IiO5qcWtKD7Lf/Sszg+Ii8BIUaP0ql69mejNxXOZA3mCz1jHFGA==
X-Received: by 2002:a1c:2289:: with SMTP id i131mr9036439wmi.111.1589052220776;
        Sat, 09 May 2020 12:23:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u74sm19225585wmu.13.2020.05.09.12.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 12:23:40 -0700 (PDT)
Message-Id: <pull.625.v3.git.1589052219528.gitgitgadget@gmail.com>
In-Reply-To: <pull.625.v2.git.1588717980225.gitgitgadget@gmail.com>
References: <pull.625.v2.git.1588717980225.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 09 May 2020 19:23:39 +0000
Subject: [PATCH v3] rebase --autosquash: fix a potential segfault
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul Ganssle <paul@ganssle.io>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When rearranging the todo list so that the fixups/squashes are reordered
just after the commits they intend to fix up, we use two arrays to
maintain that list: `next` and `tail`.

The idea is that `next[i]`, if set to a non-negative value, contains the
index of the item that should be rearranged just after the `i`th item.

To avoid having to walk the entire `next` chain when appending another
fixup/squash, we also store the end of the `next` chain in `tail[i]`.

The logic we currently use to update these array items is based on the
assumption that given a fixup/squash item at index `i`, we just found
the index `i2` indicating the first item in that fixup chain.

However, as reported by Paul Ganssle, that need not be true: the special
form `fixup! <commit-hash>` is allowed to point to _another_ fixup
commit in the middle of the fixup chain.

Example:

	* 0192a To fixup
	* 02f12 fixup! To fixup
	* 03763 fixup! To fixup
	* 04ecb fixup! 02f12

Note how the fourth commit targets the second commit, which is already a
fixup that targets the first commit.

Previously, we would update `next` and `tail` under our assumption that
every `fixup!` commit would find the start of the `fixup!`/`squash!`
chain. This would lead to a segmentation fault because we would actually
end up with a `next[i]` pointing to a `fixup!` but the corresponding
`tail[i]` pointing nowhere, which would the lead to a segmentation
fault.

Let's fix this by _inserting_, rather than _appending_, the item. In
other words, if we make a given line successor of another line, we do
not simply forget any previously set successor of the latter, but make
it a successor of the former.

In the above example, at the point when we insert 04ecb just after
02f12, 03763 would already be recorded as a successor of 04ecb, and we
now "squeeze in" 04ecb.

To complete the idea, we now no longer assume that `next[i]` pointing to
a line means that `last[i]` points to a line, too. Instead, we extend
the concept of `last` to cover also partial `fixup!`/`squash!` chains,
i.e. chains starting in the middle of a larger such chain.

In the above example, after processing all lines, `last[0]`
(corresponding to 0192a) would point to 03763, which indeed is the end
of the overall `fixup!` chain, and `last[1]` (corresponding to 02f12)
would point to 04ecb (which is the last `fixup!` targeting 02f12, but it
has 03763 as successor, i.e. it is not the end of overall `fixup!`
chain).

Reported-by: Paul Ganssle <paul@ganssle.io>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    rebase --autosquash: fix a potential segfault
    
    This patch is in response to 
    https://lore.kernel.org/git/017dbc40-8d21-00fb-7b0e-6708d2dcb366@ganssle.io/
    .
    
    Changes since v2:
    
     * Explained the fix more verbosely in the commit message.
    
    Changes since v1:
    
     * Fixed the order of two or more fixups-of-fixups (oddly enough, this
       simplified the patch...)
     * Extended the test to have two fixups-of-fixups, ensuring their order
       is preserved.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-625%2Fdscho%2Fautosquash-segfault-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-625/dscho/autosquash-segfault-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/625

Range-diff vs v2:

 1:  de029422324 ! 1:  c1c4607da0e rebase --autosquash: fix a potential segfault
     @@ Commit message
          Note how the fourth commit targets the second commit, which is already a
          fixup that targets the first commit.
      
     -    The good news is that it is easy to fix this: we use the correct
     -    condition (we now possibly set `tail[i2]` even for fixups in the middle)
     -    and we _also_ have to ensure that we _insert_ the item rather than
     -    _append_ it, i.e. we need to set `next[i2]` accordingly (it might still
     -    be set to `-1` if it was actually appended).
     +    Previously, we would update `next` and `tail` under our assumption that
     +    every `fixup!` commit would find the start of the `fixup!`/`squash!`
     +    chain. This would lead to a segmentation fault because we would actually
     +    end up with a `next[i]` pointing to a `fixup!` but the corresponding
     +    `tail[i]` pointing nowhere, which would the lead to a segmentation
     +    fault.
     +
     +    Let's fix this by _inserting_, rather than _appending_, the item. In
     +    other words, if we make a given line successor of another line, we do
     +    not simply forget any previously set successor of the latter, but make
     +    it a successor of the former.
     +
     +    In the above example, at the point when we insert 04ecb just after
     +    02f12, 03763 would already be recorded as a successor of 04ecb, and we
     +    now "squeeze in" 04ecb.
     +
     +    To complete the idea, we now no longer assume that `next[i]` pointing to
     +    a line means that `last[i]` points to a line, too. Instead, we extend
     +    the concept of `last` to cover also partial `fixup!`/`squash!` chains,
     +    i.e. chains starting in the middle of a larger such chain.
     +
     +    In the above example, after processing all lines, `last[0]`
     +    (corresponding to 0192a) would point to 03763, which indeed is the end
     +    of the overall `fixup!` chain, and `last[1]` (corresponding to 02f12)
     +    would point to 04ecb (which is the last `fixup!` targeting 02f12, but it
     +    has 03763 as successor, i.e. it is not the end of overall `fixup!`
     +    chain).
      
          Reported-by: Paul Ganssle <paul@ganssle.io>
          Helped-by: Jeff King <peff@peff.net>


 sequencer.c                  |  7 +++++--
 t/t3415-rebase-autosquash.sh | 16 ++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e528225e787..d579f6d6c06 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5264,10 +5264,13 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 			todo_list->items[i].command =
 				starts_with(subject, "fixup!") ?
 				TODO_FIXUP : TODO_SQUASH;
-			if (next[i2] < 0)
+			if (tail[i2] < 0) {
+				next[i] = next[i2];
 				next[i2] = i;
-			else
+			} else {
+				next[i] = next[tail[i2]];
 				next[tail[i2]] = i;
+			}
 			tail[i2] = i;
 		} else if (!hashmap_get_from_hash(&subject2item,
 						strhash(subject), subject)) {
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 093de9005b7..7bab6000dc7 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -424,4 +424,20 @@ test_expect_success 'abort last squash' '
 	! grep first actual
 '
 
+test_expect_success 'fixup a fixup' '
+	echo 0to-fixup >file0 &&
+	test_tick &&
+	git commit -m "to-fixup" file0 &&
+	test_tick &&
+	git commit --squash HEAD -m X --allow-empty &&
+	test_tick &&
+	git commit --squash HEAD^ -m Y --allow-empty &&
+	test_tick &&
+	git commit -m "squash! $(git rev-parse HEAD^)" -m Z --allow-empty &&
+	test_tick &&
+	git commit -m "squash! $(git rev-parse HEAD^^)" -m W --allow-empty &&
+	git rebase -ki --autosquash HEAD~5 &&
+	test XZWY = $(git show | tr -cd W-Z)
+'
+
 test_done

base-commit: af6b65d45ef179ed52087e80cb089f6b2349f4ec
-- 
gitgitgadget
