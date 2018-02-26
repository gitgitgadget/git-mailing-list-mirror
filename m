Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 468DD1F576
	for <e@80x24.org>; Mon, 26 Feb 2018 11:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752833AbeBZLsc (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 06:48:32 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34669 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbeBZLsb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 06:48:31 -0500
Received: by mail-wr0-f195.google.com with SMTP id m5so20885550wrg.1
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 03:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=utiH5csSWnTe2cmHU/rjrdRRlRB+lPS1jADxYFnpdxA=;
        b=dYs5+2UtEnyVoJGqursmorHCAVhYwbaIAq6vsODOeutgJoLCtQQZnpt+zOSwFf2f6t
         9IPuyZSpD15m1LrRM9camC76MhNvwYkL7Iz2LKcPD8PuJVRhZdCbZGvkJDoQy8QghVUZ
         wQOlbV3i5iato26aFnQIS4u7az4pM2LW35LT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=utiH5csSWnTe2cmHU/rjrdRRlRB+lPS1jADxYFnpdxA=;
        b=ulMy1wd6ogKnkTMjNDYGQ1c/7pDmuRVJjV7wz9HwKE7+FrUrpF7ezzDm9YeVceh2ak
         zE0/O1sKMQpRHbi6dtFNQA1c3slSGjP1hIbvQz1iHqPisP/qsMLGRvQPrbg31gEanLw8
         G1pfy8EMb5Uap+62P2vK8wPchX/CxslK4gTaPazkS2y8IPSzsulPARWeGJIG+G8+hayc
         WA5P0fctzbiMV5koJP3llxDCPqdqBP7VwhH1yPiLzhi9IWegfd8HzOE7aTO34hKlCcD1
         rSn8b4G+5p+bz4vnAVQukDQmgr1rioFRD465/KdA5ppwYB8+8WUh/fg1+ModYja1yTEl
         Ue3Q==
X-Gm-Message-State: APf1xPB+D6j2IeJ6Gn4TpsqdaFjy7nlbsOXlMi/YN5w0hKGOQmUTmfkf
        kBgAgO+kQScraIxBb47kLmtFo1x/
X-Google-Smtp-Source: AH8x2276mA35Zjyv/jkedaRIUuIjz/6FiPuDlHpjy3LX1IyWk5DYqq9d8WHvQ56oY6hQyoKMzr83uA==
X-Received: by 10.223.138.203 with SMTP id z11mr8759830wrz.199.1519645710435;
        Mon, 26 Feb 2018 03:48:30 -0800 (PST)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id w195sm794768wmw.29.2018.02.26.03.48.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Feb 2018 03:48:29 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH 0/1] git-p4: add format-patch subcommand
Date:   Mon, 26 Feb 2018 11:48:21 +0000
Message-Id: <20180226114822.1617-1-luke@diamand.org>
X-Mailer: git-send-email 2.15.1.272.gc310869385
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an initial attempt to add a "format-patch" command
to git-p4, following on from the earlier discussion about
shelving.

It uses the "p4 describe" command to generate the diff content and
post-processes it enough to generate git-style patches. These
can be fed to tools such as patch, or "git am".

This is useful for "unshelving" a P4 changelist into your git tree,
since the usual git subcommands (sync, clone) cannot easily read
a shelved changelist: there is no good way to get from Perforce
a consistent single revision against which to generate a diff
using git fast-import, since Perforce doesn't have the concept of
a repo revision.

By default, it leaves the depot prefix in the patch, but using
the option "--strip-depot-prefix" makes it suitable for "git am".

Use it like this:

 $ git p4 format-patch 12345 >out.patch

or
 $ mkdir patches
 $ git p4 format-patch --output patches 12345 12346

or
 $ git p4 format-patch --strip-depot-prefix 12347 >out.patch
 $ git am out.patch

Limitations of "p4 describe" mean that this will not work reliably
with binary files. There's no easy way around this. The change makes
a small attempt to at least stop on binary files, but in the case
of a file marked in P4 as "text", which contains binary deltas, the
file will unavoidably come out corrupted.

Luke Diamand (1):
  git-p4: add format-patch subcommand

 Documentation/git-p4.txt |  33 +++++
 git-p4.py                | 304 +++++++++++++++++++++++++++++++++++++++++++++--
 t/t9832-make-patch.sh    | 135 +++++++++++++++++++++
 3 files changed, 462 insertions(+), 10 deletions(-)
 create mode 100755 t/t9832-make-patch.sh

-- 
2.15.1.272.gc310869385

