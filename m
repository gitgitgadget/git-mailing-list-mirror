Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5004D1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 23:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751644AbcIGXvR (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 19:51:17 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36633 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbcIGXvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 19:51:16 -0400
Received: by mail-pf0-f179.google.com with SMTP id 128so11374251pfb.3
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 16:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kNv4ojKe8SGhb+8rlBWZtt0sLWvprLJFV5oW2dHNvlY=;
        b=VUmv16xwXXmQ6dGH16sD/Zs8Xow/eMSJn9jzSj/x1GNs1jSJKWbnf+g47n4mur/SIZ
         qgRCp29nwU52upOMhpjREJn9zs8XmJRfQMzhT6hKn5oiDbAXCIeTgmhomi5akGbVeqHD
         UyjmStraqpOmc9qQ1MPikGjnLGx/bt2cSPXEYSkl9w8K+r+jaQ99oPsF3UREeLOknXdr
         vBeFgFSvw8hTi7JD1mpGB6UMh95dQPag0rx7w9zS28qrfpFs+DndS+YNnV8jFoNOQ8I+
         LCnRrf8d1dNn6fwXs6jj3fPeELYOq8iPYKnOzR+myibC0mr7zxLmPIrAEr3oTezq2DbD
         5kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kNv4ojKe8SGhb+8rlBWZtt0sLWvprLJFV5oW2dHNvlY=;
        b=jEDulglmXpedEWeeg/SVUck7dJMF/fUh9Y+Pi3ZnQ9mlIsTPSmwJCtVqXMiaHVf+Bl
         K4TmXhrqM2E5yJsPgP0Q5CMWOI3R413oy9wOHue7jEk+EqMC8UztANH/hSIXtIL2vLM5
         9Ny7PUIFAuJxYdWCF0OWlvaU7BIvhUSSdtcKi6xRqD/6Fmn8BjxFOaQlQFW/JFYgPx30
         v+fT5PDIMoMxLNiY2jB3Et+++wz9c7L2kYf8sP+xLQzw0lY5NzomfsUkHAUO9es0HHEg
         abQDqnbx1LmSFz8Bw/2VgvaNspI9cHe8m+jy1Nn/CKtXKa12JTfK5yfPrsQN3qkbA9rK
         KITw==
X-Gm-Message-State: AE9vXwM2Vh0/Iu74L0wBYJqlpQdIpnqWU/Y+SK+kHA6hcUHLVFtlXo25vaF5p4zgKbccia3E
X-Received: by 10.98.36.76 with SMTP id r73mr22988676pfj.27.1473292275665;
        Wed, 07 Sep 2016 16:51:15 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id 29sm13825669pfp.88.2016.09.07.16.51.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Sep 2016 16:51:14 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        spearce@spearce.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com
Subject: [PATCH v3 0/2] handle empty spec-compliant remote repos correctly
Date:   Wed,  7 Sep 2016 16:50:55 -0700
Message-Id: <cover.1473291819.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1472836026.git.jonathantanmy@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updated, taking into account review comments.

This patch set uses warnings (instead of errors using "die") to indicate
protocol errors that we can recover from. There is a discussion on a sibling
thread about whether such protocol errors should be errors ("die") instead - I
can change it if consensus is that these should be errors.

Jonathan Tan (2):
  tests: move test_lazy_prereq JGIT to test-lib.sh
  connect: advertized capability is not a ref

 connect.c               | 17 +++++++++++++++++
 t/t5310-pack-bitmaps.sh |  4 ----
 t/t5512-ls-remote.sh    | 40 ++++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh           |  4 ++++
 4 files changed, 61 insertions(+), 4 deletions(-)

-- 
2.8.0.rc3.226.g39d4020

