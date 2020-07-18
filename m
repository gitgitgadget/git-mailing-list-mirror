Return-Path: <SRS0=BQqG=A5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318A1C433DF
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 20:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 015A520738
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 20:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaI+XxK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgGRURo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jul 2020 16:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgGRURo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jul 2020 16:17:44 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D0EC0619D2
        for <git@vger.kernel.org>; Sat, 18 Jul 2020 13:17:43 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id j11so16298663ljo.7
        for <git@vger.kernel.org>; Sat, 18 Jul 2020 13:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pGxG88UD0QLOtq/q9LmbNGvQk2GCCnyBh37XxYKXh94=;
        b=NaI+XxK4/J+o2i1jdZmRovfhjRbnhtgUP4noGEspLYkA1u5dm/8zHWfy9ISynIg00L
         tdwiKI7S2zvQqUDQO6JUcQLiALrkVWaI/uXTezNMj4wcDHKEqicl0fWo8uMulgurrtUY
         an4g+wof8b9igqXDP5WcyZl6f6oOTtWOassbAr/cq9G8HZguMnzyv8s/o1fRUgU1GREP
         ClapHI0+MIcTuB6R8PGGLZhMqWnD0toXvIV9roHHj4G0bDYtdFFAtVKydKES+WeTKwRv
         a4qBDl5G56qZewdb1fbzDb/a3vTPoa7D6j17sc8fesybw6w9EmT7FJutkqkpPLkIVj/9
         qQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pGxG88UD0QLOtq/q9LmbNGvQk2GCCnyBh37XxYKXh94=;
        b=noS4L+sHLRVCVrPFL3MMCjYUDJpvkzaaAoMndpSc778kXmClbU0gexGYWIfTUinQqs
         VtlFJ9LqWURjgynsYa60zvmh4Q3thv/OgmLCk9V4fAj/rCq+G0PsuC2hfmmluWss/JNY
         BtZLmpjkE3rlsx1Qr6CVwCiS763qukoUqdSt3A3c2j2jncr8BBPP2AbPQWrTlL3N331i
         lVglnf+OJ7ktk26QYbbW4mWg9zTbR3JCo9pYNYrqfOSKgRmXyYAV3cBgB3YoKMHQRmTx
         f+J4eqqu11RB3UtDKC8ToK7VJAaS5g5Iho8Xb8T2PuVhVhXWS5MzzEPd08Q8YAOP8Io8
         mNmw==
X-Gm-Message-State: AOAM532/3lkwoYi8HOFuLdv2ZWKL14AyLP/E+xp3T/jOwK/x6mpXbJJG
        L8U5uakA/ZxzPOoMbDWRUGn3qbDw
X-Google-Smtp-Source: ABdhPJzzjyd1N7rsF3JJSicAloyqnEEOGp3rQesZiVhHu+MptpyaiNc89kEseR4zedwLrPW/10QowQ==
X-Received: by 2002:a2e:8855:: with SMTP id z21mr7303729ljj.325.1595103462216;
        Sat, 18 Jul 2020 13:17:42 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id x205sm454940lfa.96.2020.07.18.13.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 13:17:41 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] gitworkflows.txt: fix broken subsection underline
Date:   Sat, 18 Jul 2020 22:17:23 +0200
Message-Id: <20200718201723.10889-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

AsciiDoctor renders the "~~~~~~~~~" literally. That's not our intention:
it is supposed to indicate a level 2 subsection. In 828197de8f ("docs:
adjust for the recent rename of `pu` to `seen`", 2020-06-25), the length
of this section header grew by two characters but we didn't adjust the
number of ~ characters accordingly. AsciiDoc handles this discrepancy ok
and still picks this up as a subsection title, but Asciidoctor is not as
forgiving.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/gitworkflows.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
index 2db7ba7842..47cf97f9be 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -292,7 +292,7 @@ described in the previous section.
 
 
 Branch management for next and seen after a feature release
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 After a feature release, the integration branch 'next' may optionally be
 rewound and rebuilt from the tip of 'master' using the surviving
-- 
2.28.0.rc1

