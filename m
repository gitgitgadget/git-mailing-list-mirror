Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E33C47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 22:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E34F9206FA
	for <git@archiver.kernel.org>; Tue,  5 May 2020 22:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYeAuqAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbgEEWdD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 18:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgEEWdD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 18:33:03 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0DFC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 15:33:03 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id h4so329140wmb.4
        for <git@vger.kernel.org>; Tue, 05 May 2020 15:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/OUXGUOduu2OKR/HpVBYDsM31P+0wsZ6rbjEyKsY8tM=;
        b=iYeAuqAkOR/AT2sReu+vwnR4KMhk6Ntv/ZxBckN+truROrdtH1adL255A+IlCKB5or
         EZHcp15/dd0jLWbXbcdrK8IZZgyYNG06DCqJ//HOxH4Feaae2ar1BDRd/mOj14iHwttP
         07SICmts2oweh385LjbnIdGz4aeNjdCq5xNhG125ASyA5JBjpcHfXi3WNLqc0YtpKJUJ
         mTTsRzVyXjKaQ59HGKjey6AWKr2kW7ob/oFIqxOnrkxOi1JgU0NuPpaj9ga5iWpeb05o
         d2x0etoEgtPAfo4gnO0h9eNNOgWFzf2Qe3AwVZWzKviSmzfr3y0Cn8ubfnNBCyr9RD9T
         beFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/OUXGUOduu2OKR/HpVBYDsM31P+0wsZ6rbjEyKsY8tM=;
        b=FNsFWwnfcJwHK4NZF2SNx7JjLi8EHLyl1evq4I6/max0l9JMqznR4Z3VG8+KS6EPHy
         jeiH8BTO8rDffQEh7E8ir+9DNQGkJKhsQxjo/4cR0e0iCmCQWfW/pmLPqgQEkEKbZU9E
         rdvO/jqwuUwW295sBBr5MG4SMzZEpsHG0GJcQrM2fgCORyPFoekuMmrBGl5wz31N0hzZ
         ZUaJ+QBiXWO5L+NXUuNQsLOUHVAId7CziyBis/17cWiVThG8gMz17p5IGKqaad4Omfaz
         se1i5cnHyIYaj81hAvHaQUC0Go1L9cef8td+0sxjXz/ZQFIQ4sbYXeD3UkBGR1nVlO7N
         Tv0Q==
X-Gm-Message-State: AGi0PuZWASfW47lbh0kfKxD3BHQypDn0UkTJWQOMTenKkszdmtOpnjDW
        K4BX/CHQmdszOMUyZ3LWRtzZMP3q
X-Google-Smtp-Source: APiQypISt8elrW865BiVs0Ez8jvgOixECi2WE4Iaq7hN8IpRHmOCoF4km+lAsZ+TEByN9vf587PvPA==
X-Received: by 2002:a1c:6a0b:: with SMTP id f11mr798905wmc.123.1588717981485;
        Tue, 05 May 2020 15:33:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8sm5592656wrg.85.2020.05.05.15.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 15:33:00 -0700 (PDT)
Message-Id: <pull.625.v2.git.1588717980225.gitgitgadget@gmail.com>
In-Reply-To: <pull.625.git.1588624804554.gitgitgadget@gmail.com>
References: <pull.625.git.1588624804554.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 May 2020 22:33:00 +0000
Subject: [PATCH v2] rebase --autosquash: fix a potential segfault
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

The good news is that it is easy to fix this: we use the correct
condition (we now possibly set `tail[i2]` even for fixups in the middle)
and we _also_ have to ensure that we _insert_ the item rather than
_append_ it, i.e. we need to set `next[i2]` accordingly (it might still
be set to `-1` if it was actually appended).

Reported-by: Paul Ganssle <paul@ganssle.io>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    rebase --autosquash: fix a potential segfault
    
    This patch is in response to 
    https://lore.kernel.org/git/017dbc40-8d21-00fb-7b0e-6708d2dcb366@ganssle.io/
    .
    
    Changes since v1:
    
     * Fixed the order of two or more fixups-of-fixups (oddly enough, this
       simplified the patch...)
     * Extended the test to have two fixups-of-fixups, ensuring their order
       is preserved.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-625%2Fdscho%2Fautosquash-segfault-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-625/dscho/autosquash-segfault-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/625

Range-diff vs v1:

 1:  bb820acc342 ! 1:  de029422324 rebase --autosquash: fix a potential segfault
     @@ Commit message
          index of the item that should be rearranged just after the `i`th item.
      
          To avoid having to walk the entire `next` chain when appending another
     -    fixup/squash, we also store the end of the `next` chain in `last[i]`.
     +    fixup/squash, we also store the end of the `next` chain in `tail[i]`.
      
          The logic we currently use to update these array items is based on the
          assumption that given a fixup/squash item at index `i`, we just found
     @@ Commit message
          Note how the fourth commit targets the second commit, which is already a
          fixup that targets the first commit.
      
     -    The good news is that it is easy to fix this: we can detect the
     -    situation by looking at `last[i2]` (which will be `-1` if `i2` is
     -    actually in the middle of a fixup chain), and in that case we simply
     -    need to squeeze the current item into the middle of the `next` chain,
     -    without touching `last` (i.e. leaving the end index of the fixup chain
     -    alone).
     +    The good news is that it is easy to fix this: we use the correct
     +    condition (we now possibly set `tail[i2]` even for fixups in the middle)
     +    and we _also_ have to ensure that we _insert_ the item rather than
     +    _append_ it, i.e. we need to set `next[i2]` accordingly (it might still
     +    be set to `-1` if it was actually appended).
      
          Reported-by: Paul Ganssle <paul@ganssle.io>
          Helped-by: Jeff King <peff@peff.net>
     @@ Commit message
      
       ## sequencer.c ##
      @@ sequencer.c: int todo_list_rearrange_squash(struct todo_list *todo_list)
     + 			todo_list->items[i].command =
     + 				starts_with(subject, "fixup!") ?
       				TODO_FIXUP : TODO_SQUASH;
     - 			if (next[i2] < 0)
     +-			if (next[i2] < 0)
     ++			if (tail[i2] < 0) {
     ++				next[i] = next[i2];
       				next[i2] = i;
      -			else
     -+			else if (tail[i2] >= 0)
     ++			} else {
     ++				next[i] = next[tail[i2]];
       				next[tail[i2]] = i;
     -+			else {
     -+				/*
     -+				 * i2 refers to a fixup commit in the middle of
     -+				 * a fixup chain
     -+				 */
     -+				next[i] = next[i2];
     -+				next[i2] = i;
     -+				continue;
      +			}
       			tail[i2] = i;
       		} else if (!hashmap_get_from_hash(&subject2item,
     @@ t/t3415-rebase-autosquash.sh: test_expect_success 'abort last squash' '
      +	git commit --squash HEAD^ -m Y --allow-empty &&
      +	test_tick &&
      +	git commit -m "squash! $(git rev-parse HEAD^)" -m Z --allow-empty &&
     -+	git rebase -ki --autosquash HEAD~4 &&
     -+	test XZY = $(git show | tr -cd X-Z)
     ++	test_tick &&
     ++	git commit -m "squash! $(git rev-parse HEAD^^)" -m W --allow-empty &&
     ++	git rebase -ki --autosquash HEAD~5 &&
     ++	test XZWY = $(git show | tr -cd W-Z)
      +'
      +
       test_done


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
