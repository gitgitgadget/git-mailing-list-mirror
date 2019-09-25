Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E39EE1F463
	for <e@80x24.org>; Wed, 25 Sep 2019 01:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394629AbfIYBkO (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 21:40:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41719 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389596AbfIYBkN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 21:40:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id s1so2254129pgv.8
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 18:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w0lus9lP4KwIlIJ9ISceZLDm6Ba+R9WpyTbizZbtOEU=;
        b=Jvy8eCMKyO+LnirBETO1yFnnGsgXoze0If/zp2xjtZdzvVzzMZ8JecP6B/e2RYX2s+
         aQtl5jpMkI57QvngbXB4GxKuPDb5zW1nKkixY7p+8wW1egHMDtVtv2jLEfFCpLRHoSpu
         upjdOCDWKpzjU2nfLmKitLSIBrx3vEaVY0gX2Q0CLDRXix64C6W6+Ziozv3U+4saRZ67
         PvBZqYhxs9JxQA+hDbRvsxcUP7eskquSwyll/rt7tdwxnuTioK7X+pxdRq4QatOnYE5s
         5dRcM/shkS2VTw705+LMJWRDBWArJne8Ntu3etQIwGjOIFl0V7CkpW0htQO9Wh7l3Nzy
         AF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w0lus9lP4KwIlIJ9ISceZLDm6Ba+R9WpyTbizZbtOEU=;
        b=AeW0lvdFY7khHnfyu5A2eCbFFzy3Rh/8UdEactbzW9xtZa4uj0mNT4b74KolP81wo1
         MVtXnPCs7so/ldfcs+p4D1c6E+c9k1lBeriSPS4cssoUC1Zz2iSRhce4bK71vJT3WsvW
         ZiIArOr9b4MGK5U1lx2T9iFUQF9qaqTIjXoHpcyi9Esfi/th3G09+p0FHnjq7bfXKCeh
         tIc8C4mx3pA6B8RzYAoc4iYuP9DnWX5jnrbO8MuGn+KIrZ+tU+chOfF8bjARNMF358yU
         hhPPRc1zQEs9/J/wtlQG78RPkFTAyqDW8MWnS14c+JZVWE7cvW9qmGJNLN+UUr71c5u1
         UrcQ==
X-Gm-Message-State: APjAAAVBF3l5c8sKp3O6SFpPAtcOJC4TVFJf7oaAKe+I9iofLSze7kqh
        vXWLzf2AY1SJC4jyI/vDSdMWkqBGb6s=
X-Google-Smtp-Source: APXvYqzwTzKqunhnbO6PqzljPs6PzRwYocaiMVQoRh5qWKrb68iVuqV8Zyx5LWc93iPxkvxDAGqxfA==
X-Received: by 2002:a63:4423:: with SMTP id r35mr6274554pga.235.1569375612625;
        Tue, 24 Sep 2019 18:40:12 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id h4sm3759050pgg.81.2019.09.24.18.40.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Sep 2019 18:40:12 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/8] fast export/import: handle nested tags, improve incremental exports
Date:   Tue, 24 Sep 2019 18:39:57 -0700
Message-Id: <20190925014005.17056-1-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.177.g8af0b3ca64
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series improves the incremental export story for fast-export and
fast-import (--export-marks and --import-marks fell a bit short),
fixes a couple small export/import bugs, and enables handling nested
tags.  In particular, the nested tags handling makes it so that
fast-export and fast-import can finally handle the git.git repo.

Elijah Newren (8):
  fast-export: fix exporting a tag and nothing else
  fast-import: fix handling of deleted tags
  fast-import: allow tags to be identified by mark labels
  fast-import: add support for new 'alias' command
  fast-export: add support for --import-marks-if-exists
  fast-export: allow user to request tags be marked with --mark-tags
  t9350: add tests for tags of things other than a commit
  fast-export: handle nested tags

 Documentation/git-fast-export.txt | 17 ++++--
 Documentation/git-fast-import.txt | 23 ++++++++
 builtin/fast-export.c             | 67 ++++++++++++++++------
 fast-import.c                     | 94 +++++++++++++++++++++++++++----
 t/t9300-fast-import.sh            | 37 ++++++++++++
 t/t9350-fast-export.sh            | 68 ++++++++++++++++++++--
 6 files changed, 268 insertions(+), 38 deletions(-)

-- 
2.23.0.177.g8af0b3ca64
