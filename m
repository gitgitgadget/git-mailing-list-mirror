Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED9BC56201
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64221208B3
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPYKoCvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgKKUdX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgKKUdX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 15:33:23 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F998C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:33:21 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id s13so3520961wmh.4
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hkFk8gjsfKjI+ZVV9MsX1EFli/O/Esfyfgt2m2FishE=;
        b=cPYKoCvyxQvqBARlnYQUepseMa6426/hOecRgBGjVFMNIbim9vrcp1MJJUM/OBozBD
         DlTIqStaXYueHnnM7LFVCjKmgdq08sZrwcafgOtdRZeOeltk5tK63k5XA4nRdeusjJaM
         cGLbniTT7kFNANSlXsCc2xPJWIxZUWSa+GWYXRvDmOuJWYjYAqpnDL+URi1B20wcOGDU
         bXwikRT/FDtMec0QxxJbVj9F5zMjyjNZzw4uoYa/Z+o3RKdQBV/pXRDlwjjB+ql+F/kU
         ArEOcADSJ4aVRNlzoYIYjkrbTM7du8iI6gEcJouF66sYRFAXZVGo07qxux++LH5WeTro
         mmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hkFk8gjsfKjI+ZVV9MsX1EFli/O/Esfyfgt2m2FishE=;
        b=hfXTnaTsPgqaCalJ5Sfnzg5/DFotXNv7oxfhCU39vxp4yv+1osPYczKVjttZjUviON
         zM06GGkVLi6zy54qJDjsoDtSu4jt3eH3Ykhx+xPuY3GlLmr0Nb1eDtT+WR0np5kxrPzL
         /JWvrKsgrfV3pdMIylGY01KmYOTsh8GgbxhANqhJvDEBgwPx5CCs9XPvXcBjIZmR4KS+
         EYanOSNrRAD18tuV1J6z3YR9sPNXP+FFdYlTF9oNx7czSbPbWd/bRvzVrkDo9ZGLbp6N
         +Zq3U5ePs9Bh1Vq97J6k1OhWnAsG5CHTwPf6k3YZtir3yha3Gs0DZFABHvENxQdt+TVD
         54dQ==
X-Gm-Message-State: AOAM530EJka3s4vbcQBW29Y+O8kc0yJ7Tj7IglyKU6KocDgccgXbll9A
        4WpBnBk1f77N0cqFByGZ34oyVJ3sNe8=
X-Google-Smtp-Source: ABdhPJzlgmscDUpfS6shQhzGe2Xm86T7PjYexxUApkPVcmgXoYe2Y3EUUv+uw9M9NprI9iC5K2n1Ug==
X-Received: by 2002:a1c:9a12:: with SMTP id c18mr5924942wme.22.1605126799980;
        Wed, 11 Nov 2020 12:33:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm3883539wrp.21.2020.11.11.12.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:33:19 -0800 (PST)
Message-Id: <0e2b11ae9851525d24e5f4e2bb0919bf4f0fd788.1605126798.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.787.git.1605126798.gitgitgadget@gmail.com>
References: <pull.787.git.1605126798.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Nov 2020 20:33:17 +0000
Subject: [PATCH 1/2] mergetools/bc: add `bc4` to the alias list for Beyond
 Compare
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pudinha <rogi@skylittlesystem.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As of 83bbf9b92ea8 (mergetool--lib: improve support for vimdiff-style
tool variants, 2020-07-29), we already list `bc` and `bc3` as aliases
for that mergetool/difftool.

However, the current Beyond Compare version is _4_, therefore the `bc4`
alias is missing from that list.

Most notably, this is the root cause of the breakage reported in
https://github.com/git-for-windows/git/issues/2893 where a
well-configured `bc4` difftool stopped working as of v2.29.0:
`setup_tool` would notice that after stripping off the trailing digit,
it finds a match in `mergetools/` (the `bc` file), source it, and then
the alias would not match the list offered by the `list_tool_variants`
function, and simply exit without doing anything, but pretending
success.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 mergetools/bc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mergetools/bc b/mergetools/bc
index a89086ee72..26c19d46a5 100644
--- a/mergetools/bc
+++ b/mergetools/bc
@@ -25,4 +25,5 @@ translate_merge_tool_path() {
 list_tool_variants () {
 	echo bc
 	echo bc3
+	echo bc4
 }
-- 
gitgitgadget

