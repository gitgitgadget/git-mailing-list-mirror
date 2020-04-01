Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41B9C18E5B
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 15:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABDD20658
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 15:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3cXhKsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733192AbgDAPzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:55:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41647 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732799AbgDAPzh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 11:55:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id a24so124027pfc.8
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 08:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OBAHPB1UzI5WDJbpz0K+g8RnWuSyhFNCzWBDIBdzs84=;
        b=e3cXhKshsBH4AODhy62F6ryTWAZNXTkmCiJ18FJX+xAmQgUP7XyoPYPMsXxtt9Czhy
         BTeSTexgTBRg0fGehRY9oNSmzKbisSovMTCmkoFjBRZc6KGkuDmdxpGfy8SMEL/0RDmE
         WkX8NQiNf1hJefXjTzzfQvr4UnnHQxCp/BgZ2x6488czpP/sVlD+BuuowUlK/MAmKrsU
         LopWMH+yaYnoc918O9xu086itfYKp4wvTwL9t9lAuvqUWbccMn4XoIlIPuJcMw9jrnST
         jOx0NizFpwzHHM7e3w7A2L8ttNoaB13owsgaa4TFTUPEkb1yudTIfvSK66xPmS5U/Y2G
         rOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OBAHPB1UzI5WDJbpz0K+g8RnWuSyhFNCzWBDIBdzs84=;
        b=WuK5anaEJ91VXaRKHCFmZVzsQkFIZdcicjNMp/MT5v1+oGqENg1rmTUp4Zh8gVghSV
         xKVZvclFASmb9Z5j1prt1SAQn8etAMs2Hkrz3CntWm6Y0ry45sVuiPiH1xA1LBIAf49C
         XEiccUYtiD9xYqUEkfa5epEunZR1aWooKxZwXj4Ty5aGfMjqoUh+c00fi0/7DLxi/ah0
         gfQYcgWh2cJBJM54XnWyQJDVdD4suaOFn+BBDG6KznZrfB9JMAy+bI8V1MitIdQlDfgi
         SpSeNX8ezEzDPIscLNYh/vRcLCvj4ShUw/iVXXHDEu1sT2NbuwuRCweyEURnWju0hQkG
         ADjA==
X-Gm-Message-State: AGi0Pua4kh+Sd/HTYzVRXwMcaAo8gkmdNY1HLgidlsMAg2ZqIdz0k5hw
        ZKMQbe4BqDpdxw0sY1fGR+UJU7YU
X-Google-Smtp-Source: APiQypK11ROAH7a5C2tQH3OqJXqFd3RxTheea3vZX2g42/grAgAUGaA5WpvwD2jfbAsajTRqRYGY0A==
X-Received: by 2002:a63:81c8:: with SMTP id t191mr1870864pgd.124.1585756535889;
        Wed, 01 Apr 2020 08:55:35 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id x4sm1990826pjf.23.2020.04.01.08.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 08:55:35 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 3/6] ci/lib: set TERM environment variable if not exist
Date:   Wed,  1 Apr 2020 22:55:05 +0700
Message-Id: <f9d0b6b0d55b79c075d9c4860f8cdfd636edd5da.1585756350.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1585756350.git.congdanhqx@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <cover.1585756350.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GitHub Action doesn't set TERM environment variable, which is required
by "tput".

Fallback to dumb if it's not set.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 ci/lib.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index d2fe02083f..c605695e38 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -79,6 +79,9 @@ check_unignored_build_artifacts ()
 	}
 }
 
+# GitHub Action doesn't set TERM, which is required by tput
+export TERM=${TERM:-dumb}
+
 # Clear MAKEFLAGS that may come from the outside world.
 export MAKEFLAGS=
 
-- 
2.26.0.334.g6536db25bb

