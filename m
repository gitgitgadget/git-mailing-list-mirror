Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E0AC433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbiCUXRJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiCUXRC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:17:02 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D853FF263
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 16:05:04 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m26-20020a05600c3b1a00b0038c8b999f58so441819wms.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 16:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SOEuVXiqSam2kqqMaWZHSLDegqfhDXwGWbk2ZzjuXcw=;
        b=q0nTExE9LmRYLTflbQl48oUsclrt4SWblmKqt6pNUDshS7GgPKTB3jNIWsv3adCNvP
         SEkg2bj5DqCR6XhJAh7xKpu9gfGclz2/Q+VuIPqwgTXeaubEDD2/pO0GgM797LNi8YOg
         suvpW9NTWzLO2UlP/V/VIv9RJapNt5eLq0FX0SHvzaIAvtKtGOoyPfrNZFSXDHMCyvJg
         SwLTUPxtsXaANyWjPUqtfr8F4WySCSgJogneU/JqDUBEhpMQI7njaI6kusqujHbmhSl+
         hJ9P2TUXVFMEP+aSftT8dlg2Hf/yOOERevynGhSc2koIPEV+HVqd133YD2IyAGilGtf4
         0LKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SOEuVXiqSam2kqqMaWZHSLDegqfhDXwGWbk2ZzjuXcw=;
        b=lnLTEsReNycqnG6Ayi7g28VHvrMiooON7x4kY9hcYsok4SvIRzBKaz/m/YNt0+BHpt
         4NrFpdV4G8nywmx9IqO927aenHB1AIbtwt8IXM+7fUv/PDXIdYUOtmzEOwB4ecaIHcKH
         TUeF6HG0yqRZPmR3HXUt4p9lzV5RtOwJ60OzKcyK+vk30pNccYN58phU2OBUvqa6Shsp
         SSF+UnffuMSxVpUZ4n4dsoVpiYH3Rd9hgiuZf/M9j43LJYZCK4OtrtqZTMGm9b0HwMAc
         /pIaaI9eqffQs1na5Mx1FbmsOCbmpI46+bnuJ0tQzzkGXJX7OrTbDnGky7ocrsT3SSRc
         J3wA==
X-Gm-Message-State: AOAM532tAlxgJCZTwGPT/X7f6+hqiGD3NVyM8jv3I0WL63ZbXrHQzSCa
        kU9hX91zj4MTHgoowaibx1zywPqbC1I=
X-Google-Smtp-Source: ABdhPJy0X4l9QJ0BPuZg3+sj+BXDWcDTRDFUzHpW+R1tkkIHM/vnhEkgDsfbVJTqVMFs1M2Vv1YLVA==
X-Received: by 2002:a05:600c:378d:b0:38b:e12f:edde with SMTP id o13-20020a05600c378d00b0038be12feddemr1111163wmr.69.1647903348309;
        Mon, 21 Mar 2022 15:55:48 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:55:48 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 08/41] init-db.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:54:50 +0000
Message-Id: <20220321225523.724509-9-gitter.spiros@gmail.com>
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
 builtin/init-db.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 546f9c595e..d8ddc04b96 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -264,7 +264,7 @@ static int create_default_files(const char *template_path,
 			    initial_branch);
 
 		if (create_symref("HEAD", ref, NULL) < 0)
-			exit(1);
+			exit(EXIT_FAILURE);
 		free(ref);
 	}
 
-- 
2.35.1

