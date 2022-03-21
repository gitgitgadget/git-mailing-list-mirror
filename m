Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07194C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbiCUXKX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbiCUXJq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:09:46 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DFD3654B5
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:58:09 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id u16so21648627wru.4
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FnITzvNqQkosIVLcL7E6KVmr8OjpAtR5BO31KpKgruk=;
        b=Kwa0CsBQjyX6MH7gfKeAV9xBbS6oWHL92EZ01cUIMDFbcxnRhMExtj4biHA+bN8OCe
         ZVJq7MGnYYmsuWDFmULAqX4zxXfa+1MtntqJeXyGdtBvCyV9Lqc2LDmqbi/xNMFeN6zt
         SUkzntfSK/PZChrypp1l9cXCCO+QbPLQx8lCG54agbBc49OVLUlzUB/kP0sfIFQ13UmY
         AJ86U2MdizJi8hHS0eFauluzM0fpvyhE36rETuWt2QBvevS/ymjSHGyByekhrftb6UwN
         xfPjkicl7N0MdHIAr/3DMIvQCAoB1YNslKCQOpLXYfm1S5eNBJmjJxBywTfumvQUhIkK
         CNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FnITzvNqQkosIVLcL7E6KVmr8OjpAtR5BO31KpKgruk=;
        b=66w/idhQZtz7UgMnQFocwFaQbaM1pj9L3UkpJ3fjOaQofhdyL/pgL2/sT6CDk3moea
         SNcmFS7JWcbNXAlJonoU35VSNppRlWOzg70a/DKUvB9nqPNm+s0FUAf15tPui6qUb3Ij
         /ObnH+pp4BKL3zN4cWCj7VcTUYKeKnqGrv4eG1aTPGBGiwffm5FncS33T2camYGiYX6l
         +NfPbLp0yNOFoUNmMe2ePrLjGRpf+SQqhKZvNVVmfpQ/AgEwLBU2ntFus3i47og6M/9s
         uoOypZus2leNnEJqQxsp0h2oDzeWmj12YWnc8Hf3atq1LaN+SoXVx7+y05jWsKZKM9Kz
         SXig==
X-Gm-Message-State: AOAM530xGEqGDBCpMJ3bCfHX+HyLRBUYUiXPOYJ9eV/inYNwYrtJq2Er
        +txxHGzmhOigXg76x5KNiChcPVsbcls=
X-Google-Smtp-Source: ABdhPJyS3a7jRdTSd1GAkc/9SUAwaVfzLRgf76ozYd+IJfsjK1c51/mi3FNCmiWxe3E3vHbeLkfpvg==
X-Received: by 2002:a5d:59ab:0:b0:203:cc07:8d82 with SMTP id p11-20020a5d59ab000000b00203cc078d82mr19078919wrr.688.1647903379155;
        Mon, 21 Mar 2022 15:56:19 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:56:18 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 40/41] upload-pack.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:55:22 +0000
Message-Id: <20220321225523.724509-41-gitter.spiros@gmail.com>
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
 upload-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/upload-pack.c b/upload-pack.c
index 3a851b3606..1683d80c4d 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -543,7 +543,7 @@ static int get_common_commits(struct upload_pack_data *data,
 				return 0;
 			}
 			if (data->stateless_rpc)
-				exit(0);
+				exit(EXIT_SUCCESS);
 			got_common = 0;
 			got_other = 0;
 			continue;
-- 
2.35.1

