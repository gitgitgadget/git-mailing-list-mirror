Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E487C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbiCUXLm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbiCUXI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:08:58 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7A84BFD9
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:13 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h23so22039915wrb.8
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nAdC0fg3NmY/18s0r0twLr8SfiD39z61/dO+DQnlen4=;
        b=TAq+jZM7MyUaZlQFniqCuatRao3R1jM5z+YqBfwmWcclwRwWG73EAQZWrHJG0uIB8K
         Y95hFkdaOdLrlA/EO6utiKm749UmYjWUTK7ROv3GvoAiIkvw96Y+MqYU5p2a8m5F5GmE
         X5Nokm4kFZkED0bSHZTwUmuO+anC1rpW9ppeDYa5Tr0y67T1Tz2JvID27YY5odRGR9Al
         hQtK7DM7OUzrTY95cZcgY91CipH6bPUWYMbzKav/S/2nvnp3WIJTFmnU8UsX0paOVCg+
         tIb42MWWP1DkV9Sm79kZ4STPnsSwwmqr6g6+DQqO6QTSUrqOikpnsMI1pJ7o3f5+QWeR
         TMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nAdC0fg3NmY/18s0r0twLr8SfiD39z61/dO+DQnlen4=;
        b=Ed+4DPtq+4/ivUABHMQ2AT6LNrmD3OJQB1ubBvGNWacNyLKIoqa2UIPRdKEDPcQPeZ
         ZWyUjV76xnK9rLafxFsLB4RxXgZtw+efus+suoMcVp+i0xLxZHyFGogY1NoUaPei6wED
         uB/knp9JHnOOD4FRxPXry9t2R+Y/M7q1ZCW4AqefM7zbCH9OgwRsFRMzohqZdu+/IbbQ
         cbSxXikD8YxAihygZddJvv9HIL8kzCePP3Fbeq29tLKAfbEC4oQSofkqZzuF0ivd4vo1
         +xMZe143BbNpEwPHd/MG2rLxemm6pKfw0w4CF5xmRsxpZz6NXuuysw0BEZU+oy8w1mHl
         DhHQ==
X-Gm-Message-State: AOAM530HS80qmFM7Est9kDuf3wSwqPGK0qWykm/VTF0+CAcRPyIV8TPt
        hFTVUxz3aRKk39cRO7oZ6bPwXhvlLfc=
X-Google-Smtp-Source: ABdhPJwF+QM/CM3uUR/RYXYFTWF/C5iMRjj/hKCCMkzNNXMIPa2fAZb4kbCXGeX5xj7v7VHNzeY40Q==
X-Received: by 2002:adf:e18f:0:b0:204:444:dd0d with SMTP id az15-20020adfe18f000000b002040444dd0dmr9574914wrb.678.1647903353627;
        Mon, 21 Mar 2022 15:55:53 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:55:53 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 14/41] remote-ext.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:54:56 +0000
Message-Id: <20220321225523.724509-15-gitter.spiros@gmail.com>
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
 builtin/remote-ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index fd3538d4f0..3b32d68ed5 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -172,7 +172,7 @@ static int command_loop(const char *child)
 		if (!fgets(buffer, MAXCOMMAND - 1, stdin)) {
 			if (ferror(stdin))
 				die("Command input error");
-			exit(0);
+			exit(EXIT_SUCCESS);
 		}
 		/* Strip end of line characters. */
 		i = strlen(buffer);
-- 
2.35.1

