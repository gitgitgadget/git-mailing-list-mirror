Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764F6EE49A0
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 03:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjHWD36 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Aug 2023 23:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjHWD35 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 23:29:57 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82481CF2
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 20:29:55 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bdf4752c3cso31244445ad.2
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 20:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692761395; x=1693366195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5i5y/1FDdwwNbEXNrzdXi753Z2ODem8RS8W/fWS1iOU=;
        b=gQjrJ9b4J0Xp+WiNrGe9j3EQzbt5O15mGuBW196vI5jYBPUTG1yVHVfMgH0rMCJYrd
         7KRyYrKvQDkGT5omyhG7K2i+2/OQ8cWetCIKjglaiCaYfl72U3IIa5RQqNtmjb5l33M+
         bBONYlLb2Pd0sC3nt2VIXeYss/XW5TKnZubP9xn6+IvOxmFZy7EkL4RCbvhEULBMtPfE
         HviSzxXIDhqHLRgEZ326zIgPZBVv9dSW6cFJoFQa3ldWI9hz5eY+ag3DnJUA92lgSg1q
         OiPeWU33A39n0ho19CcBrkDlwCLx+htWnUMbIY1B5oypH6TnIj+MNnTs70yIPFJEHGQ+
         eq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692761395; x=1693366195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5i5y/1FDdwwNbEXNrzdXi753Z2ODem8RS8W/fWS1iOU=;
        b=hly20BBzvP61k/JjpexNqQiLOS99yBfokFjgdFfEAsIGNDEAn7Z8j4ASD1WJqM+dbI
         uQKiFqvW7JOvn9lJwzD7E5uIAmfKC5TUUnQEBaKEHXqbqLQG5QDlvLya91huSqTTgBPP
         eaHWESXEQLUaSlt4TQyTSMLBEndLehfvmbVwmcXleJr8SlOJ9W5lSvg+vakBcd02a1QP
         edqbNsLA27GQ/Rwr1XRcZ5DqVdcUkRBMDZGCKlFCpmvAHd8mOr3Fo5qpNWsV/WK3hp+X
         t7eMDHpnaDX4k75g/xW3et8zi2O/rlOypuh1UrIWjqIRzmnFlH6P/gNNXKQk4gqkQ0IF
         60ZA==
X-Gm-Message-State: AOJu0Yy2WaxmTud+7gGQ9JnkjydOKLTzHecXlLYrNQ4JPOrHeisz1XFz
        JFkfUDube2g3IJjJk6l9mzEs9DVDNTl5tg==
X-Google-Smtp-Source: AGHT+IF9rxXKIKrMrJF/9AKlnkzxyoaW2lSK3yLEMIKSV0KwkGVZVUN2nsQmQdZ9bAw4kNOSRQUp9Q==
X-Received: by 2002:a17:903:124b:b0:1bb:a367:a70 with SMTP id u11-20020a170903124b00b001bba3670a70mr10064950plh.17.1692761394571;
        Tue, 22 Aug 2023 20:29:54 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id kx14-20020a170902f94e00b001b567bbe82dsm9762591plb.150.2023.08.22.20.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 20:29:53 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, Jens.Lehmann@web.de, gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] submodule: deprecate --recurse-submodules=""
Date:   Tue, 22 Aug 2023 21:28:37 -0600
Message-ID: <20230823032839.731375-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The unusual syntax --recurse-submodules="" (that is,
--recurse-submodules with an empty string argument) has been an
undocumented synonym of --recurse-submodules without an argument since
commit 8f0700dd33 (fetch/pull: Add the 'on-demand' value to the
--recurse-submodules option, 2011-03-06). Deprecate that syntax to avoid
confusion with the submodule.recurse config option, where
submodule.recurse="" is equivalent to --no-recurse-submodules.

The same thing was done for --rebase-merges="" in commit 33561f5170
(rebase: deprecate --rebase-merges="", 2023-03-25).

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 submodule-config.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 6a48fd12f6..8acb42744d 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -332,11 +332,17 @@ int option_fetch_parse_recurse_submodules(const struct option *opt,
 
 	if (unset) {
 		*v = RECURSE_SUBMODULES_OFF;
+	} else if (!arg) {
+		*v = RECURSE_SUBMODULES_ON;
 	} else {
-		if (arg)
-			*v = parse_fetch_recurse_submodules_arg(opt->long_name, arg);
-		else
-			*v = RECURSE_SUBMODULES_ON;
+		if (!*arg) {
+			warning(_("--recurse-submodules with an empty string "
+				  "argument is deprecated and will stop "
+				  "working in a future version of Git. Use "
+				  "--recurse-submodules without an argument "
+				  "instead, which does the same thing."));
+		}
+		*v = parse_fetch_recurse_submodules_arg(opt->long_name, arg);
 	}
 	return 0;
 }
-- 
2.41.0

