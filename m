Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC8171F453
	for <e@80x24.org>; Thu, 25 Oct 2018 16:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbeJZAwC (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 20:52:02 -0400
Received: from mail.ao2.it ([92.243.12.208]:44362 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbeJZAwB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 20:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it; s=20180927;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From; bh=0F5g7p2822Em9BIeSFXV8fwMHvW7XZi5nF1zegsJrvo=;
        b=w2g9Ce1os8XSCodYIMxVHE7arzSM9u9bXr4EVKInFpkiXMWdDjlQweoZs1bBv6p24uFshLiIZ1e8xsTG0g00rvIICXlw4NgUIQeDQyX3t2ErlLSLPCopx5sSPuHELql9iiPNjKkDL6gUBXsFiPme29Ii/EWvfx3OyYUC7Epwr1ot8+qYScpSPRDn6bcYxBTmLASYRADhjFrfbf8X014vbZDh/1XBcIgPA32XvJ4e8UznMWHUpYiXdTmDA4FFX9htV0+FmeGR2jMj2CXcEmGxBLxddurzK4n6YQv2Xgv0XQ0m8hViJ0gJz+rOxp4Z2eXBIo4rhKIq60x2Q+PVZ6nM3g==;
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1gFiKn-0003Kr-PF; Thu, 25 Oct 2018 18:18:09 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1gFiL4-0004V9-VP; Thu, 25 Oct 2018 18:18:26 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Antonio Ospite <ao2@ao2.it>
Subject: [PATCH v7 00/10] Make submodules work if .gitmodules is not checked out
Date:   Thu, 25 Oct 2018 18:18:03 +0200
Message-Id: <20181025161813.17252-1-ao2@ao2.it>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

this series teaches git to try and read the .gitmodules file from the
index (:.gitmodules) or from the current branch (HEAD:.gitmodules) when
the file is not readily available in the working tree.

This can be used, together with sparse checkouts, to enable submodule
usage with programs like vcsh[1] which manage multiple repositories with
their working trees sharing the same path.

[1] https://github.com/RichiH/vcsh

In the previous series there were some comments about not using the enum
in patch 8, but I decided to leave the code as it was as I still think
that it make sense to use an enum there, and have the default value
unnamed; during the discussion I pointed out that other code in git do
the same.

In this series I am addressing the comments by Stefan Beller about the
tests in patch 9.

If the new tests look OK, I'd say we try moving the series to "next" and
see what happens?

I am available to address any further concerns in follow-up patches.

v6 of the series is here:
https://public-inbox.org/git/20181005130601.15879-1-ao2@ao2.it/

v5 of the series is here:
https://public-inbox.org/git/20180917140940.3839-1-ao2@ao2.it/

v4 of the series is here:
https://public-inbox.org/git/20180824132951.8000-1-ao2@ao2.it/

v3 of the series is here:
https://public-inbox.org/git/20180814110525.17801-1-ao2@ao2.it/

v2 of the series is here:
https://public-inbox.org/git/20180802134634.10300-1-ao2@ao2.it/

v1 of the series, with some background info, is here:
https://public-inbox.org/git/20180514105823.8378-1-ao2@ao2.it/

Changes since v6:

  * Renamed t7416-submodule-sparse-gitmodules.sh to
    t7418-submodule-sparse-gitmodules.sh because t7416 was already
    taken.  This has been already taken care of by Junio in "pu".

  * Improved tests in t7418: now, instead of just testing the return
    value of "git submodule ..." commands when .gitmodules is not in the
    working tree, the actual use case is checked in each test, with pre-
    and post-conditions.

Thank you,
   Antonio

Antonio Ospite (10):
  submodule: add a print_config_from_gitmodules() helper
  submodule: factor out a config_set_in_gitmodules_file_gently function
  t7411: merge tests 5 and 6
  t7411: be nicer to future tests and really clean things up
  submodule--helper: add a new 'config' subcommand
  submodule: use the 'submodule--helper config' command
  t7506: clean up .gitmodules properly before setting up new scenario
  submodule: add a helper to check if it is safe to write to .gitmodules
  submodule: support reading .gitmodules when it's not in the working
    tree
  t/helper: add test-submodule-nested-repo-config

 Makefile                                     |   1 +
 builtin/grep.c                               |  17 ++-
 builtin/submodule--helper.c                  |  40 ++++++
 cache.h                                      |   2 +
 git-submodule.sh                             |  13 +-
 submodule-config.c                           |  68 ++++++++-
 submodule-config.h                           |   2 +
 submodule.c                                  |  28 +++-
 submodule.h                                  |   1 +
 t/helper/test-submodule-nested-repo-config.c |  30 ++++
 t/helper/test-tool.c                         |   1 +
 t/helper/test-tool.h                         |   1 +
 t/t7411-submodule-config.sh                  | 141 +++++++++++++++++--
 t/t7418-submodule-sparse-gitmodules.sh       | 122 ++++++++++++++++
 t/t7506-status-submodule.sh                  |   3 +-
 t/t7814-grep-recurse-submodules.sh           |  16 +++
 16 files changed, 454 insertions(+), 32 deletions(-)
 create mode 100644 t/helper/test-submodule-nested-repo-config.c
 create mode 100755 t/t7418-submodule-sparse-gitmodules.sh

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
