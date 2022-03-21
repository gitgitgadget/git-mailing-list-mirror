Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA7EC433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbiCUXLT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbiCUXIw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:08:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC5A337C1E
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:10 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t11so22679010wrm.5
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dXFwnhAMF7hy+x/nrhGZsTsJVc6ASEBsQq4WBu6dRMc=;
        b=jVJMwSJmW/Skrb+/a7DSHcDBq9PpguXjV/6Ht5UqdPZjX4yjpRcvaZ9cCDZAOWskyK
         Q9xOEzO5eP90YN/ip+JzBqHAc1UR/bVZS3fqv5LCeInDs59sFFt/auA7E+gpC5ZaPaXi
         XbjI8iwidtjQ8jKMIQD6obvuLrB60gEQvn+oCwAO4q4p4YlDD7LEjakV8T/ZAhR5GSjs
         mRBmsY9K9Mna77OJqxk3IC4fcwkTGYH1cSXARznjWjIPCLa/PeAgtVx3vH47b/4vjhom
         jTerLf/YIRor1KzLRkORXVP15kEqhSMBkzgx9OUnBci6j1gROfbmT2nkr9FNjvOoHBom
         KFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dXFwnhAMF7hy+x/nrhGZsTsJVc6ASEBsQq4WBu6dRMc=;
        b=I4d+21Rq/5NmVtRCY71tjXsM0S68H34r2zEUgejoW49PKDu7R4+/UEbPIGjYhqq5FX
         BNvUvjCO8bE79gPXbhPn1o3tVUzC9EyNZqj62oSofQJZcbsHJGqccokLJCfmCWUxN6WY
         JfYj+kLkkMbM8xJiWAYO+YhcrqYlidGpt/XfMJmEmM3qBcBsGaQYLk9WrID6qEAmAt84
         vw3xhqaafBdO0D9hd8nuIVQv8tDLVjyS4oZ2AzS/YDWirnRsbyA5WknAlo65R4onJyCm
         Hlt7AFru8qLwX8H2mVI4U+ywveT+XJycaNZvXXdVTsX73al8yH5i3bTxK4ni3CWsWqVl
         E+sQ==
X-Gm-Message-State: AOAM533rwjBz8qLt/SMSOu6uewaRrRQGkznooxzrA/w/yOUhHP+Df+jB
        raPliXqTmO1e9Lce+1zuDcz53qLHJPc=
X-Google-Smtp-Source: ABdhPJz13HAtUFBzYLNvolUc67Ud7J+synfUB2TgfUOks0ET53sx63HM2R8khbkV7XgqaJAFopErlQ==
X-Received: by 2002:a05:6000:188b:b0:204:109a:fbed with SMTP id a11-20020a056000188b00b00204109afbedmr6176304wri.569.1647903344806;
        Mon, 21 Mar 2022 15:55:44 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:55:44 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 04/41] blame.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:54:46 +0000
Message-Id: <20220321225523.724509-5-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321225523.724509-1-gitter.spiros@gmail.com>
References: <20220321225523.724509-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C standard specifies two constants, EXIT_SUCCESS and  EXIT_FAILURE, that may
be  passed  to exit() to indicate successful or unsuccessful termination,
respectively. The value of status in exit(status) may be EXIT_SUCCESS,
EXIT_FAILURE, or any other value, though only the least significant 8 bits (that
is, status & 0377) shall be available to a waiting parent proces. So exit(-1)
return 255.

Use the C standard EXIT_SUCCESS and EXIT_FAILURE to indicate the program exit
status instead of "0" or "1", respectively. In <stdlib.h> EXIT_FAILURE has the
value "1": use EXIT_FAILURE even if the program uses exit(-1), ie 255, for
consistency.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/blame.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 8d15b68afc..9866e6c911 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -921,7 +921,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		case PARSE_OPT_ERROR:
 			exit(129);
 		case PARSE_OPT_COMPLETE:
-			exit(0);
+			exit(EXIT_SUCCESS);
 		case PARSE_OPT_DONE:
 			if (ctx.argv[0])
 				dashdash_pos = ctx.cpidx;
-- 
2.35.1

