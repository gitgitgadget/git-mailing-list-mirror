Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F07C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 09:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89AF96104F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 09:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238950AbhHMJOt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 05:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239014AbhHMJOq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 05:14:46 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3351C061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 02:14:18 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id t16so7701556qta.9
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 02:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ImZadw+suCVRaXYGAHVUNHAcesIq/fXZiE8QwERkWfg=;
        b=Fbt6cnEfhCn/dfsKkiTqTV/NdZT8KthZRemQvYuEVYxMTaro2kJwIeV7yEzbQnefbh
         h9BiQNczhbKswCUrmTuTuV+OzBQXEctqySwBOc3ZLGyerd/NjUkymXnog+qnKx+Aj4fj
         Rwq5OcqRqdD7YNPJ8PKSQK/wF5iXCCqbuEKZJzb+e7g/W1gb/UpVHgBsXyhMU7IrGBp0
         c9t47fO4OSxN3pj+93RzTUNgrjP+Ho/pluxUfhCQB0cNL1+7w8XFmjdpR6Clf1IRb1IT
         3hVyY7FyciX49H03P6VediFzIqtOEjGP5QWMxtGL7xkr5Lj6MKE2aOB849/ywEdTWl/i
         YsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ImZadw+suCVRaXYGAHVUNHAcesIq/fXZiE8QwERkWfg=;
        b=YbV8XpGLPESXxP153IfZ7Ufs1CausV9X3x7p2U/qvO7dTDBJKsxKBwncr50mUV2gl2
         RPdeSXZKg6wEfxMM7dt8w/pSDBzZY3TVlF4OoFzYvE+kuhhQdexXNs0PTRTlgbVkxvLf
         HaNJ5Kgthd20nOJb8tMWCL87+M7Ylz3khoEioIQdoY/FA/kfVR7GitA7ys2H79jR/bCI
         o75Jpo8Fjmw1SvoJ7kws3DZzfVBrITqM3YQjhZRmyZPZabcZwufuEg2h4fF67jFHjk8H
         MfKCx/1BURvlOu8eaGtwyvp0+EfK+PgmO+li/fshXXob2MURgOMrIm1jod187KoV47jV
         ypxg==
X-Gm-Message-State: AOAM532qgCpcPCIQcMVsDNay+JWlsncNF4Dcd8KDgc/Cxo53cOwlEM/p
        IklB7LX5YB7/2HOyd8QP8i2cZml3eSI=
X-Google-Smtp-Source: ABdhPJwb42a8kbPB0Mebgp2eUOasNqyG/J4lINONqyLNxzajntg+WJgaj+fyymkYNEmJxMolBghJbA==
X-Received: by 2002:ac8:5bd6:: with SMTP id b22mr1033624qtb.193.1628846057547;
        Fri, 13 Aug 2021 02:14:17 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id a185sm317627qkg.128.2021.08.13.02.14.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Aug 2021 02:14:17 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2] ci: use upload-artifacts v1 for dockerized jobs
Date:   Fri, 13 Aug 2021 02:13:49 -0700
Message-Id: <20210813091349.88574-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.379.g2890ef5eb6
In-Reply-To: <20210812065234.71399-1-carenas@gmail.com>
References: <20210812065234.71399-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

e9f79acb28 (ci: upgrade to using actions/{up,down}load-artifacts v2,
2021-06-23) changed all calls to that action from v1 to v2, but there
is still an open bug[1] that affects all nodejs actions and prevents
its use in 32-bit linux (as used by the Linux32 container)

move all dockerized jobs to use v1 that was built in C# and therefore
doesn't have this problem, which will otherwise manifest with confusing
messages like:

  /usr/bin/docker exec  0285adacc4536b7cd962079c46f85fa05a71e66d7905b5e4b9b1a0e8b305722a sh -c "cat /etc/*release | grep ^ID"
  OCI runtime exec failed: exec failed: container_linux.go:380: starting container process caused: no such file or directory: unknown

[1] https://github.com/actions/runner/issues/1011

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
v2:
* dropped unrelated chunk and better grammar as suggested by Junio

 .github/workflows/main.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 47876a4f02..68596f2592 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -271,7 +271,7 @@ jobs:
       if: failure()
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v2
+      uses: actions/upload-artifact@v1
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
-- 
2.33.0.rc1.379.g2890ef5eb6

