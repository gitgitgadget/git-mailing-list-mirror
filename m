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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F17BC6377A
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D5A6120E
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhGUVfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 17:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhGUVfO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 17:35:14 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAA9C061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 15:15:49 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id p67so4541920oig.2
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 15:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ow+HIoUQUT24/R9HkgmAHTVnXF0Q3En88e1Pb3cSHNk=;
        b=gmlWpSwimN5OsNLfRUqg1Km9ce51JwjmcB+3MySvl+1OmdV9rgNu57UPYTG7okWoqh
         m5dhvN/ds55ZYAucgf1FFFSoLEjUPM4Yir79n6QH6XpH3pjZ80DoDDKnI9YM2TuotciP
         dZrjGD7RAPB/eX3QSCgeGOd6H+cZKvQ88uuJq9v/ipStuy8/p8baAINOOOSF77znxmGO
         3EJorECHVaq+tfkQLcOwj6TcCahrUR2JnLUP2TNiBr97vxEW/KrCFgaQ8uZeglynzL/q
         hQyquYki7WWzJ9ohSZe3WGVNvJB6r4NJiZglLK20/XqsJS1vsNDvqzcf96r9dbvfYMGP
         Flyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ow+HIoUQUT24/R9HkgmAHTVnXF0Q3En88e1Pb3cSHNk=;
        b=Wal0QAfkniZcgzn4+xMb3CugXouxmGCOZQl20Fad0OP/JOMRxD7wZfwDmU9MsNXIP7
         EvWWCSMmStfd27/K7ZwdOYYd+9AMMVFEaBcFivWzSJDBfRms49sgl2P4FbkV/0Jwj55X
         100IYEiM2fDi57hg9KbJ+LXuFD5qwUiRCqVRdq+zJIiabo1d0wUGWpt0R3/T0S+bcx21
         dTjC7UbFw4r/wR40p5ve0rV88bgCIRbheJwYn7iK/27sb4VeEsGLpdsBDQ/bREGMoHsW
         Ew6JlYk1ZWw+xkil2OUk434llJJgxBybUCSmtshjgqi7jf4/PyVWTzrNKrSeIjjE+4NV
         tnkw==
X-Gm-Message-State: AOAM531uGuihmnBYq4V1Ng+h5dhUYW98g7bNBqknYjSi7zIPt2ALuwT7
        gGOQk3C0ipSunuDyZYVlyzPiPaQ5dsgegQ==
X-Google-Smtp-Source: ABdhPJz4s3EyEwxODZ+nK/hWnjfVAE2H55O5MGckWErQtIY4YkjQldg3IJQ5f0UQIAZMOY6EOnK3yA==
X-Received: by 2002:a54:4e93:: with SMTP id c19mr26399220oiy.56.1626905748843;
        Wed, 21 Jul 2021 15:15:48 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id w13sm5127998oia.1.2021.07.21.15.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 15:15:48 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Stephen Haberman <stephen@exigencecorp.com>
Subject: [PATCH] doc: pull: fix rebase=false documentation
Date:   Wed, 21 Jul 2021 17:15:45 -0500
Message-Id: <20210721221545.1878514-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.40.gb9b36f9b52
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The behavior of --rebase=false is obviously wrong (as has been discussed
in big threads before [1] [2]): we want our users to merge their current
branch into the upstream branch, but this is not what the code is
currently doing; it does the *opposite*.

Fix the documentation so that we explain what the code actually does,
not what we wish it did.

[1] https://lore.kernel.org/git/20130522115042.GA20649@inner.h.apk.li/
[2] https://lore.kernel.org/git/4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com/

Cc: Stephen Haberman <stephen@exigencecorp.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-pull.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 5c3fb67c01..7f4b2d1982 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -117,7 +117,7 @@ When set to `preserve` (deprecated in favor of `merges`), rebase with the
 `--preserve-merges` option passed to `git rebase` so that locally created
 merge commits will not be flattened.
 +
-When false, merge the current branch into the upstream branch.
+When false, merge the upstream branch into the current branch.
 +
 When `interactive`, enable the interactive mode of rebase.
 +
-- 
2.32.0.40.gb9b36f9b52

