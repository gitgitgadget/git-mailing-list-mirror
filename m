Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E261DC4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 13:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbiK2NQE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 08:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbiK2NP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 08:15:29 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168301016
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 05:15:17 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 136so12992993pga.1
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 05:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHKl6FjwyzaA/lQRWpUOh+1jElXFyAHsa37AKTUq6Fc=;
        b=HzGwpfD6oB/wxvh1LgthdTISvHARXkltz5N1PaiXLqf+EfIBFRkQu0BbI9JACnOwxc
         9mAiR9kxVu1ZLBM/6MGaFKQqFl5fxyyUjQUzV+EZ6oo08FmdhMP2unRopRveFGCj0x5O
         2n10bAasaz2HNtBg1xoHWK171nWMt48N/kuBr4rIryUgZQqmnLF5in27di9cD7L0gfz/
         S7WT8O++EiEwqaQ9tEGOfGc6Wbn0gxItkMT449bX+xnVNwi9MwUi+Lt2JDK4eqvOy/2r
         NyRNjmEDd4pOxks8ct/m2teQBOOrENcF9rZ3HgKMV8/xUFZFqfmVfp79GpLv/tebQ5l2
         bXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHKl6FjwyzaA/lQRWpUOh+1jElXFyAHsa37AKTUq6Fc=;
        b=DAmcy6U5LpsL+k7pz+rX8oiFeLI4UxdMptqyENgtejGGGQBtLiF9XyjNesYGlroaY8
         4kAp34e0011jaf6iSTOFx95ldXBhqhmGHzI9R6KUgLpoMZ3Dt4arxoRvw6oRU/0EHlIS
         IvDRjXRFfgPO/kzKSTk2RvQuqUYPe4I3w6rVC8Qq0Wt6XeKahrinpj4xJlY4dOLJ4eQy
         CIkilgnHqcJSSPYUjz6KHt/bweIvaXbTGwz8gmZ/eIFPnPrHKknrc9zG7wEEh02yE0LI
         Q+iegDMTGoO3MMZd88OuM6qqY8cRJLdPbLfphE407gfAgt1YNoVRN5LlixmPL4G9uwAF
         r7/Q==
X-Gm-Message-State: ANoB5pnL9fkEejzFxSbgamZLe1aJGrLDbJnsiI1nqr8oh4Gdk1vnZzOc
        tEfpDCCL8qveW2XZDfu2A12QeIfNGpk=
X-Google-Smtp-Source: AA0mqf5tpbhlWWF92YnzIYh4mBAkIOUtJS5cyxJhI/853BQv15tmNcFlEJgSaDdr8MStbA3xwM3B7Q==
X-Received: by 2002:aa7:8505:0:b0:574:e18c:955a with SMTP id v5-20020aa78505000000b00574e18c955amr17055883pfn.27.1669727716253;
        Tue, 29 Nov 2022 05:15:16 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id o7-20020aa79787000000b005745635c5b5sm9904524pfp.183.2022.11.29.05.15.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2022 05:15:15 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 1/3] t1301: fix wrong template dir for git-init
Date:   Tue, 29 Nov 2022 21:15:09 +0800
Message-Id: <20221129131511.7173-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20221128130323.8914-1-worldhello.net@gmail.com>
References: <20221128130323.8914-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

The template dir prepared in test case "forced modes" is not used as
expected because a wrong template dir is provided to "git init". This is
because the $CWD for "git-init" command is a sibling directory alongside
the template directory. Change it to the right template directory and
add a protection test using "test_path_is_file".

The wrong template directory was introduced by mistake in commit
e1df7fe43f (init: make --template path relative to $CWD, 2019-05-10).

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t1301-shared-repo.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 93a2f91f8a..7578e75d77 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -140,7 +140,8 @@ test_expect_success POSIXPERM 'forced modes' '
 	(
 		cd new &&
 		umask 002 &&
-		git init --shared=0660 --template=templates &&
+		git init --shared=0660 --template=../templates &&
+		test_path_is_file .git/hooks/post-update &&
 		>frotz &&
 		git add frotz &&
 		git commit -a -m initial &&
-- 
2.39.0.rc0

