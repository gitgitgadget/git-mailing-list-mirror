Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD93C77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 18:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbjDYSvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 14:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbjDYSvb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 14:51:31 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E68817DE2
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:50:55 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-5f95cedb135so26885666d6.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682448620; x=1685040620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9h+zZkIHoOAuNC3q3ZqZOhdMx2x2r+m31bayPiY9bKI=;
        b=eAMRR+JV0TdUe//pvUVwOVzkqWJegbLNFbmjw2X+AacVqz+PHM/WisBvj8i166bHBU
         RIoPi7o3//RQO2X1xgC+kZE0VwrtVZFdMT5TACU2DHjESMhUWfjKh8EdTJ+gz/P3P+qg
         WmK/EIfuX7sKTzE5AYZKyCBYPKCTIdazyqScKJ+nLFt/pcmKt3HsuumFkOxiAkDQ3AKq
         LHPapfZs3sUdXH01ym0wHf3fstXF/WC+uzAqyY/LGLEB0GE6fKSmdWU3THp6BViyVoVJ
         YKQB9ADKMHrRcELqsPi0zTjyyTgSvSY7LgS8p0przDO/vc3GrGGM6syIv0XElc8ub3Wi
         ai7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682448620; x=1685040620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9h+zZkIHoOAuNC3q3ZqZOhdMx2x2r+m31bayPiY9bKI=;
        b=PtDVD4Zmp7mMhpQYbJOEgMy/X2XIlbDXYfIT6wrNyxwuy7Q+Ep1jOQ3tWJIf0+U29B
         jgFiHO3BapsUDzIRhlq68bnv7uea8GYmN2nDXRTasH1LiomJoGggR4xt3abXL376/7o9
         74dE1nKAuLfAgluFauHt9shqM/lZq+HZxTvlcu2MTfsl22D+7H1LJ9dI+uaq4esRPCDn
         kYuBBkCxAjwTUwIGYUJ4k6Zf+m1tYrEI+VuHBbAf0bHQ48Sl40qp622/BAiXKeleG5jp
         DhFDNRnKT8A+Rr3hkL302njinjJWtDP+xWLYAazhuX8zRr/ouRxLU/tfE5s2bG93r+Bs
         vKrQ==
X-Gm-Message-State: AAQBX9erWR9ttgwqRQEPZ0shytxs4z+/4ckVCFxmeMcwRSv2Zaou91l4
        wE7foKvOrhXix0yhzvhU2Ro/13ig3+M=
X-Google-Smtp-Source: AKy350aBSjp3zL4+u87Q4s36B/h2wbCO9XljJ8QPy2WjN/ApqU+XXrnIURMgtFuXaKVbt/FoSQrlNg==
X-Received: by 2002:a05:6214:230f:b0:5a1:6212:93be with SMTP id gc15-20020a056214230f00b005a1621293bemr32801554qvb.29.1682448619756;
        Tue, 25 Apr 2023 11:50:19 -0700 (PDT)
Received: from localhost.localdomain ([2607:fad8:4:3::1003])
        by smtp.gmail.com with ESMTPSA id h11-20020a0cf44b000000b005fd79831ac7sm4050080qvm.84.2023.04.25.11.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 11:50:19 -0700 (PDT)
From:   Maxim Cournoyer <maxim.cournoyer@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Maxim Cournoyer <maxim.cournoyer@gmail.com>
Subject: [PATCH v3 0/3] send-email: add --header-cmd option
Date:   Tue, 25 Apr 2023 14:50:10 -0400
Message-Id: <20230425185013.14351-1-maxim.cournoyer@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <xmqqcz3s3oz7.fsf@gitster.g>
References: <xmqqcz3s3oz7.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

This third revision adds some input validation, to detect invalid
output coming from user scripts used with 'git send-email'.  It also
adds a test to ensure multiline (folded) headers are correctly
supported.

Thanks,

Maxim Cournoyer (3):
  send-email: extract execute_cmd from recipients_cmd
  send-email: add --header-cmd option
  send-email: detect empty blank lines in command output

 Documentation/config/sendemail.txt |  1 +
 Documentation/git-send-email.txt   |  8 +++
 git-send-email.perl                | 82 +++++++++++++++++++++++-------
 t/t9001-send-email.sh              | 56 +++++++++++++++++++-
 4 files changed, 128 insertions(+), 19 deletions(-)


base-commit: 7580f92ffa970b9484ac214f7b53cec5e26ca4bc
-- 
2.39.2

