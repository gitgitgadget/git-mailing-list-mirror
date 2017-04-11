Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D19C20970
	for <e@80x24.org>; Tue, 11 Apr 2017 17:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752697AbdDKRSB (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 13:18:01 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35796 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752256AbdDKRR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 13:17:59 -0400
Received: by mail-lf0-f65.google.com with SMTP id i3so379400lfh.2
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/0mKjOc/eiXr2IwBbRv1yhQULH+h7ZpAbLBneZTrhok=;
        b=BWWn6LmS89p6qFdq/n8gAWkVBO35q2n3ilgcQ6wyrE0YoHXESONu/TQ77UdJFXWDfi
         Fr0k/hFk8YC9ySIJDqElQS+CN7FMUdJtLCYZSRZpX/lr5SntlH8uURy/dcAFS+4D+8V0
         Mq++KhJyYGozcVlSPVH+iobmEHE7qR60LKsJezuTzAIkA0CEzb/83JN1ixy7I6rR0hyh
         wKxgC6dNZA9x70Los1XkNVm2fa/ghCsSSZxo/30h1QuC2UwUzA4CZINCSI6nq4xzbevi
         OckqLWe28vocGLKfz8krlha69eP9Lf0x6PWolEgGlaVcJz6sMZHe2lh15VyBGFNbEEDU
         5u2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/0mKjOc/eiXr2IwBbRv1yhQULH+h7ZpAbLBneZTrhok=;
        b=N0h63j6L8hdXGAjGnmT0yLGpi1zy6PuKr8o5HNcunI+MNoe4JEnNZoqqZDNEcGPcO1
         holaJD9Tcg5waR1/bOrko8q0xICJS9Gx571ZUeRp6yGN4HXA4XO0yhJl+hESjNLFMZ9/
         AN2J24VSvEr3Jwe4R7zUMix6lMEWhxaV/cpQbJGSqFq+Bzo5YE+eSPv/ryRbK6G6up59
         vZBy2GHMFJcO59m+LTO++z/45yzoFsdPtdhwsZmdbChaL4ZWuwkIlPK/MP+p9rI/po+s
         RNWkQwUgCRpp1tElvWjegdlMwpMIaE7wmZd2crphIBSBnWMlqZKIAZzwrZFdzr0BEXVe
         N0lg==
X-Gm-Message-State: AFeK/H2C+a8667a0J2O0UDrtNcQFnsnC8BS1TOU22P3/u4+/W0UeCGhXSY+xr2jXkOT67A==
X-Received: by 10.25.141.73 with SMTP id p70mr21242896lfd.147.1491931077898;
        Tue, 11 Apr 2017 10:17:57 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by smtp.gmail.com with ESMTPSA id l70sm1009083lfl.69.2017.04.11.10.17.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 10:17:57 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Knut Franke <k.franke@science-computing.de>
Subject: [PATCH v3 0/2] http: few fixes for the proxy configuration handling
Date:   Tue, 11 Apr 2017 20:17:48 +0300
Message-Id: <20170411171750.18624-1-ryazanov.s.a@gmail.com>
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

