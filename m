Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013A0C07E96
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 02:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C727A61CA2
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 02:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhGGCe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 22:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhGGCe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 22:34:29 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D53C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 19:31:48 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id o3-20020a4a84c30000b0290251d599f19bso152359oog.8
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 19:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5mfHNn/Dtwy2a+e6E2CNqTRr6tehzEhTDzcIEzcypTE=;
        b=JGIQLdjxl5RcGhd0tDJ2yiPgXeIvM40PCkWj5rZRI7gP2QsJiMZxUx2BK2iEh58lBQ
         CNosf7ybYNVg+WkmS9WaXifEbvLlD9RCIHbNpZEdHc+ruPs9QiHYxPJpzVEFHy9+MVtK
         ZweGl+8XRG7xjgl4LP9SgoE6DPlacMzdsnBbiZc+fiwy4iJheA5f1y5Bg27iYP+gtFfs
         GJ78G/qx9IZdTUprM2Xnq15gQFLtPSvNcWw4Q9lCbhcQlnI8zpFW19WHX2elIg1dYXQQ
         9EwbDrAegy32NuMn/7e3QM/UKaaVTgF5BzF5E0vUFZFabB8BowVU1YuvnpEzrYMUshRx
         ntWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5mfHNn/Dtwy2a+e6E2CNqTRr6tehzEhTDzcIEzcypTE=;
        b=b1xl3xS1BrfVF79/NpxNB+itgwzqpj3C7M3B+83q5HFRgwPU1OJn0dJnjXOwq58r1X
         cEq53bLSZsr9l0p4Xa+oE7WqnjN59XVFo8IgU+4FRLq7lCjEFKy0tL64nDAPCY/6Lk7T
         1Bzi8yQwvJYDSbdVXpD+M2kKN7qbr4aMCjt6WqjFgMj48LWMB8CePf58F19uYWhRevv5
         4oJzdu/Nmpt9FgGM5xjKLwcnDgaFnDgUbzFTsqPCunp1uAuEFkUCk5BNgk4XLQI0oEyw
         Vg10ls6EKQpW1JOSi8aG6Y++mws+M8NKJATM7J6AfZ9sUCcOUcH45KKNst3Wasxb7ykC
         6O4A==
X-Gm-Message-State: AOAM531YkTVCrEUjdL68iX7ya31RZRtTMWQshopqGAQJBVuiykFVXQo6
        +FrsMD3EvNXIveZI5C/g9xTbTKvrCZY=
X-Google-Smtp-Source: ABdhPJw7ZNU2jxNUmYypjfKQ9OaVZUrbs1Pw0ZUgikJmYjLDj6K4nr5n3hFN/Px/2S74dWApEDMvlQ==
X-Received: by 2002:a4a:e206:: with SMTP id b6mr14300003oot.16.1625625108002;
        Tue, 06 Jul 2021 19:31:48 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id m1sm3635094otl.0.2021.07.06.19.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 19:31:47 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 0/4] completion: bash: a bunch of fixes
Date:   Tue,  6 Jul 2021 21:31:42 -0500
Message-Id: <20210707023146.3132162-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These should be pretty obvious and straightforward.

This is exactly the same as v4 and v3, which alread included the minor
adjustment to the commit message of one patch, but for some reason they
had trouble getting into 'seen'. So I'm sending it again as a new
thread.

Felipe Contreras (4):
  completion: bash: fix prefix detection in branch.*
  completion: bash: fix for suboptions with value
  completion: bash: fix for multiple dash commands
  completion: bash: add correct suffix in variables

 contrib/completion/git-completion.bash | 14 +++++++-------
 t/t9902-completion.sh                  | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 7 deletions(-)

Range-diff against v4:
1:  183328a25d = 1:  8e42ca9e43 completion: bash: fix prefix detection in branch.*
2:  a0f881b508 = 2:  37ab3ba953 completion: bash: fix for suboptions with value
3:  1e33fa9611 = 3:  49d5086250 completion: bash: fix for multiple dash commands
4:  6293c134f9 = 4:  ff13bb3b09 completion: bash: add correct suffix in variables
-- 
2.32.0.36.g70aac2b1aa

