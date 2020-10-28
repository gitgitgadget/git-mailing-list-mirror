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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9A7C388F7
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9186A207DE
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ON+nVa5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgJ1XmW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgJ1XmI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 19:42:08 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14BCC0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 16:42:07 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id m128so1402539oig.7
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 16:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FlI5dTB+2BF5Pix/aEApvsuecEutz3CEZHIgNmZ9BM8=;
        b=ON+nVa5bcgDYFrO9APFVkRkFPCfH+yaf/0L8ASNBqcTZKL+h3dvJDUl/LaOdgGz/fd
         t/JiKxkWvw9KZdFmVlg39p6L9DpYzAVWPwnrEEEQYqLe/nMnkVKPMw1kVI+UK6CUxtxl
         12XV4cbzzCUcxq3KWWh1dGzdCmq7miLVR8VtpUkDVFpx44ugd3PFg5EeVnAfZuhicUYs
         i6DTcbrMfjPWKRbgfH6ES5D11etK3lm9D/nT+DpxQQ+LNiPZ27mRqVajirV9XUgjq0cN
         6N1aMXw0ykxTxduqZjG+eoBfP1IF9WCbFgmBY4L+oHdlXVmIdTIWhfdp/NV0JGHpyMgf
         JPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FlI5dTB+2BF5Pix/aEApvsuecEutz3CEZHIgNmZ9BM8=;
        b=KEL1H/emag6ZIyQ8hYEFQnazoYcB740GZgKZeqFDPmeFvNN8C3RMymD77fYmlgCkBc
         oMnn4S8IcJGY2BXLoFDRBKcdeMkGJ4qMuRhYCqL9iiqcR2ITEYfy4DlaQeuB3Mobj64V
         EdBykes87NyScp8Bo5ixAgLX2z9iZXe21Hs5a8pjLhyPa+w8c+9bzDc74FGTY2O1aJ2V
         3+piKhZvxIDHKa1qqNdPXSBQ3+eovsKQ8wBDxlbk/WQMi9mPag2l/lsV7UdItUYsFyzn
         z3UQZZ7LMEA5bHo7yhFivOfSXaHGQPDdY9VDaeiJ430A4atlJu7/BPQhs5y8gh5vr31F
         +tQA==
X-Gm-Message-State: AOAM532zuEGMUNVQp4U87ZgS8FFuLa1/WvLVtoMjDefZgipwlN76XWqK
        Thtm8a5hBcOj5X1e3PoOMlu9vTfeSSRx0WUQ
X-Google-Smtp-Source: ABdhPJwyn8rduqQDw19OdnbgaQPyJYfuwr/AL8WLX2QX6OhSzYryIWaY/UfxVcuoo2T+h+MaDHxmlg==
X-Received: by 2002:aca:52c3:: with SMTP id g186mr3363596oib.122.1603850860722;
        Tue, 27 Oct 2020 19:07:40 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id q4sm1870177ots.34.2020.10.27.19.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:07:40 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 16/29] completion: zsh: simplify direct compadd
Date:   Tue, 27 Oct 2020 20:06:59 -0600
Message-Id: <20201028020712.442623-17-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028020712.442623-1-felipe.contreras@gmail.com>
References: <20201028020712.442623-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of manually removing the suffix so zsh can add its own, we can
tell zsh to add no suffix, so we don't have to remove it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 1ef02f936c..3689bcbd6c 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -101,7 +101,7 @@ __gitcomp_direct ()
 	emulate -L zsh
 
 	compset -P '*[=:]'
-	compadd -Q -- ${${(f)1}% } && _ret=0
+	compadd -Q -S '' -- ${(f)1} && _ret=0
 }
 
 __gitcomp_direct_append ()
-- 
2.29.1

