Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29753C433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A902073E
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6Y/ourw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgEOKFM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 06:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbgEOKFM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 06:05:12 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0ADC061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:05:11 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d207so13489739wmd.0
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b5ppLKRU0970ye5zTxC0e3Zk2GUGRNb3smRgNRmBA0E=;
        b=d6Y/ourwsCi32thP6dJx0oVygDgzklkH9Q6roSfFsKPBevxBunI7AlM4oAclEwz1zL
         Q0LMeb8n8MF3kaGwan6s/GRpzM+9532A2t+Y9OxCQWy4QPV3pXsaoydevzPOo5fZF9v4
         MlPzE6cWun9g45LVBaEjs8anrDZ5kyF0TqpYRn1VrWrR7ymQQnu5JD2kTSQiUu/UZYdI
         Pvjy47OIDD5MyKk3EkPdjpz0+L4jY4KzTgYZd0b3i0iDVlvm/rd63Sx2UoTXR2wWwm1z
         jnO8aF9Uo8VLIY9Po/F8JhPSE09eOBeEM9AuzRmqKcGSX1FjROuNeFaW8lBoKfE9BUr5
         kPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b5ppLKRU0970ye5zTxC0e3Zk2GUGRNb3smRgNRmBA0E=;
        b=QHDjpRnJ5aR6pg0JeU8RmkVIJC9o06cLI6qJtjv8jpYqnPdaA/QXJSXrGel+Jlsmp2
         4pGVE5C9pLCm8wJ8v00XBNERml2Fml7NdBvwrRzKiGrYjaJOWQNnHfSVQvmCmkqICnoV
         CM8+FP90VxPbBvD+pOXgecz6rd1wcbeXdT51E+3L9822/dlZRDoYuRW7skqPohKRv9vN
         iPAIXScmo0VwqNtBYKDHP0DV/M3v/3GCPeiEOY1yuxaBiRnPOWU4MOvnWKpdkakDkfZg
         kSsOmtCbfWKiJpWJcpQodnv4BaFdHHco59qJAP6MuetDE8EOhXeKV+UgT7VVO2UsBAVN
         OsoA==
X-Gm-Message-State: AOAM533LhA7zk1MVJkVqbfXmWr3hhZRQCdR+5Ckx+bua/ju9HN1rhTvi
        wTIIIFeGe2l1xnh8k0QUyA4b0QU2aT8=
X-Google-Smtp-Source: ABdhPJxN+lEKl156Z+melVdpzGrXi1Zdonpkcpvgip0QzeOj/D+1uH1vH1mUgPrab7pTKavPXE5azA==
X-Received: by 2002:a05:600c:2299:: with SMTP id 25mr3225572wmf.138.1589537110028;
        Fri, 15 May 2020 03:05:10 -0700 (PDT)
Received: from localhost.localdomain ([193.57.121.171])
        by smtp.gmail.com with ESMTPSA id m3sm2792326wrn.96.2020.05.15.03.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:05:09 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 01/13] upload-pack: remove unused 'wants' from upload_pack_data
Date:   Fri, 15 May 2020 12:04:42 +0200
Message-Id: <20200515100454.14486-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.26.2.639.gb7dde20fdf
In-Reply-To: <20200515100454.14486-1-chriscool@tuxfamily.org>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
more thoroughly, let's remove 'struct object_array wants' from
'struct upload_pack_data', as it appears to be unused.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 0478bff3e7..9aaf886828 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1131,7 +1131,6 @@ void upload_pack(struct upload_pack_options *options)
 }
 
 struct upload_pack_data {
-	struct object_array wants;
 	struct string_list wanted_refs;
 	struct oid_array haves;
 
@@ -1157,14 +1156,12 @@ struct upload_pack_data {
 
 static void upload_pack_data_init(struct upload_pack_data *data)
 {
-	struct object_array wants = OBJECT_ARRAY_INIT;
 	struct string_list wanted_refs = STRING_LIST_INIT_DUP;
 	struct oid_array haves = OID_ARRAY_INIT;
 	struct object_array shallows = OBJECT_ARRAY_INIT;
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
 
 	memset(data, 0, sizeof(*data));
-	data->wants = wants;
 	data->wanted_refs = wanted_refs;
 	data->haves = haves;
 	data->shallows = shallows;
@@ -1174,7 +1171,6 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 
 static void upload_pack_data_clear(struct upload_pack_data *data)
 {
-	object_array_clear(&data->wants);
 	string_list_clear(&data->wanted_refs, 1);
 	oid_array_clear(&data->haves);
 	object_array_clear(&data->shallows);
-- 
2.26.2.638.gb2c16ea67b.dirty

