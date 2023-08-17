Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A9FC678DC
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 21:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355450AbjHQVyQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 17:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355445AbjHQVyG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 17:54:06 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC091FF3
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 14:54:05 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-565aee93236so425350a12.1
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 14:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692309245; x=1692914045;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4930nbO6VWG0yGQMdAtLvc3FVglrrCjyolX5YRPobN0=;
        b=zsh+zDw961CKaVZu+oW8s7WK4Yi6ottDqZvBjN6Vr7pJMmAt0+IZzW32WwqgW/QUGQ
         jM9OqfIaJlwVkhNiaA4M5WWo+LpiYRRmHujf2X8PA8g02pUmGR960j9a+DupWMKFKmyY
         ZKCUDCrSAbU1g9Ff5h6QGVJMw1fHvyES1zyALh7yJLMsO2P9K9YKEXt/cUWahaKEGYn3
         usXNiCD13BMPwmdxPfX+Id6kU9CJKYP/z2UHtukwItbgbssyjT89BB8kOhoIc7Eji9Cp
         MUuR9ZzsOrtP9lgV48bRc3/bfboJu9cU2+qcdSGmdXNATHvcnAlIoogZCtbcr5v40Toz
         lVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692309245; x=1692914045;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4930nbO6VWG0yGQMdAtLvc3FVglrrCjyolX5YRPobN0=;
        b=fnQ0pdTk+emsidyYY4mRS/vJtsazelLYOWIxK2jV5EaSK+B/PBBPnvdkuUsm1BWpMS
         vhD0QbAgw2gw/ywgP9SbIV7IIvEPfWqwbBzdLrJvvrsfw5VM98FPlW2R0oGQCz20A5Et
         Q/ftjGCMWIVVq7ww/hM6kc7/S/mOCSTnOFkX2eKm/8Jv6tgSxLfLJgsSdG5Nh0r8Lat+
         4hkxDDBAVkfBxRL8Ke/puEyl6Cw9aZqzkoTjf7DJh0PxqwFu0J9QZI5fOPazMUkkJLmd
         T+GMRBMgkkrsDq78KzWzGZkNCkjqBdnpfEKvCWfRGr+Eths+npyEtvdRQcQl3S09MStQ
         5Oww==
X-Gm-Message-State: AOJu0YzVi3XfaKS/gJqNNfA70PeuxX2q5RfUbBFNQCfF6nK7gsF6w7wv
        PWbixLMB8Jq92YjXSxpyMKsVmGqhHSPk0eDCl1IDqaX8HmKagMqCH4ec2OgB+0bskO/na4y030u
        wyoDrA6NgBPGTmO4EkmObj6AA41wbbQbq01A6QqiHEyXuQSP9hgLwwnO8i0XbXQB5opRmvlh0S3
        PGbLE=
X-Google-Smtp-Source: AGHT+IHBmLmpyKD/bMRbnMirR0jKSiY1SXdDJU7Yozy0Z6R8FpDnje07GKeDpb8Xx+RCIjtFPPEvUuLxM5v45oj24seRAw==
X-Received: from taylorsantiago.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5c64])
 (user=taylorsantiago job=sendgmr) by 2002:a63:3c15:0:b0:542:904c:41ed with
 SMTP id j21-20020a633c15000000b00542904c41edmr92142pga.10.1692309245347; Thu,
 17 Aug 2023 14:54:05 -0700 (PDT)
Date:   Thu, 17 Aug 2023 14:53:24 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.1.gb06b9712e4
Message-ID: <20230817215325.2550998-1-taylorsantiago@google.com>
Subject: [PATCH 0/1] Fix the order of consuming unpackLimit config settings.
From:   Taylor Santiago <taylorsantiago@google.com>
To:     git@vger.kernel.org
Cc:     Taylor Santiago <taylorsantiago@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation for fetch.unpackLimit states that fetch.unpackLimit
should be treated as higher priority than transfer.unpackLimit, but the
intended order is currently inverted.

Taylor Santiago (1):
  Fix the order of consuming unpackLimit config settings.

 fetch-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


base-commit: f1ed9d7dc0e49dc1a044941d821c9d2342313c26
-- 
2.41.0.694.ge786442a9b-goog

