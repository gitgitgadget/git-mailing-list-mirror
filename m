Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1E081F404
	for <e@80x24.org>; Wed,  7 Feb 2018 19:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754180AbeBGTpy (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 14:45:54 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39116 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753721AbeBGTpx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 14:45:53 -0500
Received: by mail-pf0-f193.google.com with SMTP id l9so771800pfi.6
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 11:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SUSel8mJATW+tD1iH233quqaTPvV2sdS2g7O0Gu9hZY=;
        b=of6Qh6iNI5I1JcLyOiTyQgoUwy4b2cZ46Qw11yr/cozK5q5XP3Ib6p75LeLS6TAKew
         SBqhcDhQwidupOBZg8fxJ2wZfsDIcw3ECtmLUBCNpkdOnjjCJcXZ4w/4bYGD9zjfjA5C
         lRhad0Xfi7g2ZrA1bp++CsQZxmnPq6mlC0LrsHh9Mqjzl+hgiPVNxUyJJIi5XZLYTBMx
         N8oTf2/rWJJNzcWhZ1xRcd7athea77cPMMt9ZG4dfIxGrlsEJdta9+Tw/RKbMSkW7ikz
         NE6+SWVfAbkH4HmGPWT4/TKG7GIbqYwUX0kiv4SdS+3gH670Bc5sXoJc7QhUDyMpoVeX
         bXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SUSel8mJATW+tD1iH233quqaTPvV2sdS2g7O0Gu9hZY=;
        b=my3giplHBR1vJhtyxSWRmGu06i6zPPQzwtZeZnnlkH9eC/S/jzKOxNgODt20pyKcvV
         n8QowWddj2GwuZ007lP6aJZDlsYpJK4iHdmA1vX8Hv2MGG83AzYhOuEQ3kCQY4WQK1+V
         W8HJgk8PaV/kv8nopjry6INLkjQagboakBv02x28tIXZly6XT1ujhZ3PBl5sEmFixcuJ
         e89ZqkIXLay23bDIk+D9XDsUdhq1p050yYHSWoTWHb+izbHUJBbEBiTS8TsRQoQLmkfk
         Jsz4ZVJ+bZWl1hBJLo83YV/IxwD31TRKi4Ois95GLqYmBqvUOyjeF1mN06mAojfZiSpg
         /FTg==
X-Gm-Message-State: APf1xPBuhQ/f/GKfnIBY+GeiXkaClV5siM2TUGP4bRpThKItITYaM9Bj
        2tmM6uhVbWjmWFqQ6MlN07eNyg==
X-Google-Smtp-Source: AH8x227m5kO/cluIW4xu4V/H/SMiWJuJCSErPN9P3FfUaRITdeO/7OEI0ijfVXDN6SQQavE2bSR/1g==
X-Received: by 10.98.25.207 with SMTP id 198mr7074362pfz.83.1518032752591;
        Wed, 07 Feb 2018 11:45:52 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id w13sm5251422pfi.112.2018.02.07.11.45.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Feb 2018 11:45:52 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     artagnon@gmail.com, avarab@gmail.com, git@vger.kernel.org,
        mina86@mina86.com, mst@kernel.org, pbonzini@redhat.com,
        viktorin@rehivetech.com, zxq_yx_007@163.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] send-email: have default batch size when relogin delay is given
Date:   Wed,  7 Feb 2018 11:45:47 -0800
Message-Id: <20180207194547.1412-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <xmqqlgpppri7.fsf@gitster.mtv.corp.google.com>
References: <xmqqlgpppri7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the batch size is neither configured nor given on the command
line, but the relogin delay is given, then the user is not using the
the feature as intended. But as the user gave a relogin delay, there is
clearly the intention to delay sending out emails. Assume a batch size
of 1 instead of silently ignoring the given relogin delay.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-send-email.perl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 340b5c8482..5672e05b98 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -379,6 +379,12 @@ unless ($rc) {
 die __("Cannot run git format-patch from outside a repository\n")
 	if $format_patch and not $repo;
 
+if (defined $relogin_delay) {
+	if (not defined $batch_size) {
+		$batch_size = 1;
+	}
+}
+
 # Now, let's fill any that aren't set in with defaults:
 
 sub read_config {
-- 
2.15.1.433.g936d1b9894.dirty

