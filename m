Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96574E7542B
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 17:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjJCRtR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 13:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjJCRtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 13:49:16 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5AAA6
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 10:49:13 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id 4fb4d7f45d1cf-532c81b9adbso2039079a12.1
        for <git@vger.kernel.org>; Tue, 03 Oct 2023 10:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696355351; x=1696960151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BRc8mOG58JOAWdpGRH8x7VNe59eXxeaQtxJvw9BV7Lc=;
        b=KvXETGEuUz18pIRSfo1skT6ESatSngRq0pPmxY26O+2T0QoYQZCnNUQBXbQN5+Uy/5
         5NKpasPpeAJn+Ae0vB/WheD25o35tdjhDkxKI847AXVPK8JcJl4INC1LiMoWS9Q//aRp
         lnPLZO643ytHSyBkccUN9fwvtSPvO8po3T5zT33YhLspS7s5KLBy1HbHelOLprhRNR7y
         iKnw1wNKiZNuC02hS89pzzPnkm/EjBJPt4S8pka/tfoB1r0uzWeM+o4oOf0XOX9e1Wow
         HGL9KSTknZJY5Hwzwm6BtB978XlBIUEY3DCqCmb3AAgsbVynVo6Lwv/lYHeVgEua7knB
         UxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696355351; x=1696960151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BRc8mOG58JOAWdpGRH8x7VNe59eXxeaQtxJvw9BV7Lc=;
        b=kBOi3KoaDy1ydiF/a62anz+atQGplAuOC7JC4oNPKREVv+u0/pSGcy8cc/B3Eib+90
         9m3DZsyWlhvBA1mL1gV6UHH1fl9Need8r2fqbH+qxqpSZx6lDBe5AR9zvs0w9h/IU1pe
         58Gb+3v4pFtnlAhrE0uGG8iVnOo9+tiU0SZqcH0PwoypDFLDlEiOFJnNaQFS9bQa1lMn
         dqxMD5cyuEpLC+hIIrrvaNzwO/Iz4Jr0S6Q2xirKNgKl17DXZxm8V1gkopoQXxgKtpAX
         ZCsvcdYHrTTKhF09dM9l2bLJ9SD8z5r4rEKZjpzzq8rVlYtYR2PI3deTsCuNnYygWEwq
         TpaQ==
X-Gm-Message-State: AOJu0YyCsOGrJJa/MMFvzols7yvO/8OMya1wpEnumH2uGje7EH0gj3oN
        MW3JQCZE9LSYojUz0L64nZXpkPi9F3P1KAiSOIYpTYfX
X-Google-Smtp-Source: AGHT+IEG3vF0aa99N3wxYYhZayK/bBdf4rLZHv43egbq79FSbavEnSTxAcBY7JOM6xd+ILdwSu5InA==
X-Received: by 2002:a05:6402:2684:b0:536:aa79:a70d with SMTP id w4-20020a056402268400b00536aa79a70dmr16505511edd.0.1696355351087;
        Tue, 03 Oct 2023 10:49:11 -0700 (PDT)
Received: from localhost.localdomain ([129.0.78.163])
        by smtp.gmail.com with ESMTPSA id bf26-20020a0564021a5a00b00536e03f62bcsm1186604edb.59.2023.10.03.10.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 10:49:10 -0700 (PDT)
From:   ach.lumap@gmail.com
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, achluma <achluma@gmail.com>
Subject: [PATCH 0/1] *** Avoid using Pipes ***
Date:   Tue,  3 Oct 2023 18:48:52 +0100
Message-ID: <20231003174853.1732-1-ach.lumap@gmail.com>
X-Mailer: git-send-email 2.41.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: achluma <achluma@gmail.com>

*** BLURB HERE ***

achluma (1):
  t2400: avoid using pipes

 t/t2400-worktree-add.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)


base-commit: d0e8084c65cbf949038ae4cc344ac2c2efd77415
-- 
2.41.0.windows.1

