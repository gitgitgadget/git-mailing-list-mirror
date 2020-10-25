Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140BBC2D0A3
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D01BD20936
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RN9wOEq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766815AbgJYDNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731837AbgJYDNq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:13:46 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0340C0613CE
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:13:46 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id j6so1552308oot.3
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AgTujZnoUOuxEDc+imeV0lku1LBnsmx1Qwx8b8/0P8w=;
        b=RN9wOEq8IJAfZ3Om2uHusYWZkuf3EkpBvyx/HhHktkreHT1cvVXUjG40az10iu65jK
         vAJ8SLrbRTbeMV4i5MtRN67pTIh9meSVKg9RDGENoU7cblIg/0Pp2Rb62d4QyXD/byUa
         l1diKa28F6H5e3BC14HD/OXuo3j6h47BEU3lP6z8VvX0iXBtrHVxRHQb9/luoKIhzaYr
         4o9C5rOa/zRpu3FJAEvgA8PRfF76TZkPyt4f4+DWXDYoFaq/bvKE761a50nBfQQfGh74
         fN6yST5WyCBlCz+LbqvqjZKtik2CRDseXI140Jcdxpvg2dGKahpNOUIf3STMmCPwpIz8
         W6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AgTujZnoUOuxEDc+imeV0lku1LBnsmx1Qwx8b8/0P8w=;
        b=PSXSkpGDPPvlK1m6QGsZv4PZMBrygVO5T6v/JNugr50EHupBQm0wGthGosnTSLP8BL
         5uQI8nflVpD7dc1Aq59y5WGd4P5D/NfPl057c1SKqs1pZvgczGnvRnoCvUf1PJTweQHP
         5W8ANDpaiAL4lQJV0fTrojfxHVMPLEsTMDtY6WFmMKOuPklUkrS+r0dQjeC9eHEAiseo
         LYWfUHc1/DYToCKUOKBSFTrrDccNQUpgS+C1JdI+88g7+ZkiVCgNmN0z3O2SteYwykUJ
         w1auRBJEZs8mh+xPRV6rw8UrGJUBu2IJ69VqhFK/Jp7RxtObgJaIIDXzv0lC6F0nGmlA
         r2PA==
X-Gm-Message-State: AOAM533ohbZ2pEbve4ahdvi1SpVrBB020Ogbsqn1SYElU7oUuC3XkIFS
        8/nS7CG6usS6uoOBELcb4LsvkNr3/qnUBg==
X-Google-Smtp-Source: ABdhPJzmeJE6/bZ58s8rXrrw1fXL0SEqSDdibm8N1mOqe0G+92OefcB1m2ImQqJgp1tKSAdsnyUNKQ==
X-Received: by 2002:a4a:dbd3:: with SMTP id t19mr8217603oou.40.1603595625643;
        Sat, 24 Oct 2020 20:13:45 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id k51sm1670786otc.46.2020.10.24.20.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:13:44 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 00/29] completion: zsh: latest patches
Date:   Sat, 24 Oct 2020 22:13:14 -0500
Message-Id: <20201025031343.346913-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've been carrying around these patches for quite some time, many have already
been sent, others I refactored to make them more clear.

But what is clear is that they are needed. I see a lot of people in different
forums (e.g. Stack Overflow, Oh-My-Zsh, etc.) getting bit by many of these
issues.

I've created an independent project to keep my sanity while maintaining these
patches, but for what it's worth, I've transplanted them to Git upstream.

https://github.com/felipec/git-completion

There's also a lot of information in the README apparently scattered
everywhere, but it's good to have in one place.

Cheers.


Felipe Contreras (29):
  completion: zsh: fix __gitcomp_direct()
  completion: zsh: fix name due to broken autoloading
  completion: zsh: fix bash script extension
  completion: zsh: reorganize install instructions
  completion: zsh: fix for directories with spaces
  completion: zsh: update slave script locations
  completion: prompt: fix color for Zsh
  completion: zsh: fix for command aliasing
  completion: bash: synchronize zsh wrapper
  completion: bash: remove zsh wrapper
  completion: zsh: fix completion for --no-.. options
  completion: fix conflict with bashcomp
  completion: zsh: add missing direct_append
  completion: zsh: fix splitting of words
  completion: zsh: simplify compadd functions
  completion: zsh: simplify direct compadd
  completion: zsh: trivial cleanup
  completion: zsh: simplify nl_append
  completion: zsh: simplify file_direct
  completion: zsh: shuffle functions around
  completion: zsh: refactor command completion
  completion: zsh: improve command tags
  completion: zsh: add alias descriptions
  completion: zsh: trivial simplification
  completion: zsh: add simple version check
  completion: bash: trivial cleanup
  completion: bash: cleanup cygwin check
  completion: bash: remove old compat wrappers
  Update copyright notices

 contrib/completion/git-completion.bash | 114 +++------------------
 contrib/completion/git-completion.zsh  | 132 ++++++++++++++++---------
 contrib/completion/git-prompt.sh       |  11 ++-
 t/t9902-completion.sh                  |   2 +-
 4 files changed, 105 insertions(+), 154 deletions(-)

-- 
2.29.0

