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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE674C64E75
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 19:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AED5221F7
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 19:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7L1Lwp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404573AbgKZTmj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 14:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404540AbgKZTmj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 14:42:39 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A845C0613D4
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 11:42:37 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 3so684699wmj.4
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 11:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=//av9eqK+1pi9YuIZMSFMq33I8yAF9QfE0Cgc8M3U/0=;
        b=Y7L1Lwp/Tp1POACvtH0ZmmjYdmrFlD4MubJW1nIDP1HFSSY2z7noVmWamy5yDqvO3w
         5Un0FeHqrhuiVhLqiPad4jPTNDGSfGBu5O9ke16Ad7rUd+b5aNryvIlGgQwjfNSqCypu
         VA9pOz1pwoUpn+t5LKBHTO2T0ZQBTcxqqF11zSShvC7Z3zGOK872M0e7Cut6dtiA2rAS
         3uINtCfaQ8GkVUoGyIIUkyqbWlAqTzfhSjex5XuT1UnZn+VTKlLgbgS+ZuveVLcCGQhE
         q075MAccvoOV3wx3G37aFUtj2uanzZ/xeIanV3yg2LpkK4l2HHHjN+euY4SeNGn8QYY0
         wHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=//av9eqK+1pi9YuIZMSFMq33I8yAF9QfE0Cgc8M3U/0=;
        b=ASmxlrLX+vchKhIQZcde4pe4LvRUTCIYtEvcos/sIUz2yBjCqDIpl6UZkjLgt7vGX+
         Ztmo6Sf/KJf+dskaUeI0T8mmPFOlmF7DYT2/XSp3ppsoOI9VI6XyFh+RBSaV+EHgKDSh
         DwqDsphSkZgua1M4tuoeUOxWJNV8vVAkLM2BXfW4A893wVk3mSwwO6VcLDfbd2tqdLjD
         j46RU94A+XviHltgjnBDVNp9Iig/QtDeEUdAGeWh4iqGMOU8KsDdtPDLTS2jUxxZQpmI
         UEDBba8aLrV5xjKk0M5xRI9QeQDd5+0IQkg5RRgmOltVfOtBsbUZ8kE7uRVmiOZgIlvF
         Lx2A==
X-Gm-Message-State: AOAM532MXWQK2Yelny1Xkfco3rKGHfqEQH1s4vpJWpFBSIin6z+X7CJ1
        rf+y3/lp0UE5KuCOd/bGtR25X3NnMwY=
X-Google-Smtp-Source: ABdhPJwSdQYADuDhFobdaaCQRZpqIIZ8noqK/JGWPYytCpM/0/GBY/xBIi+pkPHNr0aos1nb9Sn2Pw==
X-Received: by 2002:a05:600c:22d5:: with SMTP id 21mr5032654wmg.33.1606419755979;
        Thu, 26 Nov 2020 11:42:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b73sm10712720wmb.0.2020.11.26.11.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 11:42:35 -0800 (PST)
Message-Id: <cf667653dff437cee4c0d04e8c061a8b9ccc46a7.1606419752.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
References: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
        <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Nov 2020 19:42:17 +0000
Subject: [PATCH v3 02/16] init-db: set the_repository->hash_algo early on
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The reftable backend needs to know the hash algorithm for writing the
initialization hash table.

The initial reftable contains a symref HEAD => "main" (or "master"), which is
agnostic to the size of hash value, but this is an exceptional circumstance, and
the reftable library does not cater for this exceptional. It insists that all
tables in the stack have a consistent format ID for the hash algorithm.

Call set_repo_hash_algo directly after reading out GIT_DEFAULT_HASH.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 builtin/init-db.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 01bc648d41..5c8c67fec6 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -391,6 +391,7 @@ static void validate_hash_algorithm(struct repository_format *repo_fmt, int hash
 			die(_("unknown hash algorithm '%s'"), env);
 		repo_fmt->hash_algo = env_algo;
 	}
+	repo_set_hash_algo(the_repository, repo_fmt->hash_algo);
 }
 
 int init_db(const char *git_dir, const char *real_git_dir,
-- 
gitgitgadget

