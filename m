Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78E6C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 16:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6FD461185
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 16:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhFQQUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 12:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbhFQQTW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 12:19:22 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAEBC061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 09:17:13 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id u11so7116078oiv.1
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 09:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7VTnjJog2wyIDotR1y7HgwJcQfUja+9tywU6WDtf9XM=;
        b=R+orS86QB/JDFJdZiY1tXCTSlU/V4RgXuk8GiYeua6SsWJi4j8GClCwsFMvnUc89/0
         CgLePB4Jp8pHXjYju+7hZPPUoHe7Otm7UTNyT4Yyi1h/ibZJ7cp2gEN6TCN8T9N8w6na
         lo+n2ivIFRFUzxBqFS82r7O0+qIE0WfuVh07waN39cdl39Aa6nORwks+EVVw3cDZ7qLF
         yx8jOrO9YARQBbQkX2t3lSyVUFGxpjA3DPeSD2opyeuNnox9GhTknwY58uUkt1g8uDj0
         oLyilnQvJuCTUsvNWMDUYnNpktjjG8MP/bvnXZUJcHTs5ZykCORynT1NnpE/XDh5NdaE
         mx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7VTnjJog2wyIDotR1y7HgwJcQfUja+9tywU6WDtf9XM=;
        b=l+TqqfSkfRXRFzAighxp5AddyYoCeHaIBUhizufO41d0DfewZowFLRs0Jn6xqJLmpm
         sKDeFZfntL0LfA05y0FQ+6QGe93A2JgycLvQ9TdohkRD9rixlHF3PGpKKaj+kfrjdMkX
         S8KM4cFF99Wt1+4iPK7m3VWwF+lHcQYUNRoIQRy4WMYR+2Ek7AeHvqI/d5I+a8dZigtD
         8rB6zCfiI+c2n0zeynCsX+FBGc1L/HGNp6NFW8zeyQhWmDbQZ0BEXPbgh2MdsiVIn6Ww
         q5W6dW0niATnE94FHIg5nMy3kJz8MVXi/HQ6fUSNTKcOKT9ZSfMK49mhF/61nsEIo7ey
         wnNg==
X-Gm-Message-State: AOAM530dAcGfJ9wdQVUukKDi/TpYbtDnFnpGGQnUdRYjy+XnBIXDSHep
        X4L0bVbGBYamSZf5JoQGF/DQSrSUeb1Kag==
X-Google-Smtp-Source: ABdhPJwcpqaG6eEssTKmn6c2HVGUmrYXV82LgiT9IpzvxYbef9ir9+C3N3CvO6aBx7RIliS/t8G7+A==
X-Received: by 2002:aca:5843:: with SMTP id m64mr11394350oib.130.1623946632474;
        Thu, 17 Jun 2021 09:17:12 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id i28sm1029377otj.41.2021.06.17.09.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 09:17:11 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.email>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/3] pull: obvious fixes
Date:   Thu, 17 Jun 2021 11:17:07 -0500
Message-Id: <20210617161710.81730-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210613045949.255090-1-felipe.contreras@gmail.com>
References: <20210613045949.255090-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are obvious fixes that I sent many times in series like [1], but
for some reason they were never merged.

No changes since v1, except the removal of a reviewed-by trailer that
was not expressly given.

[1] https://lore.kernel.org/git/20201218211026.1937168-1-felipe.contreras@gmail.com/

Felipe Contreras (3):
  pull: cleanup autostash check
  pull: trivial cleanup
  pull: trivial whitespace style fix

 builtin/pull.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

Range-diff against v1:
1:  f9520dbf78 ! 1:  bc5d3227a9 pull: cleanup autostash check
    @@ Commit message
         Let's always take the fast-forward merge shortcut by essentially
         reverting f15e7cf5cc.
     
    -    Reviewed-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## builtin/pull.c ##
2:  e677256db0 = 2:  d3c944d2fd pull: trivial cleanup
3:  34a9e2d50f = 3:  aadc7e17dc pull: trivial whitespace style fix
-- 
2.32.0

