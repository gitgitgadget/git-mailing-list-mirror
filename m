Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBACC433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 09:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJGJau (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 05:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJGJaq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 05:30:46 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F158C895A
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 02:30:42 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bk15so6347445wrb.13
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 02:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f9WjX/xmnbVTdmLJNu1Vf/sERJxZN9SwHNST8iHd/JA=;
        b=FKLIdRSYGJNc0uP7df6JzpcfiQAPa3S9JDKKnET3yMtOXjoXmGEru7ZyV6KybRer1c
         UZYWup/l7be2lm84eiinuKdJgHLPd0sqh8iwi6GKRrr7UmAGSXdiq6H5F3K3iNOWqB8G
         ffFiobQtPmQmgQyPCPbhcnrcdyagzwuonmh/wbf7vcND9YZg43LorhLpd5e/SjQGQ+HW
         +z8rsdyIICsskgqAc9ZHQCg308uKSWSu0xfkBiKgJP8h5OK7F2PCCgewCC7sIQL9z4J6
         6gZO+n+o3A/vXC/emcDPBuu3Mbk24btD5GC1/yNuo6aPrXn86ZWkVTreF9pixi0h/fO4
         H8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9WjX/xmnbVTdmLJNu1Vf/sERJxZN9SwHNST8iHd/JA=;
        b=HT6uSZ1xQxgFPCxQAigikdCwI24fpxUY7v5HOLEkK+lbjZuNATKieVmQV00pbCCkiM
         xxpEscNnGhJxHrXQTKz57Y8RBiIkJeN/AM7v4+4o2nhjtPMCnd/Mm9k2itWMglvQvy9F
         XHOc93uFiTZ0GtjypPC18Tkn+vXP1A/+9S8Qbu05NeXEnge+3xFo1Afc/MCe6thpOk9x
         54zzZKqOsWIedRALGGe9kAgXQ0iHzFVpdU7YnKy93IIPSzf3ZTf/sywrWkV3nvMWdRgp
         pshtubq05u+6GppWNnClgu8uwp92Qt1QoCVJNwiFunkYKlOMy644P+swzNjEigIo/mam
         58Dw==
X-Gm-Message-State: ACrzQf3bfey6myux8MoAWunNNlEDmqGmvb1Gvg4RZPxWRAoRGYfnZ1O/
        ecr+GbUgorYiZAeuOvvm7TNJ3ewq0hvsVA==
X-Google-Smtp-Source: AMsMyM6jFAccQ88PNWGxWSy7SgevLbyQUwgVrygeg6kvDlNKF4K3B6oezLQM3Qaf9ez9Fz91uOrofA==
X-Received: by 2002:adf:d4cd:0:b0:22c:dc00:7f99 with SMTP id w13-20020adfd4cd000000b0022cdc007f99mr2604050wrk.260.1665135040203;
        Fri, 07 Oct 2022 02:30:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o18-20020a1c7512000000b003b492753826sm1634945wmc.43.2022.10.07.02.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 02:30:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/5] CodingGuidelines: various C99 updates
Date:   Fri,  7 Oct 2022 11:30:29 +0200
Message-Id: <cover-0.5-00000000000-20221007T092505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series:

 * Rephrases CodingGuidelines so that we note we're on C99, and then
   lists exceptions and features we use. The previous prose assumed
   C89 by default.

   We still explicitly avoid opening the "feel free to use an C99
   feature" floodgates.

 * Mentions that you can use dynamic C99 initializer elements. See the
   recent discussion at
   https://lore.kernel.org/git/221006.86a668r5mf.gmgdl@evledraar.gmail.com/

 * Allows us to use "for (int i". I didn't set out to (slightly) jump
   the gun on this, but just pulling the trigger around ~20 days early
   makes it easier to ...

 * ...add the natural follow-up section of C99 features you explicitly
   shouldn't be using yet, to which I added the two cases I could
   remember (in 4-5/5).

Ævar Arnfjörð Bjarmason (5):
  CodingGuidelines: update for C99
  CodingGuidelines: mention dynamic C99 initializer elements
  CodingGuidelines: allow declaring variables in for loops
  CodingGuidelines: mention C99 features we can't use
  CodingGuidelines: recommend against unportable C99 struct syntax

 Documentation/CodingGuidelines | 34 ++++++++++++++++++++++++----------
 revision.c                     |  7 -------
 t/helper/test-parse-options.c  |  3 +--
 3 files changed, 25 insertions(+), 19 deletions(-)

-- 
2.38.0.971.ge79ff6d20e7

