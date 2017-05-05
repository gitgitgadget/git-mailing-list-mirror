Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8135C207D6
	for <e@80x24.org>; Fri,  5 May 2017 05:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbdEEF1f (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 01:27:35 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33814 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751561AbdEEF1e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 01:27:34 -0400
Received: by mail-io0-f193.google.com with SMTP id 12so2185292iol.1
        for <git@vger.kernel.org>; Thu, 04 May 2017 22:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Yia8ZEJZTXMdH3Io5cr5pvY84SV+3dfMgPt8dDpCiGY=;
        b=VzvEBJmF51mLM4ELys7h+6YlDfpZm1RK5aUyVjexfIf/AqEMp4vQbP4MhPyg7/4KLv
         PhQEEAfkA+U2LSL9nVLaP2GBZGC/NA9nUfix0OLb6zQTuAEMBSEOAqr1b2bMo4mYI1aF
         qtzKypSLWpFRlNnoViyWnAeizliDqgcQtOyvkpvoLOs7w9DYBNI1VrQBRJmNubhS1L7J
         JyIVqoKO5cofEvQef2mcqJI8RGFieRuLGNE1g+1Wio8Xo3C2pMC2aXoZaW6AxviuiVZk
         E7Zcgb5iI0qQJC93G1TCkbeGNyPCUlpgPl76ztCruLwoKamsARNe2CQfyPoTECDiRtDh
         hFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Yia8ZEJZTXMdH3Io5cr5pvY84SV+3dfMgPt8dDpCiGY=;
        b=gCvOE0qUThMTzs9clAcrF+ZN/H1q0pM0Za9gTaY5TbL+RkHwGPgCiEutS5JJ0dNhOz
         dlAkdjXaTzrd+voik15UczzTrqC1MQBxgGSLx/uVzu1UfxRPg9tDnnDgAoRQki8kD9mY
         BV+RNNBPDv7zlFPCk9HnA5X4zLGlealMXn2dXh4Iva/iQMz2KnQ6SBgM8bgenBY7Zkna
         2I0B7SK08kDx/VuyHgV8Rd+G9hgG33T9/g7OaC5UPaI7Z8HkJ8KLLqtkoy9qUwdNxHRo
         F2LrXU3r8684n9GLEmJhG4p5y5Tj1dIzVYDD27s0wM2S13+SfSa9h+6GWBYlB/+y1eg4
         KOwg==
X-Gm-Message-State: AN3rC/4NZP5Vyo7NKz9nN7CG8aLDfuZ5pEEPl45TT05Q1CRwfh1jFWpq
        15S1D5hFlib6yQ==
X-Received: by 10.157.33.98 with SMTP id l31mr16776403otd.245.1493962053588;
        Thu, 04 May 2017 22:27:33 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 2sm2179586ota.46.2017.05.04.22.27.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 May 2017 22:27:32 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH 00/10] Add blame to libgit
Date:   Fri,  5 May 2017 00:27:19 -0500
Message-Id: <20170505052729.7576-1-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In adding blame functionality to cgit, I do not wish to duplicate huge
portions of builtin/blame.c there.  I would rather shift its core
functionality into libgit.a -- which cgit already uses -- and in cgit I
can focus on the web presentation aspect.

I was able to split three separate cohesive pieces from blame.c into
libgit.  The functionality left in blame.c mostly relates to terminal
presentation.

Jeff Smith (10):
  Remove unneeded dependency on blob.h from blame
  Move textconv_object to be with other textconv methods
  Add some missing definitions to header files
  Remove unused parameter from get_origin()
  Split blame origin into its own file
  Move fake_working_tree_commit() to lib
  Break out scoreboard a little better
  Split blame scoreboard into its own file
  Break out scoreboard init and setup
  Move scoreboard init and setup to lib

 Makefile           |    3 +
 builtin.h          |    2 -
 builtin/blame.c    | 2045 ++--------------------------------------------------
 builtin/cat-file.c |    1 +
 commit-fake.c      |  200 +++++
 commit-fake.h      |    9 +
 diff.c             |   23 +
 diff.h             |    7 +
 object.h           |    2 +
 origin.c           |   62 ++
 origin.h           |  101 +++
 pathspec.h         |    4 +
 refs.h             |    3 +
 scoreboard.c       | 1569 ++++++++++++++++++++++++++++++++++++++++
 scoreboard.h       |   77 ++
 tree-walk.h        |    2 +
 16 files changed, 2108 insertions(+), 2002 deletions(-)
 create mode 100644 commit-fake.c
 create mode 100644 commit-fake.h
 create mode 100644 origin.c
 create mode 100644 origin.h
 create mode 100644 scoreboard.c
 create mode 100644 scoreboard.h

-- 
2.9.3

