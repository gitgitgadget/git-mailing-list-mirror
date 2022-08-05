Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B036AC00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 14:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238484AbiHEOZP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 10:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238458AbiHEOZL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 10:25:11 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754CD5E326
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 07:25:06 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id p8-20020a05600c05c800b003a50311d75cso3569169wmd.4
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 07:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ow9wzZtTkULTEMkQ56FvIakRPWVcW1PgmeHHvqf7150=;
        b=UCVs7X9IHdVYxXdTCpdwJ6tO0aJH5caVGTFzedvTsj3Gapd1fLShX0rjEZXyPAwrPw
         Z4MXGKXez+HJL1oGtLQu1JGea81sg8mIm92DIkAjmh7qgeowUtPJoPC7WyJs1oPTskGU
         9Dd5usLhdyTOsZObrpHqP9rtgx7OLmFrAG6FgdBx6kRXqPA2rc56N5pRCNaJV9bBYywN
         1GAmNwz/Fq/ben9D8VQUr5lAP40H/wUtRDqRSp1oYxH1QHSxPKJGn0Wiq6qfDE0ltpqq
         LAZqH9IrMbQx9r8FP2ZGeDFEruO6SMKi4A23ByDGeU6L8wTmzQ2zeRtis/XKQpiqQZCI
         zZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ow9wzZtTkULTEMkQ56FvIakRPWVcW1PgmeHHvqf7150=;
        b=MMUt26Nmo29T8OFyW2fK6m0rPu8UqXQgdSDomDnjflBNyJ8yupMBkZqv1Y+uziO1gp
         lBlhov2RRFw2MV8J+opG0wMxkYI4ME8OWtoSiV+3JeDLeJ2eoWRH+qabptmvdtj3VHQW
         SZiHg4vU6wAqaRkzKGkPr8RbZhwErS1Fdr/L90dgIj6f1Y33qKms0fakzOP2ca13n2bB
         7DXcxeQpatNpK2ISy67eSRSTML5XpFdsSaBm7frxxHV6RTLER2UBG+7FBWgs0rbnDE6B
         MgW23Mrfutk9Fig6kKHRfvpZ23ZKO85uHv81yY2+Wlh31ccMyMRAL3d3PJedjuOhdV17
         PhNA==
X-Gm-Message-State: ACgBeo30oOsqgfyGN5cxoF6UQnFj++Av7/SlF/FoJDfihE4iS5XUqtM/
        0iesyh5qsgl3UFMCwfk3dG1b1dpGmxVkjA==
X-Google-Smtp-Source: AA6agR6h/lu731LK5v/Qdl/WTEqTg8ovnEyl2wckkA28xy3RsnzwxAYP6ThQsclF9QLBWjd5BEf+cw==
X-Received: by 2002:a1c:7212:0:b0:3a4:fdbb:f07a with SMTP id n18-20020a1c7212000000b003a4fdbbf07amr4839135wmc.44.1659709504454;
        Fri, 05 Aug 2022 07:25:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p22-20020a05600c359600b003a31ca9dfb6sm7723307wmq.32.2022.08.05.07.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:25:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Noneman <emily.noneman@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Paul Horn <git@knutwalker.engineer>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] revision.c: set-up "index_state.repo", don't segfault in pack-objects
Date:   Fri,  5 Aug 2022 16:24:34 +0200
Message-Id: <patch-1.1-3ff17707481-20220805T141816Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1283.g2c56c4202c5
In-Reply-To: <CAKvVO18RVye=PkBRv=trj2GHh8ccGKL5j0mMq2eHQ1SX=wsr8A@mail.gmail.com>
References: <CAKvVO18RVye=PkBRv=trj2GHh8ccGKL5j0mMq2eHQ1SX=wsr8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Narrowly fix a segfault that's been reported against pack-objects at
[1] and [2].

This fixes a segfault in "git pack-objects", see a reports at [1] and
[2]. In that case we'd go through the add_index_objects_to_pending()
codepath being modified here, and eventually call into
new_untracked_cache().

We'd then segfault in new_untracked_cache_flags() as we tried to use a
NULL "repo" extracted from the "struct index_state".

The segfault we ran into there is only a symptom of a much bigger
problem, namely that we have various "struct index_state" variables
constructed in various places, and then call into functions that might
expect to have a non-NULL "repo" member. In follow-up work we'll fix
that more general problem, but let's just fix the segfault for now.

1. https://lore.kernel.org/git/977a6e0e-251c-4fa5-8b3b-fa3e2a761926@www.fastmail.com/
2. https://lore.kernel.org/git/ecb6fa27-b918-4234-8e44-13c2a3e76e07@gmail.com/

Reported-by: Paul Horn <git@knutwalker.engineer>
Reported-by: Emily Noneman <emily.noneman@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Thu, Aug 04 2022, Emily Noneman wrote:
> Ævar Arnfjörð Bjarmason, your patch fixed the issue for me! Thank you!

Thanks, would you mind testing this more narrow fix, I think it should
fix the segfault too, but let's be sure & confirm it.

I haven't (and haven't really tried) to come up with a regression fix
for this. I have changes that come after this which extensively test
the same issue elsewhere, so maybe it's not needed...

 revision.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 87f1c117d13..48c2f1b91a8 100644
--- a/revision.c
+++ b/revision.c
@@ -1775,7 +1775,7 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 	worktrees = get_worktrees();
 	for (p = worktrees; *p; p++) {
 		struct worktree *wt = *p;
-		struct index_state istate = { NULL };
+		struct index_state istate = { .repo = revs->repo };
 
 		if (wt->is_current)
 			continue; /* current index already taken care of */
-- 
2.37.1.1283.g2c56c4202c5

