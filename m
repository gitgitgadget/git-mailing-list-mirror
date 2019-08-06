Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C62D71F731
	for <e@80x24.org>; Tue,  6 Aug 2019 16:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387791AbfHFQhB (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 12:37:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37058 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfHFQhA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 12:37:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so41786529pfa.4
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 09:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iTAaAYUXQIC5i39GW8AU74iSCd4N7Zg3kg7iO/SC6fk=;
        b=hEZofjeqCeENxCFlnDNozILf3LC2iDaxfNAc7I52ozCv/LzeCoX3WxLzEWO+B+eoHu
         jfIvzMCL1R7wvjyzafCUxwNjgL784Ecp7Qr++aWL1nfSAmpyrp59dW64jP3tY0+miyre
         Yu3tqBM0zNFAmOzR5JTwmdX9tFRVMsRCpJia9BoIaT6NUDvZb59OqXmmbbrDm1I8Zy3/
         3ueT5RwEKS70p+m518DRfoSCrHb6zLOT2vOSMQJ13wvtxKRgoW5y/D/RIS/JXBkrpFyv
         AXIiZTbwVosRu2E5c6tD4yEGZRQN5CrvvMnsREsW7zX6eq0o8v9bU2G+MothsJZ+XvAt
         EAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iTAaAYUXQIC5i39GW8AU74iSCd4N7Zg3kg7iO/SC6fk=;
        b=E0dMc8WVHNIIx4/PKcIumhggqn1muGAyU6wh7IVzc/OOcVnkgTXh96DmUsPV+0H7f+
         g5jM9QvevU4ZNygwyCpD1Z9yaxkywPyY27yTjkSGWW60kAikYoHDROkcRBj4ZLZIWGBC
         N90sLeukFO5f7StbL0yIiqhwASpxK6uVs3/5vP5e0uGzDbj/3iixz1jJLKFVv7iS96DO
         9V7yBfxurO32suPnTiT4PSh0i3qA9QOeB6G6e27EOGBVX1CoCUFM2i1nUYzadtXk+XDO
         V0DdSQezzqvpNYNRUUjlmaPliaN0pukylZtrKcXPH9FsN1HbK9l3/U7FaTjyJh8ljYI3
         dlpg==
X-Gm-Message-State: APjAAAVZhVr2wcPXT+6wLArYZ9bRVwRhIxA2hEi/CcIfy7MBD1yD48Gv
        H1N/Jl+Jri2CVZ4GXnAijuoHlAdZfvI=
X-Google-Smtp-Source: APXvYqz8zEWRGpdzsGrnPsTdLkhUCsLknscJFVww+k/OYLnyl+UnppDpZtTlduTMyFjzg2Nxv0yp/w==
X-Received: by 2002:a17:90a:ad86:: with SMTP id s6mr4185723pjq.42.1565109419748;
        Tue, 06 Aug 2019 09:36:59 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id k36sm89364611pgl.42.2019.08.06.09.36.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Aug 2019 09:36:59 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, l.s.r@web.de,
        avarab@gmail.com, michal.kiedrowicz@gmail.com
Subject: [RFC PATCH v3 0/3] grep: no leaks or crashes (windows testing needed)
Date:   Tue,  6 Aug 2019 09:36:55 -0700
Message-Id: <20190806163658.66932-1-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190806085014.47776-1-carenas@gmail.com>
References: <20190806085014.47776-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is a candidate reroll for cb/pcre2-chartables-leakfix, that
hopefully addresses the root cause of the problem reported by Dscho in
Windows, where the PCRE2 library wasn't aware of the custom allocator and
was returning a pointer created with the system malloc but passing it to
NED's free, resulting in a segfault.

The reason why it was triggered by the original leak fix is the layering
violation reported by René and that is exclusive to PCRE2 (hence why it
hasn't been reported with PCRE1).  The first patch could be droped and
then used in a different series that will fully integrate the custom
allocator with the PCRE library and that is currently missing with PCRE2.

Eitherway, since I am unable to replicate the original bug or take
performance numbers in a representative environment without Windows
this is only published as an RFC, eventhough it has been tested and
considered mostly complete.

Junio, could you comment in my assumption that the use of grep in
revision.c doesn't require initializing a PCRE2 global context and
therefore not doing the cleanup?

Carlo Marcelo Arenas Belón (3):
  grep: make PCRE1 aware of custom allocator
  grep: make PCRE2 aware of custom allocator
  grep: avoid leak of chartables in PCRE2

 Makefile       |  2 +-
 builtin/grep.c |  1 +
 grep.c         | 51 +++++++++++++++++++++++++++++++++++++++++++++++---
 grep.h         |  2 ++
 4 files changed, 52 insertions(+), 4 deletions(-)

-- 
2.23.0.rc1
