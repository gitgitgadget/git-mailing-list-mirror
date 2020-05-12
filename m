Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA36C2D0F8
	for <git@archiver.kernel.org>; Tue, 12 May 2020 23:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51A5D20769
	for <git@archiver.kernel.org>; Tue, 12 May 2020 23:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CWKvSN0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgELXmW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 19:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELXmW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 19:42:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0822DC061A0C
        for <git@vger.kernel.org>; Tue, 12 May 2020 16:42:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x13so17485659ybg.23
        for <git@vger.kernel.org>; Tue, 12 May 2020 16:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=amTwaTOpTyHbQRAldbpDQXBXDS62NhGbqqg3aydumvo=;
        b=CWKvSN0D4myLFlvhzFd5/MQGoKP6SF53nh8JG8/MhM61tu/8SLVnO8MO7nz75EUsrG
         JpuhslYAX3pu8yVZod3ioP7HI1T0IZeae7or5iewqBBGtKqnUQwgDXqz/HZHUOiidwN6
         TMKyQPhd9z8Gv/KRVs+Pva+yCCei5qBJLHqaA+sMz+tTcF/rZuSrKtX0PyHQLduPYALR
         O+Mq5w5nbQI/5Q2zoR5d+XuANwPXJML5ui++J+fCk3LQf/96r1HELwM7JZRs4b4rvB2O
         X/JnJl+B3yUXhNBrOFVNFUL6Fy7wEOQB2v6BNnffvGileiEGXWfwdNSHMLR9wuag/8Ql
         IFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=amTwaTOpTyHbQRAldbpDQXBXDS62NhGbqqg3aydumvo=;
        b=VLSurtiX75DCmldNdQgT5XNHuQ7D/8bsEDcxgedH7jNz/ucb5FuTbhSqdqf0dg2xjs
         Ff4QASLGrJLXicYkEbt+ZYSEM/PaKAfdsVTDg0pORMUU3ktTrsRp6uQWaIXRmSGnrnQ1
         9xyY+qOmwXblPSO0osfkvoDOG4rLiTQP9+xORpEgkqJ6JvuHonv2S5H9AAg/h5zjQRH3
         NHvi7Rsf7B/5IW81iKwCn9VFRTpRClPDiSQ0SFeyotWeSHxCCeaGDALMx2j2XpFUJ4Xg
         eiHup0qDkdy7Dv0qplOMz45Kv7L9EAmcaXVbYBZWzpeusWiBgnROUPe9MafSSf/QVATX
         yt1Q==
X-Gm-Message-State: AOAM5306d+boR53COoyjDdUlXM42SHfaEgIS4Mw/Tgh+97cMPTLNcimT
        VEzPSCq627M6xSoiAB2yglKS3J6eijErEWhCSGTdrcBMUHXzuK9sYrrh7oYOtlP8NSqQwVDAk7w
        3Wt17n+Efxp9SGrc6bu0ui3tfeVF0cGaKyV39ZEdgO8mwcswQgSGVvSoHj6f5n7rIzXvFZCQGzg
        ==
X-Google-Smtp-Source: ABdhPJyO38V59yzFHkH2GHdNtmME1/wJ2AmK0a3XIXtQXiaMcZBAvulNMjrUnpbiY+5dkeszgrMloFeab4AqmxvRuyA=
X-Received: by 2002:a25:a184:: with SMTP id a4mr7051429ybi.255.1589326940443;
 Tue, 12 May 2020 16:42:20 -0700 (PDT)
Date:   Tue, 12 May 2020 16:42:12 -0700
In-Reply-To: <20200512234213.63651-1-emilyshaffer@google.com>
Message-Id: <20200512234213.63651-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200512234213.63651-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH 1/2] help: add shell-path to --build-options
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It may be useful to know which shell Git was built to try to point to,
in the event that shell-based Git commands are failing. $SHELL_PATH is
set during the build and used to launch the manpage viewer, as well as
by git-compat-util.h, and it's used during tests. 'git version
--build-options' is encouraged for use in bug reports, so it makes sense
to include this information there.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 help.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/help.c b/help.c
index 1de9c0d589..44cee69c11 100644
--- a/help.c
+++ b/help.c
@@ -641,6 +641,7 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 			strbuf_addstr(buf, "no commit associated with this build\n");
 		strbuf_addf(buf, "sizeof-long: %d\n", (int)sizeof(long));
 		strbuf_addf(buf, "sizeof-size_t: %d\n", (int)sizeof(size_t));
+		strbuf_addf(buf, "shell-path: %s\n", SHELL_PATH);
 		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
 	}
 }
-- 
2.26.2.645.ge9eca65c58-goog

