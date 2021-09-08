Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3DCC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 05:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA3C760F6C
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 05:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbhIHFQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 01:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbhIHFQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 01:16:57 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276D4C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 22:15:50 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r2so1316013pgl.10
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 22:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PIqLzY/VCrLAQ/+zc6/6xMI9xHl3bpUi6uzVFQdv03I=;
        b=JmlFRL9ZjASHpCs2bAf1lz5XWniGsl9Z7XmU4Im//jNzYkc/iMF1Ry9REbctC6WnS1
         JBCdlItSSxuj1ktr3ORqVCrIAi0MTE8DLjld4FEgno61p8KTwKlFjVchKMsaXMqJGDdX
         qAAsqcFMF/7giltBhhIOBrlHviggFPsE2xf2hCpsyaz/BgboHYZNx8I04bOILpw+ewFN
         olt5fmN8/+27zuK/2wL3ZnO+IyAMAvIXoAI1Phbwz9HGsgVIsKsgUfsRDUfQUoJVt7Pd
         zoULSP58BfCnpwuXJ46l7LmtW26ynTpkCiQZq/4P8B+lOExTyU0AGpsltROkm9Gzyz8o
         FAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PIqLzY/VCrLAQ/+zc6/6xMI9xHl3bpUi6uzVFQdv03I=;
        b=jlZCah5pqX7i0bLg04n1lF8CJGzQrQynLNty+Dt854ZPcQZu2fmuXC57kPifPI/5ts
         LGO7uWhP1BA/Om3+4GkfttmsbUzywZqP4tpEfHifHeCinuIkFCnlhDQgjQKClsQS+ulE
         igENfl4oh9uAlmTlVh5ag51vVP+6RSnS5AnN1s7/h5g1ZQcw/JjcNATZoX7b3Biti9En
         U93EFKzrHTjZoEvD/8052PRy+X0SSE8huU8YsTOCtQ6QBIf55edDf9Mskd/QC9hFy/c7
         zqmpOcE9+blCD14hb/pW8WSHYgrANkq0oiLtSkW85/scW6t/jyTBNmz6EiZwGDNaDPQR
         UScQ==
X-Gm-Message-State: AOAM533sF5qdfieInvkIWT/KLHSDBnUYisZcdfXCdwnZhIrybix+tSfa
        AHOJm9IwdG2RHdHBKDTiFhNwh5/W9tbOdg==
X-Google-Smtp-Source: ABdhPJypS0WHwH6IcaPdxWaXl+fZklLVBdYzDOhg03IH7IsUKIP7ehauLrLPzygcI977g2w7NrFLrA==
X-Received: by 2002:a62:82c6:0:b0:410:afa1:6028 with SMTP id w189-20020a6282c6000000b00410afa16028mr1961231pfd.35.1631078149352;
        Tue, 07 Sep 2021 22:15:49 -0700 (PDT)
Received: from localhost.localdomain ([74.213.228.209])
        by smtp.gmail.com with ESMTPSA id s200sm745665pfs.89.2021.09.07.22.15.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Sep 2021 22:15:48 -0700 (PDT)
From:   Colin Curtis <colinpcurtis@gmail.com>
X-Google-Original-From: Colin Curtis <colinpcurtis826@ucla.edu>
To:     git@vger.kernel.org
Cc:     Colin Curtis <colinpcurtis@gmail.com>
Subject: [PATCH 0/2] Add cmd_gud and detect libiconv path for Mac OS
Date:   Tue,  7 Sep 2021 22:13:38 -0700
Message-Id: <20210908051340.13332-1-colinpcurtis826@ucla.edu>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Colin Curtis <colinpcurtis@gmail.com>

The gud command opens the Pro Git book webpage in the default
web browser.  The reason to add this command is due to the
play on words when saying 'git gud', which sounds like 'get good'.
Hence this command when invoked will open up the Pro Git 
webpage to allow the user to 'get good' at git.

We also fix a bug in the Makefile when running on Mac OS, namely
the libiconv path when using a brew install for the library.  Previously
the developer would have to manually change the path to the library when
developing on Mac OS.

Colin Curtis (2):
  add cmd_gud to open git-scm.com webpage
  add liconv link for makefile

 .gitignore                |  1 +
 Documentation/git-gud.txt | 33 +++++++++++++++++++++++++++++++++
 Makefile                  |  9 +++++++--
 builtin.h                 |  1 +
 builtin/gud.c             | 27 +++++++++++++++++++++++++++
 git.c                     |  1 +
 t/t9904-git-gud.sh        | 16 ++++++++++++++++
 7 files changed, 86 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/git-gud.txt
 create mode 100644 builtin/gud.c
 create mode 100755 t/t9904-git-gud.sh

-- 
2.30.1 (Apple Git-130)

