Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CABC433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 18:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFB7B613CA
	for <git@archiver.kernel.org>; Thu, 13 May 2021 18:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhEMSTO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 14:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhEMSTN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 14:19:13 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A143C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 11:18:03 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z13so39783578lft.1
        for <git@vger.kernel.org>; Thu, 13 May 2021 11:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7M+tZnKAAAh3hGAiFQckn/YFMN4HhJwWYAXYBz4JLkw=;
        b=fl4RHXc5QXB8zMcY/CRWxxfC3rhgM2duy02O830Xu1d3T0pVXw7H4wmEsxyOdOnrKK
         VRRh6oHAgx1o03VQc2Z5YPJhnRGAdMcgYzykTxAvqpxzPkmKjKY2DEuiAgDxNok2B4/a
         mBKIYUUles2KNR3kpSpHXySHvmk08k/GFarEmYP64dEZYBrKRt3U7poM3LnmTSK3e53D
         Wf7fKvSA1gN1q8dk1aw4iGww6C+S1c2wJMeO3G0aIkf4Pl4baAPw+dvJfK48BbijdDow
         7HnSxxWYVE843h7ug4CFHsBeEsV6g+A4mNZ69Z6uJD6bBUbrqz49rubZ+JMM6CLBspEF
         OhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7M+tZnKAAAh3hGAiFQckn/YFMN4HhJwWYAXYBz4JLkw=;
        b=IfJlXaZb2d6cW8ZBnRgsJHJmH5j/2ew4CP9zhx5myM8/HNBuGF5AJbF/d2nWVNxbz0
         o7YxIbh4//W2Y0mOlF4EBBVzeg+S6KgrntMmi1W14H1jTpCV0EIS14ObjlNlgiyL/ajk
         XebJ2FFe3Cd7H0EGA1gCpB9LUa4IdDtO2Ncm7jz4ARE4rYpcGcdRZlT5pm6FgrUBsD0Z
         aRTkP3m472kdbLKrY4HVopmEZSOxtYo/W/pDp5aDsal7ZpR7oafJLx8hU7niHWkT3CN4
         qJBI46u/FSj4FZLbxiltNyMvmnVCVdIL3fmkESGzV9B0VolvUyiF09YQorYnlIU4qz+I
         YF8Q==
X-Gm-Message-State: AOAM532Xx5NITgAU6iwkTmV0iVGE0q7L29C1PrjSB4cFTYwMBe7RKXmT
        cpEjwxEW6jDmsASyP+aqMJoPO/5nm7w=
X-Google-Smtp-Source: ABdhPJxWzDCZ79mCf0n/aaQhIOxymaKlZFQDRnR3Zxlczo9YE4NyLeEbBNmrAxAR6lobEPxYwdEQSg==
X-Received: by 2002:a05:6512:388f:: with SMTP id n15mr23708855lft.280.1620929881351;
        Thu, 13 May 2021 11:18:01 -0700 (PDT)
Received: from localhost.localdomain (81-231-136-235-no600.tbcn.telia.com. [81.231.136.235])
        by smtp.gmail.com with ESMTPSA id v8sm554153ljn.17.2021.05.13.11.17.59
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 11:18:00 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/6] AsciiDoc vs Asciidoctor, once again
Date:   Thu, 13 May 2021 20:17:39 +0200
Message-Id: <cover.1620928059.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches reduce

  ./doc-diff --from-asciidoc --to-asciidoctor --cut-footer HEAD HEAD

from ~1200 to ~1000 lines. It's the usual mix of things where one or the
other of the tools renders something less well, or where we're doing
something odd in the source and we just happen to notice it in the diff.

My ulterior motive here is to have a smaller doc-diff when I post a
patch to switch the default to Asciidoctor (with xmlto), so that it gets
a bit easier to reason about. But if everybody gets prettier docs,
that's also good.

Some of these rephrase wording such as "other peoples' commits" to avoid
that apostrophe at the end of a word. I'm hoping those rephrasings don't
regress the quality of the text -- if they do, I'll be happy to try
something else.

Martin Ågren (6):
  git-http-push.txt,git-send-pack.txt: avoid single quote
  git-range-diff.txt: avoid single quotes
  git-check-ref-format.txt: avoid single quote
  diff-options.txt: move monospace markup out of attribute
  git-svn.txt: change verse to listing block
  Doc: use two backticks for monospace, not backtick+apostrophe

 Documentation/config/diff.txt          |  2 +-
 Documentation/diff-options.txt         |  2 +-
 Documentation/git-check-ignore.txt     |  2 +-
 Documentation/git-check-ref-format.txt |  6 +--
 Documentation/git-describe.txt         |  2 +-
 Documentation/git-http-push.txt        |  2 +-
 Documentation/git-log.txt              |  2 +-
 Documentation/git-range-diff.txt       |  6 +--
 Documentation/git-send-pack.txt        |  2 +-
 Documentation/git-show.txt             |  2 +-
 Documentation/git-svn.txt              | 51 +++++++++++++++++---------
 11 files changed, 47 insertions(+), 32 deletions(-)

-- 
2.31.1.751.gd2f1c929bd

