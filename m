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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F89C433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 06:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D653422DFB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 06:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbhASGcm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 01:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbhASGba (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 01:31:30 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07937C061575
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 22:30:50 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c124so15442632wma.5
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 22:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9ks/tMFgioqWYiNtvIqTVePT2QML9Zyuv1jcS2jlLnA=;
        b=sL+IAhH3tlEvmVSbVFvD49yu7GY6pW82DwI2aE2G2L627CjYyWZ7tdi7XgXbVfqIVu
         SgT1IkK2zY9/h9mTEBVmKX6uIfVcuZvzjftiDVF7v9Ro8hNmzMcddwHkuicOgD95V1i7
         MUCdQJJHNWsZtaqb3YzlNSc3GQWLwkjYlhVTvgZ2w7TwAs5MbHWkGDdXd835RQ5DQgTp
         kjGUgQG1uuevDsBE3/fmpsVP5o0JV2jlqJcoiRqci/iCI3J6J1JrU8t2CjJ8E55W1Yy1
         k7rjw+jCf6aImZil12IQG9vRTkMS+VlP2jBE2+Y4igrEF80XvhhUsq5FVuJBYEQMqBMG
         c/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9ks/tMFgioqWYiNtvIqTVePT2QML9Zyuv1jcS2jlLnA=;
        b=A7PgYLd2dk8lLm4DOJAGx0VpTtbSqDJHg1iVJUr2g10ofjx/sKQQqgaV36WDa2NQZ2
         ipYiwMfxhJekmdF4yhQ2tAPpAMek0bgRpFtqMeVXB6BL1vI7zad/nwlxiPKN5MK0BXx5
         M1HPJRcHQLefESyL+DYz2w2ad8fuM/Oz6iRhgXHlDrv5ZJyZNEAYg8NSmWn0NCUkt3Es
         ImKr58UEegGzn1hMX0/t3XeigDNZbzIJm9DcI5qWMe6AteG3QI1iPMNTaAzLxaZEA8yZ
         ru6ijP6le/X6DNufifcUYzZzLJR1747qHDrznV+0jTWwzO8os+YVfb9WKr7SpCynIfD/
         5elQ==
X-Gm-Message-State: AOAM531Ek8erR61BU61PqBfO5Kf+dIio4162RyK8nm2rjry8WRIqehtu
        NaLVjVqQoB+++3mRUiO13vgT+MGD7/Q=
X-Google-Smtp-Source: ABdhPJyxkAEZtDpPamE/NPJpsR0AmJ8LZ3Bt3tXM6bZEnCPqOI5CRByowAW84oAT1ozN0rNYlVcS4A==
X-Received: by 2002:a1c:4e:: with SMTP id 75mr2529949wma.150.1611037848565;
        Mon, 18 Jan 2021 22:30:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n9sm33478831wrq.41.2021.01.18.22.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 22:30:47 -0800 (PST)
Message-Id: <ec9464f6094f111bc7b6dc1dc07ecc9997d366d4.1611037846.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.832.v5.git.1611037846.gitgitgadget@gmail.com>
References: <pull.832.v4.git.1610856136.gitgitgadget@gmail.com>
        <pull.832.v5.git.1611037846.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jan 2021 06:30:44 +0000
Subject: [PATCH v5 1/3] ls_files.c: bugfix for --deleted and --modified
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

Therefore, we can directly execute show_ce without the judgment of
ie_modified() when lstat() has failed.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/ls-files.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index c8eae899b82..f1617260064 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -347,9 +347,14 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 			if (ce_skip_worktree(ce))
 				continue;
 			err = lstat(fullname.buf, &st);
-			if (show_deleted && err)
-				show_ce(repo, dir, ce, fullname.buf, tag_removed);
-			if (show_modified && ie_modified(repo->index, ce, &st, 0))
+			if (err) {
+				if (errno != ENOENT && errno != ENOTDIR)
+				    error_errno("cannot lstat '%s'", fullname.buf);
+				if (show_deleted)
+					show_ce(repo, dir, ce, fullname.buf, tag_removed);
+				if (show_modified)
+					show_ce(repo, dir, ce, fullname.buf, tag_modified);
+			} else if (show_modified && ie_modified(repo->index, ce, &st, 0))
 				show_ce(repo, dir, ce, fullname.buf, tag_modified);
 		}
 	}
-- 
gitgitgadget

