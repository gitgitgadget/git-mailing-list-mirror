Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7716C388F7
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E45A207CD
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D90TvNi+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387442AbgJ1XnO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389654AbgJ1Wvw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 18:51:52 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF23C0613D1
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:51:51 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id c129so548969yba.8
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0EmZFc5LOEyK0YBvL6y9PpGBu/UN97p4wj1DqQh+z0c=;
        b=D90TvNi+ws4Qx+cy1dmgIVdQXhP+uHAGdkzG6jCbpqQfzivDMDWDxi1mwjBTAAHu2e
         yYfc9CPOnCYh3Ar5KX1qOQ+MKEi3uV0UHmF2oyvJLjnmVcwgiP7mmigNp0m243wBrG7L
         EPjmOSASIGsPpzrLOLU7lZUqXDsVdLmeHRTRW7OPoxRgOMpwbq55Oowpfo6xIFZ9Vsku
         RL2Dj4LZapuganAs1SQMPoWpeaT6R4imVmVU9Lv+Vr86f2qJc0lGEo8vV+D1JkzOkbtQ
         wIo1r1cRNUAauLEYfh8UyR3D+XHJO7EhD8wsyvcRiuOlUgoq8lDWjzWHRQ2CfxviLAAj
         r/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0EmZFc5LOEyK0YBvL6y9PpGBu/UN97p4wj1DqQh+z0c=;
        b=lH5hqvwGY7py2F73NFAxNVvJv1r5UQmbGaJHizurkgSRMsNDnH2vq0tuh9A+tdzjSn
         Sn8aYcZx5QVhp9aeA4n3gdSn8HpK7tF/lJzvYOPe0f2P11ShUi3CZHmWMghm+tJ1Rxs/
         3uoHlhwamliIsXSRs8Rla+WGCNQC5Skct6l8jx8HKyBcXsfNluTpR/1AFBihzNpyManz
         d7fpdTdWcC4iAE2vgqssd4FDhRcFrw85UdyvhsNVSCt3hRfgBzbUQ+LKgxrW/1JmIMKs
         OT4zkGf+ULSWLImg/wsydCgQ+vblvow784F7zUdDzOij9jaF2TDGOI4TpQCBkkcspVBC
         LXEw==
X-Gm-Message-State: AOAM530p1ExdEtoNCOucfDIQMrPr4FugZdf6uHMs8HIDAn66ijPNvOLi
        jzh9ReRgI/MXDnjCBV81S5IrgDaiBwCDhhPw
X-Google-Smtp-Source: ABdhPJytSyDvIdEuSq5KrzbnSMILaa0x0LfnGIvOp8xdm1lxsMklYKLCLCkaK6YTQtL63Xp6V/xm/w==
X-Received: by 2002:a05:6830:232d:: with SMTP id q13mr3598914otg.324.1603850880492;
        Tue, 27 Oct 2020 19:08:00 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id t65sm2124526oib.50.2020.10.27.19.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:07:59 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 28/29] completion: bash: remove old compat wrappers
Date:   Tue, 27 Oct 2020 20:07:11 -0600
Message-Id: <20201028020712.442623-29-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028020712.442623-1-felipe.contreras@gmail.com>
References: <20201028020712.442623-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's been eight years, more than enough time to move on.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 980ce73b0f..49a6ef4236 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3480,18 +3480,6 @@ __git_complete ()
 		|| complete -o default -o nospace -F $wrapper $1
 }
 
-# wrapper for backwards compatibility
-_git ()
-{
-	__git_wrap__git_main
-}
-
-# wrapper for backwards compatibility
-_gitk ()
-{
-	__git_wrap__gitk_main
-}
-
 __git_complete git __git_main
 __git_complete gitk __gitk_main
 
-- 
2.29.1

