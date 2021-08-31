Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D0EC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 14:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 720E56103D
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 14:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbhHaOia (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 10:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbhHaOi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 10:38:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C4CC061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 07:37:33 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u16so28112619wrn.5
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 07:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aZyqQmxoBy8U4M6ph23mnVlkUXSK25UoNvB4S786zdQ=;
        b=Yfn5c3g7OiNPR0bYb9k2MYFVYwxFPJSZ73Pubj1V43GPOF4E8LKxJ6bng+djA5RD+e
         qBqKYScxYEhikg6GxQ2PwPNLEq2R6/gUVIZMAL5CJP6dNrgbwoyNOQVz2WusCB8Q0tvy
         qjlk62a1PrSr8ZVSWzlbGEj3pA3PUyBVkw0C3Zd82RRv6ryIcXIERNabg6FGfncO1swB
         ddWlqFf5oklFj+iq3t0Z0hNvgugRHG0Fb8BstSxengueH9HrU1Vhd/pSPzoDaoiGkIFY
         O2p5y2psO7RUKdTsdULj2gNM5mNNEKA/9dyMDjgkEdigWptTUskA9YmdDElS9/LSoRJs
         FGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aZyqQmxoBy8U4M6ph23mnVlkUXSK25UoNvB4S786zdQ=;
        b=Pr2UR931X7X+svekvoV+7O4YIN92foODzwtl3Kpt0SbaysBi0i20cichTxWFLUxap5
         u2AjyzExo+NZwBwGzVe4NbWg6Gi0UTydX4WfjJsRke5CNaXc263N2WhWgG4iZU5GWsDu
         hYoml+QmEqZ9ZmpU+BAVTyAK9iFgor5/hgm9DDsalzL2iqGj8ehPrH2v5LSfr+DWuLhh
         MVJgV4nSXZrVK7WkWFz5fMmjhcboPsZpNZti4IWuG4szBaWvk5c6Rl0MGwQmRJ0dCcc6
         WdJV8insJNCqWMZ9bU/kS/0+Uz0uGXdZeSuyfW4ryw7AYTpkFpH7fQ7R2gLJzgois11F
         25Dw==
X-Gm-Message-State: AOAM532brupm9xzdyE8OuJAbdMsHBC3s4bQN8J+ceZctAMeIK8gY3SO9
        4qhEH5ZbqAKuy4wSCoNwUQq5NkmlNBkS0Q==
X-Google-Smtp-Source: ABdhPJzXY2wuNMaOlx2vAaQ9+eOeVDD/rOM1kai4ZHwNCPquK8k8Lyioj3xzVBu24ZiP8V1+AbCI+w==
X-Received: by 2002:adf:f50a:: with SMTP id q10mr31678769wro.271.1630420651678;
        Tue, 31 Aug 2021 07:37:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y15sm2976746wmi.18.2021.08.31.07.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 07:37:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jan Judas <snugar.i@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] gc: remove trailing dot from "gc.log" line
Date:   Tue, 31 Aug 2021 16:37:29 +0200
Message-Id: <patch-1.1-27f00a664e6-20210831T143536Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.805.g739b16c2189
In-Reply-To: <CAO=eiXzPaRpEV_nsudvvCUbNab+oMxR8b9rsehjdyc4WMHe3OA@mail.gmail.com>
References: <CAO=eiXzPaRpEV_nsudvvCUbNab+oMxR8b9rsehjdyc4WMHe3OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the trailing dot from the warning we emit about gc.log. It's
common for various terminal UX's to allow the user to select "words",
and by including the trailing dot a user wanting to select the path to
gc.log will need to manually remove the trailing dot.

Such a user would also probably need to adjust the path if it e.g. had
spaces in it, but this should address this very common case.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Suggested-by: Jan Judas <snugar.i@gmail.com>
---

On Tue, Aug 31 2021, Jan Judas wrote:

> Hello,
>
> first time posting here, I hope I'm doing it right.
> I'd like to suggest a very minor UX improvement regarding the message:

This is the right place for this request. Thanks!

> error: The last gc run reported the following. Please correct the root cause
> and remove /path/to/repo/.git/gc.log.
>
> Currently, there is a dot after the file path, so it's impossible to
> select just the path using double-click. If the dot was removed, or
> separated from the path by a space, it would be slightly more
> convenient :-)
>
> Thank you
>
> Jan Judas   

Yes that's annoying, here's a proposed patch to fix this.

As an aside I've also noticed that if you have multiple worktrees
we'll trigger "git gc --auto" in each one, and then litter various
per-worktree gc.log, even though the issues being noted are usually
repository-global, e.g. too many loose objects.

That's per-se unrelated to the issue you're noting, but is usually why
I end up having to manually remove gc.log files...

 builtin/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 6ce5ca45126..69c058533ea 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -502,7 +502,7 @@ static int report_last_gc_error(void)
 		 */
 		warning(_("The last gc run reported the following. "
 			       "Please correct the root cause\n"
-			       "and remove %s.\n"
+			       "and remove %s\n"
 			       "Automatic cleanup will not be performed "
 			       "until the file is removed.\n\n"
 			       "%s"),
-- 
2.33.0.805.g739b16c2189

