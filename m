Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD35EC433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBF812053B
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTV1rG+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgFKMFf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgFKMFe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 08:05:34 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1E1C08C5C1
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:34 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j10so5875986wrw.8
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VXL/dqF2jPmp8Aa76zS+lSeSDG9FQy51xMITMS63HfI=;
        b=HTV1rG+wY5LtVqyDKZHDt/xBJ6LXXYLUStnSuLcIzK7ogeuXn32+QTUtgJ1XuRdBcP
         fNLYFdqq3gPIPPrImSSyS+PjIa++X7M0lI6rblaTZhbMUwwMHzJCgJL1jPafeXVt2ooi
         Ih7cWcWMQ2EKpkXm49FlHUgMty3/Pp54rJB2xgphzdko+gJH+fyh4EtzqESniCD8HM33
         wZhe6BnGD/Xp+NPq5tcpFPYnMB2ufxMzXVtD44ju3P3jMRpKurrw5FvWV9q+nkLusFww
         WUuPCY6DrelPI0DrlXn9hkn4Ps3Eu/GBO15+Cyejqv/RMmcwnQyo9khD6vif3AqrDbQQ
         KXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VXL/dqF2jPmp8Aa76zS+lSeSDG9FQy51xMITMS63HfI=;
        b=uKwXwLISNDnpLMRysMmDl33vWAO8wZYEs3U+NRoAP1KiifI7N9gCG15QSPZZeS/hdT
         tbrbINOTo3qSuBIWkvo/ssaNRmKDbtpdaXyEGgusdY5FXtzezjJDzd+3cHZtnugGUt7L
         ZSb4dR1AwHotBXspVk10ORoayJpJrgiObSrRhzCC/jn2MtSnl2xbl9/npEJRTnkJEiLg
         9zCIeqvIddo9cXIC4b6ZEgnbJpChv95zwpQNzf6Hm9+X+n9KGFFgMFLiT/oRVtlabKAP
         uWZEy3sr2LDfIv8UOmTLQNEGGeLtM72mbi1bnr6XG2MI5c8EIyd1rJd8xxVesKsHZo5p
         1oUQ==
X-Gm-Message-State: AOAM532hDcl2tyLBXLul5BWxWK4o3/yS70CXxH7RD2uwA8mQQpHDxWok
        dagyrcazhdtJGVSz2r/OwKQGj/++wbY=
X-Google-Smtp-Source: ABdhPJx8ZhuHErFJ0gx48mp/T3iegs8rQQfgb8RcdapROS99g9kFMu0XHLF8rBGBMPMBU83jEnL45g==
X-Received: by 2002:adf:e40c:: with SMTP id g12mr9312917wrm.121.1591877132015;
        Thu, 11 Jun 2020 05:05:32 -0700 (PDT)
Received: from localhost.localdomain ([185.228.229.208])
        by smtp.gmail.com with ESMTPSA id o8sm4047174wmb.20.2020.06.11.05.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 05:05:31 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 00/14] upload-pack: use 'struct upload_pack_data' thoroughly, part 3
Date:   Thu, 11 Jun 2020 14:05:04 +0200
Message-Id: <20200611120518.10771-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.90.gabb59f83a2
In-Reply-To: <20200515100454.14486-1-chriscool@tuxfamily.org>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is the third and last part of an effort to move all
static variables in 'upload-pack.c' into 'struct upload_pack_data'.

It is based on 'cc/upload-pack-data-2' which contains "part 2" of this
effort.

There are no static variables left in 'upload-pack.c' after this patch
series. Patch 14/14 is a small refactoring on top which can be left
out.

Thanks to Peff, Jonathan Tan and Stolee who reviewed previous parts of
this.

Christian Couder (14):
  upload-pack: pass upload_pack_data to send_shallow_list()
  upload-pack: pass upload_pack_data to deepen()
  upload-pack: pass upload_pack_data to deepen_by_rev_list()
  upload-pack: pass upload_pack_data to send_unshallow()
  upload-pack: move shallow_nr to upload_pack_data
  upload-pack: move extra_edge_obj to upload_pack_data
  upload-pack: move allow_unadvertised_object_request to
    upload_pack_data
  upload-pack: change allow_unadvertised_object_request to an enum
  upload-pack: pass upload_pack_data to process_haves()
  upload-pack: pass upload_pack_data to send_acks()
  upload-pack: pass upload_pack_data to ok_to_give_up()
  upload-pack: pass upload_pack_data to got_oid()
  upload-pack: move oldest_have to upload_pack_data
  upload-pack: refactor common code into do_got_oid()

 upload-pack.c | 287 ++++++++++++++++++++++----------------------------
 1 file changed, 125 insertions(+), 162 deletions(-)

-- 
2.27.0.90.gabb59f83a2

