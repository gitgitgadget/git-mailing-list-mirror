Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A822C433E7
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6B84222E8
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="il+OjK9s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731084AbgJSTbr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 15:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbgJSTbr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 15:31:47 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B319C0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 12:31:47 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id y12so1009840wrp.6
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 12:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=cEcqcev5Z6dfMAbUxq8RP22xOvHlWfKfmmdEh0iXPP8=;
        b=il+OjK9sOGZ/QZGrwJqO53oeJshH5nyPXLg/HQ3kmsNDhqyK1rXDQnVLEG+Nub0Fwi
         Gb30gKCXSGUj4NSMMXLcqIXp+Wuq8BBJQIcYT+Kd4Oc+TrJW5jrjCiUhrhwFRCEyaKYz
         JWK++jotO83kojwL7cjxyu33GnaLgpDL1UsIzaiCea63VWOw6PUB7RdqCTCQkzvbGtK1
         StY1Un3rrR1+cxQ20c7Whf7gyGqxmaU+2GV5W/AudBQ9ppL2l8D6aB37SmRjtYYSuY+F
         m/3CFGtfPMdwto7xgzmR3VlnO3UaGgzD6GRAZC+/jIo+JrquvQz663tsOW9vxvvdgMNA
         8jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cEcqcev5Z6dfMAbUxq8RP22xOvHlWfKfmmdEh0iXPP8=;
        b=MPY1wRQWS0+23YdFjivIRIf3DT81xMg70FJEMe2k8bMEFMxVbOXfcFJKuQdIPoKAJ4
         vzDtPc+/k5xX0Zu3v25Xye7aes5QYriGXDrqasuqxhRVbZ1YwlAUsD4RI4TxcqNTxaAW
         IyqR7t1tnr8r3Bpll6+jtYpNjGONmw09D1uJq2eaDOaYWcU3hJxdDvkB7Rnj597wjdeE
         UxiVY/1yavjSPcpQKaWkz3hka12q80tpSqfJIR6BTYCKSWIM5ZUs1UNxAbXyz5UouZ4Q
         oH1ejVIEtgt30G7Fv6JuUMgCo8n7anUqSpTtGUP0+EX+NeoSQjvHyDfa/j8ZA7lsYAhD
         a2rw==
X-Gm-Message-State: AOAM532RGiO5JLWWS0uFDt4ipMsQoWac5iXgs2l6681akXrOnyX+bRIC
        GXtfrCKO+DgtnFHgCKLhYADsOss0eKk=
X-Google-Smtp-Source: ABdhPJxkRP59ML8RLu0jg3/63GCwxm+66imNach3EVBePO5xkJDJ03y+VGqAZxAaYJc5GjbZ4LP/Bw==
X-Received: by 2002:adf:deca:: with SMTP id i10mr895537wrn.96.1603135905257;
        Mon, 19 Oct 2020 12:31:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v11sm632530wml.26.2020.10.19.12.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:31:44 -0700 (PDT)
Message-Id: <pull.758.git.1603135902.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Oct 2020 19:31:31 +0000
Subject: [PATCH 00/10] Prepare for changing the default branch name main (last manual part)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for changing the default of init.defaultBranch to main, here
are a couple of manual adjustments that cannot be automated (i.e., these
adjustments are not mere search-and-replaces).

This patch series is based on js/default-branch-name-part-3, and is part of
the larger effort tracked at https://github.com/gitgitgadget/git/pull/655.

The next patch series will be largely automated search-and-replaces;
Obviously, the search-and-replace was the easy part, the manual inspection
whether the changes are actually correct was much more involved.

What to expect next, after this patch series? Essentially, there is the
large patch series that adjusts the entire test suite, with two patch series
extracted from that effort: t5411 and t5515 simply require too large
patches, and will therefore be presented as the next patch series after this
one.

