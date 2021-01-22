Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866FCC433E6
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 19:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F3FF23B00
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 19:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbhAVSju (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 13:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbhAVOWe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 09:22:34 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0012FC0613D6
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 06:21:53 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id c2so6473979edr.11
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 06:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gAhFytyZ7rcHqLAi+I96riZ2zNjamW26leMVoNiNUQI=;
        b=PhmxfTr5Jeoao0+xCz6YGyKcfU23bETUjIMSMstmTPn2oXKB5KOi0RWaeoJdNFjvuV
         lv7If5Dp2Bfob/fsU/mElLJ4FiaCIib52toDZ+pJc6hi9VuF1xNHHYOU5pRJqD4j2MJQ
         3TY8u99X61SDuNZmV/y9XYFTHpUeT43gsGcK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gAhFytyZ7rcHqLAi+I96riZ2zNjamW26leMVoNiNUQI=;
        b=DYBwWCPHmxBL4pMY1ehY3B8TQiAmUgO9lqruEJ1MQxiIQoG+JqEg18oBjgCHjqpi87
         RimMSosgx+K0f0QpQ5d3r8b18/FbN2rNHaJmEVN9Mu/pPVx9zfbBaY0ZL42L5u/srBQL
         XvCyF5WNJciSLACFImapTG2EEDnddjeCHFUBdBi3lNYcnCIm+/4BwWgITllnsTmJWl4I
         iY5d7w+u2isnAVxOKzvHnd9kdEwxo+pTiH/4meP1+I/UmuFpeCFGFvFIDF/CPE3MAU7R
         EYDWzY1UXr9pQhzKlsLPKI3DONtQ/ISLCElqLtty8k1G4Wd6SasT+JKfn7HOgtSa9rGc
         VuqQ==
X-Gm-Message-State: AOAM5332cDl+C0Ip+MXw/HyVhGZcuy5bd3rx2EbRZTI8nM3MqLrs6EgB
        y3VzoHbbOIfi9qZjDkLomd92MZJsl/ItL4kh
X-Google-Smtp-Source: ABdhPJw0rchzeLI/ng7uym4YRjFvHbRJa7HEPHhbG7VtRrtCqh3oOcNhvTvbB3+ifGoEZqaaKadtMw==
X-Received: by 2002:a50:d552:: with SMTP id f18mr3361087edj.168.1611325312486;
        Fri, 22 Jan 2021 06:21:52 -0800 (PST)
Received: from localhost.localdomain (e93008.upc-e.chello.nl. [213.93.93.8])
        by smtp.gmail.com with ESMTPSA id zk10sm4576650ejb.10.2021.01.22.06.21.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 06:21:52 -0800 (PST)
From:   Jacob Vosmaer <jacob@gitlab.com>
To:     git@vger.kernel.org
Cc:     Jacob Vosmaer <jacob@gitlab.com>
Subject: [PATCH 0/1] upload-pack.c: fix filter spec quoting bug
Date:   Fri, 22 Jan 2021 15:21:36 +0100
Message-Id: <20210122142137.21161-1-jacob@gitlab.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes a bug in upload-pack.c that only happens when you combine
partial clone with a pack-objects hook.


Jacob Vosmaer (1):
  upload-pack.c: fix filter spec quoting bug

 upload-pack.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

-- 
2.30.0

