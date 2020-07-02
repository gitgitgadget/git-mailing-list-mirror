Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB04CC433DF
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 19:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BBA720780
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 19:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRXx5DXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgGBTYh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 15:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgGBTYh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 15:24:37 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91C0C08C5C1
        for <git@vger.kernel.org>; Thu,  2 Jul 2020 12:24:36 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z3so3656346pfn.12
        for <git@vger.kernel.org>; Thu, 02 Jul 2020 12:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w0EVJC3XiRJNOv8bVIELo+chTBdUV3BX1w/r5pjZjsk=;
        b=pRXx5DXlk7kc9UNRB0OWUuq7Qw27lJkiqgHMShJbCBuqxHchiJfwZaCLt0/EDBzYhU
         aPIWv/Yyw0DHRXaHZ+Gr7a2uWxanOawwh8lGfMUTRsdddg+dghoZjcv2HMlYU8QSh1aW
         RPGTpDPgCZoKrk2f/bmsTdLTJIlJX4uTRkE0duz3YKyxJaV15TPWqk2A/jFpK2E4vNuj
         JTUu0QZYP1u4yXNeXM0PCIriSTbLBDiLSAk59OmYJhleoIw4kMU4iaEdART1dNgxfNud
         4n2Qttubl/GSMfsfLrR1++r/lMpggCawTT3bsor31NUQsSjcGlrsvsAre70pTwDIBaMI
         Hffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w0EVJC3XiRJNOv8bVIELo+chTBdUV3BX1w/r5pjZjsk=;
        b=oxczOJYsPARQnK9NDWmgUeXtmhxtmqvPCLGT0kiYX66aV5KaJ8nEbK7OensIkRh0sG
         OuzLamKBjWieVBEcZQ4/TRyObZ/Edh/KC5eDF14ZQM8kXfdwef5CxOjL0s09m0fi6FED
         omnZftt18Mm6YvdllDrRtrMYByVTmx07g13A7QbjCSTKVwkakVbpfBaJYZ8Qq5r/AwJg
         NMswEgiadqK9R5/F6Kt5ufCyijrycQvf1WRlvMIw2BfRQ05QEzi1awYEpvWWzMysCRbF
         DJ6QL+RgeBQYXk76vfX0YS3HftKSQIBmxYxZ7brvg6MgnoasDFOOpsU52Anp+w3XT43N
         RXoQ==
X-Gm-Message-State: AOAM5305Io3zq6KNeQiBzVuj1kvwdaWjIVf0XBI0oFAf/iAtNCcbj7Hj
        jzDuuCfhK88jERWKfkkEml3VE+qLt1Q=
X-Google-Smtp-Source: ABdhPJxE9X5QRr5dTTs9C/BWvVzkXOS3Mej8QhMU/HG6zWIeYlrZ7VvOFgT/aWwZ04tB6WIzuyoIlw==
X-Received: by 2002:a63:371d:: with SMTP id e29mr25910949pga.153.1593717875757;
        Thu, 02 Jul 2020 12:24:35 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.244])
        by smtp.gmail.com with ESMTPSA id c2sm9266739pgk.77.2020.07.02.12.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 12:24:34 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com,
        liu.denton@gmail.com, kaartic.sivaraam@gmail.com,
        pc44800@gmail.com, sbeller@google.com, pclouds@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [GSoC][PATCH 0/4] submodule: port 'summary' from Shell to C
Date:   Fri,  3 Jul 2020 00:54:05 +0530
Message-Id: <20200702192409.21865-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all!

This is third subcommand in line to be converted as a part of my GSoC
project. The other two were 'set-url' and 'set-branch' both of which
have been merged into Git. This port has been taken off from what
Prathamesh Chavan left as a part of his GSoC project in 2017 under
Stefan Beller and Christian Couder. As written in my proposal and
advised by my mentors Kaartic and Christian, it was decided to re-use
PC's work for multiple reasons.

Here is the link to the v1 of his patch:
https://lore.kernel.org/git/20170731205621.24305-9-pc44800@gmail.com/

Here is the link to the v2 of his patch:
https://lore.kernel.org/git/20170807211900.15001-9-pc44800@gmail.com/

Even though this patch series draws on Prathamesh' work, a lot extra
features had to be added along with some remodelling. A summary of the 4
commits in this patch are as follows: the patch consists of 3
preparatory patches preceding the main commit porting 'git submodule summary'.

