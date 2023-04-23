Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E846C77B73
	for <git@archiver.kernel.org>; Sun, 23 Apr 2023 12:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjDWM2D (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Apr 2023 08:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjDWM2C (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2023 08:28:02 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8759B107
        for <git@vger.kernel.org>; Sun, 23 Apr 2023 05:28:01 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3ef5b5d322dso26600351cf.2
        for <git@vger.kernel.org>; Sun, 23 Apr 2023 05:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682252880; x=1684844880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yHeYGczb4rBs1JZBwvlvsD9UjId/emMzr0p+bvDyDiE=;
        b=Wkxgkvkw8dbcOmHqD5QV45GpmL0BqIoj+RDaHfmNivzX4+9hkeabLkQWVJLYMyr23F
         50g9mWFg7YlCiXioUtBW6IgP+d5CfBqH4kHZlWyYyUjPgXMSoXEvVGr8GLpeYoppzYE7
         aATT3l38gosXfw+NJvNEEiqN970p/WACFV4fjpfDvZYXr9s3Phcohib3Xtrfj9cvS3ho
         xXDQKWrAVta/SDZt2FfEZPlnmynMXtERLKzBotN8TphMdJc326d+XYfwQqgFp3O7G7+z
         ZKxGy5uh8NxDBhnLP6x2E0eHDvaZYGL0IwHekHF4F49ATS7vZS3zdveDgdADj4jLZFB2
         Iq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682252880; x=1684844880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHeYGczb4rBs1JZBwvlvsD9UjId/emMzr0p+bvDyDiE=;
        b=Wza4Ee8WrnDl/WppveLUSFl1maZpJlqagoz09LKXQYUaif1Mc+4RK0QP/eQEQkbUVW
         TLx7yo6BspxxduIj/CcDE42vtfM3+mGXlOD43b174M1AKlGx+gGeoEwzFx9A+gyLZEQ/
         W8Lg+r+fpL76OlyEbsuCPnny43aQ92bG1UsSB0XJXxQfE09qULPhuWT1fFCaDJsiWAH1
         8Te73IrQ8NhzKiXSPALmVHF16JLAHuDknuNUO3TGGThXx1Dx99nyD8/X3ubsLRVDlig8
         SVd4c/uUrPm8OFJ9NMvfTcXchXUTFN86dQdDyNHVxJKWyfP3dwyGVZJeyZ3ZtCrHmVu5
         eV3A==
X-Gm-Message-State: AAQBX9dUV55ZCsg2lEKi5d0/eYhbY5BqJuQJAXfYx+TqH4Yv4T9KzVKM
        HaTBb7tqq45orpHn0fLtk6wuFa4PLzs=
X-Google-Smtp-Source: AKy350ZpntLjcCq5hWR5Wi+mwWYugkIdZATYXScrS+XbsGfr72fxWScroo4nH0l720F1dGX5AcgCDA==
X-Received: by 2002:ac8:598a:0:b0:3eb:1512:91c5 with SMTP id e10-20020ac8598a000000b003eb151291c5mr19692883qte.12.1682252880399;
        Sun, 23 Apr 2023 05:28:00 -0700 (PDT)
Received: from localhost.localdomain (dsl-141-20.b2b2c.ca. [66.158.141.20])
        by smtp.gmail.com with ESMTPSA id b10-20020a05622a020a00b003e65228ef54sm2827654qtx.86.2023.04.23.05.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 05:27:59 -0700 (PDT)
From:   Maxim Cournoyer <maxim.cournoyer@gmail.com>
To:     git@vger.kernel.org
Cc:     Maxim Cournoyer <maxim.cournoyer@gmail.com>
Subject: [PATCH 0/2] send-email: add --header-cmd option
Date:   Sun, 23 Apr 2023 08:27:42 -0400
Message-Id: <20230423122744.4865-1-maxim.cournoyer@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This adds a new --header-cmd option to the send-email command, joining
in the ranks of '--cc-cmd' and '--to-cmd'.  The header-cmd script
provided as argument should output 'header: value' lines, such as:

  X-Debbugs-Cc: someone@example.com
  AnotherHeader: somevalue
  [...]

This change was motivated by the use case of easing collaboration
using Debbugs in GNU Guix [0].

[0]  https://issues.guix.gnu.org/58813

Thanks,

Maxim Cournoyer (2):
  send-email: extract execute_cmd from recipients_cmd
  send-email: add --header-cmd option

 Documentation/config/sendemail.txt |  1 +
 Documentation/git-send-email.txt   |  5 ++++
 git-send-email.perl                | 38 +++++++++++++++++++++++-------
 t/t9001-send-email.sh              | 21 +++++++++++++++--
 4 files changed, 54 insertions(+), 11 deletions(-)


base-commit: 7580f92ffa970b9484ac214f7b53cec5e26ca4bc
-- 
2.39.2

