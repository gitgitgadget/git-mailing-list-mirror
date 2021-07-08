Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE95C07E9E
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 15:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D92AC61621
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 15:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbhGHPxk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 11:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbhGHPx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 11:53:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A319C061574
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 08:50:47 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d2so8175001wrn.0
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 08:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QZenG9y0QmFOmVqL2EUVba74mzw/GgCevkmWTft1JFs=;
        b=Jb0QtvXFGGJ86fVnPZ0yqg6a/Dk6ynR3WIETqXmUPZnZt5ajzoKGQqAH8xQ0KZL898
         VstXSPMMz1Fae2Aez/bEXHEORKINyi7ArwJKkGsnBNsxmPzejjw2d07jcVI7+i1j1zeH
         rRXUaD6zCX8m5INeiESfiEuZDMQdEybcc4++C6rLhsHs4zb3fOU0FYoaz7q3O7JmxqX8
         nxwTA3Tyv87K4uC3ZEAKXW3GQhhcoo12vG1/MM6VWxvg8E5k4OI2SMTX6qbjFTXsFi9j
         34QmiQ10MQ1bUP7qFZT0kKyuyFs7maRh+RnWqOaqqGE88uE16KaWUsKp4s2JNUqTmDpo
         4riA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QZenG9y0QmFOmVqL2EUVba74mzw/GgCevkmWTft1JFs=;
        b=StpZOyBm2wCuJa1TkLIc2f+W3rFV9uBo7NKfR5BzgNiy6+TRyObZmKfPBuBdLHOAwk
         hyjxOA/WIClnvi0JAVBiECRRmP3+8A0FdfSc/Z6HK+IctOrM8YUYWGfG7LoOioGn4P6H
         z8sOiSiySX+WDVbdVIDKe9EXU3hHYmlg956G/UFWCIuE35kJB568xaec2vLKLvwahQSk
         sZH2Yp3VsDSnRXiVNJ9O+xMuPvLU08nV2/+pqH7L9RxeDcX4CEA/yRE8dqdAqe2wBUAq
         kDAy+VqRVhbwkSv7dwigdWdO9Galt4tuVJotNPyk+PH58E6FNSjkitD8++4i1HYdjt9m
         BgpA==
X-Gm-Message-State: AOAM531gq4BzVZrE3yQEZvMiifJhuDtw40j03Y8iIpR1GJzJ7bcyVMZG
        +XItFC70nlot7XrNo+W5AtqOPAZGQSQ=
X-Google-Smtp-Source: ABdhPJw6qhClPsgxv6kpYnu2qk6j524Dr9orqRcPsec148uo8eSZdl313YnP7tCH+dyrWuvA0zL02Q==
X-Received: by 2002:adf:f642:: with SMTP id x2mr31921824wrp.37.1625759445812;
        Thu, 08 Jul 2021 08:50:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 93sm1093925wrk.18.2021.07.08.08.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 08:50:45 -0700 (PDT)
Message-Id: <30196cc93697cd4a6a6881dcbb1073d19e96d8a0.1625759443.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.992.v2.git.1625759443.gitgitgadget@gmail.com>
References: <pull.992.git.1625550451038.gitgitgadget@gmail.com>
        <pull.992.v2.git.1625759443.gitgitgadget@gmail.com>
From:   "Stephen Manz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 08 Jul 2021 15:50:42 +0000
Subject: [PATCH v2 2/3] worktree: default lock string should be marked with
 `_()` for translation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Stephen Manz <smanz@alum.mit.edu>,
        Stephen Manz <smanz@alum.mit.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stephen Manz <smanz@alum.mit.edu>

Signed-off-by: Stephen Manz <smanz@alum.mit.edu>
---
 builtin/worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 976bf8ed063..448ec69e745 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -305,7 +305,7 @@ static int add_worktree(const char *path, const char *refname,
 	if (!opts->keep_locked)
 		write_file(sb.buf, "initializing");
 	else
-		write_file(sb.buf, "added with --lock");
+		write_file(sb.buf, _("added with --lock"));
 
 	strbuf_addf(&sb_git, "%s/.git", path);
 	if (safe_create_leading_directories_const(sb_git.buf))
-- 
gitgitgadget

