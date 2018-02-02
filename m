Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBD4E1F404
	for <e@80x24.org>; Fri,  2 Feb 2018 04:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbeBBE55 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 23:57:57 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33137 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbeBBE5z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 23:57:55 -0500
Received: by mail-pf0-f195.google.com with SMTP id u15so598299pfa.0
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 20:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gyzUj3n+DMDSnNKA295YHclozlzl3ScVzMnQK3Ei2K8=;
        b=pKQX3VoODY9lERtwCTktCNLorFFNEOCzR36jo32OmD/zTk+cwBysWozTLDuiTrQqAq
         D7ayI7lwNZo//XCw0MJslhvoUlUhu/BjVUuLWZ7hYHcyzZP6V4603hHaV1K5LeBsvyVY
         daGJA4G1DZeR+CGiB+hextRAY4JCDSWDDV8qtGxuFRqEa4cfBzzJSXUCirLjz+cZ6MiZ
         xugf4rKl8Hc8hEuxYjIEet0LZItVPnZar79RJP7SHCZz3j5epd2w9t8lKqxgwc8M0+F3
         C6u3pCMrLsZEbUw9XqGhBUm095Gar280YQUYuNvG7T+moLM6XTI3N57sQ9xeWSA17Fto
         tazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gyzUj3n+DMDSnNKA295YHclozlzl3ScVzMnQK3Ei2K8=;
        b=DNruHUXa5onK6UUmUYVzaKxOtxAACRoYIMV8ZSccx6Xb2/sURWspdB1Svdd0N/FzKb
         7ytyuZEaceXOorXhWxdYbDNCJiMi/LMCQcO3c05OSlkiFyMk1YexWVdQ89BYVKbuNI4k
         SgHH4cbMTALHC+QaK8JRnG9YE3cDpj0YS+3Vzffrb6o7nwTW8dcPWErvfvotIse1IReX
         jY87/vNSJ8scPvtveGcwvh3zo3qAjcsi4+xEhITGRyZ10Gp8ej97HTEx9uYaUrPwuuYx
         iYd9kp6gOVfzfpYPjRb28Zvu9RKpAhX7opDNVWf93Ki9K7C4osKGGvFZbPtgkN5rdoHT
         4Xag==
X-Gm-Message-State: AKwxytdrgfUAiLAmHwRZW+kBUepj7W8SVGoE24+YmL6kmqtqsghWz4wS
        8J9YzvafpGr0vUC4HgcahiSjeqGu
X-Google-Smtp-Source: AH8x227d/CqFJ8OMo0jvwnF/LijOFTp62tIMcuSR0KlS9HwNbfMjVbcRpGvExBTKuSeh1G8hwv+5/w==
X-Received: by 10.101.92.195 with SMTP id b3mr30389320pgt.319.1517547474801;
        Thu, 01 Feb 2018 20:57:54 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.200])
        by smtp.gmail.com with ESMTPSA id e3sm1496467pfb.143.2018.02.01.20.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Feb 2018 20:57:53 -0800 (PST)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, sbeller@google.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [PATCH v1 0/5] Incremental rewrite of git-submodules
Date:   Fri,  2 Feb 2018 10:27:40 +0530
Message-Id: <20180202045745.5076-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.15.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following series of patches focuses on porting submodule subcommand
git-foreach from shell to C.
An initial attempt for porting was introduced about 9 months back,
and since then then patches have undergone many changes. Some of the 
notable discussion thread which I would like to point out is: [1] 
The previous version of this patch series which was floated is
available at: [2].

The following changes were made to that:
* As it was observed in other submodule subcommand's ported function
  that the number of params increased a lot, the variables quiet and 
  recursive, were replaced in the cb_foreach struct with a single
  unsigned integer variable called flags.

* To accomodate the possiblity of a direct call to the functions
  runcommand_in_submodule(), callback function
  runcommand_in_submodule_cb() was introduced.

[1]: https://public-inbox.org/git/20170419170513.16475-1-pc44800@gmail.com/T/#u
[2]: https://public-inbox.org/git/20170807211900.15001-14-pc44800@gmail.com/

As before you can find this series at: 
https://github.com/pratham-pc/git/commits/patch-series-3

And its build report is available at: 
https://travis-ci.org/pratham-pc/git/builds/
Branch: patch-series-3
Build #202

Prathamesh Chavan (5):
  submodule foreach: correct '$path' in nested submodules from a
    subdirectory
  submodule foreach: document '$sm_path' instead of '$path'
  submodule foreach: clarify the '$toplevel' variable documentation
  submodule foreach: document variable '$displaypath'
  submodule: port submodule subcommand 'foreach' from shell to C

 Documentation/git-submodule.txt |  15 ++--
 builtin/submodule--helper.c     | 151 ++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh                |  40 +----------
 t/t7407-submodule-foreach.sh    |  38 +++++++++-
 4 files changed, 197 insertions(+), 47 deletions(-)

-- 
2.15.1