Being a bit more verbose about the prepatory patches:

    1. a8dcc59a6a amends an extra linefeed between callback struct(s)
       macro(s) of subcommands 'init', 'status' and 'sync' so as to make
       the whole format of subcommands a bit more uniform and
       consistent.

    2. 5f17ca37e0 renames the helper functions
       'show_submodule_summary()', 'prepare_submodule_summary()' and
       'print_submodule_summary()' used by the 'builtin_diff()' function
       of diff.c This was done so as to avoid any ambiguity later on
       when the helper functions used by 'summary' will be defined in
       the upcoming port. The functions are renamed to
       '*_diff_submodule_summary()' so as to classify them as the one
       being used by the diff machinery.

    3. 5945ab4113 changes the scope of the 'count_lines()' function
       defined in diff.c so as to make it usable by other entities of
       the code. This was originally a patch authored by PC with a small
       change that the function instead of being defined as an 'extern
       int', it is now defined as 'int' since f758a7f8ac4 by Nguyễn Thái
       Ngọc Duy removed extern from the function declarations in diff.h

Now moving on to the main patch 4/4 that will port summary.

    17738e9df4 ports the subcommand summary from Shell to C. I will not
    be repetitive by stating how all the functions communicate since
    this is covered in the commit message. What I will focus on is the
    bits I had to tweak along with any extra functions added. Originally
    the functions were: module_summary(),
    compute_summary_submodule_list(), submodule_summary_callback(),
    prepare_submodule_summary(), generate_submodule_summary(),
    print_submodule_summary() and verify_submodule_object_name. I had to
    add another function called get_diff_cmd() which fetches a const
    char * (a diff-index or a diff-files) in response to the enum provided
    to it and bugs out in case of an unexpected enum value. I also had
    to tweak the enum declared by PC by NOT keeping it static and
    tweaking its definition just a little. These were suggested by
    Christian on PC's patch at the time.

    There were also some changes to function parameters such as those
    of index_fd() by passing the the_index parameter to it or the case
    of submodule_from_path() where it was needed to add another parameter
    of the_repository. This all must have been due to change of function
    defintions in the past 3 years.

    Even after all this, there were two problems: t7418 had been failing
    (something which I feel might have been overlooked/not tested by PC
    during his time) and the CI build failed. First let's cover the test
    failure.

    The main test for testing summary is t7401. t7418 is another test
    which involves sparse checkouts and submodules. The test creates a
    sparse checkout clone excluding the .gitmodules file to test the
    functionality of the '--for-status' option. After quite a thorough
    investigation me, Kaartic and Christian figured out that this port
    fails to handle cases where a gitfile exists instead of a .git dir
    since all the tests in t7401 did not any submodules which were
    cloned in any way but rather just exist in a nearby directory and
    are used in our tests (this is something I feel should be fixed and
    hence I am saving this for later). But anyway, we decided that it
    will be excellent to check for a non-bare repo instead of checking
    for a gitdir therefore replacing the function is_git_directory()
    with is_nonbare_repository() in the first non-nested if-check in
    generate_submodule_summary().

    Regarding the CI failure. The build was failing due to the
    function oidcmp() in the first if-check of
    generate_submodule_summary(). The CI build suggested that we use
    oideq() instead so that the build passes and on doing the change, it
    did!

    There were some other cosmetic changes such as wrapping of
    columns upto 80 chars (to follow the CodingGuidelines) and
    improving some error messages and option descriptions,

Finally, since it was originally PC's work, I have kept him as the author
for the final 2 commits and kept the date as-is (from 2017). This patch
is not perfect and hence needs the feedback from all of you :)

Here is a 'git log --oneline' of the commits:

    17738e9df4 submodule: port submodule subcommand 'summary' from shell to C
    5945ab4113 diff: change scope of the function count_lines()
    5f17ca37e0 submodule: rename helper functions to avoid ambiguity
    a8dcc59a6a submodule: amend extra line feed between callback struct and macro

Thanks,
Shourya Shukla


Prathamesh Chavan (2):
  diff: change scope of the function count_lines()
  submodule: port submodule subcommand 'summary' from shell to C

Shourya Shukla (2):
  submodule: amend extra line feed between callback struct and macro
  submodule: rename helper functions to avoid ambiguity

 builtin/submodule--helper.c | 454 +++++++++++++++++++++++++++++++++++-
 diff.c                      |   4 +-
 diff.h                      |   1 +
 git-submodule.sh            | 186 +--------------
 submodule.c                 |  10 +-
 submodule.h                 |   2 +-
 6 files changed, 461 insertions(+), 196 deletions(-)

-- 
2.27.0

