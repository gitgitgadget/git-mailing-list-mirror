Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1ECC64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 06:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjCIGkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 01:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCIGkT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 01:40:19 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359684FAB6
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 22:40:09 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id c3so990359qtc.8
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 22:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678344008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqEjiF2UkoW6csbCl6ZH07qTkg8s+CuVt8Y60PgqhNY=;
        b=aiFKsNxm2izD7TLYC8+/5wRfWKNIFvkVF7eT1wwebohkvH2YT/p9lkB2hduVXLuZHn
         hYniNPlWyC5sIA0Ufupv9XJcnypIFj6dpMevgsvZhpuftYDiFODJPXQPeLDHRMoNwCvN
         bNi2voiHd5jJJjk+8CnIYBSV9HkxKWVVEZnON6JmhxroXDQV7NZKdQcS+B+oB0/fU+uw
         3VHj1yefxzyQBFNPnZYQrgczC1uQwo17Vwgq3ubAEjdmk0XN+uJSPdGqfvDKkHV8dKyp
         d+NGgG0wuXB3QWDgg8lpa+jMm4igHP5gER+mTpFORi4tCaxQwdCEnfrLVNzgrmBxrWNQ
         lxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678344008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqEjiF2UkoW6csbCl6ZH07qTkg8s+CuVt8Y60PgqhNY=;
        b=WWT35hreK2b0KqhTRaB2hziWLANNkQwx3a90NZKL3DheTbKnZOuXimiVwd+M2aBtER
         WV/e4vas//Kz5/ewcmh0hm3Ri/bb3ikXH9ybJb+ddsruuUrLW1GUAPD03DR81Va6nYtZ
         czongZ/IOx6j8sIXtbIG/GTlG7YFFsJot2ADjf6GY2mQZyssycZKdXMBcWmCXY8sRXN9
         SXIq2zAWJmXFCBhDNMr55WVjVoZgh4d+oI5yswaCR0gS7UBGCyNGI0t0tyFONZz/VDGn
         jNwkBUTXVOmdRfe/k2cmspg9VyaNr7sBEXWwqT3Ru9ZmMfFBKhjq16katfuRSrSkst+Q
         xmYA==
X-Gm-Message-State: AO0yUKWcJxH5XPcseAWYRlkh0bfsEGSBS4WXMYMbRdr2K5/lS1aobHJz
        ouH4u3SuLbpsQM1/Iohbu23GU8HPJgQ=
X-Google-Smtp-Source: AK7set8aeC1U8arv6xk4jIWgVC1DlQyutiZ7dx2VcvyyagwLo3tMnNRSpOO3dl51lGUbfW5tVEiHNA==
X-Received: by 2002:ac8:5814:0:b0:3b8:6a92:c8d6 with SMTP id g20-20020ac85814000000b003b86a92c8d6mr35612250qtg.60.1678344007857;
        Wed, 08 Mar 2023 22:40:07 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id v25-20020ac873d9000000b003c033b23a9asm5834970qtp.12.2023.03.08.22.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 22:40:07 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, gitster@pobox.com,
        vdye@github.com, derrickstolee@github.com
Subject: [PATCH v4 0/2] diff-files: integrate with sparse index
Date:   Thu,  9 Mar 2023 01:39:50 -0500
Message-Id: <20230309063952.42362-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230309013314.119128-1-cheskaqiqi@gmail.com>
References: <20230309013314.119128-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v3:

1.Use 'test_must_be_empty' instead of '! test_file_not_empty'

2.remove useless 'test_file_not_empty sparse-checkout-out' 
in 'file present on-disk with modifications'

Shuqi Liang (2):
  t1092: add tests for `git diff-files`
  diff-files: integrate with sparse index

 builtin/diff-files.c                     |  4 ++
 t/perf/p2000-sparse-operations.sh        |  2 +
 t/t1092-sparse-checkout-compatibility.sh | 52 ++++++++++++++++++++++++
 3 files changed, 58 insertions(+)


base-commit: a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1
-- 
2.39.0

