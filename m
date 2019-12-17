Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A9CC43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A70207FF
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqAhIL2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfLQMBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:01:53 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43647 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfLQMBv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 07:01:51 -0500
Received: by mail-pf1-f195.google.com with SMTP id h14so5529013pfe.10
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 04:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EMvx28QOUtxXZ96LQ6qQggtpOTuwWkmPV+zOmRtkw9Q=;
        b=jqAhIL2TJgBIu5FCPxPhdJ0TdkAiezMkx5QqcvlY3kz5giBBY6qKeI4YF3C13932md
         NUl1CO0bea7RpC/ddGDufEhhiFcKzQsp2hh+R/XEl+3T6AcL8GXD/Sw+aNIyKkKEIqVL
         Gtb6C7sZwY1GuR/JNsgPlWw39jOQLLlvBf00bAlLFgw0shH1k0Ij3q0jgKzaRSRhki1K
         yg9sSluhdBvbJyIEl8XOvJiDxBIYOLEFbDpga94WbIe7XI9UeixlEkOIDKxrxVtumB4Z
         cr1lj2dBrpULi652MqjvQhouc+p7P6WdjW450WA4KXw1sO74VM+Ur4KiC3/vFzxetcG3
         4JSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EMvx28QOUtxXZ96LQ6qQggtpOTuwWkmPV+zOmRtkw9Q=;
        b=Cg/Jfz/kxvfvrVua/Xdxrl1jR31RPqX35LF+smOp19oGTyuQ7dvAk1eO3LsefizqRc
         ZyF6IoYMp7fM09Jl9m7yU297GkE+WIF5hR17/csvhbfBJH6wPlQOBDAI7eKFMJuh014U
         FUucf7YR2KcoRtIwq07QPr3GYjuAtLuKVZw0rJx1172Ch+TUatQ0DMTyXSrp4//PIYp8
         adbdQ3AKzQwzHPtPnrH+JwPCit0XwJK3N2vuEuBkdDCb0/sRg0FyeB8uWEra499uYU0J
         sqmeKrgYZstK7ZyeblIERb15YS2DLVWO7r7ikMNO1dGe0iOb3eeWiOr2c7JSFqeGBUWL
         POcg==
X-Gm-Message-State: APjAAAVJPgSas7InLJneW93Lb8/eVPUkB7clvhRV2eFPOvfYK0okv87Z
        Fw+DEAU/SPSROK4rgsiDFyIInFHP
X-Google-Smtp-Source: APXvYqweRWu/DP0knN9m1hHH+G85wVzfCYFRm8hSwaoqIW2QRTecx49Ws51ZBnGFAnIOyKe762WfsA==
X-Received: by 2002:a63:6c09:: with SMTP id h9mr24249626pgc.34.1576584110579;
        Tue, 17 Dec 2019 04:01:50 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id a15sm27531723pfh.169.2019.12.17.04.01.49
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 04:01:49 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 10/15] t1306: convert `test_might_fail rm` to `rm -f`
Date:   Tue, 17 Dec 2019 04:01:35 -0800
Message-Id: <d39422505f16a14c64514b8a78ae351f41b75c44.1576583819.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.0.627.geba02921db
In-Reply-To: <cover.1576583819.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail() family of functions (including test_might_fail())
should only be used on git commands. Replace `test_might_fail rm` with
`rm -f` so that we don't use `test_might_fail` on a non-git command.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t1306-xdg-files.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
index 21e139a313..dd87b43be1 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -153,7 +153,7 @@ test_expect_success 'Checking attributes in both XDG and local attributes files'
 
 
 test_expect_success 'Checking attributes in a non-XDG global attributes file' '
-	test_might_fail rm .gitattributes &&
+	rm -f .gitattributes &&
 	echo "f attr_f=test" >"$HOME"/my_gitattributes &&
 	git config core.attributesfile "$HOME"/my_gitattributes &&
 	echo "f: attr_f: test" >expected &&
@@ -165,7 +165,7 @@ test_expect_success 'Checking attributes in a non-XDG global attributes file' '
 test_expect_success 'write: xdg file exists and ~/.gitconfig doesn'\''t' '
 	mkdir -p "$HOME"/.config/git &&
 	>"$HOME"/.config/git/config &&
-	test_might_fail rm "$HOME"/.gitconfig &&
+	rm -f "$HOME"/.gitconfig &&
 	git config --global user.name "write_config" &&
 	echo "[user]" >expected &&
 	echo "	name = write_config" >>expected &&
@@ -183,8 +183,8 @@ test_expect_success 'write: xdg file exists and ~/.gitconfig exists' '
 
 
 test_expect_success 'write: ~/.config/git/ exists and config file doesn'\''t' '
-	test_might_fail rm "$HOME"/.gitconfig &&
-	test_might_fail rm "$HOME"/.config/git/config &&
+	rm -f "$HOME"/.gitconfig &&
+	rm -f "$HOME"/.config/git/config &&
 	git config --global user.name "write_gitconfig" &&
 	echo "[user]" >expected &&
 	echo "	name = write_gitconfig" >>expected &&
-- 
2.24.0.627.geba02921db

