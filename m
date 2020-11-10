Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8281C2D0A3
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 02:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71405206F1
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 02:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERALv0UU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgKJCDq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 21:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729648AbgKJCDq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 21:03:46 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37218C0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 18:03:46 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id t143so12529925oif.10
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 18:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fg7Pf3FKxH6ncSqMVSDZtL6XN0/Htu0HYedsyJRm7MM=;
        b=ERALv0UU9Qg+3Evr1h0F3XrLIxK8y0rg7rlGr5kMM1LNHdlSzmjoGonOYJxfqrPNhz
         wZlr60kDHfCTEl/FoXp6Xu0vJCqF6qQRFVYpOuSD0xND8JKCtJkm5FWAuANeU8hP6x0D
         tXzx2mv43GGfbdmuEAURUZY4TCZlKyXdmjB8ptYhomRfdWDvKC1uVEcXN2JPXXffxxwi
         raFsLGsAyS1957C5iQAANLHHI+vPSleShQU10ydlVcZEY5GmANeglSTdwTk4M5Z7nY9y
         UwJBvGqxFzeLh9aCk8bSVHq/+I88r3803HnEcRj3kdkHhmBNFJJ2AajJSR5KB7u/lU/r
         idtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fg7Pf3FKxH6ncSqMVSDZtL6XN0/Htu0HYedsyJRm7MM=;
        b=Brgc/JRFqIU4efb/7IbmO8rySHNP2QT8Ug7GfIWZyt35sTRgs3G8i47mJu1uTTRk2F
         5WkVIDqA3Pq8+MvO9TlTjSJ+llvdygxR5nhhDCc/A5XSVAtM6lR74D3WHWyz8izrSQhx
         xegPWUdz5iyxz3NzZu5TghUWSIsUtrAXh/+X+HQMSZc7PcYGj4M6SPQmqhx41tZmOt9n
         6LMU8ymyuNiW1s+2sZm2NtysG3hj1pve5KVeodlodnKqiN4lD7SiXPDuCUpit8r8LdNS
         kO0UiXIageVB2+y6Rx9VpCzzEUmlyyHKH8dA4HeJbBj6iZChoSQQ96eRuVh8ZJQ5Z6qR
         Vzeg==
X-Gm-Message-State: AOAM5339Udqs2iTUNlRHVrraegoRkP2FsziyIn+e64G31z3JPA38GMf4
        j+y3B0EJEqwmYOxAITbQoYBKYjuL5MfXNQ==
X-Google-Smtp-Source: ABdhPJygC1FCsvrWjMFn55LEfrnP063Fw78fhEROeNrByq7c5lSjqzo3K9OC+VFEQ1zseHs4dCs5fw==
X-Received: by 2002:aca:f50e:: with SMTP id t14mr1331964oih.123.1604973825267;
        Mon, 09 Nov 2020 18:03:45 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id d26sm2817587ooh.19.2020.11.09.18.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 18:03:44 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 0/2] completion: bash: support for recursive aliases
Date:   Mon,  9 Nov 2020 20:03:41 -0600
Message-Id: <20201110020343.548848-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

As Philippe reported, aliases of aliases are not completed correctly in the
Bash completion. This patch series attempts to fix that problem.

Since v2:

 * Reshuffle the commits to have a simplified history


Felipe Contreras (2):
  completion: bash: support recursive aliases
  completion: bash: check for alias loop

 contrib/completion/git-completion.bash | 53 +++++++++++++++++---------
 t/t9902-completion.sh                  | 19 +++++++++
 2 files changed, 54 insertions(+), 18 deletions(-)

-- 
2.29.2

