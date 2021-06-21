Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846D2C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 19:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6326161289
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 19:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhFUTLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 15:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhFUTLL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 15:11:11 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D464AC061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 12:08:55 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 13-20020a17090a08cdb029016eed209ca4so627677pjn.1
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 12:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lmhDH9NtixBWziIvYyp7O0VnpCM0UAZ5BfADq2S7rIY=;
        b=jVX0SsRDaIP88Q7ppenKyayHLBzUn/TpCRUqNrEWU3SjG8GmAoFGmTrQM6NPLN7Kzu
         BYUArXQlTYxjjKla2Y2ldVHnYMGMY81X7d7K+/9RHoeL1eGVFv/98ipg4hxGk1Q1o7X2
         NfEID0tvG/aQ474wWGMIImKWsPe109x+lEp1RiTjAtxsnD98f0lo63Ekqoj+gB3j2i4f
         A+6TN7xDdyGeSZmzGc7pX2j0PracSnI7O+tprqFzMQeCRlUTQZL7wXl/BXEdncn4K4K6
         tyeScI89GLPFsXg6K7tu4ukZMGJzJdhzi35x6OymCFalvW33tEX2NO8tC2aKrxdr6eXB
         vJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lmhDH9NtixBWziIvYyp7O0VnpCM0UAZ5BfADq2S7rIY=;
        b=q/Wj7PUWcjccI+04DiNQunR20C9swrqhb6uwR40xkukXobvdkWCx9yE4+S+KjVn9zq
         wqxpxnzcU6Ia/AkxyWoIxP5/KKgpD8PyzhRmAnf+80LPMYPphJyajmHyQY2fpoZ175wB
         JqEc0Gdn+IMHxcz19Q/cdVdZ1jROahzcXyudIiYpOUJA3bVMas0eSRjDapoRq0AH+TM4
         U2nZaOb+UaCy84yA5lSWXbxY303tpOVAADHiT/3Q5ZNA/59KFE8TRV1H4pOBEqFAy0Mr
         IC7WLCBC26bniOBIQ9/CMUWnC7jtA0inIEn1fq2LDAeDXwirHh9FSA+UDjgOBi7W+Njh
         6nfA==
X-Gm-Message-State: AOAM533ANI3uyu40fyYlLuzFcJVEXyaHS+Ib8d0zbUxfTHaOlFmc3Bzv
        QKjcwtiZLC+VsUnVVHsC79pcBn+tFOtf/A==
X-Google-Smtp-Source: ABdhPJw5XfTSDMeMTRv7Q5THSZtd2WfGrk5iGlCCYVHKkwbXIaj+mv2TXgtlEZRSDxn9ltgFN3zsBA==
X-Received: by 2002:a17:90a:c595:: with SMTP id l21mr3556994pjt.145.1624302535273;
        Mon, 21 Jun 2021 12:08:55 -0700 (PDT)
Received: from localhost.localdomain ([49.205.82.114])
        by smtp.gmail.com with ESMTPSA id i125sm16256991pfc.7.2021.06.21.12.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 12:08:54 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH 0/2] Some submodule related code cleanup
Date:   Tue, 22 Jun 2021 00:38:35 +0530
Message-Id: <20210621190837.9487-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.32.0.9.g81a5432dce.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When taking a look at various changes related to the submodule
builting conversion effort[1], I noticed a couple of minor changes
that are independent of the builtin conversion effort.

So, I'm sending this series with those suggested changes.

[1]: https://public-inbox.org/git/D32894F5-FC76-4DD2-A2F6-E69AAE88C645@gmail.com/

--
Sivaraam


Kaartic Sivaraam (2):
  submodule--helper: remove an unreachable call to usage_with_options
  submodule: remove unnecessary `prefix` based option logic

 builtin/submodule--helper.c |  2 --
 git-submodule.sh            | 14 +++++++-------
 2 files changed, 7 insertions(+), 9 deletions(-)

-- 
2.32.0.9.g81a5432dce.dirty

