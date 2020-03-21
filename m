Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D11C43333
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 16:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE6C20780
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 16:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rz1YURw6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgCUQNv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 12:13:51 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:35913 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbgCUQNv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 12:13:51 -0400
Received: by mail-wm1-f43.google.com with SMTP id g62so9733164wme.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 09:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sdkHF8lh+qwdbM8cbKEFv0XdX0T47/SeTon9vn04qlY=;
        b=Rz1YURw60nBqAryF+pTnEFGWyjFnCLSGdEcLxKqLgb6oKHev4PHj5z4xJH/BBy6Y0W
         d4cVy8eLWB/sH/shsl1DyO9H/ZMjFDKxsCKE6P/vQgFLmGhjfAe01RbRsawlSAypEtio
         ScOaaj0En09KepJn1VkcfHtnNk7yG29+PJsl942o8/BWlaClJwoJkNGF2GJmAmB+8UfK
         8T+p/v11wJapDLi9OjbX1VPzD0rTbAohCQ3toXlgt4+NIliq18zkBIdZe90TxIGGt5kH
         ADeio/EMeCOZXwpsL3To/pmkuKHW4RLZC40cl4j7QpoCDsLNqCWVOYSvqMoJOZquGtfx
         AGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sdkHF8lh+qwdbM8cbKEFv0XdX0T47/SeTon9vn04qlY=;
        b=HySOyXApG/YrP1Y/uNS5V9xL+utHsKCHmb+UOe0OZX9EMjbFsQ2CeHfdbIsT5Kc1iM
         3uXJkCnwa3mxUDUFPYdYTBsc4oqGy3eHgI2hJ1vHiGKl39TwC3uFMlFq5obEk+B7/nBp
         7MvJRvH5WKZxg7cpb/WsiGIGLR7huLuGl093cxhhQXe4P95Cdo4vSdugipbQev4lA4tS
         49JAVMxl39Eg/0uWz08ZI8WzKZIXFB+nGPndwbW663nMnPY2xyJuUOP6hgToctr/RtAo
         vsl2zd4mF1bLZE8SgR1lg+OiF/oOugAHMT0oXbPG7CnVNDRKQHRc9UShVs2GXOlovvgZ
         c2AA==
X-Gm-Message-State: ANhLgQ1TZKKSRf+fsgeOuhOJktYjSbd7hwEluFDCo3W5h05byk4BD7sA
        A2ktoPecBYccd2+lAHaJFpVMGdlg
X-Google-Smtp-Source: ADFU+vtgto8p2SEvngYWdn2kQmjXifdSA9gD/5Uf0GCFTOnUclgC6HE2lo3/gKChBqxKfGtNF8MOag==
X-Received: by 2002:a1c:2701:: with SMTP id n1mr17159004wmn.180.1584807229618;
        Sat, 21 Mar 2020 09:13:49 -0700 (PDT)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id f22sm13992285wmf.2.2020.03.21.09.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 09:13:49 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 01/11] bisect--helper: fix `cmd_*()` function switch default return
Date:   Sat, 21 Mar 2020 17:10:10 +0100
Message-Id: <20200321161020.22817-2-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200321161020.22817-1-mirucam@gmail.com>
References: <20200321161020.22817-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a `cmd_*()` function, return `error()` cannot be used
because that translates to `-1` and `cmd_*()` functions need
to return exit codes.

Let's fix switch default return.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index c1c40b516d..1f81cff1d8 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -711,7 +711,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		res = bisect_start(&terms, no_checkout, argv, argc);
 		break;
 	default:
-		return error("BUG: unknown subcommand '%d'", cmdmode);
+		res = error(_("BUG: unknown subcommand."));
 	}
 	free_terms(&terms);
 
-- 
2.25.0

