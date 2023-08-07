Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575DCC001DB
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 16:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjHGQii (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 12:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjHGQi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 12:38:28 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C4C199D
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 09:37:58 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-583d63ca1e9so54726477b3.1
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 09:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691426276; x=1692031076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ONi12aEgnk5YUALdXCqyRf8n0r+9sccZlBDkY8IOSo=;
        b=ID6tAZSdRNOqo+cnxIdUApWrR+4vDYr8FjCO7nOIdAJhnRTuDQq190rLuQSYA1gZxy
         vcNuMQ54N5IfI84Vf2EflZlUMVAQq5ZnM7n1jcrv6vp8dfNzsykUI4bwja6+jVZVBZGu
         wgQ84ndXjQKMzOEuqkkdsTeWNj5KE8St5E02cUl773rKEIduR/fdcnTxlqtPDvHb/8eI
         SaN0oV3u07mbdWvU2AGGGxSFtTPhoyYgsDP+0oGdIa1dBi41a4iQNaz+jj8PalNxAWVy
         qQl4Heeae+lWJc+VZJcu/5axJboxfvGQiCohKYkbbV/7D0gsJtmSLQQDl7TgXyV6ahVN
         aayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691426276; x=1692031076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ONi12aEgnk5YUALdXCqyRf8n0r+9sccZlBDkY8IOSo=;
        b=WstAvwVUeEZNG7A1blmUuTUkAeoRzy0587UrsogTdDa18mgihLLOw+RyDLD8Y0PQwn
         u+zTDOTWcxMaUKWQttcysGFEfwKkeV43ky2yqQBDIAVT4QJSdst40wWZP4zupBhjJv0O
         EiBMCl0N/B/GTU/xdOL2PzQJaV1JT3Zl6OPxtstMst2R7bEUCiwYILv3bDTTahixIzPK
         5Gz3BgrEhwBiSPCe3Eh6dpMHGjAi6S0cswqVfGvciLIdUDpsZ0wVeXXd1vTpaf/C6EhM
         uluAomnF8L+KipEF5RssLdKvRbgO0FEcr+8Llgt7MxDaZXn9snZCcgNIqYTIVv3ruA4N
         eSew==
X-Gm-Message-State: AOJu0YwWDUL7/0LT+PXHdWzFq0KhzONdJM42dATXZkV5iKtJvRTkvVbv
        tQGzA0d+su0FCPG0sxK9m3Axt7t+l94Xh62bjUHn4g==
X-Google-Smtp-Source: AGHT+IEKs+0Sv94GoeBTd0cAazPvsrR6vBzImE8lQWBjT0Cqq73+ZefVi6rEQAqb4RcwtnmsRQt6ig==
X-Received: by 2002:a0d:dbd5:0:b0:577:3bf2:80f0 with SMTP id d204-20020a0ddbd5000000b005773bf280f0mr10961243ywe.2.1691426276706;
        Mon, 07 Aug 2023 09:37:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d203-20020a0ddbd4000000b005842447e843sm2814217ywe.10.2023.08.07.09.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 09:37:56 -0700 (PDT)
Date:   Mon, 7 Aug 2023 12:37:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 5/6] object.h: fix mis-aligned flag bits table
Message-ID: <09d6dd93594870c8010c4927c5eb9489ae23e7a2.1691426160.git.me@ttaylorr.com>
References: <cover.1691426160.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1691426160.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bit position 23 is one column too far to the left.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 object.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object.h b/object.h
index 114d45954d..db25714b4e 100644
--- a/object.h
+++ b/object.h
@@ -62,7 +62,7 @@ void object_array_init(struct object_array *array);
 
 /*
  * object flag allocation:
- * revision.h:               0---------10         15             23------27
+ * revision.h:               0---------10         15               23------27
  * fetch-pack.c:             01    67
  * negotiator/default.c:       2--5
  * walker.c:                 0-2
-- 
2.41.0.407.g6d1c33951b

