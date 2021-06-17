Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77A3C49361
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 11:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85C29613D6
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 11:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbhFQLYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 07:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbhFQLYC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 07:24:02 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208D0C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 04:21:53 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l1so9274824ejb.6
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 04:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mZYgRhNOb/H4ToGygoWOBO8xl93wU4so0dRXljdEm9c=;
        b=iBBgTG8QzMOlO045e0HrE1UjWNjHQ4ZTSuofpmCKs9hEWwNIlLMPTHSCLH7k5TmJ18
         JCINXONLGqkulQRnD7xBVj2maa1pUlp9L5BbRBGsCdChJZS+5RD4ObA7dikEohInPL47
         4/YMQQ+GJO09Bfbz992SFqATSPrkIqvoeJ4FXAelsCaNvkJr32bAxvSqX35aL9uVQiAr
         eBfEQIU5d47JKVGzkKzhH4K4kTKp6D1GDtnXVsD1j5BeLjigfiI+KUewTmmMFkpnmGl+
         sL60R6wvFX9JC+X6vzjl2fvNHrQgfmiOixX0kWMbg817gNkHDgeRU65pi933cqbBJjgw
         0A0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mZYgRhNOb/H4ToGygoWOBO8xl93wU4so0dRXljdEm9c=;
        b=jCwQYns8efiC+X0Secls/1IA9x3H9JbPtoweG/bVSRtNLQ4qhvV3d1y2xBOxutj/m5
         geMTpBJ1b0uJdB851irGInFbZ8q2HTzKPNNyEgCtbjjGGV+NUZiEb5VWOf+B/7/75lXf
         IHW6b3lvyE23lh/lBrgpxD3e3DpMEJrEmkrzOI0/KNRSWyvOCcN1wHAfCwETCQGIZNb+
         brhgr0oX2mict7DVBjgNBhV0tEWijcYNMCtlZHpuy0W+wvlvlGh9Zi3El0Pi42LebMd0
         WaeH4lHDve7dCileaPIvkgpgpUw/bTRMeciooz3q1ww1mfHrhjuoqai4zWBL3CM+9ftZ
         VLgg==
X-Gm-Message-State: AOAM530EMx18dP63GyO0LakqFkjgCEk7iHr9WnT2OZiRHaDwF4+KMd7r
        2ZAuqv2bpd5CSOPDXJ7tEmKWsyukvjSf+w==
X-Google-Smtp-Source: ABdhPJzgkElI+rDSFBU2wU1Tt6ycTqQmC4A4SSgMTXyQxhKqumU/VqRAm4w4koWlFIPHr+HNeMrbow==
X-Received: by 2002:a17:906:4b0a:: with SMTP id y10mr4789292eju.388.1623928911550;
        Thu, 17 Jun 2021 04:21:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id cw10sm3583153ejb.62.2021.06.17.04.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 04:21:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] bundle.c: remove "ref_list" in favor of string-list.c API
Date:   Thu, 17 Jun 2021 13:21:46 +0200
Message-Id: <cover-0.3-0000000000-20210617T111934Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.571.gdba276db2c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Converts the bundle.c code to use the string-list.c API, getting rid
of some duplication in the codebase, while doing that stop the bundle
command-line tool and its API from leaking memory in some common
cases.

Ævar Arnfjörð Bjarmason (3):
  bundle cmd: stop leaking memory from parse_options_cmd_bundle()
  bundle.c: use a temporary variable for OIDs and names
  bundle: remove "ref_list" in favor of string-list.c API

 builtin/bundle.c | 91 ++++++++++++++++++++++++++++++++----------------
 bundle.c         | 72 +++++++++++++++++++++-----------------
 bundle.h         | 20 +++++------
 transport.c      | 11 ++++--
 4 files changed, 119 insertions(+), 75 deletions(-)

-- 
2.32.0.571.gdba276db2c

