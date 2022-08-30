Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB0EECAAD4
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbiH3Jce (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiH3Jc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:26 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC19DDAB6
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:03 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-11dca1c9c01so15398376fac.2
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=AjkVUDWYaNWykE6lLpNh9SjNW7ND0zhhQV3lOJ4CUEc=;
        b=VgCtHz5tmzMI5WHOJBSBfD6Tj694icuzLmmDjYyxktPBtD+5X5VRyoH7NklBYmcff2
         pYfIWix6D77/ybx1c0eSptmHFdXxSexGYBP3W5EmZ9AMUnpcc546m9RILY3CZ7b/CVuR
         4QzsMg4q6578GJa1Vp/kszCXvfYdROPNIJi2UhMVXC4D8/Jq1DUG9Z1nFoL6IWBlbvGV
         iMY1OLrn5K3rnecG3zZWy5z0Gohw61yy9xaaZHhi/lTXSr6q0LxYCI9WBs2BpRNYuLda
         +6frcgv115q8e2PWDckoewijYVJPAx2QUrSxoFaBvoxo/iFes4+OLkjwy3mtWnuyPjXV
         EJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=AjkVUDWYaNWykE6lLpNh9SjNW7ND0zhhQV3lOJ4CUEc=;
        b=xlZB326fhLNzwleqolO9iDy4Na+G2/U2ldq2vQWGhZ/aeP/hfoHAjS8NQeFYxFgUoC
         mdgTx7rcREu1lcppWDFixPrPtGopdwHYODosFiUDr0tAwq31MePySdBY9Z8Yr2Jhsfx3
         y+T/TFAWjSuDzldjlJzSivIexnUysG5sPuuOfx2D2dzSlGA/Vc8V4hysCMO2DGuvApyw
         +T14p6g+2vlS8ZZ29SebyMnTUAKdN5aSQFjV8ebfisezjb8DvjM/iqJwR7SruHXGS4tJ
         keXQgjZeG5LQNUuDYFcSkvlMQrAL7D0CQybWP7NoZ3Iu2zUQjXV8D3EGPF5bB/lYuFwd
         zfEg==
X-Gm-Message-State: ACgBeo1epCvoHEmSb9kkJUv2x0HY8zhfRN2peu0zhFladVONlg9DRMJS
        KZjIdpjY4SA8SH7qm1+jzHdvNwhD7Dw=
X-Google-Smtp-Source: AA6agR4ThMyUfzL5tYsw0vci/eY/Q8NwLcJWdy1YGiEDE/o23jFEg5MYMzF9LXRAYikwnCBRhoyVLw==
X-Received: by 2002:a05:6808:1488:b0:344:dc19:d7d9 with SMTP id e8-20020a056808148800b00344dc19d7d9mr8902609oiw.196.1661851921814;
        Tue, 30 Aug 2022 02:32:01 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id y64-20020a9d22c6000000b006369d5d6372sm5986095ota.50.2022.08.30.02.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:01 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 13/51] test: completion: fix currently typed words
Date:   Tue, 30 Aug 2022 04:31:00 -0500
Message-Id: <20220830093138.1581538-14-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

They don't match what we are supposed to be completing.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh     | 4 ++--
 t/t9904-zsh-completion.sh | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 8cc30448c7..031f05cf47 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -486,7 +486,7 @@ test_expect_success '__gitcomp - option parameter' '
 '
 
 test_expect_success '__gitcomp - prefix' '
-	test_gitcomp "branch.me" "remote merge mergeoptions rebase" \
+	test_gitcomp "branch.maint.me" "remote merge mergeoptions rebase" \
 		"branch.maint." "me" <<-\EOF
 	branch.maint.merge Z
 	branch.maint.mergeoptions Z
@@ -494,7 +494,7 @@ test_expect_success '__gitcomp - prefix' '
 '
 
 test_expect_success '__gitcomp - suffix' '
-	test_gitcomp "branch.me" "master maint next seen" "branch." \
+	test_gitcomp "branch.ma" "master maint next seen" "branch." \
 		"ma" "." <<-\EOF
 	branch.master.Z
 	branch.maint.Z
diff --git a/t/t9904-zsh-completion.sh b/t/t9904-zsh-completion.sh
index d3fe42a9b3..e9df29c135 100755
--- a/t/t9904-zsh-completion.sh
+++ b/t/t9904-zsh-completion.sh
@@ -106,7 +106,7 @@ test_expect_success '__gitcomp - option parameter' '
 '
 
 test_expect_failure '__gitcomp - prefix' '
-	test_gitcomp "branch.me" "remote merge mergeoptions rebase" \
+	test_gitcomp "branch.maint.me" "remote merge mergeoptions rebase" \
 		"branch.maint." "me" <<-\EOF
 	branch.maint.merge Z
 	branch.maint.mergeoptions Z
@@ -114,7 +114,7 @@ test_expect_failure '__gitcomp - prefix' '
 '
 
 test_expect_failure '__gitcomp - suffix' '
-	test_gitcomp "branch.me" "master maint next seen" "branch." \
+	test_gitcomp "branch.ma" "master maint next seen" "branch." \
 		"ma" "." <<-\EOF
 	branch.master.Z
 	branch.maint.Z
-- 
2.37.2.351.g9bf691b78c.dirty

