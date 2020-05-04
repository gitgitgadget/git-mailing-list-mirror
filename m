Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF57C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 20:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78AEF206C0
	for <git@archiver.kernel.org>; Mon,  4 May 2020 20:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFAeEt+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgEDUkI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 16:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgEDUkH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 16:40:07 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F81EC061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 13:40:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s8so81086wrt.9
        for <git@vger.kernel.org>; Mon, 04 May 2020 13:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=OUAlH5xox6sVl8klla8Z9Rbzqc0UadSQ3qm2evNsoAI=;
        b=GFAeEt+wRHsv84oU9vdv2jSs76HBxUs1fxo6iovz3ymSbAPkKs+2k+TmN/Qr/zJ9Cw
         w5w0YDI9ZpuXxJmbXxmpv/f6mE4g3oNLg1+2b+OCirneSVxCQakF0LBvdWprid/HLy6v
         UOzLTloLwPsQ58AqdN7ZiHVJGEEIrcBl2ZJfTEU4FhkxzDiDoOMVrGB5FGn9ikWlpZek
         cW7kBIogIHguk6zr2zabaexbGPyXf4cYD229owhS8F8NjxkFKwXybCvIvz/M3x1pWP9T
         0mucMmFHab+3w399PeHRMo+StxoZ6vKUWvV/XtNKmFAfvmI9a9F2tVDR04NGk9d2M9re
         UECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OUAlH5xox6sVl8klla8Z9Rbzqc0UadSQ3qm2evNsoAI=;
        b=BU307/iHtMVKIKpWwNA5hEtw3gt/3+0x1fDOnZHlLGd3SAzbZ4iavtuPPUyP1iTVpv
         uAnLLEH2V1mANsR1ZPaEnQVR12Hd1CTN2TD8FKIUK1lE7/o0eUQfy85gCKNtg+fwFZDD
         GhTu3+evwncIkAoE1oANpW/GIYFA54Czz4KWQajQ5r3L1kgcrli4hmytzZVGlURaJVSf
         IhttH0jvtjU1WAaLNBmFk+zrcMUH7ZqieNlYCxSmS2Mv8MD6H/uwmphltdhujG79An+v
         5DCocvXPEZv5kQda1RUqhzEs30eHxldJZVsjhIwSUppOJW/OvPnU5L6v9pAdy/3DmXVf
         JYRw==
X-Gm-Message-State: AGi0PublSFGrwogqvMPWWQOeSBFTDXDGQyz3bacMUGdpywFlImLyMJne
        TNVJjbRN9otWnU0cHgZeTBTd5ERk
X-Google-Smtp-Source: APiQypKwhtrGTjCN0ffrnA4OW0WPz1NAz5h0UtcfXVCsmrKtIb853h0z893C3pyI7fn+ROKQPxVKWg==
X-Received: by 2002:adf:dc0f:: with SMTP id t15mr1119004wri.165.1588624805548;
        Mon, 04 May 2020 13:40:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t2sm186475wmt.15.2020.05.04.13.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 13:40:05 -0700 (PDT)
Message-Id: <pull.625.git.1588624804554.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 May 2020 20:40:04 +0000
Subject: [PATCH] rebase --autosquash: fix a potential segfault
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul Ganssle <paul@ganssle.io>, Jeff King <peff@peff.net>,
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
fixup/squash, we also store the end of the `next` chain in `last[i]`.

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

The good news is that it is easy to fix this: we can detect the
situation by looking at `last[i2]` (which will be `-1` if `i2` is
actually in the middle of a fixup chain), and in that case we simply
need to squeeze the current item into the middle of the `next` chain,
without touching `last` (i.e. leaving the end index of the fixup chain
alone).

Reported-by: Paul Ganssle <paul@ganssle.io>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    rebase --autosquash: fix a potential segfault
    
    This patch is in response to 
    https://lore.kernel.org/git/017dbc40-8d21-00fb-7b0e-6708d2dcb366@ganssle.io/
    .

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-625%2Fdscho%2Fautosquash-segfault-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-625/dscho/autosquash-segfault-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/625

 sequencer.c                  | 11 ++++++++++-
 t/t3415-rebase-autosquash.sh | 14 ++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index e528225e787..0d4d53d2a49 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5266,8 +5266,17 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 				TODO_FIXUP : TODO_SQUASH;
 			if (next[i2] < 0)
 				next[i2] = i;
-			else
+			else if (tail[i2] >= 0)
 				next[tail[i2]] = i;
+			else {
+				/*
+				 * i2 refers to a fixup commit in the middle of
+				 * a fixup chain
+				 */
+				next[i] = next[i2];
+				next[i2] = i;
+				continue;
+			}
 			tail[i2] = i;
 		} else if (!hashmap_get_from_hash(&subject2item,
 						strhash(subject), subject)) {
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 093de9005b7..ca135349346 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -424,4 +424,18 @@ test_expect_success 'abort last squash' '
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
+	git rebase -ki --autosquash HEAD~4 &&
+	test XZY = $(git show | tr -cd X-Z)
+'
+
 test_done

base-commit: af6b65d45ef179ed52087e80cb089f6b2349f4ec
-- 
gitgitgadget
