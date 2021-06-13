Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E7DC48BDF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 05:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C51611B0
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 05:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhFMFCK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 01:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhFMFCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 01:02:09 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4540AC061574
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 21:59:52 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so7495448otl.3
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 21:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WshOkCB1A7vbwAv6w79b3MCNoFaJW9LZ20QqL956VnU=;
        b=T1bzEoaDC0XIqWUHoU6aQTdvc78x6l9de8K9bhCwV741imoUpZvFwHOc6i5XNAGKue
         kZN5pL/Kh0nyvRog3tNe5lHbKZlgUsEokL6WCwZ/mMz3riZ9sCn36xk8YRgl28XA3Pa2
         tJmtW5zmCkTsTmLhw9zm1ZnGpOCCnw3H2syU2b/sR9cEi6NfvoKpCJQ4DMGuoJjXxsxo
         LTjd5RVFrMiYpbc4yfJFoXBtmzDHpUmqdJr1HnvrxbpJCZNvSmd8ksQFLxbMH27wY50K
         jto5x1Ac1snEgWQ67ulGqXUwhBl8PHhDSecbWT2X0B426EGK7g3Tuuv3lxp3J1kPMAKU
         lojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WshOkCB1A7vbwAv6w79b3MCNoFaJW9LZ20QqL956VnU=;
        b=FMBGt3f/RBax6DU0pF3YdnKqOWGa5MOqFiSta/gqrdo/wvXEIZM07091qm5MRl0DzX
         089CojBZ0nbD8kLJ+Ms3kXx1ZtNg5HL1BXvXZaHiSWCcDb1wSvdITQY0XJJ/1rXJ83zy
         mJ5dg6IWX+2zBQjSzagTH394rDSnPIk/Z2YJH04MXxuTxBL1yVc8/Bq6eNmqpkocD+s1
         P3fuEoIpFD6luT/2L9UsH+jk91ddw8bXrTfccZuw9dwL0+UY5FzaLzU+ffN8dnu3ZExA
         2XXQoWiiFQ2oqZi0g5iamO+v6j7nx84ZjtLfWJ4MGzZMZUl8cFpS/vhnaJKgvxwnDTD7
         LosA==
X-Gm-Message-State: AOAM533UbRE6KC7IySA44882ZWJt5LReJEyzrKpwZrEWOEmnQcculwMz
        lEYfEhnqGW3yFyWar2BTYupF66MkeM5w/w==
X-Google-Smtp-Source: ABdhPJwKtOa62ANU4ptVsUVo+9V6ZWmsFnMGr/yjy7GiJz+qUXiaHHpsMHIuZz9CosE/ui/KGOqxkg==
X-Received: by 2002:a9d:6453:: with SMTP id m19mr9196116otl.63.1623560391345;
        Sat, 12 Jun 2021 21:59:51 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id n11sm2426297otq.63.2021.06.12.21.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 21:59:51 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/3] pull: obvious fixes
Date:   Sat, 12 Jun 2021 23:59:46 -0500
Message-Id: <20210613045949.255090-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are obvious fixes that I sent many times in series like [1], but
for some reason they were never merged.

There's absolutely no reason not to merge these.

[1] https://lore.kernel.org/git/20201218211026.1937168-1-felipe.contreras@gmail.com/

Felipe Contreras (3):
  pull: cleanup autostash check
  pull: trivial cleanup
  pull: trivial whitespace style fix

 builtin/pull.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

-- 
2.32.0

