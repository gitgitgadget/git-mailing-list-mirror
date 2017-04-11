Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25CE620970
	for <e@80x24.org>; Tue, 11 Apr 2017 20:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753001AbdDKUWd (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 16:22:33 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36850 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751900AbdDKUWc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 16:22:32 -0400
Received: by mail-lf0-f66.google.com with SMTP id 75so1001292lfs.3
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 13:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l8JNMuvuhT2FbEs5lIGtM1bpJmINMydvbeD4oKUXaPc=;
        b=i4Z1HTcvDKzXUAjYUA8qaLD/O1ylTAk3WQVvIPXON2pmMlRU+ZCpr0ym7BX/RowK2p
         FOV5iR+CY5uFJa9kkuIk9LAENu15OZkLZiqq6IcG+3XmR/3C7P+mn1Rj7GVK3g1TxcXz
         5dAQZsIdrPaZv1j8Vkuta8fxG5eii72gEBl28mUmicktqQvQlCgrUJ4FMoiEJu9+ukkM
         B8UGH9WdtU9L6lH78v+QmjsLbgzPUBMakP6mHNU0+Pw7oQkAL7j+I8jXGDKurWLk/vZC
         OZcN+E7NtTQJa4DqFTetAPbZRLblGRxxsibtjqJhHpqr8gG7RIIP9FStsWjl5Z2kaMjk
         SUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l8JNMuvuhT2FbEs5lIGtM1bpJmINMydvbeD4oKUXaPc=;
        b=rpDIbIzEHzTxeWmPwhgpyVPPBil1iOooQkgt13NAV35GqYAE8cMweqw/94cnh7adaU
         yhPouHCy4KtD1JEv/0NIfePUC3YGO6C7DogrN+/j3l8IlnYfKIBnNUAM1wp2SAX4LTaL
         8AIn6iwuyNnHKCCXZOj6d2CqLDORCQKd0ApEetGaXBN/I9BRKDZI0T3jH66m+GiFhUpP
         0WHK8YA6nHu8ISYtpsgajQLxZ+/y2b9MICDqs8wVYjvX8fFaKPLVr7pe6uNnESEb2CDS
         CtZjXcNW/CiqOU3dLWPg7JQ4b/Xw4pbefULAZqgzYvlqoh0Gx1+kYCd2gt4QhBPgLF9a
         /xfQ==
X-Gm-Message-State: AN3rC/4RHUZb/iAdIcxqbgG+Ldo0vtpNdcqEdtyIvBnOsNhJLPraXxO2R+1yNmWFXQ2wFg==
X-Received: by 10.25.100.5 with SMTP id y5mr321241lfb.58.1491942150766;
        Tue, 11 Apr 2017 13:22:30 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by smtp.gmail.com with ESMTPSA id w78sm3681421lfi.23.2017.04.11.13.22.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 13:22:29 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Knut Franke <k.franke@science-computing.de>,
        git@vger.kernel.org
Subject: [PATCH v4 0/2] http: few fixes for the proxy configuration handling
Date:   Tue, 11 Apr 2017 23:22:17 +0300
Message-Id: <20170411202219.20165-1-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

this is few patches, which fixes regressions in the proxy handling.

Both patches are based on the maint branch.

Changes since v3:
 - fix grammar (thanks to Jeff)

Changes since v2:
 - fix grammar (thanks to Ævar)
 - add new patch which fixes the silent ignoring of proxy missconfiguration

Sergey Ryazanov (2):
  http: honor empty http.proxy option to bypass proxy
  http: fix the silent ignoring of proxy misconfiguraion

 http.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

-- 
2.10.2

