Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE32BC433E6
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96F0E64FAD
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhCKAPd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 19:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhCKAPT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 19:15:19 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E212FC061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:15:18 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id r15-20020a05600c35cfb029010e639ca09eso12148158wmq.1
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S6rVXI4tbstIE1477EStVhSB7+nuRlVWvSr3u38160E=;
        b=Knh2kjvY3OjlBKttlUNIOQU5golmxGXi4VgCZyU6ARlTgCT0XJKN/vnrNZgVheYXEE
         Znt8y4WLbhAw+inuCtlRwP2YTZzjTeC/PvRahXZMbX9F1tCOs8Z5kL3UhkCgyhVNQBd8
         4znT/j8XyOqjy43rOrt3UgjQmTqF4FRZifHxTkqVCzf6fdX5RvJ/yDc6PIUIdvC4bXjt
         cyiaCjf8AD/RK6Vmk2uqPyQsG6eTf1fFC/1R+Bt8/ANUwOavOpVUPBchOzjm+Jvb/io7
         zB+InXGOUcTxeD+EStywlsCdLzYbHKbm+7uoo/5/i+PlifhO88sbzTSd1UOqwVf+uJ9l
         1fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S6rVXI4tbstIE1477EStVhSB7+nuRlVWvSr3u38160E=;
        b=RdcCRhnNCVY2gIFubiUsRS9JJrCeZ8oUivZ9GG28aTQTqQ8V/y0LM2faS5wbzey8E8
         kG3a8h6wGt1OmSv7vqTBNeskxYCVF0YOF6SylaOX6CsLQEyRdWdgZd5GAnYDLaFfs8KK
         jbdNKFjq+5tn4LJa+aj3orCwhvLYsq5QgziWSHBCrPKOii/uyw/cQsEaWk7BKiqBmRBQ
         mhYlELDq4bfQ06brNXm5Yjjo+LB3a+lv+rbm4BXYcMVkXQ1Ru7luZTOQ30qF8cD4cNza
         zo1DyJqZImCFPjrKup+Nw9mwaxyATL+qAr+KlklJGnb9lEk5Qli5/NonBJPlxeNIyhGi
         /NUQ==
X-Gm-Message-State: AOAM5314UVy5oaG26AgsC5pxpM3ILxVnhn0ltRnpnAS1dALMt1xSec/A
        RbR7O8vBKo3iJQSQjOltji8itlgt59M=
X-Google-Smtp-Source: ABdhPJw9j7UQLKPf36TMcEM0kjgWjpXp8aJ85UL9bbd5dtpIAhnKOmKTM9XTbD4A2j8YQKwyonXsKw==
X-Received: by 2002:a1c:a916:: with SMTP id s22mr5784971wme.82.1615421717384;
        Wed, 10 Mar 2021 16:15:17 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s84sm1026447wme.11.2021.03.10.16.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 16:15:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/4] git-bisect: remove unused SHA-1 $x40 shell variable
Date:   Thu, 11 Mar 2021 01:14:44 +0100
Message-Id: <20210311001447.28254-2-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc1.213.gbfdb770ff55
In-Reply-To: <YEj82fOf+F4xJC8S@coredump.intra.peff.net>
References: <YEj82fOf+F4xJC8S@coredump.intra.peff.net>
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
index 6a7afaea8d..b59f3aaad4 100755
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
2.31.0.rc1.213.gbfdb770ff55

