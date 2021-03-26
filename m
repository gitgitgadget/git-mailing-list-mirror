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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DE7C433E2
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 10:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F304E61A58
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 10:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhCZKhM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 06:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhCZKg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 06:36:59 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B246BC0613B2
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 03:36:58 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k8so5163742wrc.3
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 03:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=378K/RiUGYV2PbvabSpiNF5/4z6hyDVw8XPeL1VMt/o=;
        b=WTuD6g7GesoyyejdUQ1nqkNhBtvrnpMB4yYzGFzQ+ESsrPrIfTn4x2ULJxETGpMMND
         vBLn8z2tjyxjwa2nEsITDQ4/u2NPu6iWfZrXRw9PR2kKlzo4AjaJ9D6Jd8Ge5OHXki77
         Y+pXJLijyTPG3AkrvQk0pPnT4a6M7vqECj+9+pEtY8TCMg+zW953xkypOk57Dl2DMeMr
         370a4SmjNAa5ywOJRTDu0lURoATENBCLo9seXFRPxUiS5wwTWwmj5myGPJw3tfSv6u9p
         kFEan5AGzk04t5ogJk/R7/Y67uR3RfalPwfaRXbHHBdhCtZhro/hMgjZ62+8moIXXXox
         oaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=378K/RiUGYV2PbvabSpiNF5/4z6hyDVw8XPeL1VMt/o=;
        b=XLv5TEKXeO+e7AsIn6lyhaF11OgqZQLYQhMrSlFV4DBwvc2HM58pG1ykzN+bGAtiI1
         qPAL24FLmVJgMST/Lh6YaFdqR1/bt7VgAQGZ8HU3QoprU38bxgHbo0hYmSrdiFJS2R6V
         mdnDo5hsQ/rJFq5ofqzJaIImOmxwc31zOzFPIKFYTuqo9oB07AU8KyG+K2C+63to51JQ
         aplRnEdbRM5tvWzsHhL27Y11Sci+HoM/R6zIOVufgLJ8FEepd7AJSrrU2lE1/Drxdo0t
         tk9PwBnzpbULCTwAK4F+/8FNRJcUl8iwjWv9GXUzA9mL4bW5+51wCd5ynZhjdNN8bzPl
         Sgnw==
X-Gm-Message-State: AOAM5302jiLXwJpjq3fEYAM7U6ZeLdSnAsLDCA15WRw6KSNbeeqJW18/
        IHk/4dA+OvsbDpjVGdb+rlXpziddbkxFOA==
X-Google-Smtp-Source: ABdhPJzrJ353umCFxMGQvNpuOFwSjAQfgOKqfVr/rrbQS/7U+v8U4S81CdVg6hkJBXebivKbOzH8Kw==
X-Received: by 2002:a5d:6a11:: with SMTP id m17mr14101984wru.361.1616755017170;
        Fri, 26 Mar 2021 03:36:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o2sm1752563wmr.10.2021.03.26.03.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 03:36:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] doc lint: Perl "strict" and "warnings" in lint-gitlink.perl
Date:   Fri, 26 Mar 2021 11:36:48 +0100
Message-Id: <patch-3.6-12573d90289-20210326T103454Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.419.gfc6e4cae13
In-Reply-To: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend this script added in ab81411ced (ci: validate "linkgit:" in
documentation, 2016-05-04) to pass under "use strict", and add a "use
warnings" for good measure.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/lint-gitlink.perl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/lint-gitlink.perl b/Documentation/lint-gitlink.perl
index 476cc30b837..35230875c24 100755
--- a/Documentation/lint-gitlink.perl
+++ b/Documentation/lint-gitlink.perl
@@ -1,5 +1,7 @@
 #!/usr/bin/perl
 
+use strict;
+use warnings;
 use File::Find;
 use Getopt::Long;
 
@@ -45,7 +47,7 @@ sub lint {
 				report($where, $target, "no such source");
 				next;
 			}
-			$real_section = grab_section($page);
+			my $real_section = grab_section($page);
 			if ($real_section != $section) {
 				report($where, $target,
 					"wrong section (should be $real_section)");
-- 
2.31.0.419.gfc6e4cae13

