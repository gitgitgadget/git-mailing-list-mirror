Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC96C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 15:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 979D8206F9
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 15:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0OFgS4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389584AbgKXPHf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 10:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389084AbgKXPHf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 10:07:35 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41C1C0617A6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 07:07:34 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id r3so4363302wrt.2
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 07:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hXEJY3v6TTAJzFBcIm7ytbs9WZJxxSVV6Hw7lvdxUkE=;
        b=h0OFgS4g2N5TM92OTK3f2V8c0znNK18rM+UVtqTa6fbZabN8P+owDmCOnTZxNr4Sy5
         TnRLmk9GfqwvNdNWR2yYQbEeXI+8pBK3Mgz0PqVEWTl46y7wnnEkyLb5tC5Zw+frR4W3
         WIjfvwCFa8mYna2rfYup2R3zwKkqGoIruKYjtMRgF/kmptB8frYO72bDUbSiz7+M6cQT
         vkYLOcz9lNh9ZsS0FVt3m7Qte3Z7byB0zvgh3+oRjONly+pkq02vBcxSb1bLhrw37uUY
         6LNXJlK3LOchHH3ImXevMmfxIyVu1FJdeyiBLQ2rnn542DSSElJY8Z2FRx0/BBEle1dO
         H+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hXEJY3v6TTAJzFBcIm7ytbs9WZJxxSVV6Hw7lvdxUkE=;
        b=QCoXQ8WbFOKrxFxoAi7UCBYw+YKzjLpl0sqh37d3GMjhPXzrMTSYGusRQqE+wue4pp
         327GLlUMMOBJOzkuyB9uVc9EPiPwtT5Jj+1Zj4hTcQDn9SaI3T6n9bF6m8BO5yJcNeqw
         IA0kr3PFIXc3gyKR/xyKX4pvLQAq42vNEuhKE8UNuRIhySp2bDXyWqgdKXlaKqKY+yZf
         pOAl74xa/kLalHvNFY99dY5GZpoc5Shzaiz88UbTBqSKJfs2BNYxwOr0SOnB2UvvIwDh
         QkJF5i6gT5OQfImnNNaNDJ5ry0Uk/zydzVPhELzU0ayzH5NKHstLDbcCX8xU4JvZsfzx
         vJsQ==
X-Gm-Message-State: AOAM532M0gjw2eZroycIIf3uBn/ShVZn9UmZO/4SvbQmkniF6jc7fIWU
        e3MBzMqYuLEz1MAqf+zd8nd7TK2SE1Y=
X-Google-Smtp-Source: ABdhPJysGNmrNhdSX/w8Xmyw/edh7WnJ2znu5Ak3odAeKEJ8xvXfvnBagrQKPxGfqY3ayBPlj4Q8JA==
X-Received: by 2002:adf:ead1:: with SMTP id o17mr5953980wrn.396.1606230453349;
        Tue, 24 Nov 2020 07:07:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w11sm5734426wmg.36.2020.11.24.07.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 07:07:32 -0800 (PST)
Message-Id: <483e490349165223a80a0bdf7716c5189560c977.1606230450.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.921.v3.git.git.1606230450.gitgitgadget@gmail.com>
References: <pull.921.v2.git.git.1606173607.gitgitgadget@gmail.com>
        <pull.921.v3.git.git.1606230450.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Nov 2020 15:07:26 +0000
Subject: [PATCH v3 1/4] init: document `init.defaultBranch` better
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Our documentation does not mention any future plan to change 'master' to
other value. It is a good idea to document this, though.

Initial-patch-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-init.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 59ecda6c17..2b399cb73d 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -20,8 +20,9 @@ DESCRIPTION
 
 This command creates an empty Git repository - basically a `.git`
 directory with subdirectories for `objects`, `refs/heads`,
-`refs/tags`, and template files.  An initial `HEAD` file that
-references the HEAD of the master branch is also created.
+`refs/tags`, and template files.  An initial branch without any
+commits will be created (see the `--initial-branch` option below
+for its name).
 
 If the `$GIT_DIR` environment variable is set then it specifies a path
 to use instead of `./.git` for the base of the repository.
@@ -73,8 +74,10 @@ If this is reinitialization, the repository will be moved to the specified path.
 -b <branch-name>::
 --initial-branch=<branch-name>::
 
-Use the specified name for the initial branch in the newly created repository.
-If not specified, fall back to the default name: `master`.
+Use the specified name for the initial branch in the newly created
+repository.  If not specified, fall back to the default name (currently
+`master`, but that will be changed in the future; the name can be customized
+via the `init.defaultBranch` configuration variable).
 
 --shared[=(false|true|umask|group|all|world|everybody|0xxx)]::
 
-- 
gitgitgadget

