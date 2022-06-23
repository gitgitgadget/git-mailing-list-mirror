Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4F7C43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 12:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiFWMi2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 08:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiFWMi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 08:38:27 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E6648E4D
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 05:38:27 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 23so12868540pgc.8
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 05:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FeRUiW4oaLjnPbdjGy50AOMPhIdqTnWp26qq1ORu4rk=;
        b=niN5LEMPiaAdOZJF++aVmIaW5x2nluI1wE2qoDmr37RkXYr3pxolaEXJSAkL19zrZh
         AFlizE8YAc7hvbW6Q1KEX555vyOmlvp0hleqN4p6mmuRoAY4o+Wj9w7mRvBCDrrmzrtI
         mLwW351WX4cSJMQ+nwousrTYIOFP3AnOryAnJty8KXB7YXoAF/S4HrYy+1auVJOjQFdi
         8CrlEvLPhNu/WUXXRP/LKyTMNEufvcG1onFbl1kh4UxjQ4R7d+/1ujaHlUgG6v7/Ee6f
         1pDYT/w+fO2GdYv/DblLCrB8ywhWDmLRv+3wh3VXYeOQVFW1LsyU/yn73ktFKVK0Pg11
         hkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FeRUiW4oaLjnPbdjGy50AOMPhIdqTnWp26qq1ORu4rk=;
        b=30HhX1QTgnVpe2Egt2Jll7kVkvy+UDt7PD3E8XbSqAHozqzGIUPQkKzZyIq4DJl4fG
         Au2/e5KJCXrA5EHKb4z/wMZEK2y7nyABe/fjw3N/1NM4J7oZNgCM1V3JhVL+SCkb08hu
         Tf9ZdMvCvoNQaVq/CVlwrOVuZYVVF3zIe19WnvT/kQi3dU66NHwhMkT2nq/Xy2gEvI9l
         UqUHOxgBPToMxn0OnBmAr8Tu7oepF9CUqJw0I1Z3VKh3t9E9gnyWy2BKHQH3/kS+KBDD
         opq652V7/k2sTJ5Vc8QT7ghqrk/oJeIy8RupZLVzZLy9M5hyQ3uxCDsOG3oRZ2jjXsB7
         PLAA==
X-Gm-Message-State: AJIora9f1SFaZSCRTihgMURqt7KgEJNDS582PGhR8yOcILh8cr280Q4x
        WeJ5dTswZCm1MV4bjT6FtNI=
X-Google-Smtp-Source: AGRyM1tjRAkAb9Y+lYHLk0AUpTPVrT78t2tg2QLwr+NNXLDj2pV9HEyAp1eyn+LFsrC3LiEmWZwY3Q==
X-Received: by 2002:a63:8949:0:b0:40d:44d6:423e with SMTP id v70-20020a638949000000b0040d44d6423emr4460518pgd.525.1655987906719;
        Thu, 23 Jun 2022 05:38:26 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.34])
        by smtp.gmail.com with ESMTPSA id g10-20020a63be4a000000b0040c52ff0ba9sm13001685pgo.37.2022.06.23.05.38.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jun 2022 05:38:25 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     me@ttaylorr.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, haoyurenzhuxia@gmail.com
Subject: Re: [RFC PATCH] midx.c: clean up .rev file
Date:   Thu, 23 Jun 2022 20:38:19 +0800
Message-Id: <20220623123819.2388-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.1463.gf770e9f396.dirty
In-Reply-To: <YrNb2x2/7Z31XnFJ@nand.local>
References: <YrNb2x2/7Z31XnFJ@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Wed, 22 Jun 2022 14:13:47 -0400, Taylor Blay wrote:

> It shouldn't in practice. We'll recognize that the .rev file is garbage
> if it's checksum doesn't match the MIDX's, and we squashed the bug where
> changing the object *order* (but not the objects themselves) doesn't
> change the MIDX checksum (it does now).
> 
> We won't write over an existing .rev file with the right name, but we'll
> always prefer to read the .rev data from the MIDX itself, if it exists.

Yes, this is what I want to say.

On the patch itself, I think it may worth to remove the tmp rev file at earlier
time because there may reduce doubt about whether the file remaining after
the interruption will have side effects (but we know it won't for now ,
because regenerating midx and rev will ensure an strict match based on the
checksum).

Thanks.
