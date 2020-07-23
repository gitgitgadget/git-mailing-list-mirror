Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B35FC433E4
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 21:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61B0E206E3
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 21:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gE+K7yOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgGWVi4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 17:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgGWVi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 17:38:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA159C0619D3
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 14:38:55 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z18so2940321wrm.12
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 14:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7b0gY7BZo1FVmv1FULC5Lr4YJxxFs+EoxJPNikYOEgo=;
        b=gE+K7yOmR25/vlQ3yjjo9oMuZ2KQdfi5+3jrc/XsukHshV2GosU63+tcNuGrVgDc+v
         JEt8PylByeKDZd7LjCWifOxxCF577+6NiSjsXNAli7EeEnJ9pmxOqekg4djthLFnKoCe
         Jn8q2zk+FhmG4r3eockut7YOUrIEocWlOmVeI+MXMD0scG+RhMlJ+wlr1m0cBanpczbd
         eqzeRPlDA1JnTuuWyzwtoBVSFsdn1VB446l1CW9OEskcvboGqRr7OrHRy3ddIysYlXi+
         aW4kkzu48v+ofum4u2kZdjfQq3D3SGH3UP0oc+QjXborwDOOfs8b2TFZM9otAV5MZxc1
         lCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7b0gY7BZo1FVmv1FULC5Lr4YJxxFs+EoxJPNikYOEgo=;
        b=tUvTPwRCAg9I6iX1zc0x0qnDk5MJVOvQX4a3D7158FYhmkAYUPiWCoUrFlGtE5fT5s
         3KcKCndH93dHjCtbQ2oCg5xUhc1ZCUlW5APL5nnwvC6E1mHm0siuUjU2zpj/X7SuK8D4
         klVcn2gZcRmH3rTLOvL6GWFNm9newgWfbz3RuIy8/wml6DJQcFTMlug/vwupqJCwNlIN
         OEHaxYqvwVZvgQku8a+7TNKyx+MG+tsUEUddk7L4dbQb0+xfkML03fBf7Ypj6jh3Zs9j
         4AAMjGRHXU0mtfbRAFqhOHSO3D3jHu18NtemdmlZkrMn7pA69rz7i76nX3oMvSD8hoH1
         hJng==
X-Gm-Message-State: AOAM532ZehjTiLRE/TGE21QPV8RgVPEQmVGi4BcvL1+HKnr3/n4XGqqQ
        DrHJnyd4lRalV7v/6Lff5Bw=
X-Google-Smtp-Source: ABdhPJxW4g7DD8rjAWbsClwodtMnSQ3qwx2hdJJqrT0/jMVW7d+DNJGYqRiFKVLHLgvss4x+LRnoSQ==
X-Received: by 2002:a5d:4c82:: with SMTP id z2mr5463944wrs.287.1595540334658;
        Thu, 23 Jul 2020 14:38:54 -0700 (PDT)
Received: from localhost.localdomain (62-165-238-20.pool.digikabel.hu. [62.165.238.20])
        by smtp.gmail.com with ESMTPSA id c136sm4919879wmd.10.2020.07.23.14.38.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2020 14:38:53 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2] ci: use absolute PYTHON_PATH in the Linux jobs
Date:   Thu, 23 Jul 2020 23:38:48 +0200
Message-Id: <20200723213848.30032-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.28.0.rc2.319.g2e16345e2b
In-Reply-To: <xmqqsgdk7gkq.fsf@gitster.c.googlers.com>
References: <xmqqsgdk7gkq.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In our test suite, when 'git p4' invokes a Git command as a
subprocesses, then it should run the 'git' binary we are testing.
Unfortunately, this is not the case in the 'linux-clang' and
'linux-gcc' jobs on Travis CI, where 'git p4' runs the system
'/usr/bin/git' instead.

Travis CI's default Linux image includes 'pyenv', and all Python
invocations that involve PATH lookup go through 'pyenv', e.g. our
'PYTHON_PATH=$(which python3)' sets '/opt/pyenv/shims/python3' as
PYTHON_PATH, which in turn will invoke '/usr/bin/python3'.  Alas, the
'pyenv' version included in this image is buggy, and prepends the
directory containing the Python binary to PATH even if that is a
system directory already in PATH near the end.  Consequently, 'git p4'
in those jobs ends up with its PATH starting with '/usr/bin', and then
runs '/usr/bin/git'.

So use the absolute paths '/usr/bin/python{2,3}' explicitly when
setting PYTHON_PATH in those Linux jobs to avoid the PATH lookup and
thus the bogus 'pyenv' from interfering with our 'git p4' tests.
Don't bother with special-casing Travis CI: while this issue doesn't
affect the corresponding Linux jobs on GitHub Actions, both CI systems
use Ubuntu LTS-based images, so we can safely rely on these Python
paths.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Junio, I see that you picked up the first/RFC version and applied it
on top of v2.26.2.  This patch won't work on v2.26.2, because its 'git
p4' is not compatible with python3 yet.

 ci/lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index ff24c547c8..3eefec500d 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -184,9 +184,9 @@ linux-clang|linux-gcc)
 	if [ "$jobname" = linux-gcc ]
 	then
 		export CC=gcc-8
-		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
+		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3"
 	else
-		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
+		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python2"
 	fi
 
 	export GIT_TEST_HTTPD=true
-- 
2.28.0.rc2.319.g2e16345e2b

