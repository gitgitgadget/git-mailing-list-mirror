Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11A8220450
	for <e@80x24.org>; Thu,  2 Nov 2017 06:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbdKBGxA (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 02:53:00 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43655 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbdKBGw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 02:52:59 -0400
Received: by mail-pf0-f193.google.com with SMTP id a8so3901690pfc.0
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 23:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=YM3cHX8aNmyjdCCM1EWhk5BHOZ9nwIvKNj24Yhi2ulk=;
        b=X+rjEvxUYp0yqGhzIr7I66C+Gira1Df0T8+2Ir2HaqmhtojoltyC7ZmM+7yAkRoa9U
         tdYe2U/+pvro9lnOid3iJOxM5YcuxXQv5h6Mgvo+w9CCpPYbpATVwAFbSzP5QKIJz8/O
         A6WnwZVLm/2JyjdZCHtau1q0aGTyes+wND4MZrdQNOI5+8YK9Cd+d6V6kfIQ8m4Hh195
         3SCTRdR8YHxM8wmc9U8Zbd9/SFfEBYSMG8VzG9GgI70ZlLMXUGonFw6IfJlgBXkvfLfB
         u1TGqXyGGF/z4Q3C5y3hPBXNU52rRgxNNKm8QqVd44yB+JEriujf5E5z+W1P9v32vqRw
         sRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=YM3cHX8aNmyjdCCM1EWhk5BHOZ9nwIvKNj24Yhi2ulk=;
        b=NpaqoW7es9yc/1GCEr7Q9FZclzU/r294IMg96c3rghSOULebqnnr3A8Dh9lTPHSkYQ
         5XN0S0JUwTpPH0b6PnS7sebNAt6byRgi0uj4+NcEES3hZtJpB+ZpXJLxh6iJ6j47tFz6
         PYsovOK3pNnz10wT2IYjgN6lHY1K644eu8zLHVOx0fOZMEEMpSLQQAq7BSMiwIM6201L
         euP5DUgyaG45w/vTE8OO/3V5HFCefIzIc1J4WU9cH9RK5bx4w8DfKkAByPQzY5GL2LdI
         fCKTwoQpF652hnA+UDDNrtRG6WP3kD3LazxP8kXuieTniZUlpecJo3lz0hczl3wOjzW1
         YxQw==
X-Gm-Message-State: AMCzsaVHZ6NDCcgjLaPwaAti+dE27rkEg09V4ay9yOkelBRg4Mv4Sa+Q
        7WQiOoiLtfuQ0/rTM3uQwhcR2Vx1
X-Google-Smtp-Source: ABhQp+TdRMRYleJE1EpmAFmCi6dMQmWQPaPeDHJZ2s0rHwaa1+W3hiFAPPQ0FTP1B/k3iKfBdZsFJQ==
X-Received: by 10.99.127.89 with SMTP id p25mr2516793pgn.196.1509605579029;
        Wed, 01 Nov 2017 23:52:59 -0700 (PDT)
Received: from localhost.localdomain ([117.245.109.9])
        by smtp.gmail.com with ESMTPSA id p4sm3879871pga.58.2017.11.01.23.52.55
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Nov 2017 23:52:57 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH v3 0/4] give more useful error messages while renaming branch
Date:   Thu,  2 Nov 2017 12:22:38 +0530
Message-Id: <20171102065242.25299-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.461.gf957c703b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In builtin/branch, the error messages weren't handled directly by the branch
renaming function and was left to the other function. Though this avoids
redundancy this gave unclear error messages in some cases. So, make builtin/branch
give more useful error messages.

Changes in v3:

	Incorporated suggestions from v2 to improve code and commit message. To
	be more precise about the code part,

	In 2/4 slightly re-ordered the parameters to move the flag parameters to
	the end.

	In 3/4, changed the return type of the branchname validation functions to
	be the enum (whose values they return) as suggested by Stefan.

	Dropped the PATCH 3/5 of v2 as there was another series[1] that did the
	refactor and got merged to 'next'. I have now re-rolled the series over
	'next' [pointing at 273055501 (Sync with master, 2017-10-24)].
 
	This has made the code in 3/4 a little clumsy (at least to me) as I
	tried to achieve to achieve what the previous patches did with the new
	validate*_branchname functionS. Let me know, if it looks too bad.

So this could go on top of 'next' without any conflicts but in case I
missed something, let me know. The series could be found in my fork[2].


Any feedback welcome.

Thanks,
Kaartic

[1] : https://public-inbox.org/git/20171013051132.3973-1-gitster@pobox.com

[2] : https://github.com/sivaraam/git/tree/work/branch-revamp


Kaartic Sivaraam (4):
  branch: improve documentation and naming of 'create_branch()'
  branch: re-order function arguments to group related arguments
  branch: introduce dont_fail parameter for branchname validation
  builtin/branch: give more useful error messages when renaming

 branch.c           | 63 ++++++++++++++++++++++++++++++------------------------
 branch.h           | 57 ++++++++++++++++++++++++++++++++++++++----------
 builtin/branch.c   | 49 ++++++++++++++++++++++++++++++++++--------
 builtin/checkout.c | 11 +++++-----
 4 files changed, 127 insertions(+), 53 deletions(-)

-- 
2.15.0.rc2.401.g3db9995f9
