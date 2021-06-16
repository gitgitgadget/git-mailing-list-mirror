Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E59C48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 12:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D956761356
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 12:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhFPMkX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 08:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhFPMkW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 08:40:22 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DB9C061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 05:38:14 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q5so2542964wrm.1
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 05:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=k3Q7+wwqkSqngjWmiVovU7Brbz50Rmjfud/Z+yp1RgU=;
        b=LTuReOxhxik+A/NTlteOm7WfRcU58bm3Vcdny/Kz66uEPVVJr3cJPx0adoI+/52V6z
         DivtCXrVBRez8sn+CZgPXI+SmZ3nQGYxod85JX5wWuT5fg5Zk4dhVz8a14ol09PONrnq
         trrSpSWOaW+uHFQfvKrz0S4DbsVoGtQptT2F0Cqvbwp3NpfqouESdb10JVEjhI5SbYbS
         vuE5Ay5pxV0b8JBAwB4xXcWoYBkIqHOq5EkM+r9s0YtDXNQtUgXD7jtaEPuF6VYJQ9oD
         oVRcx/4a4+imOxW0jPlDyoYJwFxcPxSSItclwaXMQaFjEQ7lzxFnqINP3wnx3Iwc9xOy
         dNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=k3Q7+wwqkSqngjWmiVovU7Brbz50Rmjfud/Z+yp1RgU=;
        b=fCQqHd5YxhLjLYsUsCg7qdfX+id5s9sms+/QsT9a3cxIMcKM3e/2lWwYuT+gP28c8e
         smi7YptVTyh0mcFOPt4mBWguqBXD7bz8McXSebB4h5cYTPq6E1bZ9mGZSHLk8YzvBkns
         LUyjIWDyk0c7ESTdmdupzJtV1f9mc2pXjck0PYEDAv74esKYxsmbYqx57E/uHm5Q75y4
         Q9Sw6asAesosQUEBelp4pGbNO2kfo5oajL7dduiDj55CDc6OBhmWxwaM2Fjh3H9KCrCT
         B5ss/qaDwU2Uf6hM6iGiO4EbuTJN1NOCWfM6a1KraIummaZ4bT8XfSIjhugcaRLSVNgl
         LRmQ==
X-Gm-Message-State: AOAM532FntozaXThie7ykOy7nLWy7MKvGDr3I6npMTM6qvW0ynhVqZCQ
        zK+m5Wi9xh3sq48jJ8ym45wyTdmO7fA=
X-Google-Smtp-Source: ABdhPJy/Vk7W1s0BlwZ6MMEFhdHoazybfH98hajTOwHzhIfsX2l3RjlPoXj6gtUrA+IgN7wT1qTcxQ==
X-Received: by 2002:adf:a2d1:: with SMTP id t17mr5155570wra.74.1623847093301;
        Wed, 16 Jun 2021 05:38:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y26sm1784412wma.33.2021.06.16.05.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 05:38:12 -0700 (PDT)
Message-Id: <pull.982.v2.git.1623847092299.gitgitgadget@gmail.com>
In-Reply-To: <pull.982.git.1623701952823.gitgitgadget@gmail.com>
References: <pull.982.git.1623701952823.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Jun 2021 12:38:11 +0000
Subject: [PATCH v2] pager: do not unnecessarily set COLUMNS on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Since https://github.com/gwsw/less/commit/bb0ee4e76c2, `less` prefers
the `COLUMNS` variable over asking ncurses itself.

This is typically not a problem because we ask `TIOCGWINSZ` in Git, to
determine the correct value for `COLUMNS`, and then set that environment
variable.

However, on Windows it _is_ a problem. The reason is that Git for
Windows uses a version of `less` that relies on the MSYS2 runtime to
interact with the pseudo terminal (typically inside a MinTTY window,
which is also aware of the MSYS2 runtime). Both MinTTY and `less.exe`
interact with that pseudo terminal via `ioctl()` calls (which the MSYS2
runtime emulates even if there is no such thing on Windows).

