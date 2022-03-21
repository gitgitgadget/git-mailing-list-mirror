Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF046C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiCUXHY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbiCUXHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:07:16 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B2C23DEBA
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:47 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id q8so11294896wrc.0
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7S49J4rNMrM1ov2+uazlPh/tM8brvFV6SbkvoU8GTe4=;
        b=bfCJ4hkTh3y83hUORGEWQ0twxUQThdl9Fqidbae3z9vyVStREdXJSbjeMMA4UfTJsp
         qAfW2uxiWgI8Z/KCXgbeX9iibZFyPEXXw32Mego3CnNj/ZFvb65/j9Ef/Y6w2qMBB4Dh
         FasiYaqxIy0vefsoXGOmZtxZcLVzZ2hqCRWtiXi6XjK84+dInmKKtsnBdFgdV+d4aq2m
         mj6hLpgbieA5IT14cAqTmo922+A3xSle4987CuLYwyCAyrRg6qs0pYtu33TFNYHcakGs
         4Tk4VE1iX3fBRIFNARuerZKY+vKGNewrqOBIY4XLXpWMCMD5e0JIaXwJZlmS8sM10naI
         7bgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7S49J4rNMrM1ov2+uazlPh/tM8brvFV6SbkvoU8GTe4=;
        b=KfZ7JSnrJEIpOjiedBxIFBLdkPSmbnf3oxeZWQcSVszrq+N5Pc0zWVs48/omBoCWeG
         Oylo21Yq9EVufD/eBOM29C0IRrWi/y9J31wuzdk4z5wAh2WPSqP9rJptxCUyvkCs9+V4
         JpvY/7OSPpM1o9yrOuvaOrgbTejG7xOBFmzGWVtyrtDm8YMVyWhsdLr8esMCgCLa2KbT
         uREZC4TBbei329qIKJMNu4u++dHw/aVXooZ69/EcohAd3+HanO+nlLGON1kGZ3tp+gaS
         +f3i0G/Rdr7A+jKlXCq2iYtlZcgbBH7h215GdAK1ip1HWOmZR5ukd4KFZa9OJdcTpgF7
         E5+g==
X-Gm-Message-State: AOAM532/IJEKIWMiibaE04dgcN7zTAuGR9LKqUJmYtABfPGuUavvsPsb
        acK4oWTF9F91nRV/DmEjdfs1/TS0SEQ=
X-Google-Smtp-Source: ABdhPJzIONCUshG0V24rV3b8kwXTMvT8K18n/yZE1qB6fGou2N2UdeaRQqsWfKoeBzU4SJOhyvHiMQ==
X-Received: by 2002:a5d:64e5:0:b0:204:147a:5f4d with SMTP id g5-20020a5d64e5000000b00204147a5f4dmr5009769wri.225.1647903347374;
        Mon, 21 Mar 2022 15:55:47 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:55:47 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 07/41] help.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:54:49 +0000
Message-Id: <20220321225523.724509-8-gitter.spiros@gmail.com>
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
 builtin/help.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/help.c b/builtin/help.c
index 222f994f86..e5ca9d4a6e 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -554,7 +554,7 @@ static const char *check_git_cmd(const char* cmd)
 		if (!exclude_guides || alias[0] == '!') {
 			printf_ln(_("'%s' is aliased to '%s'"), cmd, alias);
 			free(alias);
-			exit(0);
+			exit(EXIT_SUCCESS);
 		}
 		/*
 		 * Otherwise, we pretend that the command was "git
-- 
2.35.1

