Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E1FEB64D9
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 15:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjGGPTH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 11:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjGGPTC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 11:19:02 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3690C2123
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 08:19:01 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-635de6776bdso14261916d6.2
        for <git@vger.kernel.org>; Fri, 07 Jul 2023 08:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688743140; x=1691335140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iA5bHkUBVq0H/s2qn/18DqjwN31FuX+wGgYKZJPMS0E=;
        b=AqlUG6Dyt3zR6bvZXoVGoJ65iYwGCy87pTdBgHJBhFanx9rHEJXq8vXQ4KuUyMuPkG
         52X5dbn6lgeau9Dcv4hJjcVqGI1eLGySZUQPPgbp50WxtYFyXoQt9OAGDQWWPLv8zR/V
         fEsqgOlFxl5+QtXavH5n9/oqCsHTVHmrF/ZqwzOqbO7XTAItRoLRAYocwFXA+lxzo5u6
         jHBfNzigN/4pBKcWSCaymjsISUhIuFNtW0bmJo3PxdClHCfTg22Jh/Nn5nBp+mn/tX4C
         iEXJM9rfqhsZvsKBgxe520FBUPrfbX2Dvwg3tMMZ9GLHzwCF4xGgHbpAOLdK7e91Y8GD
         bALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688743140; x=1691335140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iA5bHkUBVq0H/s2qn/18DqjwN31FuX+wGgYKZJPMS0E=;
        b=aHcloJTuMmbrhO88SojZhKAAo1eojye4ZT+01DtNaNA29RcdqeSm/2s8W3v4B0ES0O
         iWg6hldGXyh/mt0zCyYh/sFPMVWWN//OtV1TO2sq2eXzUgmnFDrBQePWhmc6aJLukfti
         cq+4vTr4Pz2xt8hKsRiR1yW6DaKevGAWi+66Ly7eoX9xEyNtkJRucqvKKXJHD7hhnbs7
         KZx2dmD42NsrEnk2+qmi9P7N5bo/aiAiSw/BbspTjvDQU7eaaDIDftuPzMyytgv9TFj3
         vGxiZE8cGcrmXwW+COmxcSi3L/YSpvEWg3FBNSmKI6tu8Q8uvt1cexpUnR1+OgSYnLbY
         uQiA==
X-Gm-Message-State: ABy/qLYIz8+sFvcRLljKqWYURdKHyyemkMoiveyxEz6u/dRWmJsBtrkN
        CDLkviSgkMFo56UeWq+uEAcEcPUS110=
X-Google-Smtp-Source: APBJJlHsLUvhu4Q8R/5IueaLS+zNYEg9PZhXoePnZ3F6bEKFzqMiQVzMudnQH6mwHqnlGK5dQT+TDQ==
X-Received: by 2002:a0c:8c8b:0:b0:637:7671:5899 with SMTP id p11-20020a0c8c8b000000b0063776715899mr4419811qvb.27.1688743139937;
        Fri, 07 Jul 2023 08:18:59 -0700 (PDT)
Received: from localhost.localdomain ([69.158.190.118])
        by smtp.googlemail.com with ESMTPSA id a14-20020aed278e000000b004039e9199cesm338698qtd.60.2023.07.07.08.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 08:18:59 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com
Subject: [PATCH v2 2/3] t1092: add tests for `git check-attr`
Date:   Fri,  7 Jul 2023 11:18:38 -0400
Message-Id: <20230707151839.504494-3-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230707151839.504494-1-cheskaqiqi@gmail.com>
References: <20230701064843.147496-1-cheskaqiqi@gmail.com>
 <20230707151839.504494-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add smudge/clean filters in .gitattributes files inside the affected
sparse directories in test 'merge with conflict outside cone', make sure
it behaves as expected when path is outside of sparse-checkout.

Add tests for `git check-attr`, make sure it behaves as expected when
path is both inside or outside of sparse-checkout definition.

Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 40 ++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 8a95adf4b5..839e08d8dd 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1006,6 +1006,17 @@ test_expect_success 'merge with conflict outside cone' '
 
 	test_all_match git checkout -b merge-tip merge-left &&
 	test_all_match git status --porcelain=v2 &&
+
+	echo "a filter=rot13" >>.gitattributes &&
+	run_on_sparse mkdir folder1 &&
+	run_on_all cp ../.gitattributes ./folder1 &&
+	git -C full-checkout add folder1/.gitattributes &&
+	run_on_sparse git add --sparse folder1/.gitattributes &&
+	run_on_all git commit -m "add .gitattributes" &&
+	test_sparse_match git sparse-checkout reapply &&
+	git config filter.rot13.clean "tr 'A-Za-z' 'N-ZA-Mn-za-m'" &&
+	git config filter.rot13.smudge "tr 'A-Za-z' 'N-ZA-Mn-za-m'" &&
+
 	test_all_match test_must_fail git merge -m merge merge-right &&
 	test_all_match git status --porcelain=v2 &&
 
@@ -2259,4 +2270,33 @@ test_expect_success 'worktree is not expanded' '
 	ensure_not_expanded worktree remove .worktrees/hotfix
 '
 
+test_expect_success 'check-attr with pathspec inside sparse definition' '
+	init_repos &&
+
+	echo "a -crlf myAttr" >>.gitattributes &&
+	run_on_all cp ../.gitattributes ./deep &&
+
+	test_all_match git check-attr -a -- deep/a &&
+
+	test_all_match git add deep/.gitattributes &&
+	test_all_match git check-attr -a --cached -- deep/a
+'
+
+test_expect_success 'check-attr with pathspec outside sparse definition' '
+	init_repos &&
+
+	echo "a -crlf myAttr" >>.gitattributes &&
+	run_on_sparse mkdir folder1 &&
+	run_on_all cp ../.gitattributes ./folder1 &&
+	run_on_all cp a folder1/a &&
+
+	test_all_match git check-attr -a -- folder1/a &&
+
+	git -C full-checkout add folder1/.gitattributes &&
+	run_on_sparse git add --sparse folder1/.gitattributes &&
+	run_on_all git commit -m "add .gitattributes" &&
+	test_sparse_match git sparse-checkout reapply &&
+	test_all_match git check-attr  -a --cached -- folder1/a
+'
+
 test_done
-- 
2.39.0

