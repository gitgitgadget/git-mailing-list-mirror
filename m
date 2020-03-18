Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FCFC10DCE
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 16:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3315D20752
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 16:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfQYaOZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCRQcp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 12:32:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34006 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgCRQcp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 12:32:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id 23so14197027pfj.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 09:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i959pBOZz3ITELSE8mfL6bRR76r1NpPrDO3RhsWrd0Y=;
        b=FfQYaOZDS/8c4mhVFDOVJqb1zwAiRoXbRw6LYG3UW2FwL2+dUJkPujdqCaZmRLASBn
         oD9DwFq5SWRsScw8Gw1JIsUg8ucGAzvPIWv6cosnO6IHOxkmcryJZm9o0izq3vNMNPpi
         RrH2tc/yI/C506kSEog8U7hyTQYNXGN9+V7P28eYjvgB7FF/VCM7Z02+ac/Z3IYNdMgB
         6BifYvr2B0TK1CDaYF8qlAqd4rIe/Yeg/TA/p7d7bhqxN6XwPKsST2BhPM8WQA1Cp0nr
         jwPlq2LSkf2px5wmU1afsd5YUy9QmEaCfJ/8cTzoHLGZgUmsm8/37CMwPF4VBdiUcUwR
         SyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i959pBOZz3ITELSE8mfL6bRR76r1NpPrDO3RhsWrd0Y=;
        b=GbX7W7rjMxo/Yl1WYTPTuZNLKY39iPbS5Mo8iziqcFrsLVMVXZX16uwO2dekipkba5
         RcfK6VEOUIQluyavOx/uSAcGAE05lycT6FBZ0hvHhpwj903z2Ryjx/fjSl1UkdfUjY6A
         Ei0uOLQFllKFTu4ozi51VoIKeXLEISc0yVPCAVwTFF5e5MZ7YNqUjE+QMMyy1FdbzoLs
         n75Qz5YSmpWUWvpZuZx0LCCPZFr8eJoC5kWp4Go10yXADpzG3xJyhyAJpaK6HORq9SJL
         S2G/SVC2jpZdDV1TYomAHLXfCS5Rc1EGiRYandGNQ+mTu56Bn0i0ILsu1Jnd72Gk+MrR
         9CqQ==
X-Gm-Message-State: ANhLgQ3VlpeAL5MY/2ciiaRetCou/oVFHKCIA9Ezu+soCv7To+usQe6/
        8Yn9UxqcWCWpuYS5T1olNTy77MyDiDNWHg==
X-Google-Smtp-Source: ADFU+vshbeZlQBpA6ZMM1frvH3Fg7fvs7WLH1C/szVDc2ghvgG4AfSTN8ZQtbssOy3lKH7neIOlwwg==
X-Received: by 2002:a63:f455:: with SMTP id p21mr5367297pgk.430.1584549163504;
        Wed, 18 Mar 2020 09:32:43 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.173])
        by smtp.gmail.com with ESMTPSA id q91sm3032107pjb.11.2020.03.18.09.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 09:32:42 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, newren@gmail.com,
        peff@peff.net, chriscool@tuxfamily.org, jnareb@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: RFC][Feature] submodule: teach subcommand 'summary' to give summary for nested submodules
Date:   Wed, 18 Mar 2020 22:02:34 +0530
Message-Id: <20200318163234.21628-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,

I was converting the subcommand 'summary'(of command submodule) from shell to C and I realised that
the subcommand does not have a '--recursive' option in it, meaning it cannot give out summaries of nested
submodules. My opinion on this is that an option should maybe exist for the same.

What are the community's thoughts on this? Should the aforementioned option be added? Is there any feasibility
of this option in this case?

Regards,
Shourya Shukla
