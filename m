Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964AAC433E2
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 05:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6807B20719
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 05:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfOKBYDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbgHaFLQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 01:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgHaFLP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 01:11:15 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D001C061573
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 22:11:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e16so4595840wrm.2
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 22:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=Is7pR+gcHII+N+fY8ybNoiItJnFrTR2YpBUDdoeX2NE=;
        b=hfOKBYDY7iB4rEARFFT1Af8je05Dhrd/NZ77ZwNBUW7RPhB2Ufgd8ufOtyRfuo5KOP
         XZ6fhOsoblyqLPBJ19B/UsQ/ZoXQKOXghHUunQK++C/v/ApY12efCgRYzvrh1gWSRegC
         c50AHahrfPpea16OVTgnxoVhifAFSEFH0sddcaa5qxfO80x/zaR/KE+xro7m2jKwmbpu
         hOYoq3lqP4Aec4ZfxCbluNGksED0fEnvKqfffGjSGaFf4d9mqZx8mZVelCInlo+ErtOX
         Tyy+yyD9g8xVuPT0YstGTfZPRmfcL6AZAZz+j5b1KyyVHvtdU125EFCfA6RH3lRyKPiC
         u1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=Is7pR+gcHII+N+fY8ybNoiItJnFrTR2YpBUDdoeX2NE=;
        b=kXF8R7NEmlFPC8e6JHiICTuUqvgX3INscnj8D6E9L9TLJ+OBx/pqSNQTUZpFKnG2ty
         5DUbgRkBHgRxrQ+Q/Y6z2mYNlCvYlacQ1fo/Y138x6oF5lkGdommQEgcpJlqdnuZgbqz
         jCca11N4nkrqqHFGdPM+nKOAxT+ZPWAc2H+Gnb6SXrMhXFIUREIKjpdXxqiXh9HgJB1o
         azin0R2/l+wZ9dZC4ZcnSQ15V+nS5bxQmLFPky7DlVb1+iyN5404aOpfdRiDVrH/wGS1
         PuLaShauhLTb6oy4rWQaAWLukNzA3XSuiNzOlyxBMC2A/LejeaQ7pynYcaFZltcnwj60
         LnRQ==
X-Gm-Message-State: AOAM530YFFF08lTq+gLJ1SFRCXoQZYIgkosn1KUkFzVXqs2MTNKH+nAX
        IX3sQTopZOxI4xxBTfYWh+R5GFuqDYM=
X-Google-Smtp-Source: ABdhPJwlhRehBwihUJ6N6PcEUCagfLfMgH7rsH2YnaVETZxrBzuw7xAtrHZX2MI2NJwyWJXkAM0vug==
X-Received: by 2002:a5d:484d:: with SMTP id n13mr9756521wrs.297.1598850673062;
        Sun, 30 Aug 2020 22:11:13 -0700 (PDT)
Received: from debian1 (88-144-199-94.host.pobb.as13285.net. [88.144.199.94])
        by smtp.gmail.com with ESMTPSA id l21sm9701873wmj.25.2020.08.30.22.11.12
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 22:11:12 -0700 (PDT)
Message-ID: <3488b6bec8cda0e0161ee0cbc6a3f750e21ecd0c.camel@gmail.com>
Subject: [gitk] searching commits includes irrelevant file renaming entries
From:   Lyndon Brown <jnqnfe@gmail.com>
To:     git@vger.kernel.org
Date:   Mon, 31 Aug 2020 06:11:11 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

When searching commits in add/remove string mode, the search results
include commits that simply rename files that contain the string. UX
would be improved IMO if it were to ignore such commits.

I'm a Debian Linux user, running version 1:2.28.0-1.

