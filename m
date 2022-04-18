Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DE7C433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242095AbiDRRah (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347123AbiDRRaa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:30:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D25A13F04
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:27:43 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id lc2so27996523ejb.12
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QHlm8vIEcoD801CxXOzQ8i73gzoLGIIv2e9W9lc8Prs=;
        b=DHB8JQjhwrMuLyjMhWNY7qmH/IrLOEL4KpNsSywBsfhFb731iIybvZjoqbgc4ODfjM
         r/hRkXHsTwyDMLWMtwxP3uKE8u+XYLAtdboiaBplvI0aTJsVRvd+KZb2r+OCrrui0QRk
         M3+O0y4eCKWnr7v2VipVNZ47gCW5ooEAxLnGra1oxW+iDjw74N+aL3sHJl3Pbxutr6B5
         1Cwd6Fb7o7YI7REM9116nMVZ9CgCDYtpIUw3Il0Ck1ZvthPVCA50n9+WsSD3Ck0aJ2kT
         /2qoOqc3CKCBDPlnYGbly6F6oJvlwHILdZ8sD9XXwTzBDE2ls0mjBr2YgAnHpuNyApXM
         0VJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QHlm8vIEcoD801CxXOzQ8i73gzoLGIIv2e9W9lc8Prs=;
        b=S0shk23oRVbOWjTnq3ackwPZ+z34uEOT+GNj+3b1Mp7FkYHt0ZNwPy8WnTBRKDczao
         tgBIKE5G7ERJqysWF9zQZwhSDsC6oW0aGQI+JnsrBI0XtFeGycCoMgXhH4E6Zft5VTZt
         OAN8+bCCxKvttub1hcn8x91sNwxq65WJBE0CtF2h1FaNlI42K23Hnrh0x3ISTnTFK5Jq
         wsA21royPybeNQTWpI1V4lkDCM3wCtcRae4SEng+DFXZ9wJ6xialvI1pnmF0ym9pPDrL
         HuyJQ04GGk+/UD3bYYshT2IuoF1a26GQeTqadIjoJ7IyTJJga4S9Ze8YSb95RxVSML5p
         SHYg==
X-Gm-Message-State: AOAM532ldaxDU/Cekkx7hWwK3ELiusoI2OzG6BOgwmb8p2sKBcXA/g2K
        cnCTyTsrtDwk6a03+kY36NyFiCAlUMt7+WPt
X-Google-Smtp-Source: ABdhPJyaunufXFkVVeAe+pAbNbPtFFgLMZ5T1tYy3px5PpYCVcffWpRz1r0nqZ0JeLx4YnWcv9NPpw==
X-Received: by 2002:a17:907:728c:b0:6e8:bb41:7df8 with SMTP id dt12-20020a170907728c00b006e8bb417df8mr9933606ejc.688.1650302861480;
        Mon, 18 Apr 2022 10:27:41 -0700 (PDT)
Received: from linuxerio.localdomain (j109098.upc-j.chello.nl. [24.132.109.98])
        by smtp.gmail.com with ESMTPSA id d7-20020a170906174700b006e80a7e3111sm4909747eje.17.2022.04.18.10.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:27:41 -0700 (PDT)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     git@vger.kernel.org
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH v2] rebase: simplify an assignment of options.type in cmd_rebase
Date:   Mon, 18 Apr 2022 19:27:21 +0200
Message-Id: <20220418172721.215898-1-eantoranz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is an if statement where both if and else have the same
assignment of options.type to REBASE_MERGE. Simplify
it by getting that assigmnent out of the if.

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
Range-diff:
1:  7b6483fcce ! 1:  959aff8b8e rebase: simplify an assignment of options.type in cmd_rebase
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
     -			if(file_exists(buf.buf)) {
     -				options.type = REBASE_MERGE;
     +			options.type = REBASE_MERGE;
    -+			if(file_exists(buf.buf))
    ++			if (file_exists(buf.buf))
      				options.flags |= REBASE_INTERACTIVE_EXPLICIT;
     -			} else
     -				options.type = REBASE_MERGE;

 builtin/rebase.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 27fde7bf28..baf7a0bb36 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1187,11 +1187,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		} else {
 			strbuf_reset(&buf);
 			strbuf_addf(&buf, "%s/interactive", merge_dir());
-			if(file_exists(buf.buf)) {
-				options.type = REBASE_MERGE;
+			options.type = REBASE_MERGE;
+			if (file_exists(buf.buf))
 				options.flags |= REBASE_INTERACTIVE_EXPLICIT;
-			} else
-				options.type = REBASE_MERGE;
 		}
 		options.state_dir = merge_dir();
 	}
-- 
2.35.1

