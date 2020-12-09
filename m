Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF64BC4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A4172337F
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388070AbgLITvP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 14:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387866AbgLITm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 14:42:56 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D15C061257
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 11:41:41 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id g25so1493918wmh.1
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 11:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7l9C4hKG0uP1LLJpc/apFcMTDSU1D6v9u9ZiVBlN6VY=;
        b=a66RTLgt/br72WCjaxcDz41cWMXvtZkpy30m4pONFYiWjqfdgY+qpUQRyF4c5aiaA5
         Jc0kvghUVSVKlWSUADlowGApFdD7joVJXTTSL9QS3XC5uJNb9V6PLHxWQ94JuxrE9MOW
         7c/jD0v0IcKmOjZ47GUFJYAc/cbAWbI/auotqLa7Y/5oz+MjQ2CKgYXP1g33I4g2Anqz
         dBHhAugm94/rvLbWjztnJ1HboPLHZLJQjlkQVzc+yxFFKOkNdULnGWom7PmfJ9V/ABU2
         j2LPzOdJcsi9PAlXbS9Gj8hjOWqIJZ9HvDAjMVmoFwubh7uWmg7uK38Giu+vjSpNyz9Q
         3TbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7l9C4hKG0uP1LLJpc/apFcMTDSU1D6v9u9ZiVBlN6VY=;
        b=jJMy2zQmJUO8KSqVsSl/wH/ve4o5/N52W0XywxbssUVPRj0fl/jyJ8OlmAVLpJxsWA
         SxSRcRtq415O1WgIgFtmmm0xJVZ6xQof6/y/Qkmt4UYyZVwA5nvqeUaW0/1EgHL+Tjus
         lgQC8u/vpFjq9y46LtA2fH3RyZV35BtmmgumQaq+ad4hKzGBgZKWLLGC5zoBHB4rwzDW
         DeiJQTQUdspFxcPzsSVE3TZHMPXtslpa2FnXoiXtf/c7AiWq5W8AM2w7SLds8zdwjHJx
         NPFXBx7nW/mny+Y9r77eeN2fwLKUBIUyRdLpiGDUmrD0E0/So0hyREdA+k6TOKfuM3gz
         RAVg==
X-Gm-Message-State: AOAM531dcAdZZqqADKgTfNOeuhhte9npBsUywrEuZfvh7l9MgZI7m/RY
        htbVSYczdRmcgVbjOFsA6Xg1O6oADjY=
X-Google-Smtp-Source: ABdhPJyAw7YXS2uWrkD8Q6SEeZJhaNwi6YIuhWka9ZrjuEBhRPuLe1IYiQrTfxElKSsZ43g29uebPA==
X-Received: by 2002:a1c:55ca:: with SMTP id j193mr4459299wmb.87.1607542899978;
        Wed, 09 Dec 2020 11:41:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm5179379wrn.83.2020.12.09.11.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 11:41:39 -0800 (PST)
Message-Id: <476553e2b2049452db0b453150ecab40d011ab0d.1607542887.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.git.1607542887.gitgitgadget@gmail.com>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 19:41:27 +0000
Subject: [PATCH 11/11] merge-ort: add implementation of type-changed rename
 handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Implement cases where renames are involved in type changes (i.e. the
side of history that didn't rename the file changed its type from a
regular file to a symlink or submodule).  There was some code to handle
this in merge-recursive but only in the special case when the renamed
file had no content changes.  The code here works differently -- it
knows process_entry() can handle mode conflicts, so it does a few
minimal tweaks to ensure process_entry() can just finish the job as
needed.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index f2e4edf6506..64b23c8aa2a 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -752,7 +752,32 @@ static int process_renames(struct merge_options *opt,
 			 S_ISREG(newinfo->stages[target_index].mode));
 		if (type_changed && collision) {
 			/* special handling so later blocks can handle this */
-			die("Not yet implemented");
+			/*
+			 * if type_changed && collision are both true, then this
+			 * was really a double rename, but one side wasn't
+			 * detected due to lack of break detection.  I.e.
+			 * something like
+			 *    orig: has normal file 'foo'
+			 *    side1: renames 'foo' to 'bar', adds 'foo' symlink
+			 *    side2: renames 'foo' to 'bar'
+			 * In this case, the foo->bar rename on side1 won't be
+			 * detected because the new symlink named 'foo' is
+			 * there and we don't do break detection.  But we detect
+			 * this here because we don't want to merge the content
+			 * of the foo symlink with the foo->bar file, so we
+			 * have some logic to handle this special case.  The
+			 * easiest way to do that is make 'bar' on side1 not
+			 * be considered a colliding file but the other part
+			 * of a normal rename.  If the file is very different,
+			 * well we're going to get content merge conflicts
+			 * anyway so it doesn't hurt.  And if the colliding
+			 * file also has a different type, that'll be handled
+			 * by the content merge logic in process_entry() too.
+			 *
+			 * See also t6430, 'rename vs. rename/symlink'
+			 */
+			collision = 0;
+		}
 		if (source_deleted) {
 			if (target_index == 1) {
 				rename_branch = opt->branch1;
@@ -832,7 +857,11 @@ static int process_renames(struct merge_options *opt,
 			newinfo->pathnames[0] = oldpath;
 			if (type_changed) {
 				/* rename vs. typechange */
-				die("Not yet implemented");
+				/* Mark the original as resolved by removal */
+				memcpy(&oldinfo->stages[0].oid, &null_oid,
+				       sizeof(oldinfo->stages[0].oid));
+				oldinfo->stages[0].mode = 0;
+				oldinfo->filemask &= 0x06;
 			} else if (source_deleted) {
 				/* rename/delete */
 				newinfo->path_conflict = 1;
-- 
gitgitgadget
