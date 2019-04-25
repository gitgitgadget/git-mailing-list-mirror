Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C531A1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 15:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfDYPv1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 11:51:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38478 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfDYPv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 11:51:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so55868pgl.5
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 08:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xVD38Qrh96GxDTWbuwHslwPtydMrBbbBCjJbQugCy4U=;
        b=aRHLx+aKPsWQZvUpt3b/luUd+SlTRy4Xd17F3zMQxpYZnv82lyhztdqRCPHYH05iMP
         J/47etfo7iC1Q8GcYXZpL50Fwak/urZjcbZMX7PFYVu47R7+lr2/E7v9d+aEasj8R91Y
         t8DS4+kyHKX5KfbvGucCtWiTogqwvInmBd5KD8VD2R3w2wluMFtjs66Mmlgp4aH3qPem
         LNu5VS/5JrrzyokdlbBIFKbpIRy2yIlTzw7O2ZXiyTTlxG05bJzcZPBqc7PKK8oi1Mi+
         ryCrhXy5Ro5ZUgoAn9UKB7oYJulXdy36j7WPp3ou+zykU0KXxsiFRukK7bfLPwP8nJRq
         04fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xVD38Qrh96GxDTWbuwHslwPtydMrBbbBCjJbQugCy4U=;
        b=bLKHAzRYE9wpTq+9jfjRTVY01oDGVSbYZ+FnjnWALxRhKkCWmuVwQ1BoVUE5xo/EMJ
         ZqQTNTblDcIw6FO2G4EjyHbEfLqklX8z4oGHvUlhHTxcRtntSiYvGHbUiUGUwC1JKPv5
         hI9PQUADw/xJr7ax+SYWth70a/SrOXgp83Q47ZdEF6o8/cUcqR3UxwA+FMdd06onvsWf
         +FTOz/ldExUA6BZvupaBZcd6Qwc4M82UBjZo62tZ2mV/MWMFWaTna8g2/fO0XTh1rwlU
         gJ0IoE/Fgznj8feP0R1CX9ALwxWWgHF0aMCdqC2rCjAlNo/92mWPqWK8/5vLAO9Ke9iY
         DNwQ==
X-Gm-Message-State: APjAAAVt3+6gPTfQgai+u48/lpfMc9/d7j+oFvlSzj21RypB3Y+zLq17
        Clcacl+xKm6+5HvEBHANsBVRoO8Q
X-Google-Smtp-Source: APXvYqw4wGsyCJWS/7hKFMqVvrevGwpFOZFmpmIrFE80jhfXsv4Q+wNHhF8tv1qslcXh4mLZT/DHBA==
X-Received: by 2002:aa7:9801:: with SMTP id e1mr10018105pfl.252.1556207485923;
        Thu, 25 Apr 2019 08:51:25 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id e6sm15244914pfe.158.2019.04.25.08.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Apr 2019 08:51:25 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/5] Fix and extend encoding handling in fast export/import
Date:   Thu, 25 Apr 2019 08:51:13 -0700
Message-Id: <20190425155118.7918-1-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.782.gb6cebc4909
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While stress testing `git filter-repo`, I noticed an issue with
encoding; further digging led to the fixes and features in this series.
See the individual commit messages for details.

Elijah Newren (5):
  t9350: fix encoding test to actually test reencoding
  fast-import: support 'encoding' commit header
  fast-export: avoid stripping encoding header if we cannot reencode
  fast-export: differentiate between explicitly utf-8 and implicitly
    utf-8
  fast-export: do automatic reencoding of commit messages only if
    requested

 Documentation/git-fast-import.txt |  7 ++++
 builtin/fast-export.c             | 44 ++++++++++++++++++++----
 fast-import.c                     | 12 +++++--
 t/t9300-fast-import.sh            | 20 +++++++++++
 t/t9350-fast-export.sh            | 57 ++++++++++++++++++++++++++-----
 5 files changed, 123 insertions(+), 17 deletions(-)

-- 
2.21.0.779.g2f4b9c5032
