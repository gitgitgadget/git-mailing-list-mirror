Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83571C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 21:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241761AbiBDVVI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 16:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241626AbiBDVVB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 16:21:01 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C825DC061401
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 13:21:00 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m14so13506941wrg.12
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 13:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KGJxs0C7b7ND+ak7wsHfwV0J+rvRtG8FRFEwqqKEqKI=;
        b=chd7XGeq9c+fyZCyPe2MFMhF7iY4xB/a7DW9vQA3eJ+QrIsalEaeyIUaTLthxfKQV4
         ikf1i1tq6Osr4Hf5QEYUBBlwaBoWOiN1rjjYgd7ZsD+N5SQHn8ux75yKhQ7GBLzeYNbb
         aBdjsOwtfq5gEZ6IG/irusQ7VsKqRFO+4uyY3XPuKXibKB/jpWO/aepEdq0F5bQjhMmc
         kGrHS6nW8JgwT8Wfb3MfBeVJfnx2kNZTBtiS6KjzT5598eEiHCu+AziLNoyY2PhHuO59
         cSAH75qs8g0vDrHJiO+FSeXJinIgBv8IZBlpWaQKEfBUVBegNXlBoUf/WTehdYO+QkyF
         J+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KGJxs0C7b7ND+ak7wsHfwV0J+rvRtG8FRFEwqqKEqKI=;
        b=1IWnrOZs7ReF37+PPaa7I3VJsvCFR/Iz5UauzdSb7eDDmd0lOSJBFLOerHj07J71ov
         mXOpjbScXdy4mB9u+1/KZitcEYCCJW55160XdZuB5iuon3cKEc90VSbeuN3Jrpvf2RMq
         ARfMT9chKHJnUx0sGphekLYs+bR6fFEz/CIXhZd+pQbM0tID6AjrFT24vTjDT7DpQ7S3
         onQO1wNTrsNklzq+4X6Ve8omBfS5FffHWd0XCTRnPth/M2fPau+U13ge48yDwPaCkJei
         9oC2Pzn2MdPKJvnWLb1txeT5aDQyAyYT7jeS8Np6VtOWGfpb3QZ7YDvuMcsiByOHtSVd
         z+BA==
X-Gm-Message-State: AOAM532MRJg+jAyOzVZSNHTB2UrVqu46WvLVmDDz24qhTbQqZ2HTefRe
        z2v5a9e66+HXyZVoj4Vp6vdz/uKvo4FG9w==
X-Google-Smtp-Source: ABdhPJwAHC3JGS102X5Qwt3teZ+E8Fk3zn9Nxq5VrXHCbj9OB/LIehi709ZDMMicRYruY0pQqhfhZg==
X-Received: by 2002:a5d:484b:: with SMTP id n11mr606653wrs.528.1644009659196;
        Fri, 04 Feb 2022 13:20:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o21sm2321598wmh.36.2022.02.04.13.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 13:20:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 5/9] grep.c: don't pass along NULL callback value
Date:   Fri,  4 Feb 2022 22:20:47 +0100
Message-Id: <patch-v10-5.9-1f09de53e07-20220204T211534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v10-0.9-00000000000-20220204T211534Z-avarab@gmail.com>
References: <cover-v9-0.9-00000000000-20220127T115058Z-avarab@gmail.com> <cover-v10-0.9-00000000000-20220204T211534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change grep_cmd_config() to stop passing around the always-NULL "cb"
value. When this code was added in 7e8f59d577e (grep: color patterns
in output, 2009-03-07) it was non-NULL, but when that changed in
15fabd1bbd4 (builtin/grep.c: make configuration callback more
reusable, 2012-10-09) this code was left behind.

In a subsequent change I'll start using the "cb" value, this will make
it clear which functions we call need it, and which don't.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index d85cbabea67..5ec4cecae45 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -285,8 +285,8 @@ static int wait_all(void)
 
 static int grep_cmd_config(const char *var, const char *value, void *cb)
 {
-	int st = grep_config(var, value, cb);
-	if (git_color_default_config(var, value, cb) < 0)
+	int st = grep_config(var, value, NULL);
+	if (git_color_default_config(var, value, NULL) < 0)
 		st = -1;
 
 	if (!strcmp(var, "grep.threads")) {
-- 
2.35.1.940.ge7a5b4b05f2

