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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4219C433DB
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 04:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79F4722DA9
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 04:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbhAQEDF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 23:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbhAQEDA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 23:03:00 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3BDC061574
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 20:02:19 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m4so13188185wrx.9
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 20:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EZBvCxFr999zNNlHhfHCMJ9xkTJeDy390B9jpXnd3HY=;
        b=f0HYV13sJeDnfu9B2NtyIcnImw5nRtpp7RBZAfxT/Hv3luzaE30pNnes1ALxBIuUKC
         822XJ1o8qDkfu/xzVD5U6tZA+oQgM8QgqRg9YaNH9BnDtkPSftAbulWC/0YRDhCNwahm
         TwHq0kCTiObjznDOhIYCpCcf9iuKEc/wUfF7ZZ3swnfMdsfMUEI9grkPfSZpNZpfTc6s
         o3cEMXFW3Bg+U67VvNcxQ3rpcZWZZnJzMY55hjmy7or+I1llLyjsyfRKDnP02jjhKrr6
         mJAbESve3dPsJ1WF/MJmV8tT4TfL/zDCJwmWIg9TQJLHCZZYYbJE8UuAMsfu6yBJ8Jxw
         Hj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EZBvCxFr999zNNlHhfHCMJ9xkTJeDy390B9jpXnd3HY=;
        b=EFwF+icmeUJsZ57t6dkDEdlwLN1rSF1No6t10yY6SX9NpLbYn9eNdd9cwxs9h1mh+k
         Jd7ZYDi+wh5LiWfjV7jOKyb2GO6+DYvUEF/HFn1wFBlca7wr1gkGTNBf11I3p2T6grjH
         HeOMJuLVfZA3ool91dZSog0rL65Iqgs7PaR41lBfKplIz900wbDGElj54SqG4PZv5fhc
         GnhLod0iLdyKH1FIRDzp9ns2KtxRDk4i5ExJ9KXjhRgMlRX0QfDb7f7J0uJBTerHKtA9
         GUpFeyoZAerTxk9JUD7lctiJoQ/HfbDNf8KNxWoZe54hFbqsTZJBWRsar2WWonEG+Ogm
         Rh/A==
X-Gm-Message-State: AOAM530RLlUq2YDkGdxz9h2I7CoXYLe2PpgJstWehInrkkvmskUoSjcU
        0QOV2803bGNiYYUimwVkdqr26+tbcpc=
X-Google-Smtp-Source: ABdhPJxylRWfizqOC6r8AfprsxxU294yc5jUAfnwzywsMSKJ/OR449bjgSVyRCt9hA1gBZYrwfngdA==
X-Received: by 2002:adf:dc10:: with SMTP id t16mr20537038wri.345.1610856138310;
        Sat, 16 Jan 2021 20:02:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16sm18839731wmi.3.2021.01.16.20.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 20:02:17 -0800 (PST)
Message-Id: <f4d9af8a3124bcd37a35b1863441406f6d939f11.1610856136.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.832.v4.git.1610856136.gitgitgadget@gmail.com>
References: <pull.832.v3.git.1610626942677.gitgitgadget@gmail.com>
        <pull.832.v4.git.1610856136.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 17 Jan 2021 04:02:14 +0000
Subject: [PATCH v4 1/3] ls_files.c: bugfix for --deleted and --modified
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=E8=83=A1=E5=93=B2=E5=AE=81?= <adlternative@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

This situation may occur in the original code: lstat() failed
but we use `&st` to feed ie_modified() later.

It's buggy!

Therefore, we can directly execute show_ce without the judgment of
ie_modified() when lstat() has failed.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/ls-files.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index c8eae899b82..6f97a23c2dc 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -347,9 +347,12 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 			if (ce_skip_worktree(ce))
 				continue;
 			err = lstat(fullname.buf, &st);
-			if (show_deleted && err)
-				show_ce(repo, dir, ce, fullname.buf, tag_removed);
-			if (show_modified && ie_modified(repo->index, ce, &st, 0))
+			if (err) {
+					if (show_deleted)
+						show_ce(repo, dir, ce, fullname.buf, tag_removed);
+					if (show_modified)
+						show_ce(repo, dir, ce, fullname.buf, tag_modified);
+			}else if (show_modified && ie_modified(repo->index, ce, &st, 0))
 				show_ce(repo, dir, ce, fullname.buf, tag_modified);
 		}
 	}
-- 
gitgitgadget

