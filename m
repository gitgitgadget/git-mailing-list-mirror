Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E067C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbiCUXL2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbiCUXIv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:08:51 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724C850075
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:15 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r10so22689786wrp.3
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vjS1e+sxxdbN387S/B19fro7YDW3v+cHmLxecGDRcjs=;
        b=CVOTONMipcgySQEYCwnZ8OxY8uKSq2oz9GbK5JObYFHvqEoSw07DvT8lWe195WYxCy
         3He3cWRKxnIc3kfaDt7XYGyQhDI8wW4WgCOMzcpvqsEp9y9P9f+bWi+6vSORZrFzVASx
         GOhuu9oTSy7f8jXfW3+XRKi1RTEx3DJvHmhmz5NwsLy6LnpXMJjR8v0XmeQWNo0P6EJV
         XC+4Q4/qRv7OtUAFNmpB9fh+rqw8u4qsxIU4y0n0iZJr9z1MvaI1Lm9iHZYn4d2fp/qD
         uhGDJFITFlz5pluMSS804J+/3vjyak3nPtr+ZjavMpTkPoKwNEjY4kVxZw8TD1N+OUei
         OQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vjS1e+sxxdbN387S/B19fro7YDW3v+cHmLxecGDRcjs=;
        b=rmV5ZxMuD88VL8K8cLKu3GyBnx6nJSGtGTZAWN5GspiXWoDDXiQIXjnM016tzBf3dj
         RJ2a3nX3/2w519aKSklxwIrjes7K+IW+fOYYigqx8dXKA0T3+fwD3YJaxmaRpw7IjYRj
         TaQFMvSTgnsu67kGV4+/ohiSSCzxzAXiBG5V0NuUIjNT2flNBdSp9GlygG+/nGT88XbB
         j3erNT+5Iia2f5WDPGez9bbHn2i7hK4JFheYzulUIIzm3XPOs5xinOQD90z/3njhhRZ6
         sO1xoPdrf1NY8f6AmdvkZowhRDrIwJjywfTrm1AwmyshA2HgNi/JwudU0KRA1XM9Nhs7
         W2wg==
X-Gm-Message-State: AOAM531ak/jw5Sm0MNVFuV2CL49YuGUxl/Ir4PtW1ltypktc2ZBszrer
        0Jj56hfdfhKXDjr0qJ4Zn0TLQuQLTRk=
X-Google-Smtp-Source: ABdhPJxHY7r9VQyDOdqPktqrXgskjnrcPBQVKH7VRluMtGPIxRVPrspkE38uVBPN5WZFd/0iP/ElZA==
X-Received: by 2002:a5d:5509:0:b0:204:f77:c2d with SMTP id b9-20020a5d5509000000b002040f770c2dmr6417226wrv.432.1647903357121;
        Mon, 21 Mar 2022 15:55:57 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:55:56 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 18/41] show-branch.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:55:00 +0000
Message-Id: <20220321225523.724509-19-gitter.spiros@gmail.com>
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
 builtin/show-branch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 330b0553b9..04a99aa7b2 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -820,7 +820,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 
 	if (!ref_name_cnt) {
 		fprintf(stderr, "No revs to be shown.\n");
-		exit(0);
+		exit(EXIT_SUCCESS);
 	}
 
 	for (num_rev = 0; ref_name[num_rev]; num_rev++) {
@@ -898,7 +898,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		}
 	}
 	if (extra < 0)
-		exit(0);
+		exit(EXIT_SUCCESS);
 
 	/* Sort topologically */
 	sort_in_topological_order(&seen, sort_order);
-- 
2.35.1

