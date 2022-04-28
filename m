Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5D7C433FE
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 11:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344894AbiD1LDO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 07:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345156AbiD1LCw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 07:02:52 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1602A2044
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 03:59:02 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id z126so3294695qkb.2
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 03:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QXhK6pB+9ra/lVfhlovTe8Ldmd4BEQdrMSiXcnfoiV4=;
        b=DALFXtdMEiQwufb9c/DCOCKxssN0Pyj629p45hN7i1xI6+jJLa1ubklfEgAktjbF94
         oKKzTC9EESu7Xb2pyc0tG7wJ3R3ojm8MyIV8tw43MfZ6tlQz2uEIbN26i1WlTpJ53tbN
         aaxhq1KseIqBpx2Sr+S3Jqdo3Eg/JS6EO/q/dEATH5GsryDfWHEoQarfTtL91K0CbAjL
         QzUCU9g+xHbf61FmCgnXejJegpFcoT5ye/VFCC8QdVd/NDAXMDhjQgyF9jH4fBGMgPE7
         J3XBRgCe1N8ym6O8ZnHb+JhGQXGKLKp7Y5yvbWNWpYmAMQ7cgY0g6H+jMAlPvbtrIegV
         RvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QXhK6pB+9ra/lVfhlovTe8Ldmd4BEQdrMSiXcnfoiV4=;
        b=E41GbCxfAPCrRYfCljU9eBhcM6smFnEbah6naPlhUjV/oBZhJJTrUegbP1RY+cKuj0
         QDl0X6EUcDWRnHXTXVWhkdWNBUBnUgV+jGPFXAmE+CUA1VeS1Q0nsP/jd4CRffF4oolo
         gBe52+6xLKM7mGxxp+zkER5pcLQSIz0eYcK7923kLcfR0FYM7q51TRIuja2uVXu+C+Ck
         UV3igS4qItmD5i2PXy686TkzwSiK4+yKSx0pp+5Ug3HLwGhYPU3aom7V2m8PPl4b3+0J
         qn/tTXN5xyEg3mCEvLy3mgcEXYMw67WlK32XclEuVaIDMq6uBsGB7Xj9TvYGQdKu7ysO
         Edqw==
X-Gm-Message-State: AOAM533H9NgNo7mOtWoIua5sO83nV0xKyqONwvnPEUpcV5Kfsf2mHasl
        7qpeXtq345pJjjgM6Qsk4eOT+uh18do=
X-Google-Smtp-Source: ABdhPJxSCD/ULyer7I6kEUtymel2Hm3uOKA8zwdIUgQZ/rVo2qjpE4KK4g1PS1VNxqjN1awycLNC0Q==
X-Received: by 2002:a05:620a:210e:b0:69f:9d3e:3ced with SMTP id l14-20020a05620a210e00b0069f9d3e3cedmr2450037qkl.536.1651143541857;
        Thu, 28 Apr 2022 03:59:01 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id v3-20020a05622a014300b002e1dcd4cfa9sm12950299qtw.64.2022.04.28.03.59.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Apr 2022 03:59:01 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 0/3] fix `sudo make install` regression in maint
Date:   Thu, 28 Apr 2022 03:58:49 -0700
Message-Id: <20220428105852.94449-1-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.352.g0cd7feaf86f
In-Reply-To: <20220428033544.68188-1-carenas@gmail.com>
References: <20220428033544.68188-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mainly documentation (both in the manual and commit messages) and
extended/cleaner tests with the following considerations :

 * able to run as root, and therefore removed reported issue with message
 * remove perl function for a sudo native alternative and a more reliable
   execution by making sure to avoid its PATH interceptions.
 * would likely need more changes to the test framework to avoid odities
   but the deficiencies are clearly visible until then, and so safe for
   backporting.

Carlo Marcelo Arenas Belón (3):
  git-compat-util: avoid failing dir ownership checks if running privileged
  Documentation: explain how safe.directory works when running under sudo
  t: add tests for safe.directory when running with sudo

 Documentation/config/safe.txt  |  9 ++++
 git-compat-util.h              | 40 +++++++++++++++-
 t/t0034-root-safe-directory.sh | 87 ++++++++++++++++++++++++++++++++++
 3 files changed, 135 insertions(+), 1 deletion(-)
 create mode 100755 t/t0034-root-safe-directory.sh

-- 
2.36.0.352.g0cd7feaf86f

