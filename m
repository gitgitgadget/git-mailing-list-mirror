Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE77C4332F
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 14:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiK0Ovj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Nov 2022 09:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiK0Ovi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2022 09:51:38 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E49F58F
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 06:51:38 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so8089115pjb.0
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 06:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CjJoiXSis0CEI6gdhEn9ZXxw1w8vMbCF2c1knrNxcP8=;
        b=S7X+R2I9Ar12ty9osjTgD/RXVzemGnVkOV1o8hWk3LH7rrL0N9+dLL9mJY+P8GcfDb
         d1BJyw/ruJrcs+X6BOJsePlkIFPnxKNBrZqamv/3r8mgK5B5ym64npJKBncabL+MjuQF
         sIB71ngDYEtdpFebH0nKZ3ZgxXqr5+QOaEN6qWKUuLuU+5mLsVb57uPGcffhJvU+qj5w
         OQzLbKc+0HDk0j2EpQxyAZZmj7K6CWJsI297aaul+nkqVZHvmjKoq+isPTWLFSJNnvow
         Kz5FB6+xUKDVAuPvNRCSy09FG6DXIE854B7+1dJ2RkAQTpGusb7S8Jf7T7V532RAGeYY
         vshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CjJoiXSis0CEI6gdhEn9ZXxw1w8vMbCF2c1knrNxcP8=;
        b=5ZkzS0Hx3rC8OwzyMLloxKZAgBoFglQ2yY2cwE/nn6BEqcMXByNuoZLqsRzW2sMZbK
         IwcBQGsmMFAwLSVFKVoGTeQChaCJ3kkcZxb/9pn5XNknBJuMDgPT75UQV8dFCi8owz5m
         10HFTaDAbxMYi3jUVKeEDO6KDlMgY3Uo+yT+Wn2ivh6AAJEldGL591/bhZanlvc3WCch
         21lLus6TVrgLY8CNMSlFn7jvMk1i/QlhzZSGMgsdixxSeHTiMF9Bbit30ly1QywcW1LS
         Rxxc8I8YKBncLzuG77yJMA9PNjP40o4WP3BtFpDxlgcyincrtLtJGR+9WhcAfYfhTfNK
         xY7g==
X-Gm-Message-State: ANoB5pm7t0oSJfHmjo+dZj3Ez8oqbqbVdvm8Toj+Di4VhIKBm/H1OVsi
        DLqutrqnvOmT8qqUvgKEthA9XoYBiZI=
X-Google-Smtp-Source: AA0mqf6OsQlzzuNS8MtA7a4JWBli25NeoRVojV+8vVHG5rHj69QmcjF+hws2aPwPz3wj6KI5IvcskA==
X-Received: by 2002:a17:90b:3c8d:b0:20a:6468:9bf0 with SMTP id pv13-20020a17090b3c8d00b0020a64689bf0mr51146722pjb.31.1669560697472;
        Sun, 27 Nov 2022 06:51:37 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090a058800b002137d3da760sm7915050pji.39.2022.11.27.06.51.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Nov 2022 06:51:36 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v1 1/4] t1301: fix wrong template dir for git-init
Date:   Sun, 27 Nov 2022 22:51:27 +0800
Message-Id: <20221127145130.16155-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

The template dir parepared in test case "forced modes" is not used as
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

