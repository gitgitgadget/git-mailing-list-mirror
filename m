Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE23BC433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiCUXLl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbiCUXI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:08:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CCF4BBA4
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:13 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id p9so22620438wra.12
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MX1goLsm5UdtODGaQviXS6GI4k8Bwq9p8iWNLzhjkk8=;
        b=hK84w3GeKxdV/+azoi/EoL3oRCMYg1dBHVVv7uxs/C8anzQ7HWHk4roxJHUubKMzaw
         4L5ii6+kzRC8NVMEGS4omyyIpWgPAF1kyoOHnAjFx4sGZ6kQLKHA8yIRjWZ5tzim9Ayn
         0lAxdW17dgkv0m4RTC51SR7fhmmY9L3ZEg3baJam9L3M8f1gejouPu9cV9BYsrzSZO6v
         7g+gFTYkKjce6mdHx+StMidvIX4AgBHiLaiKp9CHkauaVgX1oJKhHmDR7NPkUg3a6UPH
         XeEXpZzWQt9/4wEl8A7PWBydCYnuni1AJi+4iPcQdzI7DpSlInMgkVFBVardNWfTx0G+
         EDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MX1goLsm5UdtODGaQviXS6GI4k8Bwq9p8iWNLzhjkk8=;
        b=XCxjtg9g942HHskyOpEO7YBF6QJLMHdLNwFAIyRhHST8S7y51eSwPnSfU9TNioPEKX
         WG1vJVcB6BPRHGpwCCUmkDWwCmsKFa4gqxzrNWAAZhPn3jliGzFWH+AkEho0qNVBbvTn
         vndum2XPhPkwzOnRLA5i32NC131L9+sVg+Z5oqcqCiO2fZZb5+gQOcmZHRnFODRmiD7M
         sDV3cAU8KyEPoL+lSOHEDZUmuhU0P7XNOv+y5erwKL/Nc2XLdp/Pvjzf3QDlRuHvn50Z
         LUFxT8inOpjhIntYfM2ZuYlHZzJzwx+NSDrKRT2KTKNROiwV6zknQ++Y8e/1byieai8D
         nI/A==
X-Gm-Message-State: AOAM531c8q7a04NQmWR1Y5Q26NZr2YRvkrY0n4oNl2oRgYJSw6h7G+oZ
        5ECLqEFgCLy5mfT6vftgeKNcfvFCTLk=
X-Google-Smtp-Source: ABdhPJwbrffveuPFrIZp34b3Iupickr/hF7/s4YwrtFvK5mIrEeVes5WF94yowWxKTJwvnVQVZhV0A==
X-Received: by 2002:adf:f14e:0:b0:203:e049:6829 with SMTP id y14-20020adff14e000000b00203e0496829mr19507588wro.386.1647903346560;
        Mon, 21 Mar 2022 15:55:46 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:55:46 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 06/41] credential-cache--daemon.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:54:48 +0000
Message-Id: <20220321225523.724509-7-gitter.spiros@gmail.com>
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
 builtin/credential-cache--daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 4c6c89ab0d..83441cad5e 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -138,7 +138,7 @@ static void serve_one_client(FILE *in, FILE *out)
 		 * process actually ends, which closes the socket and gives
 		 * them EOF.
 		 */
-		exit(0);
+		exit(EXIT_SUCCESS);
 	}
 	else if (!strcmp(action.buf, "erase"))
 		remove_credential(&c);
-- 
2.35.1

