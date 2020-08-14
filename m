Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF70C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 18:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA68D20771
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 18:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cf2/fQIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgHNSH0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 14:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbgHNSHY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 14:07:24 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74048C061384
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 11:07:24 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 3so8654748wmi.1
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 11:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sP/+JweEgFHkxGuRGaOk+dTd7TR0KQm37A4hXQ1StOA=;
        b=Cf2/fQIGRTmAMDiZsZUnCajLD4bz4qkTlW32/qFfFMK8sJ2UmiHXEbG/Q3qC2yWOmt
         7A8xPP2G3+PsQHd+Pd9vydScBxhyrGquyVUTVsMKDHVpXNJAu6LVZCMYnMh1TqG4w9Xp
         VVpMqJVdmQKWj15a58Lif9RsR1xOvHfqQTi9JtuZbP9J77HL5Pocxp8DDAinB1OXf/Mb
         M3EtGcSED3NfGo0tfHQIMoKNY2P0hOo8NfuMAKo8L2rWgBOmaHgOJrGh6Y2nSy4VJCAU
         28I6ltQTBzfDFJS3ienZva4ms5bDFS7UuTzGq6POLqeiILhDkxoUBVyTbbrlO2OENtuT
         /q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sP/+JweEgFHkxGuRGaOk+dTd7TR0KQm37A4hXQ1StOA=;
        b=JrQq34WTIjJDKxBh1MfaqfqxoZdZVJKX4NwQhnlU0kRHlz6BuuuuIJVYmIPRRyyUrU
         9ZzBlmM6gxw3QhdhFB07ti5qfQorcICeqVPZF6eAzQS1G/R0JyCHW0kWd+/aAKM6NjGP
         23PcBBI/U4ehHN5LC58uRT+NDniCiaRZ4ivc5sY5GyKjIOCn2NV3RAY3BQYs+uhrdm6C
         aAqzX8pksGf/R87GQPgMkdW2zogNwhvEf9mmMGcFccTMzFdmkbHPY1ZgQvTd/nh8sIzw
         zPhzI28205VacUQTNn9ZOQ/t8zZ6UZsVsSVCxckAkCvKvzo1dez4l7WYoKAPAkYbeVNr
         3DRg==
X-Gm-Message-State: AOAM531o+Y8zGYTrY4/HcsWVF+6So+yMjckh5cGSmvoUQD8ozq5Ey+4O
        NwGJBTjjy4LvOKu38ydKk4gsV8dtJOU=
X-Google-Smtp-Source: ABdhPJwEsmJj3D1D4D/uFAjysjT8ASyy1ORDE/IjLE35X7h/wAka21oAqDwW5FvBRq7zH+dEqGPL3A==
X-Received: by 2002:a1c:964b:: with SMTP id y72mr3584139wmd.69.1597428442890;
        Fri, 14 Aug 2020 11:07:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h5sm19210057wrc.97.2020.08.14.11.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 11:07:22 -0700 (PDT)
Message-Id: <242a44b63c8fc0ab7e8d8a6a913fde71444f931d.1597428440.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.703.git.1597428440.gitgitgadget@gmail.com>
References: <pull.703.git.1597428440.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Aug 2020 18:07:18 +0000
Subject: [PATCH 1/3] t/README: document GIT_TEST_DEFAULT_HASH
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     martin.agren@gmail.com, sandals@crustytoothpaste.net,
        me@ttaylorr.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/README | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/README b/t/README
index 70ec61cf88..ecf8c7291d 100644
--- a/t/README
+++ b/t/README
@@ -421,6 +421,9 @@ GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=<boolean>, when true (which is
 the default when running tests), errors out when an abbreviated option
 is used.
 
+GIT_TEST_DEFAULT_HASH=<sha1|sha256> specifies which hash algorithm to use
+in the test scripts.
+
 Naming Tests
 ------------
 
-- 
gitgitgadget

