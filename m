Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBB5C433E9
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 11:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0AC364F59
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 11:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhCSLBN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 07:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCSLBE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 07:01:04 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1CAC06174A
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 04:01:04 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h25so3420606pgm.3
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 04:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s+BBKSLutNLIy0prvjyQHjs8T45hpk79dbL83d+ldzc=;
        b=aZUFNVNFs5biuauf63Cv6Q8IHdiHdiTauMQEz6zCyQQfxlZSOeKdI46O0Wm5mdwduW
         StC2oQB5+w5nLbefZVYsZMu7Wt96TmwzI1zzW0SIaf7mM80nG7e/yrMqgvlP0lBZrgTV
         MELyR/mo0hAxBD7/Dl27X/IrZM2KSkP+840IRObmC6kg0DEvf35hfCXOEcePknIKjPSz
         sxXZQa6hT7N+qUBUH1wJT07RI3G3PEhQLnm+aw8G7Rf0pQChVRIAuzWD9x7NafkKLC/X
         bhBiBwKyIDxog/ebsTakSGIZF+rz4f9VVyHTuRZvSRgCzLFHvgvFFHv+8YUyeEs3DLBG
         xw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s+BBKSLutNLIy0prvjyQHjs8T45hpk79dbL83d+ldzc=;
        b=kUg3Etl1juWD0iKRT8PuEAbyz4L1CdJfTyL2dagJBjFTcVp57VoL1gGsfwEW00oMlW
         o5eX4l61e+By4B4jjuLLg6Crrw4kUJA2BNkNL3t+rb5OpD88HhosY/ogBnQwYvAcChKQ
         S8mwxiGXvFlrct1BQMPAGQcpMHPybAmuDJImEqnxyebt1VeZzLwnwkf2C5Tkke87SgX/
         PHlMeinLAqsElx2YftF2Wa+7mpTdMlW3Wcfs2REPho56YAUtbF7SB1zMAgYYfglc3ch9
         /SeEEJ3lYS08MAC/tBvosiupq+SkUYHWREhz01fCeua55H/JpOAtUI8l8HcfjLvO070O
         Armg==
X-Gm-Message-State: AOAM5329618PW34dLPtBYUvY0CAAW5hzMLFHG/fYXkr4hcMzhJEeakGq
        7hIoYGyaRbJ1PLskhzc5dWH+npa6M3Swfw==
X-Google-Smtp-Source: ABdhPJyT50z+YPsMZ40eopAVD26Pxm79QrxP7mnM0rRVS8DRRLv6+BXv6pRjom0FGkA0SMFzMSGQHQ==
X-Received: by 2002:aa7:9ae7:0:b029:20a:d94d:dd61 with SMTP id y7-20020aa79ae70000b029020ad94ddd61mr8956789pfp.0.1616151663440;
        Fri, 19 Mar 2021 04:01:03 -0700 (PDT)
Received: from ubuntu.mate (subs32-116-206-28-11.three.co.id. [116.206.28.11])
        by smtp.gmail.com with ESMTPSA id z18sm4986556pfa.39.2021.03.19.04.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:01:02 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2] INSTALL: note on using Asciidoctor to build doc
Date:   Fri, 19 Mar 2021 18:00:45 +0700
Message-Id: <20210319110045.15987-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note on using Asciidoctor to build documentation suite.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---

 Changes from v1:
   * Apply suggestions from Junio:
     * Place on the same paragraph as asciidoc version requirement
     * Reword
   * Mention Asciidoctor minimum version required for building to 1.5
     (as suggested by brian m. carlson)

 INSTALL | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/INSTALL b/INSTALL
index 8474ad01bf..66389ce059 100644
--- a/INSTALL
+++ b/INSTALL
@@ -197,7 +197,9 @@ Issues of note:
    Building and installing the pdf file additionally requires
    dblatex.  Version >= 0.2.7 is known to work.
 
-   All formats require at least asciidoc 8.4.1.
+   All formats require at least asciidoc 8.4.1. Alternatively, you can
+   use Asciidoctor (requires Ruby) by passing USE_ASCIIDOCTOR=YesPlease
+   to make. You need at least Asciidoctor version 1.5.
 
    There are also "make quick-install-doc", "make quick-install-man"
    and "make quick-install-html" which install preformatted man pages
-- 
2.25.1

