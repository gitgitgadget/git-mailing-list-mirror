Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD0C01F453
	for <e@80x24.org>; Sun,  3 Feb 2019 21:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfBCVBM (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Feb 2019 16:01:12 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:53928 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbfBCVBM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Feb 2019 16:01:12 -0500
Received: by mail-wm1-f48.google.com with SMTP id d15so11193640wmb.3
        for <git@vger.kernel.org>; Sun, 03 Feb 2019 13:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UoTVKHoLIG/o0wRN6UL8nGX/g6yBS1PF2k0qbG7gIW4=;
        b=iO8MyWtllA8helTMDoDfzSjBCrbycSY+6n/Ojt153uJE3+z72mZ0LXVAfcBVx8yW82
         lgiLMKhLhKOZRr4VyyA7nbIYd5xBH6zK4r5lP0ryC/pwWvLOjJkH2nq2hzMtP9xEtlsl
         IC4hB2nZagJDCUXiXEOe4+2xlUiergIl4EheFNhy4xkT7vJC9E/DhBOCes5swqumD/Pt
         2t1deHZT0SIzANHsNvEIgUppWC6EFldTqFDpZWE/GeNYko6k6clxUxlLRzy7BdYRNLf4
         xXupNTcs+ZTNbmZmDwsXF+6/bCfEJjlTQHQsfyxZ5U3ZJ5mPrCKRS1iHTGk8XCrGRL1f
         dAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UoTVKHoLIG/o0wRN6UL8nGX/g6yBS1PF2k0qbG7gIW4=;
        b=lsbLHHACjnju1+1Y1+IKv6z42CLWMF2DOu5lE1HwiMW4OvnMd374pJQVmwCMlxBKLc
         7HhHsv1Ccoq5+xgVGyWEvS0GFGDH4fmX1EAAVyPzGAVNtjJFwX7RQKIbJBIGq2wVdnci
         L6/LOEvEXLyO4IH7KVDFcSLbhbEwKxPXivTKuFA+29cauJE2xVqjAb66DGAG81G8Xtg9
         VDMrW9/LyWqRol3EOoQRiQPKytYCTYKnZVCYQZDiQMljKAjeOls6Sskw7T6fX7oEXJ4+
         winEyxhjLxcQwvpO7bRqPLh9rWMGZVTDETbYyGKOjipddGRbrNOcoPv87Ecu0cOw0pm/
         CaFA==
X-Gm-Message-State: AHQUAuby1ah/ZrZm/U5hCSi8FMax+NfhIvQAswwPfwZH0QaeZZos6s2q
        EanUDo42l6E3dj8XhAlbvHtKWekY
X-Google-Smtp-Source: AHgI3IahpxVo4Ds+7J58ObVnsutfUS7ydLR9kL5wpy1Hvhxkjq3NF8fNrQiNfW9Xf0AcIn/Mzq9ITg==
X-Received: by 2002:a7b:cd14:: with SMTP id f20mr10012569wmj.93.1549227670340;
        Sun, 03 Feb 2019 13:01:10 -0800 (PST)
Received: from t500.lan (13.162.125.91.dyn.plus.net. [91.125.162.13])
        by smtp.gmail.com with ESMTPSA id a187sm9679787wmf.33.2019.02.03.13.01.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 03 Feb 2019 13:01:09 -0800 (PST)
From:   Sven van Haastregt <svenvh@gmail.com>
To:     git@vger.kernel.org
Cc:     Sven van Haastregt <svenvh@gmail.com>
Subject: [PATCH v3] git-submodule.sh: shorten submodule SHA-1s using rev-parse
Date:   Sun,  3 Feb 2019 21:00:27 +0000
Message-Id: <20190203210027.13272-1-svenvh@gmail.com>
X-Mailer: git-send-email 2.12.2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Until now, `git submodule summary` was always emitting 7-character
SHA-1s that have a higher chance of being ambiguous for larger
repositories.  Use `git rev-parse --short` instead, which will
determine suitable short SHA-1 lengths.

We cannot always rely on successfully invoking `git rev-parse` in the
submodule directory.  Keep the old method using `cut` as a fallback.

Signed-off-by: Sven van Haastregt <svenvh@gmail.com>
---

Differences since v2: Simplify code as suggested by Eric
Sunshine <sunshine@sunshineco.com> and suppress stderr.

 git-submodule.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5e608f8bad..e26146e721 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -850,8 +850,11 @@ cmd_summary() {
 			;;
 		esac
 
-		sha1_abbr_src=$(echo $sha1_src | cut -c1-7)
-		sha1_abbr_dst=$(echo $sha1_dst | cut -c1-7)
+		sha1_abbr_src=$(GIT_DIR="$name/.git" git rev-parse --short $sha1_src 2>/dev/null ||
+			echo $sha1_src | cut -c1-7)
+		sha1_abbr_dst=$(GIT_DIR="$name/.git" git rev-parse --short $sha1_dst 2>/dev/null ||
+			echo $sha1_dst | cut -c1-7)
+
 		if test $status = T
 		then
 			blob="$(gettext "blob")"
-- 
2.20.1.dirty

