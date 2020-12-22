Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E9DC433DB
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 15:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C65502312E
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 15:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgLVPpZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 10:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbgLVPpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 10:45:25 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BE0C0613D6
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 07:44:45 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id q18so14975369wrn.1
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 07:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dyMK4vZmrOiEqLUs/dxFjrtO7MaPPo64wqdwyzBuONk=;
        b=TFGxzOHTkT/SnStTj7VVDr/HjOpQy+TZDLefIz3/si2H9WRIN+h6ubdogFQndHGt2P
         oMli0eXNS7TeB1tnAGatTAjgjVPIE0XAYAAxllq3yMrDdz4E8bShPFzTrQz8W/3lC8r0
         64PVJ2yta4lPYu82k9TQ12cEUK/xLyxGi2UAkFg0dEBAx4bmB/ue56AOZCMUxSjkFbEP
         Lgn9Gf54XjiwR/IzavW04PcOk2xag0kGbL3Wb+g3h87ox99eB5+4+Ur86Bl37RBXcr2K
         QxXe4bWgVCg0Zrqz1XFio0Uq4kHd1kELbtwdv7hy1GPH2i7bQkA9BenZNmx4zwoV9tUT
         K2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dyMK4vZmrOiEqLUs/dxFjrtO7MaPPo64wqdwyzBuONk=;
        b=MLR8UeOpwrZC8rfvWLhBr7FWlbHYB0yMQAN4Hw3BxBlUiaGX6BVtunrmRzo8Ra6L95
         1qQUaEFRCPA+VjJUgVEL5G22Md/dUj7eCSZ1n4mKNttQRFYQZbxFrljQJ1LNzaii6+Qb
         ZIzk8wNpIpqbq5ybL8iMpNW5UzCSyr8PVbfHWj4haLRdSESTpYmCNxVECdBnFEgHf5Xn
         27TuUzJENhBgIzeFWem7scDwmne5FYpmO5ylGcxrtmaeZvW0kF0LGREPpKUXrgaCoCtK
         9iLBwnj812Z18sOiTh/th1uPvOrxpuIDejmumxswmPhvbn7qUgaHAwA59TplfYXlAO0n
         QyxA==
X-Gm-Message-State: AOAM532Xa1boIe86BA2KCZkYt51wSmzVyvkPS5tNfJPkA1qUJChcPd8J
        mpqa73EcOAXGDwbG5vQsoXWS7pqORkg=
X-Google-Smtp-Source: ABdhPJyTRfm9+IkKT1bzhwZ5tYCQs+vYVd1+vZXJNk7zfrdqoCInFML85vbUTbdkq3Uk9H2lMEUqNw==
X-Received: by 2002:a5d:6a4f:: with SMTP id t15mr25628897wrw.62.1608651883706;
        Tue, 22 Dec 2020 07:44:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x7sm26658640wmi.11.2020.12.22.07.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 07:44:43 -0800 (PST)
Message-Id: <pull.934.v2.git.git.1608651882510.gitgitgadget@gmail.com>
In-Reply-To: <pull.934.git.git.1608651140403.gitgitgadget@gmail.com>
References: <pull.934.git.git.1608651140403.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Dec 2020 15:44:42 +0000
Subject: [PATCH v2] git.txt: fix typos in 'linkgit' macro invocation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The 'linkgit' Asciidoc macro is misspelled as 'linkit' in the
description of 'GIT_SEQUENCE_EDITOR' since the addition of that variable
to git(1) in 902a126eca (doc: mention GIT_SEQUENCE_EDITOR and
'sequence.editor' more, 2020-08-31). Also, it uses two colons instead of
one.

Fix that.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    git.txt: fix typos in 'linkgit' macro invocation
    
    Changes since v1:
    
     * also fixed the fact that I had used two colons instead of one.
    
    Sorry for not checking the doc build before sending v1.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-934%2Fphil-blain%2Ffix-linkgit-git1-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-934/phil-blain/fix-linkgit-git1-v2
Pull-Request: https://github.com/git/git/pull/934

Range-diff vs v1:

 1:  978e328fb94 ! 1:  494173a5865 git.txt: fix typos in 'linkgit' macro invocation
     @@ Commit message
          The 'linkgit' Asciidoc macro is misspelled as 'linkit' in the
          description of 'GIT_SEQUENCE_EDITOR' since the addition of that variable
          to git(1) in 902a126eca (doc: mention GIT_SEQUENCE_EDITOR and
     -    'sequence.editor' more, 2020-08-31).
     +    'sequence.editor' more, 2020-08-31). Also, it uses two colons instead of
     +    one.
      
          Fix that.
      
     @@ Documentation/git.txt: other
       	when editing the todo list of an interactive rebase. See also
      -	linkit::git-rebase[1] and the `sequence.editor` option in
      -	linkit::git-config[1].
     -+	linkgit::git-rebase[1] and the `sequence.editor` option in
     -+	linkgit::git-config[1].
     ++	linkgit:git-rebase[1] and the `sequence.editor` option in
     ++	linkgit:git-config[1].
       
       `GIT_SSH`::
       `GIT_SSH_COMMAND`::


 Documentation/git.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index c463b937a86..a6d4ad0818b 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -609,8 +609,8 @@ other
 `GIT_SEQUENCE_EDITOR`::
 	This environment variable overrides the configured Git editor
 	when editing the todo list of an interactive rebase. See also
-	linkit::git-rebase[1] and the `sequence.editor` option in
-	linkit::git-config[1].
+	linkgit:git-rebase[1] and the `sequence.editor` option in
+	linkgit:git-config[1].
 
 `GIT_SSH`::
 `GIT_SSH_COMMAND`::

base-commit: 6d3ef5b467eccd2769f1aa1c555d317d3c8dc707
-- 
gitgitgadget
