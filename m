Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A820AC433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86F552071A
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBN2js0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgE0Qr7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 12:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgE0Qr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 12:47:59 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33C8C05BD1E
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:47:58 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u188so85075wmu.1
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mBmqsrXG+1gof22K0ulz6ASIEWcoDVdZNdSBmRHLLkE=;
        b=YBN2js0HsxErCZPj812WBOryb3jU88jLtIYxTky7VueQIbJiBd3glYRXVhlpBoQVDA
         FgXGiyZlRMqFiI4JehFtizPrRdSU6E/kz87W36Ax2pNptfxv/xwleJgxvFyC3laBFZDI
         LA9/X/61Ekv3DOQcC6UIPhXIyhx9uJ54S3UKU03opCVDFhW10Cht0nRbMyDSHDrltjuv
         a1ySjeMFujuwSf+Vj8OIKmeuN42CdKsEhbTWr2svbzYEs1uk0Kx2r6sBW8eK+P4pk8JZ
         P7A3pXH7rUS9tIxIFL/PGaNpqqkVs54HMJGEY0ylB5hFgqPTGCuqOy06FuZP83VU0I0f
         +55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mBmqsrXG+1gof22K0ulz6ASIEWcoDVdZNdSBmRHLLkE=;
        b=JqsK8t2b960n3oqlStNTQk48kkcHcuNKqXsUWDxPc4PRkGGC+JcpZze8JfhZXzrKVO
         avG/MsOOA5ivQbe2Onh/GD+25TRdIGgkv7H03MO1XpXCECV8Fl/AD/8YYADEkSimBliN
         klgeitcR+RVYDCC2cEhS5aQsLuGM0PNqTEg8DElCsWOvyPa9p+V+mPy355aXBVYiJyLH
         9rgR6cb15zbsYP+cLDoJkRZ6k9oLW6TrHA/P/fWzAmBeVKFYH3IsaSh81vSL86Hf2K9b
         oLgFU9CDSl6R7XvCMsz6laB8K1ZCBH6QAUqNaP8ki4Jy1H/CAZfUnqPj4qikuzSSkD6I
         YfXw==
X-Gm-Message-State: AOAM533hr291kwEO4eiB9vn5eZCx8LN10pX/A6r4Al4tfyCuQ16xycdS
        HkIaz4YIV2YH/sx4lOuK/4rvaRHwdwY=
X-Google-Smtp-Source: ABdhPJy28LuE6Psbwrh+bStZZpWXlVm4mBngbChAW0uAdbC39WlKl11+BlWuL4Nn6mIC6qNt3Guamw==
X-Received: by 2002:a1c:f207:: with SMTP id s7mr5035611wmc.123.1590598077239;
        Wed, 27 May 2020 09:47:57 -0700 (PDT)
Received: from localhost.localdomain ([193.57.121.40])
        by smtp.gmail.com with ESMTPSA id d17sm2432852wrg.75.2020.05.27.09.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 09:47:56 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 00/12] upload-pack: use 'struct upload_pack_data' thoroughly, part 2
Date:   Wed, 27 May 2020 18:47:30 +0200
Message-Id: <20200527164742.23067-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.rc2.38.gc6b4ed14d2.dirty
In-Reply-To: <20200515100454.14486-1-chriscool@tuxfamily.org>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is the second part of an effort to move all static
variables in 'upload-pack.c' into 'struct upload_pack_data'.

It is based on 'cc/upload-pack-data' which contains "part 1" of this
effort. (See also: https://lore.kernel.org/git/20200515100454.14486-1-chriscool@tuxfamily.org/)

A part 3 will follow with the rest of the patches needed to get rid of
the static variables left after this patch series.

Thanks to Peff and Stolee for their review and help.

Christian Couder (11):
  upload-pack: move static vars to upload_pack_data
  upload-pack: move use_sideband to upload_pack_data
  upload-pack: move filter_capability_requested to upload_pack_data
  upload-pack: move multi_ack to upload_pack_data
  upload-pack: change multi_ack to an enum
  upload-pack: pass upload_pack_data to upload_pack_config()
  upload-pack: move keepalive to upload_pack_data
  upload-pack: move allow_filter to upload_pack_data
  upload-pack: move allow_ref_in_want to upload_pack_data
  upload-pack: move allow_sideband_all to upload_pack_data
  upload-pack: move pack_objects_hook to upload_pack_data

Jeff King (1):
  upload-pack: actually use some upload_pack_data bitfields

 upload-pack.c | 185 +++++++++++++++++++++++++++-----------------------
 1 file changed, 101 insertions(+), 84 deletions(-)

-- 
2.27.0.rc2.38.gc6b4ed14d2.dirty

