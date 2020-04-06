Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E43C2BA1E
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 13:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07C0233F8
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 13:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ketlExwk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgDFN5h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:57:37 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:53953 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbgDFN5g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 09:57:36 -0400
Received: by mail-wm1-f42.google.com with SMTP id d77so14778902wmd.3
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 06:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=swqzSCWLFtWHq3OdyTG+kmWuQ8HXtDIO/63wU06hD0c=;
        b=ketlExwkkWR2/jdvwBUZp7ZPT/RO56EUP4Erj6nGRUd+RHBvSJj1Jcp5yXLi0aSGiV
         BAkjjOIDx9j1eL380BSjNCIjMur6QkswE8hT3paDpm/r9EdVOVsz1YEaEZne+YqpGEFe
         HSvrRBQp3RZ/3sKqoCyv+vbSi/wPXboWNV+tgGCW8WapBBwwZ/jDK8a3oOCZF1RPUTLU
         0+iNLlyP1AZ7UqEmSoX/hMzN5t/oIeRri7+3it5lOML3xt7hfSkXp0bawy5uvWhtm1S6
         fSIf2LSl5HybEwOs2fsgnmHg/viexPdW6wRhOAU8DyOsM2I2d5SRDvDuHxlPV4xQWrgE
         zdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=swqzSCWLFtWHq3OdyTG+kmWuQ8HXtDIO/63wU06hD0c=;
        b=HjXg4uq35m7fFzPpJHmUTCL5sBKHa1aTeP2OaqPKiKyEEVMWADX8u8gq8gaQ4v73WM
         Jh1BS8SH5K1A0IPsRnzKWCCUZlNH7zF2BZgBMSxAWPWrAw0pUA4r4qzPbhBMFx14mz7S
         wfM1BQF4LO89a+mgX8F//FL5ejwBR9mk7mN81pIjpMSvlXySQOq370wpEeGM+/tJL1TH
         VZ5g9SkW2iGzCmVgX+knxSjFOzkjRI4BAIR9l/p9EKFVUJKxVSdddUu1M0gJO6vA67WG
         Kqh9Anq4HGP3SuFOfDAGo8pcL1Ojl4F4D43kLvHY0SMeumUmrqU3+FSz2hfqbYCLcKhD
         2/yQ==
X-Gm-Message-State: AGi0Pua3FwODES732p2RahuRYb7ctzhXnKcirU7UzD74Fk+N4kaisJ8t
        OBaNA5J4juQNGninbmiH7cftBTUZ5EM=
X-Google-Smtp-Source: APiQypLg+2vOtqHwiqsfO4cHm63qQDXUmjJivYQl7KqVJ3o3tKA7vP8ZZ60tmDjr2UqJ9Ke5LqZOcw==
X-Received: by 2002:a7b:c30a:: with SMTP id k10mr22061144wmj.19.1586181454516;
        Mon, 06 Apr 2020 06:57:34 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id s13sm10414149wrw.20.2020.04.06.06.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 06:57:33 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v6 0/5] doc: --recurse-submodules
Date:   Mon,  6 Apr 2020 15:57:04 +0200
Message-Id: <20200406135709.60041-1-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200320213729.571924-1-damien.olivier.robert+git@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix typo mentioned by Junio.

Damien Robert (5):
  doc: list all commands affected by submodule.recurse
  doc: document --recurse-submodules for reset and restore
  doc: explain how to deactivate submodule.recurse completely
  doc: be more precise on (fetch|push).recurseSubmodules
  doc: --recurse-submodules mostly applies to active submodules

 Documentation/config/fetch.txt     | 13 ++++++++-----
 Documentation/config/push.txt      |  2 ++
 Documentation/config/submodule.txt | 12 ++++++++++--
 Documentation/fetch-options.txt    |  3 ++-
 Documentation/git-checkout.txt     |  4 ++--
 Documentation/git-grep.txt         |  2 +-
 Documentation/git-ls-files.txt     |  2 +-
 Documentation/git-pull.txt         |  5 +++--
 Documentation/git-read-tree.txt    |  4 ++--
 Documentation/git-reset.txt        |  6 ++++++
 Documentation/git-restore.txt      | 11 +++++++++++
 Documentation/git-switch.txt       |  4 ++--
 Documentation/gitsubmodules.txt    |  3 ++-
 13 files changed, 52 insertions(+), 19 deletions(-)

-- 
Patched on top of v2.26.0-106-g9fadedd637 (git version 2.26.0)

