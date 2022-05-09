Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7443AC433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 17:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239829AbiEIR7H (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 13:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239814AbiEIR65 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 13:58:57 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9AB2D7EFD
        for <git@vger.kernel.org>; Mon,  9 May 2022 10:55:03 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id a21so17206533edb.1
        for <git@vger.kernel.org>; Mon, 09 May 2022 10:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zbp0m/JBmcCn2CtDc8T5iAGob/QKeDBumuIuvRbbVio=;
        b=oCLP5r+Y+TjfReagS7imcFc/fujB5K2CNXpuDiGt8gErIB8FpQ9yZGKbqjd3IbHwIm
         BhbxdVnCdhSnq3RUpwST1LGbyWnLV+5naiksfTnSZ6iJ7JB9MTw+mGwS44RH/xnevDCe
         hVcv0Ebv9DZwQ1Y3CDzbauhGMBRvnnQ+VSx1kDhumCYfhQTGXV6UUEhp3tPSeY7NfaXd
         z9uxXdF1uB/zWCbAIj6abO5K/62zXupJzSCOPG7vinSTQupPZZ3U640MyqlFA0JDnhyZ
         qkmdnnA8xC+ImAK0e2bfx4nb5oYlZn01sdkA+wnHh4O7yxJA+7H2C88m+1frmO8bG/ce
         zxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zbp0m/JBmcCn2CtDc8T5iAGob/QKeDBumuIuvRbbVio=;
        b=A2DmlJwA3QlnrU8T3mVFD5OGMfDhqROozZ0yIwgisZgMaTQf1xZrwkX8Stgersuzli
         eQQ/EfrN/SZs7WirQDhsaJHBr+RP/16wmoOc2Fd0rdlpnr0kvl9rnkdVF0MFARYhWKls
         w6foDvfp8KxiE3xA17tuJHoew6GLKW7nfO9hwqCaesD3dBzgJtYthHwrCxuH+qd62C69
         DQoTqnZd2hWMME46By8qoud0KRYcPBPoiJWht5MtzIEkuq6kXmNHwJao/ll7a/Vq3TQ3
         IZ/cwENrLVY/U4LqqQPpKvCTCRQX3NTqcv9gpIzEo5E3lonksu8TKwiqFfKakKoBlQcw
         8R5A==
X-Gm-Message-State: AOAM530gvCS0d/rcygy8zZTe03N+0Zr8LgguAvB5JjAAIxqVvhEYwQBD
        a05X0F4XvpxB644K0aNqk29YYBH43Ww=
X-Google-Smtp-Source: ABdhPJyabz6HuTCGv9CtkIPvv3kB8ZdMIWlNLbfBdHg82/GpULBzPzFr+H8sfm/na0Yc23EiKB35qg==
X-Received: by 2002:a50:ee11:0:b0:425:b5b3:a48d with SMTP id g17-20020a50ee11000000b00425b5b3a48dmr18439921eds.246.1652118902681;
        Mon, 09 May 2022 10:55:02 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2149:8a7c:1900:a49c:b216:27f2:528a])
        by smtp.gmail.com with ESMTPSA id l17-20020aa7cad1000000b0042617ba63bfsm6552883edt.73.2022.05.09.10.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 10:55:02 -0700 (PDT)
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, avarab@gmail.com,
        Plato Kiorpelidis <kioplato@gmail.com>
Subject: [PATCH v2 05/15] test-dir-iterator: print EACCES and ELOOP errno set by dir_iterator
Date:   Mon,  9 May 2022 20:51:49 +0300
Message-Id: <20220509175159.2948802-6-kioplato@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220509175159.2948802-1-kioplato@gmail.com>
References: <20220509175159.2948802-1-kioplato@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, only ENOENT and ENOTDIR errno names are explicitly printed
when an unsuccessful call to dir_iterator_begin occurs. In case any
other errno happens it's collapsed and ESOMETHINGELSE is printed.
ESOMETHINGELSE collapses a lot of errno error numbers which makes
explicitly testing for specific cases of directory hierarcies
impossible.

This commit allows for more thorought testing by seperating EACCES and
ELOOP errno from ESOMETHINGELSE, which makes them explicitly printed
instead of just collapsed into ESOMETHINGELSE.

Right now, there isn't any test that depends on ESOMETHINGELSE directly,
neither in EACCES or ELOOP as a result, since only errno error codes set
by unsuccessful dir_iterator_begin calls are printed and the ones set by
dir_iterator_advance are ignored. However, this commit provides the
required support that future tests need to improve test coverage.

Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
---
 t/helper/test-dir-iterator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
index 81e931673e..cdb9269ad5 100644
--- a/t/helper/test-dir-iterator.c
+++ b/t/helper/test-dir-iterator.c
@@ -9,6 +9,8 @@ static const char *error_name(int error_number)
 	switch (error_number) {
 	case ENOENT: return "ENOENT";
 	case ENOTDIR: return "ENOTDIR";
+	case EACCES: return "EACCES";
+	case ELOOP: return "ELOOP";
 	default: return "ESOMETHINGELSE";
 	}
 }
-- 
2.36.1

