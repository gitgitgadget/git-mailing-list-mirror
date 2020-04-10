Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39674C2BB85
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 11:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1116A2084D
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 11:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HheM3Hi6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgDJLDH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 07:03:07 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37366 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgDJLDH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 07:03:07 -0400
Received: by mail-ed1-f68.google.com with SMTP id de14so2037586edb.4
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 04:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=N9XTNr21d7tU8Lg9DEfabFR8kVuhMyVpg/6eS8JrkD0=;
        b=HheM3Hi6OUpzB9jaj0bjCYdrJIbgScVFV7khaAx5BC3fdQfVBEnIPrZAR/pCWrw++M
         2iEws37pgl7cSH2TeXm29+aHHU8hp8LcvHw0J2JY0W0RGkgMa5Kh/dWYwQsbXV8EDwKi
         vHhVJnEF3Uo15xvVwJXX+5jlX4mU0r2nw3XcaaebpAhg92DxkBfALyvI2tUVUPojZeh1
         E756zmbymyhUlu6WD0b69j0pl3UokpEYhdRKTqSl6wgEv9x5ekdisqCAe1bWfuw0NeIO
         1DnyRrTUJE26n0yn2qkZqO8u2ShMYfBpeJLLyJvo8HifEw6tWUjvfYVp+IeAP2gLomoL
         AMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=N9XTNr21d7tU8Lg9DEfabFR8kVuhMyVpg/6eS8JrkD0=;
        b=sAHFddLnsxsH+vFOpBGeHOlIrcFd0D5HEznCVmSQswucH7pH5VZAx4ozUJRzJZucDY
         KnavZEJsj5ILg7lEkAvw7wmF8YtajuxRy8uqLYlXpLg66TqljDtt6Yku1WdkNt5jfLnP
         1x0aAr5gLVHOD5l6Be9EQ0sh2Y48cHaa/pz+Ss3oHyvRKAOkLOL8VChg7RqROjAWCYTB
         y+g9Z1uGM6Mc4nPKAAAK2FJNC8rHsF30F0xpn7OOvuytWb5T9OqYFbPQVM6vA5OvOaBS
         HNsaLBeDIIlGBlTaNfOY4p6SzD6gvtS/s4naThBB1AvKhrZtbWD5mCG1GxJZtyFj+rC0
         CMRg==
X-Gm-Message-State: AGi0PuaxfaJtv/iXtxUtpXzsV7pk7hc7nakqTaBEWQFLDuC2sUnbfOc/
        u8plYpokcv3iSYCPMfrquZ5yLXCH
X-Google-Smtp-Source: APiQypI2uN4YIBIDQnF5Gz1WpAF1YuelCEBmOp5uZq1cp0tOajLnyYm1AsUbQ/P60Av0N3tOsLvuDg==
X-Received: by 2002:a17:906:af81:: with SMTP id mj1mr3112991ejb.99.1586516586826;
        Fri, 10 Apr 2020 04:03:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j8sm100423ejd.91.2020.04.10.04.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 04:03:06 -0700 (PDT)
Message-Id: <fc4202cb5484e0e24babc20959e1c78d3dc2c156.1586516583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.603.v2.git.1586516583.gitgitgadget@gmail.com>
References: <pull.603.git.1586374474512.gitgitgadget@gmail.com>
        <pull.603.v2.git.1586516583.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Apr 2020 11:03:02 +0000
Subject: [PATCH v2 2/3] mingw: make test_path_is_hidden tests in t0001/t5611
 more robust
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This function uses Windows' system tool `attrib` to determine the state
of the hidden flag of a file or directory.

We should not actually expect the first `attrib.exe` in the PATH to
be the one we are looking for. Or that it is in the PATH, for that
matter.

Let's use the full path to the tool instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 09a2479fd38..09e2cebb456 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1550,6 +1550,6 @@ test_path_is_hidden () {
 	BUG "test_path_is_hidden can only be used on Windows"
 
 	# Use the output of `attrib`, ignore the absolute path
-	case "$(attrib "$1")" in *H*?:*) return 0;; esac
+	case "$("$SYSTEMROOT"/system32/attrib "$1")" in *H*?:*) return 0;; esac
 	return 1
 }
-- 
gitgitgadget

