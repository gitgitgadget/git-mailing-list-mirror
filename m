Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FDEB1FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 23:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932975AbcLTXUT (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 18:20:19 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35033 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932236AbcLTXUT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 18:20:19 -0500
Received: by mail-pg0-f53.google.com with SMTP id i5so12822651pgh.2
        for <git@vger.kernel.org>; Tue, 20 Dec 2016 15:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oVV3iRi6CSY7EWXBFK/RXi+v+b7Xs1hnplhiqqY8iZ8=;
        b=jPPwbNvQAVekCi4+aAIZCTck+3IxINYbZ4jqlJC3KBUvMIeuA1uT6AGpORTmCXIle2
         qTQbZwzQkK8dMwtopZ/A8MbUEuAbMnjpBqJ4vtl4X0u3cmkUptbfN+mmh2LvNOmAMKWK
         akYvIRyoy6XM1ogYoLNVe6JHcmwpuUoASXQiZ2z0bf7L3qhl560c1bhu1z7nyOtWl2Fv
         jLi04id5LPUn9COw0+SAcYPa6Zf+g7ext1friVCDlGntLiIPsVgbd2q7c56S6ZgEQXZG
         4M+NallcCe/y5E18CH9dqSpyMC8u6xsU4tZQCOK7ZKKYfL0a5EiGZUjNOqDG1NJ+5/8U
         gRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oVV3iRi6CSY7EWXBFK/RXi+v+b7Xs1hnplhiqqY8iZ8=;
        b=G3RbwIuVBGaCnNcAxlFU8xZIQzNI+qd9Y3GesZGPzsnXTmAbMlM0OGZygzKoWmwY3b
         t+1IHrSuFkTTl1lnbrRI4WbIJUm0Y93YKm9gpuSA1/jLwrBvYJZAfMKqjh+6BK1If7CA
         GvhiC2h5mS8xaBfqlqcbRXcvdgpIgiP5ntH7LDJVXhhiSPIYDAsMGCiojJ02wZn6AW+e
         Ik2AXK8Ja/g3CdnbsKHus8a6R7IkP5jGdvhdlGfGvImoIDOY4jK5vYKJDvaxnNuiZM4k
         r6PPqA0u+FZ2g96SvrWEAEHCPTVZ2H5mVTWVl4XpsEYWgTlxqVFNSisy77TvzEooMUOM
         ywvw==
X-Gm-Message-State: AIkVDXKxMsZdFQOOBwZK4wG54bYTZLbY1KwZ2xyqZkOdDsxMGdtdZf4Enm8xLtVPW94UGdZq
X-Received: by 10.99.234.21 with SMTP id c21mr2768300pgi.166.1482276018125;
        Tue, 20 Dec 2016 15:20:18 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:6c5b:c771:3806:a807])
        by smtp.gmail.com with ESMTPSA id p68sm41534056pfd.11.2016.12.20.15.20.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Dec 2016 15:20:17 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, David.Turner@twosigma.com,
        sandals@crustytoothpaste.net, j6t@kdbg.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 0/4] git-rm absorbs submodule git directory before deletion
Date:   Tue, 20 Dec 2016 15:20:08 -0800
Message-Id: <20161220232012.15997-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.53.gb7b3fba.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v5:
* removed the patch for adding {run,start,finish}_or_die
* added one more flag to the function ok_to_remove_submodule
  (if die on error is ok)
* renamed ok_to_remove_submodule to bad_to_remove_submodule to signal
  the error case better.

v4:
* reworded commit messages of the last 2 patches
* introduced a new patch introducing {run,start,finish}_command_or_die
* found an existing function in dir.h to use to remove a directory
  which deals gracefully with the cornercases, that Junio pointed out.
  
v3:
* removed the patch to enhance ok_to_remove_submodule to absorb the submodule
  if needed
* Removed all the error reporting from git-rm that was related to submodule
  git directories not absorbed.
* instead just absorb the git repositories or let the absorb function die
  with an appropriate error message.

v2:
* new base where to apply the patch:
  sb/submodule-embed-gitdir merged with sb/t3600-cleanup.
  I got merge conflicts and resolved them this way:
#@@@ -709,9 -687,10 +687,9 @@@ test_expect_success 'checking out a com
#          git commit -m "submodule removal" submod &&
#          git checkout HEAD^ &&
#          git submodule update &&
#-         git checkout -q HEAD^ 2>actual &&
#+         git checkout -q HEAD^ &&
#          git checkout -q master 2>actual &&
# -        echo "warning: unable to rmdir submod: Directory not empty" >expected &&
# -        test_i18ncmp expected actual &&
# +        test_i18ngrep "^warning: unable to rmdir submod:" actual &&
#          git status -s submod >actual &&
#          echo "?? submod/" >expected &&
#          test_cmp expected actual &&
#

* improved commit message in "ok_to_remove_submodule: absorb the submodule git dir"
  (David Turner offered me some advice on how to write better English off list)
* simplified code in last patch:
  -> dropped wrong comment for fallthrough
  -> moved redundant code out of both bodies of an if-clause.
* Fixed last patchs commit message to have "or_die" instead of or_dir.

v1:
The "checkout --recurse-submodules" series got too large to comfortably send
it out for review, so I had to break it up into smaller series'; this is the
first subseries, but it makes sense on its own.

This series teaches git-rm to absorb the git directory of a submodule instead
of failing and complaining about the git directory preventing deletion.

It applies on origin/sb/submodule-embed-gitdir.

Any feedback welcome!

Thanks,
Stefan


Stefan Beller (4):
  submodule.h: add extern keyword to functions
  submodule: modernize ok_to_remove_submodule to use argv_array
  submodule: rename and add flags to ok_to_remove_submodule
  rm: absorb a submodules git dir before deletion

 builtin/rm.c  | 83 +++++++++++++++--------------------------------------------
 submodule.c   | 57 ++++++++++++++++++++++++++--------------
 submodule.h   | 59 ++++++++++++++++++++++++------------------
 t/t3600-rm.sh | 39 +++++++++++-----------------
 4 files changed, 108 insertions(+), 130 deletions(-)

-- 
2.11.0.rc2.53.gb7b3fba.dirty

