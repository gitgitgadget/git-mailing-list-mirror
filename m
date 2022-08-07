Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4A7C19F2D
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 02:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiHGCuH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 22:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiHGCtz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 22:49:55 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D409AE0CA
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 19:49:54 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-10ee900cce0so7087099fac.5
        for <git@vger.kernel.org>; Sat, 06 Aug 2022 19:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=BNgZn1+Ub9nUkaXLtigV7lSzP3BPhpGLsNz3+cOiJ5c=;
        b=lfXqYSajiNbov8xN18tNq7Csz1tHfEugh6gpG5LjiB/hJ1CRfhj9dmIs0tFARp4HVN
         KeGOP0R3qi5iJSxZTX9gumbXsqBFEs2UqHP/MiMtSQb0JUM0Fdb1d8W33YhtisngzqRV
         Vj9glf2QalZf9TRrLk6e6rNs2teXEPcpawDeCYv2P/Ua4ArnjIaNm2XytjpQIPOFoQj6
         67ERVnYfRYhJPL605NQyHatcl+EsEbczlx1F5vPCFlUmole9+u7If0k8VJANOv+QuWRS
         WyC7xxDK9b/87R1nhps5zmz5oPdERlGcpp6wr/vjEn0I0FN37hQof1sigragdflNsxfa
         rMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=BNgZn1+Ub9nUkaXLtigV7lSzP3BPhpGLsNz3+cOiJ5c=;
        b=5qGjlFnZcaCVuEtJeC/jtAGnjJ/2pZKN9U5gKoJ4HaUHxOpANRZK/AUrWfpwEMw2VC
         M9nozvTt9H6G4Jn+635ow1zRLxaWqU6rRBtpyQtfe8TLz1Dsowze4tOKl3fxDBUolCA0
         e8DF0U4BOQw2Ep6R9EzRPhbUWuJ5mBazgKdVbD7A7dccs8OIPDZqRb0y6T12TYYCXAvL
         VpNPLFFl0qWQKZmMW1oYAmpgbdSXnaKWTudVTwlpTiB4BC0wdOoLLsE4BS0jxbRslhzY
         gj5aS+Gi6Kc6KQcJAHhamNYnEgyyqJqgnRqiBuR3mA3B4haMG6r2Nv0TFhz7elM7BWzP
         IW2g==
X-Gm-Message-State: ACgBeo1loXm4OMx8e9CHB2W8xouXfQMK1siOHSDW50FmxNTA+vi48Gut
        1Qlw9qwVmSC6knPuBog8xFboEvjfC18=
X-Google-Smtp-Source: AA6agR4hvfNIMDCVLaTyNXA0QjWXox5hwWEvlzD9L7Pjfm5I17cNN/nInvRb4TFkPNaWt24BwbrfDg==
X-Received: by 2002:a05:6870:d582:b0:fe:4131:6dbb with SMTP id u2-20020a056870d58200b000fe41316dbbmr9821874oao.76.1659840593978;
        Sat, 06 Aug 2022 19:49:53 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:afaf:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id n5-20020a056870240500b0010dc461410bsm1555515oap.38.2022.08.06.19.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 19:49:53 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 8/9] mergetools: vimdiff: fix single window mode
Date:   Sat,  6 Aug 2022 21:49:40 -0500
Message-Id: <20220807024941.222018-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.1.378.g3f95da6bac
In-Reply-To: <20220807024941.222018-1-felipe.contreras@gmail.com>
References: <20220807024941.222018-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Right now it doesn't really matter which target is used, vim always goes
for 'MERGED' since that's the last buffer.

As the documentation of bufdo says:

  The last buffer (or where an error occurred) becomes the current
  buffer.

So we have to switch to the desired buffer *after* running the bufdo
command. And we can't simply do `| 1b` because that will be considered
part of the bufdo command, so we have to run it inside an execute
command.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 mergetools/vimdiff | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index cdef1dcae3..34373ad92c 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -325,7 +325,7 @@ gen_cmd () {
 	if ! echo "$LAYOUT" | grep ",\|/" >/dev/null
 	then
 		buf=$(get_buf "$LAYOUT")
-		FINAL_CMD="-c \"set hidden diffopt-=hiddenoff | ${buf}b | silent bufdo diffthis\""
+		FINAL_CMD="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | ${buf}b\""
 		return
 	fi
 
@@ -560,7 +560,7 @@ run_unit_tests () {
 	EXPECTED_CMD_01="-c \"echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_02="-c \"echo | leftabove vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_03="-c \"echo | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 4b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_04="-c \"set hidden diffopt-=hiddenoff | 4b | silent bufdo diffthis\""
+	EXPECTED_CMD_04="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | 4b\""
 	EXPECTED_CMD_05="-c \"echo | leftabove split | 1b | wincmd j | leftabove split | 4b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_06="-c \"echo | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_07="-c \"echo | leftabove vertical split | 4b | wincmd l | leftabove split | 1b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-- 
2.37.1.378.g3f95da6bac

