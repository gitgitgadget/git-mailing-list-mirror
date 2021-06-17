Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBFCC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 14:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D438561405
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 14:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbhFQOhi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 10:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbhFQOhh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 10:37:37 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8E2C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 07:35:29 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id s20-20020a4ae9940000b02902072d5df239so1632958ood.2
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 07:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j83Z/XRG4XeSeLcnKL8hezOzYhepdxE04KG8lx2tSUM=;
        b=i6mzWp3cjN/0MrFg38MolvIaxOzDQrm0YpXvo5Zwe0Xv7j7nm//mrs4zdQUUsWnxLz
         Hr40+KFIqzRk4jzsuJxwdbTINd5SfBDXUwIOAxzJRni2Qz/WqYGmXrW3PkAWVeIHtHxl
         +zq3EmcfHSQwB4E1TWCriPBoUBbd6DpTpAqKW1N1to8h6kbmbgxJxPGu3GeM5SgUnqVy
         PF7irMul4cwcGT4jFFcG466DFZXFTXjDm4SwqnIUbpSQ/t/DTq1gVE0VJP5YUWBvdtXw
         UunrgeEkPBKVNCYU6UJsgn7yKBmLwkSHx8ykyktPn60ALabOl0VkdtVOnpjox7e9DNhO
         1DIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j83Z/XRG4XeSeLcnKL8hezOzYhepdxE04KG8lx2tSUM=;
        b=MLoX+q1E2jYlBB6LJXqn/HVc1RP03Qj0bxjY6UxZWZuKYyaXmLbgo6RmfA+btjAdPo
         CDZyymxRatu4x1+24vgH3PvAZBQ/AbhelwKuaj2/BUOb8Jrdi/P4QhpDqdYy1GW4SOlS
         DV+f/FsKfRBh15wyqhzu5G6EDZ0TzHkuj66X2okKjNeW/R2HxH34T83gSuhFj8zTbv/p
         XIxrGbY3i/fpujL9GoakhrPW7ia8uhIBJdOngxdY2dBIk5puy9r7ydsHlR+SXvH4VXw/
         QVdVYUbPjxSzxtK4FpX/NF+TEPEwbp+2RZ6OxugwIRUWlfLIUVTF3ATRkdS+llcbP4xV
         0kfQ==
X-Gm-Message-State: AOAM5315rpmQ66756FOcWCXPUV9/+Vz1BM+T0QhsYWzmMkEmXV0ZVuzF
        zwWmkrhmdrijtVrA7QDTEXQ5Z3ngGORcTQ==
X-Google-Smtp-Source: ABdhPJyV8rs9oFhTYlaP3F/lT/68RdXM43Zz4vJQgNkJIccMPWXQyGiReYWISd2aKMTB6MyhXIE6dw==
X-Received: by 2002:a4a:e286:: with SMTP id k6mr4713675oot.62.1623940529009;
        Thu, 17 Jun 2021 07:35:29 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id t33sm424205oiw.13.2021.06.17.07.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 07:35:28 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 0/4] completion: bash: a bunch of fixes
Date:   Thu, 17 Jun 2021 09:35:23 -0500
Message-Id: <20210617143527.77329-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These should be pretty obvious and straightforward.

This is exactly the same as v3, which alread included the minor
adjustment to the commit message of one patch, but for some reason v3
had trouble getting into 'seen'. So I'm sending it again as a new
thread.

Felipe Contreras (4):
  completion: bash: fix prefix detection in branch.*
  completion: bash: fix for suboptions with value
  completion: bash: fix for multiple dash commands
  completion: bash: add correct suffix in variables

 contrib/completion/git-completion.bash | 14 +++++++-------
 t/t9902-completion.sh                  | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 7 deletions(-)

Range-diff against v3:
1:  4b73b26338 = 1:  183328a25d completion: bash: fix prefix detection in branch.*
2:  cb2fc1a7f2 = 2:  a0f881b508 completion: bash: fix for suboptions with value
3:  ece06463a2 = 3:  1e33fa9611 completion: bash: fix for multiple dash commands
4:  f9db132cbd = 4:  6293c134f9 completion: bash: add correct suffix in variables
-- 
2.32.0

