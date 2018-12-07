Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F107720A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 23:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbeLGXyr (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 18:54:47 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:45119 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGXyq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 18:54:46 -0500
Received: by mail-io1-f74.google.com with SMTP id r65so5096317iod.12
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 15:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kuvCeQO9ymjYq6mNngIbyYme9Vr+BHCcrjKVkAY+Gkk=;
        b=jrPwgK3I5NXv91dUjNrqERVxYTNa2RUYDj9Hs1kbpWsEdWf6BEfLfSKvwz3SjL+6fn
         tDK217rS+sj7mmcB8xxqM7ZygL3Zs87iIJPBhgwixP17OOsFhPEqmIOozkhAMNZOY6TH
         efEwP/i8pzPeXSyhsn56IOOFekw/jduX3jNbaZUM5p1hKaUUKUDCrwXxcUqNH3TJy233
         6ji26v1JPQhuPDr3No6AhRQefnvqIoihNww/GXOKhmq3wlDrjUo5ktbo8BgxngNmJST1
         51sieq+GmdsHYdeDz7hVYTnA3JsKDhmLg02mzsAAuOCiH6Q5OE6x0wlliYZFuL0AAFK6
         4lkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kuvCeQO9ymjYq6mNngIbyYme9Vr+BHCcrjKVkAY+Gkk=;
        b=CKURWyzOFZ1ew0+fjsPaInG5AVyW2V4pN9kDcWkeCBG0wqGrCl2WA1WKbSsX2URqzF
         qJxnbwJEOfmMipxPtrPFkVC3Bu5JJNTWKAn8hI8HHyF5XpjTU6qqUaIn+pKD6vG9F2Mc
         Ok/mRqvPOX9dmtCzjLgiWHLA7D2mrbRTNLqeUw20zRHuYH15TyJ59dIo2n1IS0povY2C
         hcKLM0rMu4zFzHRIMlji1dULH2U91EJWjKJex5rTYJrfaDNPCraNAjUKuXKgUTXMktx2
         9Buy/QTELVSnUE22eLC1LlsePP+6WH958PBhm9aCXv7cFJGP2wbrisszvmpIUVBiN+q4
         JfQg==
X-Gm-Message-State: AA+aEWa8b2TBBoYTNxsjT30YRddhA+tf5/NRGQyvdWpFUNCrATPu2TzO
        H5oSdwUP07ThfoepfryG2XBpJcck36nywwx0oWZUCG1zzSaxaIH6Y+FQOPnFE6EjKYkpURArWe8
        T8AvR33O9ygpfTW41rZFHD8aD0x5S+gOZpUMrXH0j0ApQbrBtGA23bcOYcpdk
X-Google-Smtp-Source: AFSGD/WygIg+GSNRg4swfxfENUp/UhBv2s2tYn0FRjnrdZXAV+C1o4/AylMK5Ox5fRD9vfCMfS+hb/S2R5yv
X-Received: by 2002:a24:a94:: with SMTP id 142mr3274482itw.15.1544226885782;
 Fri, 07 Dec 2018 15:54:45 -0800 (PST)
Date:   Fri,  7 Dec 2018 15:54:24 -0800
In-Reply-To: <20181207235425.128568-1-sbeller@google.com>
Message-Id: <20181207235425.128568-4-sbeller@google.com>
Mime-Version: 1.0
References: <20181207235425.128568-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH 3/4] submodule--helper: fix BUG message in ensure_core_worktree
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shortly after f178c13fda (Revert "Merge branch
'sb/submodule-core-worktree'", 2018-09-07), we had another series
that implemented partially the same, ensuring that core.worktree was
set in a checked out submodule, namely 74d4731da1 (submodule--helper:
replace connect-gitdir-workingtree by ensure-core-worktree, 2018-08-13)

As the series 4d6d6ef1fc (Merge branch 'sb/submodule-update-in-c',
2018-09-17) has different goals than the reverted series 7e25437d35
(Merge branch 'sb/submodule-core-worktree', 2018-07-18), I'd wanted to
replay the series on top of it to reach the goal of having `core.worktree`
correctly set when the submodules worktree is present, and unset when the
worktree is not present.

The replay resulted in a strange merge conflict highlighting that
the BUG message was not changed in 74d4731da1 (submodule--helper:
replace connect-gitdir-workingtree by ensure-core-worktree, 2018-08-13).

Fix the error message.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d38113a31a..31ac30cf2f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2045,7 +2045,7 @@ static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
 	struct repository subrepo;
 
 	if (argc != 2)
-		BUG("submodule--helper connect-gitdir-workingtree <name> <path>");
+		BUG("submodule--helper ensure-core-worktree <path>");
 
 	path = argv[1];
 
-- 
2.20.0.rc2.403.gdbc3b29805-goog

