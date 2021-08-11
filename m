Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118C3C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 09:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3B5D60FC3
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 09:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236397AbhHKJHz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 05:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbhHKJHy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 05:07:54 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833D7C061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 02:07:29 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d17so1785205plr.12
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 02:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w5fiXvq8v48ytlm+ewoKx6S++0bZnX0hFWDTGjDFHp4=;
        b=VBJjrjG3CmW67jOOavXcveEziMKpHw8q9CkmAC6trexi0/d1pM2oTQ9sAvhtdpg0t2
         5JkUejpThiQdqA6SlKQgvpQ+cEWjaGl7XWWp4jj9CriJN1/fADk+gBQKx/aihjGaNAiC
         et4NUWTWPuleeDY458revF02ydvRiEaUdSPipLB2zdQOXjX/mN3vOLrZHNYarNsi/zfh
         /ZHvgwTP9BzNI/RNUklb3lJ/pRRcodjT2x0E0oKi8o3KJm9Fl3cpXdGOT+Iv1pCP4f2K
         1GBl3ZpmwA5sRE86hurja+WVURZA+wVjRdjBZcOM50yo5HLYIIWecPUuUkw8cjiZMtHt
         Nx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w5fiXvq8v48ytlm+ewoKx6S++0bZnX0hFWDTGjDFHp4=;
        b=mld7JzsEE6zstjopLWVojWGg1I1wq2v/WEAnkvl69uzbohsyGMMdwfMm7ffSdX66Nk
         allz3RWnx7kuLhT3DlNeO2a12EKyPCSVaz+PeDyUY0xF0bKtw3BT+zvwxhCYEPgaO8tp
         AEMPMgsSkzzZAtP1L+ROX4S10iKy1v1b4ykVYRGzyz5yju2kWHZr83XtV7Ntljo21pqr
         tMmW+oVpEe7lAvBu1cAJGdATDeFj3v+2G1owPnfbC7TvP1MeRB36F6M8nRqig4T+Fp7y
         WgiiSDh5AEq+q0V24RsK5sdSGy1K7kNhCi6zCwmRFhx+6/pD8d9U6aoHA+/bX/+MwbgM
         IHVQ==
X-Gm-Message-State: AOAM533Qjm5yeoNT5N/vzp0clCdLVTxhF2+dNGAmwrLXaP3tcg05Rfem
        oWBb1YnR8H7IrbAbdtNRghI=
X-Google-Smtp-Source: ABdhPJw6Ku7l9iHL8Qv5htWhTtyYzCrKfDFN0wwmoREvs22bls2L4uf+k8WutGK1bhSgn5z3fI5Y+Q==
X-Received: by 2002:a17:90a:2e04:: with SMTP id q4mr9548166pjd.204.1628672849107;
        Wed, 11 Aug 2021 02:07:29 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.155])
        by smtp.gmail.com with ESMTPSA id 8sm16245270pfo.153.2021.08.11.02.07.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Aug 2021 02:07:28 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     git@vger.kernel.org
Subject: [PATCH v1 0/1] traverse_trees_and_blobs: rename and tree-wide
Date:   Wed, 11 Aug 2021 17:07:13 +0800
Message-Id: <cover.1628670288.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.32.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long (1):
  list-objects.c: traverse_trees_and_blobs: rename and tree-wide

 list-objects.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.32.0.dirty

