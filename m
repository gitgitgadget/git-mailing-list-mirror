Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF3AC19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 16:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbiHDQ27 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 12:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236826AbiHDQ25 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 12:28:57 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541EE67148
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 09:28:56 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h34-20020a05600c49a200b003a5165eae0fso118420wmp.4
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 09:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=gVWkVlwo90wFvc4B3LJvIw/EYxu0d/ZD4Ho7ToXx2e0=;
        b=N6ea0pm6jJmuwDb7lWORt+STbUk8Zq157HrwSrwwCAce9Xw1ZKkunsPU5ZNhMJxPxN
         Haz2W/O/9kFpFDdzuLPvrZpmhu7schoPIXtFZ/1IB8urqD7UcLGpbeqrBLJ51ORQHZWq
         egMR3L1uMnt7wGwrNYHYkcmYq68jVdVLi1l9gGD/G64AWzFKtKwL5kf/sGfmkq6ZFghP
         VcwA8ZV+Dc1Ht69zBcRcwAA1XfrjIy0Y8cEOtTL5rTR+Ik3BVs96SoKqAn303kPLGTZY
         m3GrbxXBs08Yjmxk6tCZF3V2WxwdiAOw56mzsztMCdoKQabaPv9TGdLMoAP607mof9fp
         lucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=gVWkVlwo90wFvc4B3LJvIw/EYxu0d/ZD4Ho7ToXx2e0=;
        b=AudACfnmzZVvI/LshCNRYjxSZ9JP6p/fsC2a15TcTyetBs/ErW222zBL3/o8tJ2Aly
         uKq30NijZ+7flSgg6AfWLek3KcaxWdEtzONo3Le1VWRLABzaa2Z3dRlM2UFVFHipvoI5
         /CPbautzoO7JJSJ9nencAh0Aig3UC/VINrd6xLy8lw5auJh+KKmLLTY9jd5DatIXX+zO
         GVLUEu7VjHSwGcBWKusOLy4ZC+rA0SLu/WwCluJ+fZbdqFSKibqt6IQ/sV0gsGkD6nl3
         KkwXQgkzg3A9S4Gt2oLy/BHHzEudTbENrncVzvnMEiBAefULbMkvlJUbt79aKwdVnz5N
         PtKg==
X-Gm-Message-State: ACgBeo3yo/AmT2kGgBI8mGXQwAuI00XQg6VT+1n2QmxBuTsEUAk5UY/W
        EqgKSCQwvNy6PPNFVjBF10j76e/evMA=
X-Google-Smtp-Source: AA6agR764TDo1CkIe6Xz6RIbM9L4wVgZdRmnmjrXTng+b/JsQ2K7Rp93dwWm2ho4SHPoILXBPrIxSQ==
X-Received: by 2002:a1c:f719:0:b0:3a3:15d4:5752 with SMTP id v25-20020a1cf719000000b003a315d45752mr6919859wmh.194.1659630534588;
        Thu, 04 Aug 2022 09:28:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n66-20020a1ca445000000b003a513ee7830sm1868063wme.27.2022.08.04.09.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 09:28:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 02/12] help.c: remove common category behavior from drop_prefix() behavior
Date:   Thu,  4 Aug 2022 18:28:31 +0200
Message-Id: <patch-v8-02.12-aebb56da6e9-20220804T162138Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.g61622908797
In-Reply-To: <cover-v8-00.12-00000000000-20220804T162138Z-avarab@gmail.com>
References: <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com> <cover-v8-00.12-00000000000-20220804T162138Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the behavior of the "git" prefix stripping for CAT_guide so
that we don't try to strip the "git-" prefix in that case. We should
be stripping either "git" or "git-" depending on the category. This
change makes it easier to add extra "category" conditions in
subsequent commits.

Before this we'd in principle strip a "git-" prefix from a "guide" in
command-list.txt, in practice we have no such entry there. As we don't
have any entry that looks like "git-foo" in command-list.txt this
changes nothing in practice, but it makes the intent of the code
clearer. In that hypothetical case we'd now strip it down to "-foo",
not "foo".

When this code was added in cfb22a02ab5 (help: use command-list.h for
common command list, 2018-05-10) the only entries in command-list.txt
that didn't begin with "git-" were "gitweb" and "gitk".

Then when the "guides" special-case was added in 1b81d8cb19d (help:
use command-list.txt for the source of guides, 2018-05-20) we had the
various "git" (not "git-") prefixed "guide" entries, which the
"CAT_guide" case handles.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 help.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/help.c b/help.c
index 7e594d291b0..8a09f18a3d9 100644
--- a/help.c
+++ b/help.c
@@ -44,16 +44,17 @@ static struct category_description main_categories[] = {
 static const char *drop_prefix(const char *name, uint32_t category)
 {
 	const char *new_name;
-	const char *prefix = NULL;
+	const char *prefix;
 
-	if (skip_prefix(name, "git-", &new_name))
-		return new_name;
 	switch (category) {
 	case CAT_guide:
 		prefix = "git";
 		break;
+	default:
+		prefix = "git-";
+		break;
 	}
-	if (prefix && skip_prefix(name, prefix, &new_name))
+	if (skip_prefix(name, prefix, &new_name))
 		return new_name;
 
 	return name;
-- 
2.37.1.1233.g61622908797