But `git.exe` itself is _not_ aware of the MSYS2 runtime, or for that
matter of that pseudo terminal, and has no way to call `ioctl()` or
`TIOCGWINSZ`.

Therefore, `git.exe` will fall back to hard-coding 80 columns, no matter
what the actual terminal size is.

But `less.exe` is totally able to interact with the MSYS2 runtime and
would not actually require Git's help (which actually makes things
worse here). So let's not override `COLUMNS` on Windows.

Note: we do this _only_ on Windows, and _only_ if `TIOCGWINSZ` is not
defined, to reduce any potential undesired fall-out from this patch.

This fixes https://github.com/git-for-windows/git/issues/3235

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    pager: do not unnecessarily set COLUMNS on Windows
    
    A recent upgrade of the "less" package in Git for Windows causes
    problems. Here is a work-around.
    
    Changes since v1:
    
     * The commit message was reworded to clarify the underlying issue
       better.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-982%2Fdscho%2Ffix-duplicated-lines-when-moving-in-pager-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-982/dscho/fix-duplicated-lines-when-moving-in-pager-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/982

Range-diff vs v1:

 1:  22d3a9a2c9a2 ! 1:  82099e53bbc9 pager: do not unnecessarily set COLUMNS on Windows
     @@ Commit message
          the `COLUMNS` variable over asking ncurses itself.
      
          This is typically not a problem because we ask `TIOCGWINSZ` in Git, to
     -    determine the correct value for `COLUMNS`.
     +    determine the correct value for `COLUMNS`, and then set that environment
     +    variable.
      
     -    However, on Windows it _is_ a problem because Git for Windows' Bash (and
     -    `less.exe`) uses the MSYS2 runtime while `git.exe` does _not_, and
     -    therefore we never get the correct value in Git, but `less.exe` has no
     -    problem obtaining it.
     +    However, on Windows it _is_ a problem. The reason is that Git for
     +    Windows uses a version of `less` that relies on the MSYS2 runtime to
     +    interact with the pseudo terminal (typically inside a MinTTY window,
     +    which is also aware of the MSYS2 runtime). Both MinTTY and `less.exe`
     +    interact with that pseudo terminal via `ioctl()` calls (which the MSYS2
     +    runtime emulates even if there is no such thing on Windows).
      
     -    Let's not override `COLUMNS` in that case.
     +    But `git.exe` itself is _not_ aware of the MSYS2 runtime, or for that
     +    matter of that pseudo terminal, and has no way to call `ioctl()` or
     +    `TIOCGWINSZ`.
     +
     +    Therefore, `git.exe` will fall back to hard-coding 80 columns, no matter
     +    what the actual terminal size is.
     +
     +    But `less.exe` is totally able to interact with the MSYS2 runtime and
     +    would not actually require Git's help (which actually makes things
     +    worse here). So let's not override `COLUMNS` on Windows.
     +
     +    Note: we do this _only_ on Windows, and _only_ if `TIOCGWINSZ` is not
     +    defined, to reduce any potential undesired fall-out from this patch.
      
          This fixes https://github.com/git-for-windows/git/issues/3235
      


 pager.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/pager.c b/pager.c
index 3d37dd7adaa2..b84668eddca2 100644
--- a/pager.c
+++ b/pager.c
@@ -111,11 +111,13 @@ void setup_pager(void)
 	 * to get the terminal size. Let's grab it now, and then set $COLUMNS
 	 * to communicate it to any sub-processes.
 	 */
+#if !defined(WIN32) || defined(TIOCGWINSZ)
 	{
 		char buf[64];
 		xsnprintf(buf, sizeof(buf), "%d", term_columns());
 		setenv("COLUMNS", buf, 0);
 	}
+#endif
 
 	setenv("GIT_PAGER_IN_USE", "true", 1);
 

base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
-- 
gitgitgadget
