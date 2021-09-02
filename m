Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC60C433B4
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 16:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFCC160FDA
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 16:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346099AbhIBQCj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 12:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346081AbhIBQCe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 12:02:34 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2132CC0612A5
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 09:01:33 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v10so3756861wrd.4
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 09:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9v7RFIwRe7fpQNRWjZ8Quocz9Rmiz5cTvDNaozRmuRw=;
        b=Xo91PidMMpGrVVH0w7qymdkeg5pjBEdjnC5kqmKObFL34WTlHkdYdKh8ImlOhPLHM6
         8kMnre/hO2QUcD9BwoMXhRYlU7jqF1Za/wK1l35MIm67gChWx8MxnCM26zyV41gTi1OD
         EXCtiqJ0mpi0PF2r1vkbB/h8PCLZPW8sUIdNezHL6HOGl4ia7KSysweUFPlyQ5XaK30M
         Tjtg2ngkjRaRs+Xon1jpfD699afkiZl+RZmlHFGPR1RlHePE+ankV+EGVWwwNd7xLIaA
         O9VHPZweXROXUQ/Hq6uKvlUaEr+7lD3KN40GOxWMt2rJqsRhyNVxUWW6gDXMMLCMkQsc
         QQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9v7RFIwRe7fpQNRWjZ8Quocz9Rmiz5cTvDNaozRmuRw=;
        b=YkykEwEVPw1tDiowXjDlMmwNpqwcjRkKG9c3z2Bbw2tF4VHi80rJ7Ida4EZHzpR/p9
         yB/xDkUWwOoNbdyhcu1MT7qhXhpdpN3MJe6pH67dvl8ML7V01mv+H0yozZ8y7oH7Z3UL
         tr2s87CI/bLGXmFY5/pH5UgpkbQgEkCO1tN1MNXwJN/3sI4Fzx8KpJwCWkA3RCTwa6YX
         dgOI99f6NuyS/d0ziZbukxVewEfWuwz7zh0ESfifh8JRd6U0eGTki4ZYw0MWyX+p+C5i
         yaKmS28WzjidA/jTgEk5nVxfnkkoJd2j9/JLwKAJ1UJ4gM3Farm1C9e9qMT235eFTpW1
         7mhg==
X-Gm-Message-State: AOAM532eqYPk7gztHyy+l+Jq05EVyZl5Gsfg4gB6BQxOMfxNtGv4TkuD
        7O6HloPwron+8wiHhhiKGYJSLDxJF7a+RA==
X-Google-Smtp-Source: ABdhPJwMbJD3UYTv2heThzsWc8qveUKnTHDCueTwuIzLM+y2q+vXbL9uzJ9hdh9PL4kAjvJz8h0Pfw==
X-Received: by 2002:adf:fd0a:: with SMTP id e10mr4676715wrr.2.1630598491469;
        Thu, 02 Sep 2021 09:01:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u26sm2403215wrd.32.2021.09.02.09.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 09:01:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 8/9] git-bisect: remove unused SHA-1 $x40 shell variable
Date:   Thu,  2 Sep 2021 18:01:15 +0200
Message-Id: <patch-8.9-88dffac9088-20210902T155758Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.814.gb82868f05f3
In-Reply-To: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This variable was last used in code removed in
06f5608c14 (bisect--helper: `bisect_start` shell function partially in
C, 2019-01-02).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-bisect.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 6a7afaea8da..b59f3aaad43 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -34,8 +34,6 @@ Please use "git help bisect" to get the full man page.'
 OPTIONS_SPEC=
 . git-sh-setup
 
-_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
-_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 TERM_BAD=bad
 TERM_GOOD=good
 
-- 
2.33.0.814.gb82868f05f3

