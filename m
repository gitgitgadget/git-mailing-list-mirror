Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA189C433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 13:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiK1NDa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 08:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiK1ND2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 08:03:28 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A082DAE40
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 05:03:27 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id f9so9842820pgf.7
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 05:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHKl6FjwyzaA/lQRWpUOh+1jElXFyAHsa37AKTUq6Fc=;
        b=AcQo1VtBsehPnw5X5PpLu+lHPRr39R8HPBHJarNW9/Cu/g1XYua/rl4kE5u3vtS/d0
         mJVFLjBnXgjrnBqb69a/JpM/OGD5WuYIGDsA98W+rKNAU+8r2wu0dZBOLiCI7CmjMs9J
         3m8Rm7pr4y8x9zIuodjQgfnmbfSlgDawaSi1OJMpCAZt0Zs0s22Fobr3kKDOfRSXNyZ9
         QLJzOARqGTwStA5hPllXN7YGu5poglbzbuCvo5YZ2oO0Spjk0C5TPg+Xu1c6vwW/pVqb
         nB8u+hiKv7rO457JqKHYxzYM/mwlHtxnTHfv8N6ofoprZJO5N+Lg5LW4wZ2KWhLTEfoB
         cKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHKl6FjwyzaA/lQRWpUOh+1jElXFyAHsa37AKTUq6Fc=;
        b=AovBffEuCQM8z9uTrlKynP+PAAz6IhoFBWReW3L5nM4YNFI0LFu4sT3Ll78+OCazz8
         V99SIrXlOy8WJxIIe5hcvFATC+RQApQr6FI5Uir8pRVMDTmKwKAixHmyybw2kY/dMQzr
         wsfySr4glvOpxfqTjDiVvv1UoXZ0zDOM73d2iWCj/npUn2dFuhiPF3IctKVxm5OGGjv3
         0VQlH/HDMJ9N3OWVVoLo0+60SPNdoS0JzKZWUvoOCQeNrx/GdrMGEpmbEt5G4ge/p3RL
         W3m0b3Nut7GwibVyQ+6+EgA/NiMpT3cIYIvg/3a5LBu0/Ssj7f0IuoNWCB97EhCkiLNH
         3Atw==
X-Gm-Message-State: ANoB5pkZ5fq8MGBEpv1xmix1CSIvXCguz6fqbXFvLTp4FlrwnSfIwwH2
        ly5dbFFLC2Ot/FV7SUWwxwkXQORlaHQ=
X-Google-Smtp-Source: AA0mqf7b7G4dstQrPx6nQ3BAuM5ri9otNpp3bkR8uMn0+xKhMaTdWGNaG+1+Ixyvl6ameYtZYFFA0g==
X-Received: by 2002:a63:2310:0:b0:457:a1a5:3ce with SMTP id j16-20020a632310000000b00457a1a503cemr27497859pgj.416.1669640606945;
        Mon, 28 Nov 2022 05:03:26 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id x127-20020a626385000000b0057409583c09sm7977301pfb.163.2022.11.28.05.03.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2022 05:03:26 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 1/3] t1301: fix wrong template dir for git-init
Date:   Mon, 28 Nov 2022 21:03:21 +0800
Message-Id: <20221128130323.8914-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20221127145130.16155-1-worldhello.net@gmail.com>
References: <20221127145130.16155-1-worldhello.net@gmail.com>
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

