Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7F871FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 23:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753446AbcLBXnT (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 18:43:19 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36457 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbcLBXnR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 18:43:17 -0500
Received: by mail-pg0-f46.google.com with SMTP id f188so112070326pgc.3
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 15:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=dh81KciqH2pLVGCIqTWPrPFv3KSWQCGVH8JDNrjff+Y=;
        b=j2HQd5nIytGz2jbdgNO6SbkzSF39LzA0dNLXFj9iyeFyN7aPNHDcBygll8996/Rfdv
         AYYCKNnMH5Tdqjky6aF+jSI+zL2D94J4zqDDvUdDpyrHs4oQuWMkdn5U8ujqAYuxN4av
         atkVWhZlvEgXfCu3OXuK/zSMsT9dBBt3SYLxjaxGTWVABZMblj5wFFbdDzy4OzN/6gfc
         JYQRi4tWkJrlBKTSLQEivKpdS+Jvz6CHHq1W15CjkzHQqeQCG+9OzQjT2C8UAfpni+WU
         OmuGcnwhAQ5Oe4G6+d0ybA9dAIq/VyLBbMelQ02gOCa8x/fnR0S7sO7VozmdVFDYhb8e
         lA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dh81KciqH2pLVGCIqTWPrPFv3KSWQCGVH8JDNrjff+Y=;
        b=ToW1lwFHSgA43w+HCO3lKoRMWQaaEm+GiiJcxMPobFDgtsuDsh5qaat6Txizlq9603
         Rx5gDx09XxVBblIv5I4KYAi2ZpaHPuyWx6igCmspNOIIhgJAPxybAPH0ytsWWmPh/Y1L
         DBW+VdGd96p5JT06mnj2a6gIArIrw3ZLIB4rJ3wiMPM5Ue0rpujsDGZMQAWb11FzY0nw
         QHtbDlJdHFP3D2afiyfkKOqVpebus1+JZ+t/4qoIdHugd96D/Dpzs+A85piyiLyi6x9x
         WhOybH4qSQqxGk3iVlDu3Fdw3KDTrIThYMoKFKiM07hisdMj8s1w1EriPZ+1BPtysdTA
         gXVg==
X-Gm-Message-State: AKaTC02UDFSXsy37XzZXNwPdkWyu5wOxbo4I3rjNoe3+YYhkNDyjPEaGB6HoQTNv3GHimve9
X-Received: by 10.84.195.228 with SMTP id j91mr99349233pld.88.1480722144354;
        Fri, 02 Dec 2016 15:42:24 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:99ac:e2be:c532:3e35])
        by smtp.gmail.com with ESMTPSA id t67sm10213183pfg.13.2016.12.02.15.42.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 15:42:23 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com, bmwill@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 0/5] submodule embedgitdirs
Date:   Fri,  2 Dec 2016 15:42:15 -0800
Message-Id: <20161202234220.24664-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.28.g2673dad
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v4:
* rebuilt on top of nd/worktree-list-fixup
* fix and test behavior for un-init submodules (don't crash, rather do nothing)
* incorporated a "static" as pointed out by Ramsay
* use internal functions instead of duplicating code in worktree.c
  (use get_common_dir_noenv for the submodule to actually get the common dir)
* fixed a memory leak in relocate_gitdir 

Stefan Beller (5):
  submodule: use absolute path for computing relative path connecting
  submodule helper: support super prefix
  test-lib-functions.sh: teach test_commit -C <dir>
  worktree: get worktrees from submodules
  submodule: add embed-git-dir function

 Documentation/git-submodule.txt   |  14 ++++++
 builtin/submodule--helper.c       |  91 +++++++++++++++++++++++++++++-----
 dir.c                             |  81 ++++++++++++++++++++++++++++++
 dir.h                             |   4 ++
 git-submodule.sh                  |   7 ++-
 git.c                             |   2 +-
 submodule.c                       |  12 +++--
 t/t7412-submodule-embedgitdirs.sh | 101 ++++++++++++++++++++++++++++++++++++++
 t/test-lib-functions.sh           |  20 ++++++--
 worktree.c                        |  47 ++++++++++++++----
 worktree.h                        |   6 +++
 11 files changed, 352 insertions(+), 33 deletions(-)
 create mode 100755 t/t7412-submodule-embedgitdirs.sh

v3:
* have a slightly more generic function "relocate_gitdir".
  The recursion is strictly related to submodules, though.
* bail out if a submodule is using worktrees.
  This also lays the groundwork for later doing the proper thing,
  as worktree.h offers a function `get_submodule_worktrees(path)`
* nit by duy: use git_path instead of git_common_dir

* diff to v2 (as queued by Junio) below.

v2:
* fixed commit message for patch:
 "submodule: use absolute path for computing relative path connecting"
* a new patch "submodule helper: support super prefix"
* redid the final patch with more tests and fixing bugs along the way
* "test-lib-functions.sh: teach test_commit -C <dir>" unchanged

v1:
The discussion of the submodule checkout series revealed to me that a command
is needed to move the git directory from the submodules working tree to be
embedded into the superprojects git directory.

So I wrote the code to intern the submodules git dir into the superproject,
but whilst writing the code I realized this could be valueable for our use
in testing too. So I exposed it via the submodule--helper. But as the
submodule helper ought to be just an internal API, we could also
offer it via the proper submodule command.

The command as it is has little value to the end user for now, but
breaking it out of the submodule checkout series hopefully makes review easier.

Thanks,
Stefan

-- 
2.11.0.rc2.28.g2673dad

