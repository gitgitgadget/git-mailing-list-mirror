Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CAAC7619C
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 04:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD3320726
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 04:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tbyv2Tp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgBQExM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 23:53:12 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34331 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgBQExM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 23:53:12 -0500
Received: by mail-wm1-f65.google.com with SMTP id s144so6482445wme.1
        for <git@vger.kernel.org>; Sun, 16 Feb 2020 20:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mKOGydVWPAfYsYOVWjtxvMBouK6S3P+5Jvfry3Mw2MA=;
        b=tbyv2Tp5NboaovYG8NCNWTXFN8qH6I4L360VH+RbFxFGjnIZq0AcWPmcQCwMxJLVDN
         Bymx2vz6pah4rXl9c4zYHxfnm5hSOcvMyZM6C0/xcBkSn3/LcUrMhEHmMK1UqmerFoFO
         mTCK4HNezzhob3ADBZldGVLgNDOfTfOWApRQZCEn5R8wvhNxKIcuocrYhvhKOcTAteCb
         f4ITorRDgA2I+yiYuUVxvJ+OHTOM7QuhE4OYjdXjKSONVQ+qzQUwVKtJm+oERceY5j1r
         bWek5VaHJoJD6cLPpqvTSa4OmGa80nPV1z6cwSYoPgBYPjpfYQXxoM4oNEJ56IQIWIhz
         1hEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mKOGydVWPAfYsYOVWjtxvMBouK6S3P+5Jvfry3Mw2MA=;
        b=UF+F6pJRzO1f5K6rekSCwpShkpvDTnMIOX1GtEtIc4UuE3aRfaRzGIUMnW9f+Pb0wh
         /NEMH1ECFx45x+L0uttC41/FLFWHZ8phG2AtE5YIzwTBlsElN1gcVnXQ3diszxRVCMpR
         5j+zkSi+/QmFqfPjM0sL4RvRAQFeZgnkore1JuYK13V9XnDP/ePmacE0S8KPgbWG7rA8
         ehUCEqG31Wwu7v3plF45nt1mnF+FmFqku1WRUy/TIZx1MIvcM0pj16A/AGsaRsC1y/ja
         VEBCX/w27xT2qFuBavjdyKfgzXKWPg0+uRIa94CTEVZbUTtWcA/6eKBATChd6W4F+C6k
         IDyg==
X-Gm-Message-State: APjAAAUwbmEfNldXQA/IGejpLXShEsJz8OLSllyAs9Vur0SqMElNoLNc
        i4FFJpVUv6eJkxPgW6WQ1fVk3L5V
X-Google-Smtp-Source: APXvYqxpLgZF1m4AEfoF98rugjBrQwRBbxxWxzKf1quxVGF2Jd5BopxiZPTbiCdt3pmm5CwcIoRIPg==
X-Received: by 2002:a1c:791a:: with SMTP id l26mr20032022wme.58.1581915190110;
        Sun, 16 Feb 2020 20:53:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h18sm18122735wrv.78.2020.02.16.20.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 20:53:09 -0800 (PST)
Message-Id: <bc7217f293a381226abdff89ba046814777a96a5.1581915186.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.555.git.1581915186.gitgitgadget@gmail.com>
References: <pull.555.git.1581915186.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Feb 2020 04:53:04 +0000
Subject: [PATCH 4/6] unpack-trees: remove outdated description for
 verify_clean_submodule
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Damien Robert <damien.olivier.robert@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The function verify_clean_submodule() learned to verify if a submodule
working tree is clean in a7bc845a9a (unpack-trees: check if we can
perform the operation for submodules, 2017-03-14), but the commented
description above it was not updated to reflect that, such that this
description has been outdated since then.

Since Git has now learned to optionnally recursively check out
submodules during a superproject checkout, remove this outdated
description.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 unpack-trees.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index da4d6d4ec01..37eca3ede8b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1815,9 +1815,6 @@ static void invalidate_ce_path(const struct cache_entry *ce,
 /*
  * Check that checking out ce->sha1 in subdir ce->name is not
  * going to overwrite any working files.
- *
- * Currently, git does not checkout subprojects during a superproject
- * checkout, so it is not going to overwrite anything.
  */
 static int verify_clean_submodule(const char *old_sha1,
 				  const struct cache_entry *ce,
-- 
gitgitgadget

