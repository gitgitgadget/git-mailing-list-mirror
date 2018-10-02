Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C62891F453
	for <e@80x24.org>; Tue,  2 Oct 2018 22:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbeJCEpk (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 00:45:40 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:43134 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbeJCEpk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 00:45:40 -0400
Received: by mail-pl1-f201.google.com with SMTP id b95-v6so4093873plb.10
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 15:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UBMHUL7+C1wjGEvXPE99G/GxvCAVMtnoJsWPA9VQbeA=;
        b=IbVas+79jDpY+6ArrWeA3GMTgOD2OQQDIdZIjo5WwkeFHon7OlHxtFOsPMz30wP+DZ
         6/s4YHSKsnn1ztRVyqMGwts1Sz/qtWeorKzkYqSGo+OLu4iM0e/GUMPi7kjKeMUmeboO
         tYIHR++0rC9jdb963dCBBdb5s+Wl2qeaR4aJLxIdEDCLWXvljlPBr1Ls45Am/QwTCZ3U
         SsgiopEMSV5TzRlWul15ZMXgkMje0sK47WFICTJmpCJAQWTg6F6H+A2GfmDbCugnV0OM
         R1CnVAdkTHAUtOl27MMofefX/RYinjPnHIkiLLtuItnELUS/3w1LWc0piwKvjhAOLQSo
         kGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UBMHUL7+C1wjGEvXPE99G/GxvCAVMtnoJsWPA9VQbeA=;
        b=ItTRDdBMn1BIyulmcgoxa72z8Zum/wAdH5JInw7DCfSk/9fWpwWpvlWeC2derAUgtB
         owJ6Hz7jSDeb+wPR8pzzlCRXdsOL7XSu9XwsoAGs3P/jewKpl+4LnhF+8gjQrqMjTVKD
         uwhRQWcYoqkxxMoGhgfLzX4zCfpia0Jd4zN7j99p3pw5zliKk7UYvVNIQmo2ve75upWx
         yVqBDiSKLEBjehw6Hr+vtgZcs98KSKwUaBsg6F76XlYWLYZsDq2Rdl8JpaIwVNkT5+oH
         TYWdFeTDGrpJP5zdLY+dB8PDkpeQKNdksyUqImhbLvydB+qpLmabDNqdj+iggOmViUOf
         l/Lw==
X-Gm-Message-State: ABuFfogkxiu9X4fuipGmVhavZLUH1A4u3YHB9X8VBvU6zH9F8ucPWDGQ
        sFVG657T+rc+ZQHO/Vzi63AlakCXebcsGieIOQuvlbUuWVkmj8iefU+wJ7Xxb7qpRBwph47ksCP
        8VvGIlWzd2E8QK3EcmBT1I5ulrfuMS7ABh7b7dKn3RMnjMipCL3wFqdkETt0x9sM=
X-Google-Smtp-Source: ACcGV61uZzaCfNdD3P9q1K3MexBBJ11lyXkHaM8g/Oc16NQs2hEFtRuzmACVMmaZOMjFYcG5XXBnGN3vFtaoPg==
X-Received: by 2002:a65:5048:: with SMTP id k8-v6mr7404190pgo.17.1538517610760;
 Tue, 02 Oct 2018 15:00:10 -0700 (PDT)
Date:   Tue,  2 Oct 2018 14:59:50 -0700
Message-Id: <cover.1538516853.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH 0/1] Limit client version advertisements
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, gitster@pobox.com,
        steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As discussed in [1], clients will incorrectly advertise support for
protocol version 2 even when the service in question does not have a v2
implementation. This patch sets maximum protocol versions for
git-receive-pack, git-upload-archive, and git-upload-pack.

[1]: https://public-inbox.org/git/20180927012455.234876-1-steadmon@google.com/

Josh Steadmon (1):
  protocol: limit max protocol version per service

 connect.c     | 11 ++++-------
 protocol.c    | 13 +++++++++++++
 protocol.h    |  7 +++++++
 remote-curl.c | 11 ++++-------
 4 files changed, 28 insertions(+), 14 deletions(-)

-- 
2.19.0.605.g01d371f741-goog

