Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18046C2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 11:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2149238E2
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 11:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oq1fjI6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgIZLqh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 07:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIZLqh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 07:46:37 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E607EC0613CE
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 04:46:36 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mm21so873087pjb.4
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 04:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q9D5GCw1EAChWummcSWcrt3fFvjuL88VfiKPHLkhhZA=;
        b=oq1fjI6ngTOO1yogplQQKby8Ytda7HM7i8QxRMBW4SCW58XRBPKYntZt9kT5vc3VcS
         LqkN+daGyQRYSA7idoRZLR2p8eJD6gr7dCIavARKGj69h0/HLZ537qZ5FVz4A/hX6cLL
         WGv6dTurPRee9x3Lei1TbwBsCIFU4RCMEaY4Xk+8XkWyhG6YJbuOKului+xXGnjR0G8w
         RDKN9rJP4JTOlaDdm2Pei9iODTKcJU+9E5tbm0J06Tdi7B3EY+p5TktHQ07lJeHmgKMD
         vH/RwruQt8Yd24ofak1nVW1EGKY35M86viAqyxSkorkR3VAgQW6TqicGHinSpXbzTA/z
         jW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q9D5GCw1EAChWummcSWcrt3fFvjuL88VfiKPHLkhhZA=;
        b=izSKHOPWPG8w1OE2GHJFb5/y0ZQ0C4t5bd9TzuzNmQPkAA5hdnstfoaXbWSScSd8E2
         AAWXDugr5h4oiRVWDWJivRZqal8BJfETICCCnUBzWtmPL+IzM5xNhjTVr43Zz30yZBBo
         S3pYYrOZOr+2BuMKEDWhU0Mx0IVcllhtmuYPovpL+cIVSUYLdVDW60x0X7bVI3/Y/eKl
         VAe0x/XRvJ2AVOkpMbzi9poRtGDom/jpUvHvACv3rBxlnVFXPn+jBblCO9+rqV7vGTTQ
         MZcm7zK43H2WXE5GokncerYwDXo0ZP2sD8H6Lz0IoPGWADZBaPkrWlLx8UiJgsU3NAF/
         Dsmw==
X-Gm-Message-State: AOAM533P8MRnzScNcqWDUg5WqfXdmX6ahvgIE0+AGqk5LZosXCiNRrS6
        Zz5MReRgyk+X3GyNxKxDLUrf71NYsQz0zNQ5
X-Google-Smtp-Source: ABdhPJyA8s3FA0iWDczbp1xfrmWu+bwP/oOHmbDRD7eXNIFWR5BCqMnQzFCky3uE/gd2QlciGs/bFg==
X-Received: by 2002:a17:90b:d90:: with SMTP id bg16mr1734194pjb.199.1601120795999;
        Sat, 26 Sep 2020 04:46:35 -0700 (PDT)
Received: from localhost.localdomain ([124.123.106.26])
        by smtp.gmail.com with ESMTPSA id 72sm5315942pfx.79.2020.09.26.04.46.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Sep 2020 04:46:35 -0700 (PDT)
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v7 0/3]  push: add "--[no-]force-if-includes"
Date:   Sat, 26 Sep 2020 17:16:23 +0530
Message-Id: <20200926114626.28823-1-shrinidhi.kaushik@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200926101324.73457-1-shrinidhi.kaushik@gmail.com>
References: <20200926101324.73457-1-shrinidhi.kaushik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new option: "--force-if-includes" to "git-push" where forced
updates are allowed only if the tip of the remote-tracking ref has
been integrated locally, by verifying if the tip of the remote-tracking
ref -- on which a local branch has based on -- is reachable from at
least one of the "reflog" entries of the branch about to be updated
by force on the remote.

This option can be used with "--force-with-lease" with setups where
the remote-tracking refs of the repository are implicitly updated in
the background to help prevent unintended remote overwrites.

If a local branch is based on a remote ref for a rewrite, and if that
remote-tracking ref is updated by a push from another repository after
it has been checked out locally, force updating that branch to remote
with "--force-with-lease[=<refname>[:<expect>]]" without specifying
the "<expect>" value, can cause the update that happened in-between
the checkout and forced push to be lost.

Changes since v5:
  - In the previous patch, the stopping condition for "reflog"
    iteration used the commit date of the remote ref. That has
    been changed to use the the timestamp of the latest entry
    of the remote ref's "reflog"; calls "in_merge_bases_many()"
    are batched when the number of commits collected in the list
    is more than 8.

  - Add more tests for t5533 to include scenarios where forced
    updates should be allowed for "pull --rebase" and local
    rebase operations.

  - Reword commit messages, fix typos, and update documentation
    to use "`" where necessary.

Changes since v6:
  - Compilation failed because there was an argument missing when
    calling "print_ref_status()"; it has been updated.

Srinidhi Kaushik (3):
  push: add reflog check for "--force-if-includes"
  push: parse and set flag for "--force-if-includes"
  t, doc: update tests, reference for "--force-if-includes"

 Documentation/config/advice.txt |   9 +-
 Documentation/config/push.txt   |   6 ++
 Documentation/git-push.txt      |  26 ++++-
 advice.c                        |   3 +
 advice.h                        |   2 +
 builtin/push.c                  |  27 +++++
 builtin/send-pack.c             |  12 +++
 remote-curl.c                   |  14 ++-
 remote.c                        | 185 ++++++++++++++++++++++++++++++--
 remote.h                        |  12 ++-
 send-pack.c                     |   1 +
 t/t5533-push-cas.sh             | 129 ++++++++++++++++++++++
 transport-helper.c              |  10 ++
 transport.c                     |   8 ++
 transport.h                     |  15 ++-
 15 files changed, 442 insertions(+), 17 deletions(-)

base-commit: 9bc233ae1cf19a49e51842c7959d80a675dbd1c0
--
2.28.0
