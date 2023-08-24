Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3DFC3DA6F
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 18:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243041AbjHXSlO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 14:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbjHXSkm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 14:40:42 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E2AE50
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 11:40:40 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d743a5fe05aso155100276.2
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 11:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692902439; x=1693507239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PEpQJoX6umF6aNN9++OpECtzl8JAgkROYh5sQYRBY1A=;
        b=sQSL8Jn4z/RDvQL468JurcTdZzfeUla2/yfrEtXv097JZ6/kKR8FJD2tA2EiJ/Ar6z
         5aubx1CsJ6wvoekd1YV9kcMmtBos9Nc7xautWkj3Jo4SNOsJDnvDdCABPEQXKSaQxeDD
         KJP4UAfYyX9iuzoaze9EISc6xpAzNOIVWMCVwqB5sDGtmdotcpLlWx6kp7gItqpJTUZW
         MK255HEVm1IO8srBC3bsqc5rhmn3dArZG89yFk5Coo/vsirRkH1/Db2ao0Bu84pzZCOi
         t83Iyv7VTD554LOmqpQ4faf6c6sWa+TVRhemw4pdd8CD+n7JOsWlDp2TyloHmJDQTkL0
         I0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692902439; x=1693507239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEpQJoX6umF6aNN9++OpECtzl8JAgkROYh5sQYRBY1A=;
        b=Ltu3wpTrJqDqAtDjV799Dvt2HfiXOjR6Y5G1nszkmyKKlD5PAzycy5jK+DtRvlONoz
         bU8PO4CcnyLQCCfRgzSi9oO2dmW3+uGt4M7nfhVcSo/IlwlMuIs8qbIAsfcvmIgoe+yO
         bWhkLVc79ve7q1Y5IoXppq8ozGzx9yDp1scrjtxHTRcqzvygMctzsS5ZxoAsVD0XT/2R
         5Ua2DV68FZiT8ajoFaz882JIJWHuuUkuLm2HSY+XnXPts+EvKzRiI/0hZQsYgV85tqiP
         +QJ421cZMI80PBLDABWPfooe06Ksi86HFE5qg5oq7Ouegu1FcyK3egNqj9lG/L2++dw8
         PeLg==
X-Gm-Message-State: AOJu0Yzwjm5CCcnvXsPzJ0ICAze/e8Lb2P7IeEx/icCqD6rCrTfAoUmb
        r6axbS3Q6heum9s6nHV9HkwgnwvX7YqWHM0IJDIVyg==
X-Google-Smtp-Source: AGHT+IF69be7zVSrog1AlCW3OucOV+49D0YvK0qamUUC3zFesIR4C+owZYSq7NlPy4Q9EllyOvYUTw==
X-Received: by 2002:a25:244a:0:b0:d5c:ce73:6528 with SMTP id k71-20020a25244a000000b00d5cce736528mr17237285ybk.35.1692902439458;
        Thu, 24 Aug 2023 11:40:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g22-20020a25ae56000000b00d74b8fa3497sm886ybe.20.2023.08.24.11.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 11:40:39 -0700 (PDT)
Date:   Thu, 24 Aug 2023 14:40:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 1/3] leak tests: mark a handful of tests as leak-free
Message-ID: <b1711c4c817f95011bc477a9485c115b4926c7da.1692902414.git.me@ttaylorr.com>
References: <cover.1692902414.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1692902414.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the topic merged via 5a4f8381b6 (Merge branch
'ab/mark-leak-free-tests', 2021-10-25), a handful of tests in the suite
were marked as leak-free.

As far as I can tell, each patch from that series ran tests from a
handful of subject areas, such as "some ls-files tests", or "all trace2
tests". This left some gaps in which tests had and hadn't been audited
to be leak-free.

This patch closes those gaps by exporting TEST_PASSES_SANITIZE_LEAK=true
before sourcing t/test-lib.sh on most remaining leak-free tests. This
list was compiled by doing:

    $ make SANITIZE=leak
    $ make \
        GIT_TEST_PASSING_SANITIZE_LEAK=check \
        GIT_TEST_SANITIZE_LEAK_LOG=true \
        GIT_TEST_OPTS=-vi test

and looking through the list of failing tests in the output.

There are a couple of other tests which are similarly leak-free, but not
included in the list of tests touched by this patch. The remaining tests
will be addressed in the subsequent two patches.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5571-pre-push-hook.sh | 1 +
 t/t7516-commit-races.sh  | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/t/t5571-pre-push-hook.sh b/t/t5571-pre-push-hook.sh
index a11b20e378..448134c4bf 100755
--- a/t/t5571-pre-push-hook.sh
+++ b/t/t5571-pre-push-hook.sh
@@ -4,6 +4,7 @@ test_description='check pre-push hooks'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7516-commit-races.sh b/t/t7516-commit-races.sh
index 2d38a16480..bb95f09810 100755
--- a/t/t7516-commit-races.sh
+++ b/t/t7516-commit-races.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='git commit races'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'race to create orphan commit' '
-- 
2.42.0.3.g4011eb6a8b

