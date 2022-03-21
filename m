Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E95C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiCUXTH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbiCUXTB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:19:01 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D01A2A12B8
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 16:08:14 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r64so9409933wmr.4
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 16:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N7OIzuAD4d82PuujQmbOZ41TnMl4AcEADQ2IsmOons8=;
        b=p9g5qbYtwt6+wGqVBT6hckKp/tr/MOcctFhuvlqq4/SryrM79Wt/EEyOr347S1Z95R
         KsEzaI2Pfx1T+kPbftlIz73BGWCftP/q55AWdC2jJFU/cRBKPV0ORj45WFutfH3ZW8/W
         P6qmNXGczeSdCY8wx4I9m2mSFQoa1/QvI8NGO4XATZSkYSihN0Wmz/ucJSXwuYHJN4a0
         TEz6z6KkJxEImSs/M3DdgodMoZl10zXhbEDDgj5GWZ8U+T6kP+6bXSASsk7sq53OG5MW
         iNTPKS/aC5dCbbxF5mRqBlLSth4w3MOiLRuaTLTaOE/cITfgUJ/OclsR9fSEvSTOU2Ty
         AmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N7OIzuAD4d82PuujQmbOZ41TnMl4AcEADQ2IsmOons8=;
        b=iNxGq8RjXrvexSyrp4xcYGkb/fu38Vp8bkNs8bIsupLmXSyBoE06ab5UEFMcrRiktT
         r0uSpV2DeWXkOCMiuxfDf2fB8QWnI8IJay4a+1qd5tB8+0PNdLh+idCrW5Ja+/psw0Nu
         jTzVAAitt62MGBp6r9uoEkwOlygqTw3r3Un1a7Xbvsyq/lTMBhDwXrpftR5nRxpa+TMM
         9fyq1CylO6DwDhrVK4Q0Qp1WnD4XZf0BjMAVAaS0gKR0qWwiwTcedLdFDzhB1AX8PB8v
         tHXIi6lXWf7eG8B9HbQlSY2zan2da8XEPajqcVcQgLfwknS/zt24CGkq+g9z05OwfR4r
         PbjQ==
X-Gm-Message-State: AOAM530A8j8CNHPZZTYcFwZFh1hRQhrPlBc4WBmeRHH+unx6bi90+caH
        nDKyfSDt3XNCj/9ZI9Zz2WHpdUcGENQ=
X-Google-Smtp-Source: ABdhPJxBzOj56bYvjGyaBql1m0CXXCiCZH8OxDwcQWqEwcuGO9ADXeI88Cp2u7gfz9maIJw+rtXdRg==
X-Received: by 2002:a05:600c:1c1e:b0:38c:b393:b355 with SMTP id j30-20020a05600c1c1e00b0038cb393b355mr1119544wms.92.1647903358026;
        Mon, 21 Mar 2022 15:55:58 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:55:57 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 19/41] stash.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:55:01 +0000
Message-Id: <20220321225523.724509-20-gitter.spiros@gmail.com>
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
 builtin/stash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 0c7b6a9588..9315ff74ce 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -656,7 +656,7 @@ static void assert_stash_ref(struct stash_info *info)
 	if (!info->is_stash_ref) {
 		error(_("'%s' is not a stash reference"), info->revision.buf);
 		free_stash_info(info);
-		exit(1);
+		exit(EXIT_FAILURE);
 	}
 }
 
-- 
2.35.1

