Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD842C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 10:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiBVKe0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 05:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiBVKeP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 05:34:15 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABED15B987
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 02:33:41 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id i19so11214451wmq.5
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 02:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Xzk0xmEKSAdmCSIsuzUq0UlsuJy+OTJY8EWkH7wcDfA=;
        b=URh94cyOM0XRi+jzk4N/Lx9zSc5d2jma4gVxGFABGHRTB2AS0cnprL8bhqWQsPOdik
         438PmWrN3RK3cPee1TdUrTffw91Ad2TbxJ1Psn0F0wsaVnvtPTsS7sZcuF/igaiFPxDf
         PhwNKQdp8+5GxiOyKAm9fyVBGopW1DDZM6mEEH3e6DlD3anNWLdciakXZTLdMfuploNh
         GTTreEXlDCOB1e7utXJqVyiH0b5sN1R2qjGf6ML/g0LtjJsCVKr2IDbz2D9MjHa/k7Gf
         QT8EpxjYY9HnYF0Y4WxuHKvLCzhF9TAO+C6TwvHSVBVPrxkFks/W15F/7VJq7qq2xdzD
         zNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Xzk0xmEKSAdmCSIsuzUq0UlsuJy+OTJY8EWkH7wcDfA=;
        b=etGDc/tsrH7pK9wHC3+FTO7e7rt0V6oaSzt5T+1iFIwF1rpq9MP//u8M9lFc6h4vcR
         pJTMLx3R1+14c8vkqMzSEtGWXwCL84WXSa/NIOi7KDhYkEVHBhuFUbQbj9/gJYQ6U/dx
         AGEyHvj75SOmRPEOkqAkI0krXe5VjmhpySIO32aHPEXQXb5kFbwdDvmfmntM4LgcRfSt
         zV/ZU5qCFjf3Ea14v0xmghcsWoHsYHjeZsSFTNVrRfQqGADOKq8wuIPHqWDLMD41l0mI
         ekPZ0IIh1xEkuA/Wb+HLL8YI6fsyINVlTAtdkNwCmydaeloBI5kmgxVl4W6nPU5Y1igq
         nCiQ==
X-Gm-Message-State: AOAM530DhRJngppypOVmb5BIDZYqD7cLswoEa+qy7XEgJrdozQbSPA/t
        R9CdcbZxXUFJYx0VHQk7nnB7L9sc7Lw=
X-Google-Smtp-Source: ABdhPJyworvv83Jw87YNYF4Ho4wr42IvnPfWfXX5MvdjSXGrPKI8XcyQXaQ6i/fTXPixWFzy0i2/eg==
X-Received: by 2002:a05:600c:6c5:b0:380:dda2:d562 with SMTP id b5-20020a05600c06c500b00380dda2d562mr1218289wmn.138.1645526019209;
        Tue, 22 Feb 2022 02:33:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z17sm1988382wmf.11.2022.02.22.02.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 02:33:38 -0800 (PST)
Message-Id: <cd06aa68c2fc65551cd810a1c2c0941c51433163.1645526016.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1155.git.1645526016.gitgitgadget@gmail.com>
References: <pull.1155.git.1645526016.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 10:33:35 +0000
Subject: [PATCH 1/2] rebase: help user when dying with preserve-merges`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.email>

Git will die if a "rebase --preserve-merges" is in progress.
Users cannot --quit, --abort or --continue the rebase.

This sceario can occur if the user updates their Git, or switches
to another newer version, after starting a preserve-merges rebase,
commonly via the pull setting.

One trigger is an unexpectedly difficult to resolve conflict, as
reported on the `git-users` group.
(https://groups.google.com/g/git-for-windows/c/3jMWbBlXXHM)

Tell the user the cause, i.e. the existence of the directory.
The problem must be resolved manually, `git rebase --<option>`
commands will die, or the user must downgrade. Also, note that
the deleted options are no longer shown in the documentation.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index d858add3fe8..07221d0ae41 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1181,7 +1181,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "%s/rewritten", merge_dir());
 		if (is_directory(buf.buf)) {
-			die("`rebase -p` is no longer supported");
+			die("`rebase --preserve-merges` (-p) is no longer supported.\n"
+			"You still have a `.git/rebase-merge/rewritten` directory, \n"
+			"indicating a `rebase preserve-merge` is still in progress.\n");
 		} else {
 			strbuf_reset(&buf);
 			strbuf_addf(&buf, "%s/interactive", merge_dir());
-- 
gitgitgadget

