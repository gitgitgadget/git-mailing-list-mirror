Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7C4C11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 16:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04A7361463
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 16:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhF3Qkq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 12:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhF3Qkp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 12:40:45 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9867AC061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 09:38:15 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id f14so4055327wrs.6
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 09:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iptwFlrab+tAkA0sMgUMvRsdEDYrJlDnkBX2ITFo2Y8=;
        b=uk/WnPFiqQ6s4PQ2flNgFWJdtNXFffZHB/T9es9wgRT8uzg7MBU0dDeKqJdss14PdL
         s2VDPc2CGDNsQ8OgdXM87gRq7hIa0af8sDbdLTc9e5pnRYY/Ib0pDrV6gf1+ebteU8zY
         LWHR9KwTDdOPyw7xeXWp52KKddi1doe1oPnls4gDORZN2tIuC9Zpzeaq/kKgfbHWahkR
         FPGeXYJ04iQidqxvolQ0XvhH98P50TgDY+uUZEgZo4jcHIhPgyBQpPUB3tTpTDCo2Eot
         uUJxfrcUjzvXGvhi+wCvTZx9Qdctk1fgV9DE0bPP1JBanc/9Mq59gyx4YqQIvEpMM5LB
         0wIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iptwFlrab+tAkA0sMgUMvRsdEDYrJlDnkBX2ITFo2Y8=;
        b=uYS7sbzTQoD3enB66qnrlupgcNnLhlLHCMnapxqVKIiFrsArL/T3JxCz0eZi0eaX7s
         afRw5jODHw0Z4RnG3yIvl042bm3yJzIk+hx2mFNN5V5fVNG1kxK0NCI2r2KEjEZjpOAj
         snOMpbNILftS3sgT/Y0rGeNIkrl0ABiZjFchs4yr0gG8tgIMZbVhIcaUptz7PqwdlGck
         6x2FKz6UJzs8q8sTFLKRtHzxOhw7ce/puw8rt6A7pfDbz9WjYEMgjg6cv6o5+XrwflvU
         Cxy8W56XHg7ZUst/5BrB38p7NHFH3Qwo4188udLRhrbuuLHjfrn/7QrYa8KhtVWq9kxS
         ukRA==
X-Gm-Message-State: AOAM531ED69s/0bV5UbH5v6jo2AiGXckAMXhKhQ5fTFhmtUWHHTz604k
        MHPqV38hCdty+zUeeRMFnjxtsp8vn8/QxQ==
X-Google-Smtp-Source: ABdhPJzz4x2FIveDLsiRhtZ9OnB7cCr3rWba4SnwrvRgphIiB7sCnPqdWYxP3ftYE13cstvBahHkeQ==
X-Received: by 2002:a05:6000:1a8e:: with SMTP id f14mr41103129wry.61.1625071093937;
        Wed, 30 Jun 2021 09:38:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l1sm1952066wme.11.2021.06.30.09.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 09:38:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] fetch: fix segfault, missing docs in --negotiate-only
Date:   Wed, 30 Jun 2021 18:38:09 +0200
Message-Id: <cover-0.3-00000000000-20210630T163329Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.619.g53a98c35da0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The recently added --negotiate-only option segfaults when not combined
with --negotiation-tip=*, this fixes that, and adds documentation for
it.

1/3 is a related fix to save us some work in a codepath checking the
"--negotiate-only" and other passed-in options in send-pack.c.

Ævar Arnfjörð Bjarmason (3):
  send-pack.c: move "no refs in common" abort earlier
  fetch: document the --negotiate-only option
  fetch: fix segfault in --negotiate-only without --negotiation-tip=*

 Documentation/config/fetch.txt  |  3 ++-
 Documentation/fetch-options.txt | 13 +++++++++++--
 builtin/fetch.c                 |  3 +++
 send-pack.c                     | 11 ++++++-----
 t/t5702-protocol-v2.sh          | 17 +++++++++++++++++
 5 files changed, 39 insertions(+), 8 deletions(-)

-- 
2.32.0.619.g53a98c35da0