Johannes Schindelin (10):
  fmt-merge-msg: also suppress "into main" by default
  t9801: use `--` in preparation for default branch rename
  tests: start moving to a different default main branch name
  t4013: prepare for the new default branch name "main"
  t6200: adjust suppression pattern to also match "main"
  t5703: adjust a test case for the upcoming default branch name
  t3200: prepare for `main` being shorter than `master`
  t9902: prepare a test for the upcoming default branch name
  tests: prepare aligned mentions of the default branch name
  t1400: prepare for `main` being default branch name

 fmt-merge-msg.c                               |   4 +-
 refs.c                                        |   5 +-
 t/lib-submodule-update.sh                     |   2 +-
 t/t0001-init.sh                               |  13 +-
 t/t1400-update-ref.sh                         |  10 +-
 t/t3200-branch.sh                             |  16 +-
 t/t3201-branch-contains.sh                    |   8 +-
 t/t3203-branch-output.sh                      |   4 +-
 t/t3205-branch-color.sh                       |   8 +-
 t/t4013-diff-various.sh                       | 177 +++++++++---------
 ...ree_--cc_--patch-with-stat_--summary_main} |   2 +-
 ...iff.diff-tree_--cc_--patch-with-stat_main} |   2 +-
 ...r => diff.diff-tree_--cc_--shortstat_main} |   2 +-
 ...diff.diff-tree_--cc_--stat_--summary_main} |   2 +-
 ...master => diff.diff-tree_--cc_--stat_main} |   2 +-
 ...e_--cc_master => diff.diff-tree_--cc_main} |   2 +-
 ...master => diff.diff-tree_-c_--abbrev_main} |   2 +-
 ...> diff.diff-tree_-c_--stat_--summary_main} |   2 +-
 ...t_master => diff.diff-tree_-c_--stat_main} |   2 +-
 ...-tree_-c_master => diff.diff-tree_-c_main} |   2 +-
 ...-p_-m_master => diff.diff-tree_-p_-m_main} |   2 +-
 t/t4013/diff.diff-tree_-p_main                |   2 +
 t/t4013/diff.diff-tree_-p_master              |   2 -
 t/t4013/diff.diff-tree_main                   |   2 +
 t/t4013/diff.diff-tree_master                 |   2 -
 t/t4013/diff.diff_--dirstat_--cc_main~1_main  |   3 +
 .../diff.diff_--dirstat_--cc_master~1_master  |   3 -
 t/t4013/diff.diff_--dirstat_main~1_main~2     |   3 +
 t/t4013/diff.diff_--dirstat_master~1_master~2 |   3 -
 ...ff.diff_--line-prefix=abc_main_main^_side} |   2 +-
 ...master^_side => diff.diff_main_main^_side} |   2 +-
 ...mat-patch_--attach_--stdout_initial..main} |   2 +-
 ...at-patch_--attach_--stdout_initial..main^} |   2 +-
 ...e_--stdout_--numbered-files_initial..main} |   2 +-
 ...t_--subject-prefix=TESTCASE_initial..main} |   2 +-
 ...mat-patch_--inline_--stdout_initial..main} |   2 +-
 ...at-patch_--inline_--stdout_initial..main^} |   2 +-
 ...t-patch_--inline_--stdout_initial..main^^} |   2 +-
 ...--stdout_--cover-letter_-n_initial..main^} |   2 +-
 ...atch_--stdout_--no-numbered_initial..main} |   2 +-
 ...t-patch_--stdout_--numbered_initial..main} |   2 +-
 ... diff.format-patch_--stdout_initial..main} |   2 +-
 ...diff.format-patch_--stdout_initial..main^} |   2 +-
 t/t4013/diff.log_--decorate=full_--all        |   2 +-
 t/t4013/diff.log_--decorate_--all             |   2 +-
 ..._--diff-merges=off_-p_--first-parent_main} |   2 +-
 ..._--first-parent_--diff-merges=off_-p_main} |   2 +-
 ...g_--no-diff-merges_-p_--first-parent_main} |   2 +-
 ..._--patch-with-stat_--summary_main_--_dir_} |   2 +-
 ...master => diff.log_--patch-with-stat_main} |   2 +-
 ...> diff.log_--patch-with-stat_main_--_dir_} |   2 +-
 ...oot_--cc_--patch-with-stat_--summary_main} |   2 +-
 ...g_--root_--patch-with-stat_--summary_main} |   2 +-
 ...=> diff.log_--root_--patch-with-stat_main} |   2 +-
 ...-root_-c_--patch-with-stat_--summary_main} |   2 +-
 ...root_-p_master => diff.log_--root_-p_main} |   2 +-
 ...log_--root_master => diff.log_--root_main} |   2 +-
 ...ter => diff.log_-GF_-p_--pickaxe-all_main} |   2 +-
 ...log_-GF_-p_master => diff.log_-GF_-p_main} |   2 +-
 ...{diff.log_-SF_master => diff.log_-GF_main} |   2 +-
 ...log_-SF_-p_master => diff.log_-SF_-p_main} |   2 +-
 ...{diff.log_-GF_master => diff.log_-SF_main} |   2 +-
 t/t4013/diff.log_-SF_main_--max-count=0       |   2 +
 ...ount=2 => diff.log_-SF_main_--max-count=1} |   2 +-
 t/t4013/diff.log_-SF_main_--max-count=2       |   7 +
 t/t4013/diff.log_-SF_master_--max-count=0     |   2 -
 t/t4013/diff.log_-SF_master_--max-count=1     |   7 -
 ...iff.log_-S_F_master => diff.log_-S_F_main} |   2 +-
 ...ter => diff.log_-m_-p_--first-parent_main} |   2 +-
 ...f.log_-m_-p_master => diff.log_-m_-p_main} |   2 +-
 ...master => diff.log_-p_--first-parent_main} |   2 +-
 .../{diff.log_-p_master => diff.log_-p_main}  |   2 +-
 t/t4013/{diff.log_master => diff.log_main}    |   2 +-
 ...iff.noellipses-diff-tree_-c_--abbrev_main} |   2 +-
 ...> diff.noellipses-whatchanged_--root_main} |   2 +-
 ...r => diff.noellipses-whatchanged_-SF_main} |   2 +-
 ...aster => diff.noellipses-whatchanged_main} |   2 +-
 ...t_master => diff.show_--first-parent_main} |   2 +-
 ...{diff.show_-c_master => diff.show_-c_main} |   2 +-
 ...{diff.show_-m_master => diff.show_-m_main} |   2 +-
 t/t4013/{diff.show_master => diff.show_main}  |   2 +-
 ..._--patch-with-stat_--summary_main_--_dir_} |   2 +-
 ...> diff.whatchanged_--patch-with-stat_main} |   2 +-
 ...hatchanged_--patch-with-stat_main_--_dir_} |   2 +-
 ...oot_--cc_--patch-with-stat_--summary_main} |   2 +-
 ...d_--root_--patch-with-stat_--summary_main} |   2 +-
 ...whatchanged_--root_--patch-with-stat_main} |   2 +-
 ...-root_-c_--patch-with-stat_--summary_main} |   2 +-
 ...master => diff.whatchanged_--root_-p_main} |   2 +-
 ...ot_master => diff.whatchanged_--root_main} |   2 +-
 ...-p_master => diff.whatchanged_-SF_-p_main} |   2 +-
 ...d_-SF_master => diff.whatchanged_-SF_main} |   2 +-
 ...ged_-p_master => diff.whatchanged_-p_main} |   2 +-
 ...atchanged_master => diff.whatchanged_main} |   2 +-
 t/t5505-remote.sh                             |  30 +--
 t/t5510-fetch.sh                              |   8 +-
 t/t5526-fetch-submodules.sh                   |  70 +++----
 t/t5606-clone-options.sh                      |   3 +
 t/t5703-upload-pack-ref-in-want.sh            |   6 +-
 t/t6200-fmt-merge-msg.sh                      |   2 +-
 t/t6302-for-each-ref-filter.sh                |  24 +--
 t/t9801-git-p4-branch.sh                      |  12 +-
 t/t9902-completion.sh                         |   6 +-
 t/test-lib.sh                                 |   7 +
 104 files changed, 311 insertions(+), 286 deletions(-)
 rename t/t4013/{diff.diff-tree_--cc_--patch-with-stat_--summary_master => diff.diff-tree_--cc_--patch-with-stat_--summary_main} (86%)
 rename t/t4013/{diff.diff-tree_--cc_--patch-with-stat_master => diff.diff-tree_--cc_--patch-with-stat_main} (89%)
 rename t/t4013/{diff.diff-tree_--cc_--shortstat_master => diff.diff-tree_--cc_--shortstat_main} (65%)
 rename t/t4013/{diff.diff-tree_-c_--stat_--summary_master => diff.diff-tree_--cc_--stat_--summary_main} (71%)
 rename t/t4013/{diff.diff-tree_-c_--stat_master => diff.diff-tree_--cc_--stat_main} (76%)
 rename t/t4013/{diff.diff-tree_--cc_master => diff.diff-tree_--cc_main} (91%)
 rename t/t4013/{diff.diff-tree_-c_--abbrev_master => diff.diff-tree_-c_--abbrev_main} (83%)
 rename t/t4013/{diff.diff-tree_--cc_--stat_--summary_master => diff.diff-tree_-c_--stat_--summary_main} (70%)
 rename t/t4013/{diff.diff-tree_--cc_--stat_master => diff.diff-tree_-c_--stat_main} (75%)
 rename t/t4013/{diff.diff-tree_-c_master => diff.diff-tree_-c_main} (93%)
 rename t/t4013/{diff.diff-tree_-p_-m_master => diff.diff-tree_-p_-m_main} (97%)
 create mode 100644 t/t4013/diff.diff-tree_-p_main
 delete mode 100644 t/t4013/diff.diff-tree_-p_master
 create mode 100644 t/t4013/diff.diff-tree_main
 delete mode 100644 t/t4013/diff.diff-tree_master
 create mode 100644 t/t4013/diff.diff_--dirstat_--cc_main~1_main
 delete mode 100644 t/t4013/diff.diff_--dirstat_--cc_master~1_master
 create mode 100644 t/t4013/diff.diff_--dirstat_main~1_main~2
 delete mode 100644 t/t4013/diff.diff_--dirstat_master~1_master~2
 rename t/t4013/{diff.diff_--line-prefix=abc_master_master^_side => diff.diff_--line-prefix=abc_main_main^_side} (87%)
 rename t/t4013/{diff.diff_master_master^_side => diff.diff_main_main^_side} (89%)
 rename t/t4013/{diff.format-patch_--attach_--stdout_initial..master => diff.format-patch_--attach_--stdout_initial..main} (98%)
 rename t/t4013/{diff.format-patch_--attach_--stdout_initial..master^ => diff.format-patch_--attach_--stdout_initial..main^} (97%)
 rename t/t4013/{diff.format-patch_--inline_--stdout_--numbered-files_initial..master => diff.format-patch_--inline_--stdout_--numbered-files_initial..main} (99%)
 rename t/t4013/{diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master => diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..main} (99%)
 rename t/t4013/{diff.format-patch_--inline_--stdout_initial..master => diff.format-patch_--inline_--stdout_initial..main} (98%)
 rename t/t4013/{diff.format-patch_--inline_--stdout_initial..master^ => diff.format-patch_--inline_--stdout_initial..main^} (97%)
 rename t/t4013/{diff.format-patch_--inline_--stdout_initial..master^^ => diff.format-patch_--inline_--stdout_initial..main^^} (95%)
 rename t/t4013/{diff.format-patch_--stdout_--cover-letter_-n_initial..master^ => diff.format-patch_--stdout_--cover-letter_-n_initial..main^} (96%)
 rename t/t4013/{diff.format-patch_--stdout_--no-numbered_initial..master => diff.format-patch_--stdout_--no-numbered_initial..main} (97%)
 rename t/t4013/{diff.format-patch_--stdout_--numbered_initial..master => diff.format-patch_--stdout_--numbered_initial..main} (97%)
 rename t/t4013/{diff.format-patch_--stdout_initial..master => diff.format-patch_--stdout_initial..main} (97%)
 rename t/t4013/{diff.format-patch_--stdout_initial..master^ => diff.format-patch_--stdout_initial..main^} (96%)
 rename t/t4013/{diff.log_--no-diff-merges_-p_--first-parent_master => diff.log_--diff-merges=off_-p_--first-parent_main} (95%)
 rename t/t4013/{diff.log_--first-parent_--diff-merges=off_-p_master => diff.log_--first-parent_--diff-merges=off_-p_main} (95%)
 rename t/t4013/{diff.log_--diff-merges=off_-p_--first-parent_master => diff.log_--no-diff-merges_-p_--first-parent_main} (95%)
 rename t/t4013/{diff.log_--patch-with-stat_--summary_master_--_dir_ => diff.log_--patch-with-stat_--summary_main_--_dir_} (96%)
 rename t/t4013/{diff.log_--patch-with-stat_master => diff.log_--patch-with-stat_main} (98%)
 rename t/t4013/{diff.log_--patch-with-stat_master_--_dir_ => diff.log_--patch-with-stat_main_--_dir_} (96%)
 rename t/t4013/{diff.log_--root_--cc_--patch-with-stat_--summary_master => diff.log_--root_--cc_--patch-with-stat_--summary_main} (98%)
 rename t/t4013/{diff.log_--root_--patch-with-stat_--summary_master => diff.log_--root_--patch-with-stat_--summary_main} (98%)
 rename t/t4013/{diff.log_--root_--patch-with-stat_master => diff.log_--root_--patch-with-stat_main} (98%)
 rename t/t4013/{diff.log_--root_-c_--patch-with-stat_--summary_master => diff.log_--root_-c_--patch-with-stat_--summary_main} (98%)
 rename t/t4013/{diff.log_--root_-p_master => diff.log_--root_-p_main} (98%)
 rename t/t4013/{diff.log_--root_master => diff.log_--root_main} (96%)
 rename t/t4013/{diff.log_-GF_-p_--pickaxe-all_master => diff.log_-GF_-p_--pickaxe-all_main} (90%)
 rename t/t4013/{diff.log_-GF_-p_master => diff.log_-GF_-p_main} (91%)
 rename t/t4013/{diff.log_-SF_master => diff.log_-GF_main} (86%)
 rename t/t4013/{diff.log_-SF_-p_master => diff.log_-SF_-p_main} (91%)
 rename t/t4013/{diff.log_-GF_master => diff.log_-SF_main} (86%)
 create mode 100644 t/t4013/diff.log_-SF_main_--max-count=0
 rename t/t4013/{diff.log_-SF_master_--max-count=2 => diff.log_-SF_main_--max-count=1} (79%)
 create mode 100644 t/t4013/diff.log_-SF_main_--max-count=2
 delete mode 100644 t/t4013/diff.log_-SF_master_--max-count=0
 delete mode 100644 t/t4013/diff.log_-SF_master_--max-count=1
 rename t/t4013/{diff.log_-S_F_master => diff.log_-S_F_main} (86%)
 rename t/t4013/{diff.log_-m_-p_--first-parent_master => diff.log_-m_-p_--first-parent_main} (97%)
 rename t/t4013/{diff.log_-m_-p_master => diff.log_-m_-p_main} (99%)
 rename t/t4013/{diff.log_-p_--first-parent_master => diff.log_-p_--first-parent_main} (97%)
 rename t/t4013/{diff.log_-p_master => diff.log_-p_main} (98%)
 rename t/t4013/{diff.log_master => diff.log_main} (97%)
 rename t/t4013/{diff.noellipses-diff-tree_-c_--abbrev_master => diff.noellipses-diff-tree_-c_--abbrev_main} (81%)
 rename t/t4013/{diff.noellipses-whatchanged_--root_master => diff.noellipses-whatchanged_--root_main} (96%)
 rename t/t4013/{diff.noellipses-whatchanged_-SF_master => diff.noellipses-whatchanged_-SF_main} (86%)
 rename t/t4013/{diff.noellipses-whatchanged_master => diff.noellipses-whatchanged_main} (96%)
 rename t/t4013/{diff.show_--first-parent_master => diff.show_--first-parent_main} (92%)
 rename t/t4013/{diff.show_-c_master => diff.show_-c_main} (95%)
 rename t/t4013/{diff.show_-m_master => diff.show_-m_main} (98%)
 rename t/t4013/{diff.show_master => diff.show_main} (96%)
 rename t/t4013/{diff.whatchanged_--patch-with-stat_--summary_master_--_dir_ => diff.whatchanged_--patch-with-stat_--summary_main_--_dir_} (94%)
 rename t/t4013/{diff.whatchanged_--patch-with-stat_master => diff.whatchanged_--patch-with-stat_main} (97%)
 rename t/t4013/{diff.whatchanged_--patch-with-stat_master_--_dir_ => diff.whatchanged_--patch-with-stat_main_--_dir_} (94%)
 rename t/t4013/{diff.whatchanged_--root_--cc_--patch-with-stat_--summary_master => diff.whatchanged_--root_--cc_--patch-with-stat_--summary_main} (97%)
 rename t/t4013/{diff.whatchanged_--root_--patch-with-stat_--summary_master => diff.whatchanged_--root_--patch-with-stat_--summary_main} (97%)
 rename t/t4013/{diff.whatchanged_--root_--patch-with-stat_master => diff.whatchanged_--root_--patch-with-stat_main} (97%)
 rename t/t4013/{diff.whatchanged_--root_-c_--patch-with-stat_--summary_master => diff.whatchanged_--root_-c_--patch-with-stat_--summary_main} (97%)
 rename t/t4013/{diff.whatchanged_--root_-p_master => diff.whatchanged_--root_-p_main} (98%)
 rename t/t4013/{diff.whatchanged_--root_master => diff.whatchanged_--root_main} (97%)
 rename t/t4013/{diff.whatchanged_-SF_-p_master => diff.whatchanged_-SF_-p_main} (89%)
 rename t/t4013/{diff.whatchanged_-SF_master => diff.whatchanged_-SF_main} (86%)
 rename t/t4013/{diff.whatchanged_-p_master => diff.whatchanged_-p_main} (98%)
 rename t/t4013/{diff.whatchanged_master => diff.whatchanged_main} (97%)


base-commit: 538228ed23a1d5e17e89bb17086d4dda51325bd8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-758%2Fdscho%2Fprepare-for-main-branch-manual-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-758/dscho/prepare-for-main-branch-manual-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/758
-- 
gitgitgadget
