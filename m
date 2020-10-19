Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181C9C433DF
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96E88223BF
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdFfmDKG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbgJSTby (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 15:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731189AbgJSTbw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 15:31:52 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F209C0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 12:31:52 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x7so1035954wrl.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 12:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vBWpQVP9W9AUH+844xu0esY1mae5vqIGN194ZyBCTpI=;
        b=bdFfmDKGhMp4R/0/hrqtjZeQHO6iev5sDg7buJc7llplQo1HYDEScDJjHL6zdiYJP2
         gq2faHKz8hQcE4yTx01rBzVYsL/gufWT1muKDwEhotISzor8msCdWQ3XUMlPh4hRvqAc
         B9SksV9Nl2kDqenrw67XUt4RfLOq6D0imeJ0X0h/tEXpSY7Pra/Dga3kXZzHbOyFf+Rv
         uXJc8cGL7+cJnp89Cdate+louOR1YsWhmANNiI4Jt+c6BBBMqb5ASzSRAKumYGOuoNJr
         Q3El0lYi5U+9hEP+/ZGnIoQgPTOdFth/Sg0iN5GY57DEHXisK/GVHcmDsAdAZh8fMjMU
         wzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vBWpQVP9W9AUH+844xu0esY1mae5vqIGN194ZyBCTpI=;
        b=l6tSCxcve7eHaueFYAVQk+3FANLwVskFoWuoZJ1kJi0qnBQ8B2L7c8IpkWpjPxz0KB
         KKnqMDqNoC0AXU80+zaWoEpk/7OE3UvbF+LwhpaVSe08OO0aWpslRY+y6amk+Hjcok8N
         eyo699Ow2Sulq1QexqLr+MW7heFdlmXwKVBJvLSkXguu7VwUjTtZZF3OJ/R9p4YflfJr
         Ry8P7VEoENaBlz8Y3ddFDQw2bgDXE+2ebUMGHs8wr9/UMu1OhXYUQ5MWQiLq57Twv8eH
         IZxLnIdWcdPeFSxG1o0bblOkaXQl6w+0XyxlqgQPexxk2s43uOLWSxz2N7Qzt5T2IFJx
         IVsA==
X-Gm-Message-State: AOAM533cjWcLkC4+ZN4mGRJvbYTdU+KP+RQeIPHFYZql4nRYcOEoYW0l
        OtbLOUSye53AVoS7rpTwRHbUqDIBjJU=
X-Google-Smtp-Source: ABdhPJxB644q+yBeM/aHbAYLvIWKyjVJmCraYwIHmKgWN7JaqQR5pBGumiFdHGJCaUWOUIPppSYA/Q==
X-Received: by 2002:a5d:6845:: with SMTP id o5mr802904wrw.87.1603135909306;
        Mon, 19 Oct 2020 12:31:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i10sm995496wrq.27.2020.10.19.12.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:31:48 -0700 (PDT)
Message-Id: <baeb01f70646ce0c7564f1a1f820fb011e124d97.1603135902.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.758.git.1603135902.gitgitgadget@gmail.com>
References: <pull.758.git.1603135902.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Oct 2020 19:31:35 +0000
Subject: [PATCH 04/10] t4013: prepare for the new default branch name "main"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This patch is a bit involved, mainly because the default branch name is
not only hard-coded in the script `t4013-diff-various.sh` itself, and
not only in the support files in `t/t4013/`, but also in the _file
names_ in `t/t4013/`.

The trick to adjust this test script was performed by inserting the
definition GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main at the beginning of
the test script, and then running these commands:

(cd t &&
 sed -i 's/master/main/g' -- \
	$(git grep -l master HEAD -- ./t4013\* | sed 's/HEAD://'))

and

eval "$(git ls-files t/t4013/ | sed -n \
	-e 's/\(.*\)master\(.*\)master\(.*\)/git mv & \1main\2main\3;/p')"

and

eval "$(git ls-files t/t4013/ | sed -n \
	-e 's/\(.*\)master\(.*\)/git mv & \1main\2;/p')"

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
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
 85 files changed, 181 insertions(+), 178 deletions(-)
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

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 5c7b0122b4..1d0ce8de25 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -5,6 +5,9 @@
 
 test_description='Various diff formatting options'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
@@ -60,7 +63,7 @@ test_expect_success setup '
 	GIT_COMMITTER_DATE="2006-06-26 00:04:00 +0000" &&
 	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
 
-	git checkout master &&
+	git checkout main &&
 	git pull -s ours . side &&
 
 	GIT_AUTHOR_DATE="2006-06-26 00:05:00 +0000" &&
@@ -85,7 +88,7 @@ test_expect_success setup '
 	for i in B A; do echo $i; done >dir/sub &&
 	git add dir/sub &&
 	git commit -m "Rearranged lines in dir/sub" &&
-	git checkout master &&
+	git checkout main &&
 
 	GIT_AUTHOR_DATE="2006-06-26 00:06:00 +0000" &&
 	GIT_COMMITTER_DATE="2006-06-26 00:06:00 +0000" &&
@@ -93,7 +96,7 @@ test_expect_success setup '
 	git checkout -b mode initial &&
 	git update-index --chmod=+x file0 &&
 	git commit -m "update mode" &&
-	git checkout -f master &&
+	git checkout -f main &&
 
 	GIT_AUTHOR_DATE="2006-06-26 00:06:00 +0000" &&
 	GIT_COMMITTER_DATE="2006-06-26 00:06:00 +0000" &&
@@ -102,12 +105,12 @@ test_expect_success setup '
 	git update-index --chmod=+x file2 &&
 	git commit -m "update mode (file2)" &&
 	git notes add -m "note" &&
-	git checkout -f master &&
+	git checkout -f main &&
 
-	# Same merge as master, but with parents reversed. Hide it in a
+	# Same merge as main, but with parents reversed. Hide it in a
 	# pseudo-ref to avoid impacting tests with --all.
 	commit=$(echo reverse |
-		 git commit-tree -p master^2 -p master^1 master^{tree}) &&
+		 git commit-tree -p main^2 -p main^1 main^{tree}) &&
 	git update-ref REVERSE $commit &&
 
 	git config diff.renames false &&
@@ -117,15 +120,15 @@ test_expect_success setup '
 
 : <<\EOF
 ! [initial] Initial
- * [master] Merge branch 'side'
+ * [main] Merge branch 'side'
   ! [rearrange] Rearranged lines in dir/sub
    ! [side] Side
 ----
   +  [rearrange] Rearranged lines in dir/sub
- -   [master] Merge branch 'side'
+ -   [main] Merge branch 'side'
  * + [side] Side
- *   [master^] Third
- *   [master~2] Second
+ *   [main^] Third
+ *   [main~2] Second
 +*++ [initial] Initial
 EOF
 
@@ -283,91 +286,91 @@ diff-tree initial mode
 diff-tree --stat initial mode
 diff-tree --summary initial mode
 
-diff-tree master
-diff-tree -p master
-diff-tree -p -m master
-diff-tree -c master
-diff-tree -c --abbrev master
-:noellipses diff-tree -c --abbrev master
-diff-tree --cc master
+diff-tree main
+diff-tree -p main
+diff-tree -p -m main
+diff-tree -c main
+diff-tree -c --abbrev main
+:noellipses diff-tree -c --abbrev main
+diff-tree --cc main
 # stat only should show the diffstat with the first parent
-diff-tree -c --stat master
-diff-tree --cc --stat master
-diff-tree -c --stat --summary master
-diff-tree --cc --stat --summary master
+diff-tree -c --stat main
+diff-tree --cc --stat main
+diff-tree -c --stat --summary main
+diff-tree --cc --stat --summary main
 # stat summary should show the diffstat and summary with the first parent
 diff-tree -c --stat --summary side
 diff-tree --cc --stat --summary side
-diff-tree --cc --shortstat master
+diff-tree --cc --shortstat main
 diff-tree --cc --summary REVERSE
 # improved by Timo's patch
-diff-tree --cc --patch-with-stat master
+diff-tree --cc --patch-with-stat main
 # improved by Timo's patch
-diff-tree --cc --patch-with-stat --summary master
+diff-tree --cc --patch-with-stat --summary main
 # this is correct
 diff-tree --cc --patch-with-stat --summary side
 
-log master
-log -p master
-log --root master
-log --root -p master
-log --patch-with-stat master
-log --root --patch-with-stat master
-log --root --patch-with-stat --summary master
+log main
+log -p main
+log --root main
+log --root -p main
+log --patch-with-stat main
+log --root --patch-with-stat main
+log --root --patch-with-stat --summary main
 # improved by Timo's patch
-log --root -c --patch-with-stat --summary master
+log --root -c --patch-with-stat --summary main
 # improved by Timo's patch
-log --root --cc --patch-with-stat --summary master
-log --no-diff-merges -p --first-parent master
-log --diff-merges=off -p --first-parent master
-log --first-parent --diff-merges=off -p master
-log -p --first-parent master
-log -m -p --first-parent master
-log -m -p master
-log -SF master
-log -S F master
-log -SF -p master
-log -SF master --max-count=0
-log -SF master --max-count=1
-log -SF master --max-count=2
-log -GF master
-log -GF -p master
-log -GF -p --pickaxe-all master
+log --root --cc --patch-with-stat --summary main
+log --no-diff-merges -p --first-parent main
+log --diff-merges=off -p --first-parent main
+log --first-parent --diff-merges=off -p main
+log -p --first-parent main
+log -m -p --first-parent main
+log -m -p main
+log -SF main
+log -S F main
+log -SF -p main
+log -SF main --max-count=0
+log -SF main --max-count=1
+log -SF main --max-count=2
+log -GF main
+log -GF -p main
+log -GF -p --pickaxe-all main
 log --decorate --all
 log --decorate=full --all
 
 rev-list --parents HEAD
 rev-list --children HEAD
 
-whatchanged master
-:noellipses whatchanged master
-whatchanged -p master
-whatchanged --root master
-:noellipses whatchanged --root master
-whatchanged --root -p master
-whatchanged --patch-with-stat master
-whatchanged --root --patch-with-stat master
-whatchanged --root --patch-with-stat --summary master
+whatchanged main
+:noellipses whatchanged main
+whatchanged -p main
+whatchanged --root main
+:noellipses whatchanged --root main
+whatchanged --root -p main
+whatchanged --patch-with-stat main
+whatchanged --root --patch-with-stat main
+whatchanged --root --patch-with-stat --summary main
 # improved by Timo's patch
-whatchanged --root -c --patch-with-stat --summary master
+whatchanged --root -c --patch-with-stat --summary main
 # improved by Timo's patch
-whatchanged --root --cc --patch-with-stat --summary master
-whatchanged -SF master
-:noellipses whatchanged -SF master
-whatchanged -SF -p master
+whatchanged --root --cc --patch-with-stat --summary main
+whatchanged -SF main
+:noellipses whatchanged -SF main
+whatchanged -SF -p main
 
-log --patch-with-stat master -- dir/
-whatchanged --patch-with-stat master -- dir/
-log --patch-with-stat --summary master -- dir/
-whatchanged --patch-with-stat --summary master -- dir/
+log --patch-with-stat main -- dir/
+whatchanged --patch-with-stat main -- dir/
+log --patch-with-stat --summary main -- dir/
+whatchanged --patch-with-stat --summary main -- dir/
 
 show initial
 show --root initial
 show side
-show master
-show -c master
-show -m master
-show --first-parent master
+show main
+show -c main
+show -m main
+show --first-parent main
 show --stat side
 show --stat --summary side
 show --patch-with-stat side
@@ -376,22 +379,22 @@ show --patch-with-raw side
 show --patch-with-stat --summary side
 
 format-patch --stdout initial..side
-format-patch --stdout initial..master^
-format-patch --stdout initial..master
-format-patch --stdout --no-numbered initial..master
-format-patch --stdout --numbered initial..master
+format-patch --stdout initial..main^
+format-patch --stdout initial..main
+format-patch --stdout --no-numbered initial..main
+format-patch --stdout --numbered initial..main
 format-patch --attach --stdout initial..side
 format-patch --attach --stdout --suffix=.diff initial..side
-format-patch --attach --stdout initial..master^
-format-patch --attach --stdout initial..master
+format-patch --attach --stdout initial..main^
+format-patch --attach --stdout initial..main
 format-patch --inline --stdout initial..side
-format-patch --inline --stdout initial..master^
-format-patch --inline --stdout --numbered-files initial..master
-format-patch --inline --stdout initial..master
-format-patch --inline --stdout --subject-prefix=TESTCASE initial..master
+format-patch --inline --stdout initial..main^
+format-patch --inline --stdout --numbered-files initial..main
+format-patch --inline --stdout initial..main
+format-patch --inline --stdout --subject-prefix=TESTCASE initial..main
 config format.subjectprefix DIFFERENT_PREFIX
-format-patch --inline --stdout initial..master^^
-format-patch --stdout --cover-letter -n initial..master^
+format-patch --inline --stdout initial..main^^
+format-patch --stdout --cover-letter -n initial..main^
 
 diff --abbrev initial..side
 diff -U initial..side
@@ -410,13 +413,13 @@ diff --name-status dir2 dir
 diff --no-index --name-status dir2 dir
 diff --no-index --name-status -- dir2 dir
 diff --no-index dir dir3
-diff master master^ side
+diff main main^ side
 # Can't use spaces...
-diff --line-prefix=abc master master^ side
-diff --dirstat master~1 master~2
+diff --line-prefix=abc main main^ side
+diff --dirstat main~1 main~2
 diff --dirstat initial rearrange
 diff --dirstat-by-file initial rearrange
-diff --dirstat --cc master~1 master
+diff --dirstat --cc main~1 main
 # No-index --abbrev and --no-abbrev
 diff --raw initial
 :noellipses diff --raw initial
@@ -469,7 +472,7 @@ test_expect_success 'diff-tree --stdin with log formatting' '
 	Third
 	Second
 	EOF
-	git rev-list master | git diff-tree --stdin --format=%s -s >actual &&
+	git rev-list main | git diff-tree --stdin --format=%s -s >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_master b/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_main
similarity index 86%
rename from t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_master
rename to t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_main
index 9951e3677d..af1cf20f4c 100644
--- a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_main
@@ -1,4 +1,4 @@
-$ git diff-tree --cc --patch-with-stat --summary master
+$ git diff-tree --cc --patch-with-stat --summary main
 59d314ad6f356dd08601a4cd5e530381da3e3c64
  dir/sub | 2 ++
  file0   | 3 +++
diff --git a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_master b/t/t4013/diff.diff-tree_--cc_--patch-with-stat_main
similarity index 89%
rename from t/t4013/diff.diff-tree_--cc_--patch-with-stat_master
rename to t/t4013/diff.diff-tree_--cc_--patch-with-stat_main
index db3c0a7b2c..0ec6042097 100644
--- a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_master
+++ b/t/t4013/diff.diff-tree_--cc_--patch-with-stat_main
@@ -1,4 +1,4 @@
-$ git diff-tree --cc --patch-with-stat master
+$ git diff-tree --cc --patch-with-stat main
 59d314ad6f356dd08601a4cd5e530381da3e3c64
  dir/sub | 2 ++
  file0   | 3 +++
diff --git a/t/t4013/diff.diff-tree_--cc_--shortstat_master b/t/t4013/diff.diff-tree_--cc_--shortstat_main
similarity index 65%
rename from t/t4013/diff.diff-tree_--cc_--shortstat_master
rename to t/t4013/diff.diff-tree_--cc_--shortstat_main
index a4ca42df2a..9a4ef03197 100644
--- a/t/t4013/diff.diff-tree_--cc_--shortstat_master
+++ b/t/t4013/diff.diff-tree_--cc_--shortstat_main
@@ -1,4 +1,4 @@
-$ git diff-tree --cc --shortstat master
+$ git diff-tree --cc --shortstat main
 59d314ad6f356dd08601a4cd5e530381da3e3c64
  2 files changed, 5 insertions(+)
 $
diff --git a/t/t4013/diff.diff-tree_-c_--stat_--summary_master b/t/t4013/diff.diff-tree_--cc_--stat_--summary_main
similarity index 71%
rename from t/t4013/diff.diff-tree_-c_--stat_--summary_master
rename to t/t4013/diff.diff-tree_--cc_--stat_--summary_main
index 81c3021541..9db08a4aa9 100644
--- a/t/t4013/diff.diff-tree_-c_--stat_--summary_master
+++ b/t/t4013/diff.diff-tree_--cc_--stat_--summary_main
@@ -1,4 +1,4 @@
-$ git diff-tree -c --stat --summary master
+$ git diff-tree --cc --stat --summary main
 59d314ad6f356dd08601a4cd5e530381da3e3c64
  dir/sub | 2 ++
  file0   | 3 +++
diff --git a/t/t4013/diff.diff-tree_-c_--stat_master b/t/t4013/diff.diff-tree_--cc_--stat_main
similarity index 76%
rename from t/t4013/diff.diff-tree_-c_--stat_master
rename to t/t4013/diff.diff-tree_--cc_--stat_main
index 89d59b1548..7ecc67a524 100644
--- a/t/t4013/diff.diff-tree_-c_--stat_master
+++ b/t/t4013/diff.diff-tree_--cc_--stat_main
@@ -1,4 +1,4 @@
-$ git diff-tree -c --stat master
+$ git diff-tree --cc --stat main
 59d314ad6f356dd08601a4cd5e530381da3e3c64
  dir/sub | 2 ++
  file0   | 3 +++
diff --git a/t/t4013/diff.diff-tree_--cc_master b/t/t4013/diff.diff-tree_--cc_main
similarity index 91%
rename from t/t4013/diff.diff-tree_--cc_master
rename to t/t4013/diff.diff-tree_--cc_main
index 5ecb4e14ae..1a962856ad 100644
--- a/t/t4013/diff.diff-tree_--cc_master
+++ b/t/t4013/diff.diff-tree_--cc_main
@@ -1,4 +1,4 @@
-$ git diff-tree --cc master
+$ git diff-tree --cc main
 59d314ad6f356dd08601a4cd5e530381da3e3c64
 diff --cc dir/sub
 index cead32e,7289e35..992913c
diff --git a/t/t4013/diff.diff-tree_-c_--abbrev_master b/t/t4013/diff.diff-tree_-c_--abbrev_main
similarity index 83%
rename from t/t4013/diff.diff-tree_-c_--abbrev_master
rename to t/t4013/diff.diff-tree_-c_--abbrev_main
index b8e4aa2530..039d127cf2 100644
--- a/t/t4013/diff.diff-tree_-c_--abbrev_master
+++ b/t/t4013/diff.diff-tree_-c_--abbrev_main
@@ -1,4 +1,4 @@
-$ git diff-tree -c --abbrev master
+$ git diff-tree -c --abbrev main
 59d314ad6f356dd08601a4cd5e530381da3e3c64
 ::100644 100644 100644 cead32e... 7289e35... 992913c... MM	dir/sub
 ::100644 100644 100644 b414108... f4615da... 10a8a9f... MM	file0
diff --git a/t/t4013/diff.diff-tree_--cc_--stat_--summary_master b/t/t4013/diff.diff-tree_-c_--stat_--summary_main
similarity index 70%
rename from t/t4013/diff.diff-tree_--cc_--stat_--summary_master
rename to t/t4013/diff.diff-tree_-c_--stat_--summary_main
index d019867dd9..05a8d16ba7 100644
--- a/t/t4013/diff.diff-tree_--cc_--stat_--summary_master
+++ b/t/t4013/diff.diff-tree_-c_--stat_--summary_main
@@ -1,4 +1,4 @@
-$ git diff-tree --cc --stat --summary master
+$ git diff-tree -c --stat --summary main
 59d314ad6f356dd08601a4cd5e530381da3e3c64
  dir/sub | 2 ++
  file0   | 3 +++
diff --git a/t/t4013/diff.diff-tree_--cc_--stat_master b/t/t4013/diff.diff-tree_-c_--stat_main
similarity index 75%
rename from t/t4013/diff.diff-tree_--cc_--stat_master
rename to t/t4013/diff.diff-tree_-c_--stat_main
index 40b91796b3..61d9f450df 100644
--- a/t/t4013/diff.diff-tree_--cc_--stat_master
+++ b/t/t4013/diff.diff-tree_-c_--stat_main
@@ -1,4 +1,4 @@
-$ git diff-tree --cc --stat master
+$ git diff-tree -c --stat main
 59d314ad6f356dd08601a4cd5e530381da3e3c64
  dir/sub | 2 ++
  file0   | 3 +++
diff --git a/t/t4013/diff.diff-tree_-c_master b/t/t4013/diff.diff-tree_-c_main
similarity index 93%
rename from t/t4013/diff.diff-tree_-c_master
rename to t/t4013/diff.diff-tree_-c_main
index e2d2bb2611..a84e1185cf 100644
--- a/t/t4013/diff.diff-tree_-c_master
+++ b/t/t4013/diff.diff-tree_-c_main
@@ -1,4 +1,4 @@
-$ git diff-tree -c master
+$ git diff-tree -c main
 59d314ad6f356dd08601a4cd5e530381da3e3c64
 ::100644 100644 100644 cead32e925b1420c84c14cbf7cf755e7e45af8ad 7289e35bff32727c08dda207511bec138fdb9ea5 992913c5aa0a5476d10c49ed0f21fc0c6d1aedf3 MM	dir/sub
 ::100644 100644 100644 b414108e81e5091fe0974a1858b4d0d22b107f70 f4615da674c09df322d6ba8d6b21ecfb1b1ba510 10a8a9f3657f91a156b9f0184ed79a20adef9f7f MM	file0
diff --git a/t/t4013/diff.diff-tree_-p_-m_master b/t/t4013/diff.diff-tree_-p_-m_main
similarity index 97%
rename from t/t4013/diff.diff-tree_-p_-m_master
rename to t/t4013/diff.diff-tree_-p_-m_main
index b60bea039d..29c9fc20b8 100644
--- a/t/t4013/diff.diff-tree_-p_-m_master
+++ b/t/t4013/diff.diff-tree_-p_-m_main
@@ -1,4 +1,4 @@
-$ git diff-tree -p -m master
+$ git diff-tree -p -m main
 59d314ad6f356dd08601a4cd5e530381da3e3c64
 diff --git a/dir/sub b/dir/sub
 index cead32e..992913c 100644
diff --git a/t/t4013/diff.diff-tree_-p_main b/t/t4013/diff.diff-tree_-p_main
new file mode 100644
index 0000000000..c658062422
--- /dev/null
+++ b/t/t4013/diff.diff-tree_-p_main
@@ -0,0 +1,2 @@
+$ git diff-tree -p main
+$
diff --git a/t/t4013/diff.diff-tree_-p_master b/t/t4013/diff.diff-tree_-p_master
deleted file mode 100644
index b182875fb2..0000000000
--- a/t/t4013/diff.diff-tree_-p_master
+++ /dev/null
@@ -1,2 +0,0 @@
-$ git diff-tree -p master
-$
diff --git a/t/t4013/diff.diff-tree_main b/t/t4013/diff.diff-tree_main
new file mode 100644
index 0000000000..dc5b9fdeb6
--- /dev/null
+++ b/t/t4013/diff.diff-tree_main
@@ -0,0 +1,2 @@
+$ git diff-tree main
+$
diff --git a/t/t4013/diff.diff-tree_master b/t/t4013/diff.diff-tree_master
deleted file mode 100644
index fe9226f8a1..0000000000
--- a/t/t4013/diff.diff-tree_master
+++ /dev/null
@@ -1,2 +0,0 @@
-$ git diff-tree master
-$
diff --git a/t/t4013/diff.diff_--dirstat_--cc_main~1_main b/t/t4013/diff.diff_--dirstat_--cc_main~1_main
new file mode 100644
index 0000000000..168a357a02
--- /dev/null
+++ b/t/t4013/diff.diff_--dirstat_--cc_main~1_main
@@ -0,0 +1,3 @@
+$ git diff --dirstat --cc main~1 main
+  40.0% dir/
+$
diff --git a/t/t4013/diff.diff_--dirstat_--cc_master~1_master b/t/t4013/diff.diff_--dirstat_--cc_master~1_master
deleted file mode 100644
index fba4e34175..0000000000
--- a/t/t4013/diff.diff_--dirstat_--cc_master~1_master
+++ /dev/null
@@ -1,3 +0,0 @@
-$ git diff --dirstat --cc master~1 master
-  40.0% dir/
-$
diff --git a/t/t4013/diff.diff_--dirstat_main~1_main~2 b/t/t4013/diff.diff_--dirstat_main~1_main~2
new file mode 100644
index 0000000000..6809733708
--- /dev/null
+++ b/t/t4013/diff.diff_--dirstat_main~1_main~2
@@ -0,0 +1,3 @@
+$ git diff --dirstat main~1 main~2
+  40.0% dir/
+$
diff --git a/t/t4013/diff.diff_--dirstat_master~1_master~2 b/t/t4013/diff.diff_--dirstat_master~1_master~2
deleted file mode 100644
index b672e1ca63..0000000000
--- a/t/t4013/diff.diff_--dirstat_master~1_master~2
+++ /dev/null
@@ -1,3 +0,0 @@
-$ git diff --dirstat master~1 master~2
-  40.0% dir/
-$
diff --git a/t/t4013/diff.diff_--line-prefix=abc_master_master^_side b/t/t4013/diff.diff_--line-prefix=abc_main_main^_side
similarity index 87%
rename from t/t4013/diff.diff_--line-prefix=abc_master_master^_side
rename to t/t4013/diff.diff_--line-prefix=abc_main_main^_side
index 99f91e7f0e..67a2145a36 100644
--- a/t/t4013/diff.diff_--line-prefix=abc_master_master^_side
+++ b/t/t4013/diff.diff_--line-prefix=abc_main_main^_side
@@ -1,4 +1,4 @@
-$ git diff --line-prefix=abc master master^ side
+$ git diff --line-prefix=abc main main^ side
 abcdiff --cc dir/sub
 abcindex cead32e,7289e35..992913c
 abc--- a/dir/sub
diff --git a/t/t4013/diff.diff_master_master^_side b/t/t4013/diff.diff_main_main^_side
similarity index 89%
rename from t/t4013/diff.diff_master_master^_side
rename to t/t4013/diff.diff_main_main^_side
index 50ec9cadd6..ab81ec9e47 100644
--- a/t/t4013/diff.diff_master_master^_side
+++ b/t/t4013/diff.diff_main_main^_side
@@ -1,4 +1,4 @@
-$ git diff master master^ side
+$ git diff main main^ side
 diff --cc dir/sub
 index cead32e,7289e35..992913c
 --- a/dir/sub
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..master b/t/t4013/diff.format-patch_--attach_--stdout_initial..main
similarity index 98%
rename from t/t4013/diff.format-patch_--attach_--stdout_initial..master
rename to t/t4013/diff.format-patch_--attach_--stdout_initial..main
index 52fedc179e..9f56380350 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..main
@@ -1,4 +1,4 @@
-$ git format-patch --attach --stdout initial..master
+$ git format-patch --attach --stdout initial..main
 From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
 From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:01:00 +0000
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..master^ b/t/t4013/diff.format-patch_--attach_--stdout_initial..main^
similarity index 97%
rename from t/t4013/diff.format-patch_--attach_--stdout_initial..master^
rename to t/t4013/diff.format-patch_--attach_--stdout_initial..main^
index 1c3cde251b..80132ea99e 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..main^
@@ -1,4 +1,4 @@
-$ git format-patch --attach --stdout initial..master^
+$ git format-patch --attach --stdout initial..main^
 From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
 From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:01:00 +0000
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_initial..master b/t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_initial..main
similarity index 99%
rename from t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_initial..master
rename to t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_initial..main
index 02c4db7ec5..8e889090fb 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_initial..master
+++ b/t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_initial..main
@@ -1,4 +1,4 @@
-$ git format-patch --inline --stdout --numbered-files initial..master
+$ git format-patch --inline --stdout --numbered-files initial..main
 From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
 From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:01:00 +0000
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master b/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..main
similarity index 99%
rename from t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master
rename to t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..main
index c7677c5951..d7d2b12d15 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master
+++ b/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..main
@@ -1,4 +1,4 @@
-$ git format-patch --inline --stdout --subject-prefix=TESTCASE initial..master
+$ git format-patch --inline --stdout --subject-prefix=TESTCASE initial..main
 From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
 From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:01:00 +0000
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..master b/t/t4013/diff.format-patch_--inline_--stdout_initial..main
similarity index 98%
rename from t/t4013/diff.format-patch_--inline_--stdout_initial..master
rename to t/t4013/diff.format-patch_--inline_--stdout_initial..main
index 5b3e34e2c0..c49c423f82 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..main
@@ -1,4 +1,4 @@
-$ git format-patch --inline --stdout initial..master
+$ git format-patch --inline --stdout initial..main
 From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
 From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:01:00 +0000
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^ b/t/t4013/diff.format-patch_--inline_--stdout_initial..main^
similarity index 97%
rename from t/t4013/diff.format-patch_--inline_--stdout_initial..master^
rename to t/t4013/diff.format-patch_--inline_--stdout_initial..main^
index d13f8a8128..8669dbfe6c 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..main^
@@ -1,4 +1,4 @@
-$ git format-patch --inline --stdout initial..master^
+$ git format-patch --inline --stdout initial..main^
 From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
 From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:01:00 +0000
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^ b/t/t4013/diff.format-patch_--inline_--stdout_initial..main^^
similarity index 95%
rename from t/t4013/diff.format-patch_--inline_--stdout_initial..master^^
rename to t/t4013/diff.format-patch_--inline_--stdout_initial..main^^
index caec5537de..b749be58b0 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..main^^
@@ -1,4 +1,4 @@
-$ git format-patch --inline --stdout initial..master^^
+$ git format-patch --inline --stdout initial..main^^
 From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
 From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:01:00 +0000
diff --git a/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..main^
similarity index 96%
rename from t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^
rename to t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..main^
index 244d964fc6..567f222198 100644
--- a/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^
+++ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..main^
@@ -1,4 +1,4 @@
-$ git format-patch --stdout --cover-letter -n initial..master^
+$ git format-patch --stdout --cover-letter -n initial..main^
 From 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0 Mon Sep 17 00:00:00 2001
 From: C O Mitter <committer@example.com>
 Date: Mon, 26 Jun 2006 00:06:00 +0000
diff --git a/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..master b/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..main
similarity index 97%
rename from t/t4013/diff.format-patch_--stdout_--no-numbered_initial..master
rename to t/t4013/diff.format-patch_--stdout_--no-numbered_initial..main
index bfc287a147..195b62ea4f 100644
--- a/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..master
+++ b/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..main
@@ -1,4 +1,4 @@
-$ git format-patch --stdout --no-numbered initial..master
+$ git format-patch --stdout --no-numbered initial..main
 From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
 From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:01:00 +0000
diff --git a/t/t4013/diff.format-patch_--stdout_--numbered_initial..master b/t/t4013/diff.format-patch_--stdout_--numbered_initial..main
similarity index 97%
rename from t/t4013/diff.format-patch_--stdout_--numbered_initial..master
rename to t/t4013/diff.format-patch_--stdout_--numbered_initial..main
index 568f6f584e..0678a38515 100644
--- a/t/t4013/diff.format-patch_--stdout_--numbered_initial..master
+++ b/t/t4013/diff.format-patch_--stdout_--numbered_initial..main
@@ -1,4 +1,4 @@
-$ git format-patch --stdout --numbered initial..master
+$ git format-patch --stdout --numbered initial..main
 From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
 From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:01:00 +0000
diff --git a/t/t4013/diff.format-patch_--stdout_initial..master b/t/t4013/diff.format-patch_--stdout_initial..main
similarity index 97%
rename from t/t4013/diff.format-patch_--stdout_initial..master
rename to t/t4013/diff.format-patch_--stdout_initial..main
index 5f0352f9f7..b4a6302e7c 100644
--- a/t/t4013/diff.format-patch_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--stdout_initial..main
@@ -1,4 +1,4 @@
-$ git format-patch --stdout initial..master
+$ git format-patch --stdout initial..main
 From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
 From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:01:00 +0000
diff --git a/t/t4013/diff.format-patch_--stdout_initial..master^ b/t/t4013/diff.format-patch_--stdout_initial..main^
similarity index 96%
rename from t/t4013/diff.format-patch_--stdout_initial..master^
rename to t/t4013/diff.format-patch_--stdout_initial..main^
index 2ae454d807..36b3221582 100644
--- a/t/t4013/diff.format-patch_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--stdout_initial..main^
@@ -1,4 +1,4 @@
-$ git format-patch --stdout initial..master^
+$ git format-patch --stdout initial..main^
 From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
 From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:01:00 +0000
diff --git a/t/t4013/diff.log_--decorate=full_--all b/t/t4013/diff.log_--decorate=full_--all
index 3f9b872ece..7cfd2ea22d 100644
--- a/t/t4013/diff.log_--decorate=full_--all
+++ b/t/t4013/diff.log_--decorate=full_--all
@@ -26,7 +26,7 @@ Date:   Mon Jun 26 00:06:00 2006 +0000
 
     Notes added by 'git notes add'
 
-commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> refs/heads/master)
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> refs/heads/main)
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
diff --git a/t/t4013/diff.log_--decorate_--all b/t/t4013/diff.log_--decorate_--all
index f5e20e1e14..735f1aa83c 100644
--- a/t/t4013/diff.log_--decorate_--all
+++ b/t/t4013/diff.log_--decorate_--all
@@ -26,7 +26,7 @@ Date:   Mon Jun 26 00:06:00 2006 +0000
 
     Notes added by 'git notes add'
 
-commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> master)
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> main)
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
diff --git a/t/t4013/diff.log_--no-diff-merges_-p_--first-parent_master b/t/t4013/diff.log_--diff-merges=off_-p_--first-parent_main
similarity index 95%
rename from t/t4013/diff.log_--no-diff-merges_-p_--first-parent_master
rename to t/t4013/diff.log_--diff-merges=off_-p_--first-parent_main
index 597002232e..fe180fda3b 100644
--- a/t/t4013/diff.log_--no-diff-merges_-p_--first-parent_master
+++ b/t/t4013/diff.log_--diff-merges=off_-p_--first-parent_main
@@ -1,4 +1,4 @@
-$ git log --no-diff-merges -p --first-parent master
+$ git log --diff-merges=off -p --first-parent main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--first-parent_--diff-merges=off_-p_master b/t/t4013/diff.log_--first-parent_--diff-merges=off_-p_main
similarity index 95%
rename from t/t4013/diff.log_--first-parent_--diff-merges=off_-p_master
rename to t/t4013/diff.log_--first-parent_--diff-merges=off_-p_main
index 5d7461a167..dca62d4e60 100644
--- a/t/t4013/diff.log_--first-parent_--diff-merges=off_-p_master
+++ b/t/t4013/diff.log_--first-parent_--diff-merges=off_-p_main
@@ -1,4 +1,4 @@
-$ git log --first-parent --diff-merges=off -p master
+$ git log --first-parent --diff-merges=off -p main
 commit 80e25ffa65bcdbe82ef654b4d06dbbde7945c37f
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--diff-merges=off_-p_--first-parent_master b/t/t4013/diff.log_--no-diff-merges_-p_--first-parent_main
similarity index 95%
rename from t/t4013/diff.log_--diff-merges=off_-p_--first-parent_master
rename to t/t4013/diff.log_--no-diff-merges_-p_--first-parent_main
index 194e893c94..0b54118088 100644
--- a/t/t4013/diff.log_--diff-merges=off_-p_--first-parent_master
+++ b/t/t4013/diff.log_--no-diff-merges_-p_--first-parent_main
@@ -1,4 +1,4 @@
-$ git log --diff-merges=off -p --first-parent master
+$ git log --no-diff-merges -p --first-parent main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_ b/t/t4013/diff.log_--patch-with-stat_--summary_main_--_dir_
similarity index 96%
rename from t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
rename to t/t4013/diff.log_--patch-with-stat_--summary_main_--_dir_
index a18f1472a9..3ed46cc867 100644
--- a/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
+++ b/t/t4013/diff.log_--patch-with-stat_--summary_main_--_dir_
@@ -1,4 +1,4 @@
-$ git log --patch-with-stat --summary master -- dir/
+$ git log --patch-with-stat --summary main -- dir/
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--patch-with-stat_master b/t/t4013/diff.log_--patch-with-stat_main
similarity index 98%
rename from t/t4013/diff.log_--patch-with-stat_master
rename to t/t4013/diff.log_--patch-with-stat_main
index ae425c4672..2e12b557cb 100644
--- a/t/t4013/diff.log_--patch-with-stat_master
+++ b/t/t4013/diff.log_--patch-with-stat_main
@@ -1,4 +1,4 @@
-$ git log --patch-with-stat master
+$ git log --patch-with-stat main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--patch-with-stat_master_--_dir_ b/t/t4013/diff.log_--patch-with-stat_main_--_dir_
similarity index 96%
rename from t/t4013/diff.log_--patch-with-stat_master_--_dir_
rename to t/t4013/diff.log_--patch-with-stat_main_--_dir_
index d5207cadf4..d511ea7f6b 100644
--- a/t/t4013/diff.log_--patch-with-stat_master_--_dir_
+++ b/t/t4013/diff.log_--patch-with-stat_main_--_dir_
@@ -1,4 +1,4 @@
-$ git log --patch-with-stat master -- dir/
+$ git log --patch-with-stat main -- dir/
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master b/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_main
similarity index 98%
rename from t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
rename to t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_main
index 0fc1e8cd71..3cfd0e6422 100644
--- a/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_main
@@ -1,4 +1,4 @@
-$ git log --root --cc --patch-with-stat --summary master
+$ git log --root --cc --patch-with-stat --summary main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--root_--patch-with-stat_--summary_master b/t/t4013/diff.log_--root_--patch-with-stat_--summary_main
similarity index 98%
rename from t/t4013/diff.log_--root_--patch-with-stat_--summary_master
rename to t/t4013/diff.log_--root_--patch-with-stat_--summary_main
index dffc09dde9..9f4d6dfa44 100644
--- a/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.log_--root_--patch-with-stat_--summary_main
@@ -1,4 +1,4 @@
-$ git log --root --patch-with-stat --summary master
+$ git log --root --patch-with-stat --summary main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--root_--patch-with-stat_master b/t/t4013/diff.log_--root_--patch-with-stat_main
similarity index 98%
rename from t/t4013/diff.log_--root_--patch-with-stat_master
rename to t/t4013/diff.log_--root_--patch-with-stat_main
index 55aa98012d..0d69ae2e11 100644
--- a/t/t4013/diff.log_--root_--patch-with-stat_master
+++ b/t/t4013/diff.log_--root_--patch-with-stat_main
@@ -1,4 +1,4 @@
-$ git log --root --patch-with-stat master
+$ git log --root --patch-with-stat main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master b/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_main
similarity index 98%
rename from t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
rename to t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_main
index 019d85f7de..1b71add9de 100644
--- a/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_main
@@ -1,4 +1,4 @@
-$ git log --root -c --patch-with-stat --summary master
+$ git log --root -c --patch-with-stat --summary main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--root_-p_master b/t/t4013/diff.log_--root_-p_main
similarity index 98%
rename from t/t4013/diff.log_--root_-p_master
rename to t/t4013/diff.log_--root_-p_main
index b42c334439..04581296ed 100644
--- a/t/t4013/diff.log_--root_-p_master
+++ b/t/t4013/diff.log_--root_-p_main
@@ -1,4 +1,4 @@
-$ git log --root -p master
+$ git log --root -p main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--root_master b/t/t4013/diff.log_--root_main
similarity index 96%
rename from t/t4013/diff.log_--root_master
rename to t/t4013/diff.log_--root_main
index e8f46159da..d5e90fd6b4 100644
--- a/t/t4013/diff.log_--root_master
+++ b/t/t4013/diff.log_--root_main
@@ -1,4 +1,4 @@
-$ git log --root master
+$ git log --root main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_-GF_-p_--pickaxe-all_master b/t/t4013/diff.log_-GF_-p_--pickaxe-all_main
similarity index 90%
rename from t/t4013/diff.log_-GF_-p_--pickaxe-all_master
rename to t/t4013/diff.log_-GF_-p_--pickaxe-all_main
index d36f88098b..1f7a497c2d 100644
--- a/t/t4013/diff.log_-GF_-p_--pickaxe-all_master
+++ b/t/t4013/diff.log_-GF_-p_--pickaxe-all_main
@@ -1,4 +1,4 @@
-$ git log -GF -p --pickaxe-all master
+$ git log -GF -p --pickaxe-all main
 commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
diff --git a/t/t4013/diff.log_-GF_-p_master b/t/t4013/diff.log_-GF_-p_main
similarity index 91%
rename from t/t4013/diff.log_-GF_-p_master
rename to t/t4013/diff.log_-GF_-p_main
index 9d93f2c23a..c80dda41e9 100644
--- a/t/t4013/diff.log_-GF_-p_master
+++ b/t/t4013/diff.log_-GF_-p_main
@@ -1,4 +1,4 @@
-$ git log -GF -p master
+$ git log -GF -p main
 commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
diff --git a/t/t4013/diff.log_-SF_master b/t/t4013/diff.log_-GF_main
similarity index 86%
rename from t/t4013/diff.log_-SF_master
rename to t/t4013/diff.log_-GF_main
index c1599f2f52..b94a7f7839 100644
--- a/t/t4013/diff.log_-SF_master
+++ b/t/t4013/diff.log_-GF_main
@@ -1,4 +1,4 @@
-$ git log -SF master
+$ git log -GF main
 commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
diff --git a/t/t4013/diff.log_-SF_-p_master b/t/t4013/diff.log_-SF_-p_main
similarity index 91%
rename from t/t4013/diff.log_-SF_-p_master
rename to t/t4013/diff.log_-SF_-p_main
index 5e32438972..fa82ac1490 100644
--- a/t/t4013/diff.log_-SF_-p_master
+++ b/t/t4013/diff.log_-SF_-p_main
@@ -1,4 +1,4 @@
-$ git log -SF -p master
+$ git log -SF -p main
 commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
diff --git a/t/t4013/diff.log_-GF_master b/t/t4013/diff.log_-SF_main
similarity index 86%
rename from t/t4013/diff.log_-GF_master
rename to t/t4013/diff.log_-SF_main
index 4c6708d2d0..dbf770db49 100644
--- a/t/t4013/diff.log_-GF_master
+++ b/t/t4013/diff.log_-SF_main
@@ -1,4 +1,4 @@
-$ git log -GF master
+$ git log -SF main
 commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
diff --git a/t/t4013/diff.log_-SF_main_--max-count=0 b/t/t4013/diff.log_-SF_main_--max-count=0
new file mode 100644
index 0000000000..683b17eb99
--- /dev/null
+++ b/t/t4013/diff.log_-SF_main_--max-count=0
@@ -0,0 +1,2 @@
+$ git log -SF main --max-count=0
+$
diff --git a/t/t4013/diff.log_-SF_master_--max-count=2 b/t/t4013/diff.log_-SF_main_--max-count=1
similarity index 79%
rename from t/t4013/diff.log_-SF_master_--max-count=2
rename to t/t4013/diff.log_-SF_main_--max-count=1
index a6c55fd482..2102426f8c 100644
--- a/t/t4013/diff.log_-SF_master_--max-count=2
+++ b/t/t4013/diff.log_-SF_main_--max-count=1
@@ -1,4 +1,4 @@
-$ git log -SF master --max-count=2
+$ git log -SF main --max-count=1
 commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
diff --git a/t/t4013/diff.log_-SF_main_--max-count=2 b/t/t4013/diff.log_-SF_main_--max-count=2
new file mode 100644
index 0000000000..23e12a4cbb
--- /dev/null
+++ b/t/t4013/diff.log_-SF_main_--max-count=2
@@ -0,0 +1,7 @@
+$ git log -SF main --max-count=2
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:02:00 2006 +0000
+
+    Third
+$
diff --git a/t/t4013/diff.log_-SF_master_--max-count=0 b/t/t4013/diff.log_-SF_master_--max-count=0
deleted file mode 100644
index c1fc6c8731..0000000000
--- a/t/t4013/diff.log_-SF_master_--max-count=0
+++ /dev/null
@@ -1,2 +0,0 @@
-$ git log -SF master --max-count=0
-$
diff --git a/t/t4013/diff.log_-SF_master_--max-count=1 b/t/t4013/diff.log_-SF_master_--max-count=1
deleted file mode 100644
index c981a03814..0000000000
--- a/t/t4013/diff.log_-SF_master_--max-count=1
+++ /dev/null
@@ -1,7 +0,0 @@
-$ git log -SF master --max-count=1
-commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
-Author: A U Thor <author@example.com>
-Date:   Mon Jun 26 00:02:00 2006 +0000
-
-    Third
-$
diff --git a/t/t4013/diff.log_-S_F_master b/t/t4013/diff.log_-S_F_main
similarity index 86%
rename from t/t4013/diff.log_-S_F_master
rename to t/t4013/diff.log_-S_F_main
index 978d2b4118..a75a42e143 100644
--- a/t/t4013/diff.log_-S_F_master
+++ b/t/t4013/diff.log_-S_F_main
@@ -1,4 +1,4 @@
-$ git log -S F master
+$ git log -S F main
 commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
diff --git a/t/t4013/diff.log_-m_-p_--first-parent_master b/t/t4013/diff.log_-m_-p_--first-parent_main
similarity index 97%
rename from t/t4013/diff.log_-m_-p_--first-parent_master
rename to t/t4013/diff.log_-m_-p_--first-parent_main
index 7a0073f529..459e10786b 100644
--- a/t/t4013/diff.log_-m_-p_--first-parent_master
+++ b/t/t4013/diff.log_-m_-p_--first-parent_main
@@ -1,4 +1,4 @@
-$ git log -m -p --first-parent master
+$ git log -m -p --first-parent main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_-m_-p_master b/t/t4013/diff.log_-m_-p_main
similarity index 99%
rename from t/t4013/diff.log_-m_-p_master
rename to t/t4013/diff.log_-m_-p_main
index 9ca62a01ed..07453c5698 100644
--- a/t/t4013/diff.log_-m_-p_master
+++ b/t/t4013/diff.log_-m_-p_main
@@ -1,4 +1,4 @@
-$ git log -m -p master
+$ git log -m -p main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (from 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0)
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_-p_--first-parent_master b/t/t4013/diff.log_-p_--first-parent_main
similarity index 97%
rename from t/t4013/diff.log_-p_--first-parent_master
rename to t/t4013/diff.log_-p_--first-parent_main
index 28840ebea1..247980817b 100644
--- a/t/t4013/diff.log_-p_--first-parent_master
+++ b/t/t4013/diff.log_-p_--first-parent_main
@@ -1,4 +1,4 @@
-$ git log -p --first-parent master
+$ git log -p --first-parent main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_-p_master b/t/t4013/diff.log_-p_main
similarity index 98%
rename from t/t4013/diff.log_-p_master
rename to t/t4013/diff.log_-p_main
index bf1326dc36..c82b4dbf16 100644
--- a/t/t4013/diff.log_-p_master
+++ b/t/t4013/diff.log_-p_main
@@ -1,4 +1,4 @@
-$ git log -p master
+$ git log -p main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_master b/t/t4013/diff.log_main
similarity index 97%
rename from t/t4013/diff.log_master
rename to t/t4013/diff.log_main
index a8f6ce5abd..50401f73e6 100644
--- a/t/t4013/diff.log_master
+++ b/t/t4013/diff.log_main
@@ -1,4 +1,4 @@
-$ git log master
+$ git log main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.noellipses-diff-tree_-c_--abbrev_master b/t/t4013/diff.noellipses-diff-tree_-c_--abbrev_main
similarity index 81%
rename from t/t4013/diff.noellipses-diff-tree_-c_--abbrev_master
rename to t/t4013/diff.noellipses-diff-tree_-c_--abbrev_main
index bb80f013b3..3aa1f80af3 100644
--- a/t/t4013/diff.noellipses-diff-tree_-c_--abbrev_master
+++ b/t/t4013/diff.noellipses-diff-tree_-c_--abbrev_main
@@ -1,4 +1,4 @@
-$ git diff-tree -c --abbrev master
+$ git diff-tree -c --abbrev main
 59d314ad6f356dd08601a4cd5e530381da3e3c64
 ::100644 100644 100644 cead32e 7289e35 992913c MM	dir/sub
 ::100644 100644 100644 b414108 f4615da 10a8a9f MM	file0
diff --git a/t/t4013/diff.noellipses-whatchanged_--root_master b/t/t4013/diff.noellipses-whatchanged_--root_main
similarity index 96%
rename from t/t4013/diff.noellipses-whatchanged_--root_master
rename to t/t4013/diff.noellipses-whatchanged_--root_main
index c2cfd4e729..2bec055835 100644
--- a/t/t4013/diff.noellipses-whatchanged_--root_master
+++ b/t/t4013/diff.noellipses-whatchanged_--root_main
@@ -1,4 +1,4 @@
-$ git whatchanged --root master
+$ git whatchanged --root main
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
diff --git a/t/t4013/diff.noellipses-whatchanged_-SF_master b/t/t4013/diff.noellipses-whatchanged_-SF_main
similarity index 86%
rename from t/t4013/diff.noellipses-whatchanged_-SF_master
rename to t/t4013/diff.noellipses-whatchanged_-SF_main
index b36ce5886e..0c1476d19e 100644
--- a/t/t4013/diff.noellipses-whatchanged_-SF_master
+++ b/t/t4013/diff.noellipses-whatchanged_-SF_main
@@ -1,4 +1,4 @@
-$ git whatchanged -SF master
+$ git whatchanged -SF main
 commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
diff --git a/t/t4013/diff.noellipses-whatchanged_master b/t/t4013/diff.noellipses-whatchanged_main
similarity index 96%
rename from t/t4013/diff.noellipses-whatchanged_master
rename to t/t4013/diff.noellipses-whatchanged_main
index 55e500f2ed..c48d2851aa 100644
--- a/t/t4013/diff.noellipses-whatchanged_master
+++ b/t/t4013/diff.noellipses-whatchanged_main
@@ -1,4 +1,4 @@
-$ git whatchanged master
+$ git whatchanged main
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
diff --git a/t/t4013/diff.show_--first-parent_master b/t/t4013/diff.show_--first-parent_main
similarity index 92%
rename from t/t4013/diff.show_--first-parent_master
rename to t/t4013/diff.show_--first-parent_main
index 3dcbe473a0..480502d65c 100644
--- a/t/t4013/diff.show_--first-parent_master
+++ b/t/t4013/diff.show_--first-parent_main
@@ -1,4 +1,4 @@
-$ git show --first-parent master
+$ git show --first-parent main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.show_-c_master b/t/t4013/diff.show_-c_main
similarity index 95%
rename from t/t4013/diff.show_-c_master
rename to t/t4013/diff.show_-c_main
index 81aba8da96..74ef8bc96b 100644
--- a/t/t4013/diff.show_-c_master
+++ b/t/t4013/diff.show_-c_main
@@ -1,4 +1,4 @@
-$ git show -c master
+$ git show -c main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.show_-m_master b/t/t4013/diff.show_-m_main
similarity index 98%
rename from t/t4013/diff.show_-m_master
rename to t/t4013/diff.show_-m_main
index 4ea2ee453d..8fd56736d9 100644
--- a/t/t4013/diff.show_-m_master
+++ b/t/t4013/diff.show_-m_main
@@ -1,4 +1,4 @@
-$ git show -m master
+$ git show -m main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (from 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0)
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.show_master b/t/t4013/diff.show_main
similarity index 96%
rename from t/t4013/diff.show_master
rename to t/t4013/diff.show_main
index fb08ce0e46..630b52a95e 100644
--- a/t/t4013/diff.show_master
+++ b/t/t4013/diff.show_main
@@ -1,4 +1,4 @@
-$ git show master
+$ git show main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.whatchanged_--patch-with-stat_--summary_master_--_dir_ b/t/t4013/diff.whatchanged_--patch-with-stat_--summary_main_--_dir_
similarity index 94%
rename from t/t4013/diff.whatchanged_--patch-with-stat_--summary_master_--_dir_
rename to t/t4013/diff.whatchanged_--patch-with-stat_--summary_main_--_dir_
index c8b6af2f43..ce0754d556 100644
--- a/t/t4013/diff.whatchanged_--patch-with-stat_--summary_master_--_dir_
+++ b/t/t4013/diff.whatchanged_--patch-with-stat_--summary_main_--_dir_
@@ -1,4 +1,4 @@
-$ git whatchanged --patch-with-stat --summary master -- dir/
+$ git whatchanged --patch-with-stat --summary main -- dir/
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
diff --git a/t/t4013/diff.whatchanged_--patch-with-stat_master b/t/t4013/diff.whatchanged_--patch-with-stat_main
similarity index 97%
rename from t/t4013/diff.whatchanged_--patch-with-stat_master
rename to t/t4013/diff.whatchanged_--patch-with-stat_main
index 1ac431ba92..aabccf39a5 100644
--- a/t/t4013/diff.whatchanged_--patch-with-stat_master
+++ b/t/t4013/diff.whatchanged_--patch-with-stat_main
@@ -1,4 +1,4 @@
-$ git whatchanged --patch-with-stat master
+$ git whatchanged --patch-with-stat main
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
diff --git a/t/t4013/diff.whatchanged_--patch-with-stat_master_--_dir_ b/t/t4013/diff.whatchanged_--patch-with-stat_main_--_dir_
similarity index 94%
rename from t/t4013/diff.whatchanged_--patch-with-stat_master_--_dir_
rename to t/t4013/diff.whatchanged_--patch-with-stat_main_--_dir_
index b30c28588f..c05a0e8149 100644
--- a/t/t4013/diff.whatchanged_--patch-with-stat_master_--_dir_
+++ b/t/t4013/diff.whatchanged_--patch-with-stat_main_--_dir_
@@ -1,4 +1,4 @@
-$ git whatchanged --patch-with-stat master -- dir/
+$ git whatchanged --patch-with-stat main -- dir/
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
diff --git a/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_master b/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_main
similarity index 97%
rename from t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_master
rename to t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_main
index 30aae7817b..1f74b1b548 100644
--- a/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_main
@@ -1,4 +1,4 @@
-$ git whatchanged --root --cc --patch-with-stat --summary master
+$ git whatchanged --root --cc --patch-with-stat --summary main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.whatchanged_--root_--patch-with-stat_--summary_master b/t/t4013/diff.whatchanged_--root_--patch-with-stat_--summary_main
similarity index 97%
rename from t/t4013/diff.whatchanged_--root_--patch-with-stat_--summary_master
rename to t/t4013/diff.whatchanged_--root_--patch-with-stat_--summary_main
index db90e51525..80d9812151 100644
--- a/t/t4013/diff.whatchanged_--root_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.whatchanged_--root_--patch-with-stat_--summary_main
@@ -1,4 +1,4 @@
-$ git whatchanged --root --patch-with-stat --summary master
+$ git whatchanged --root --patch-with-stat --summary main
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
diff --git a/t/t4013/diff.whatchanged_--root_--patch-with-stat_master b/t/t4013/diff.whatchanged_--root_--patch-with-stat_main
similarity index 97%
rename from t/t4013/diff.whatchanged_--root_--patch-with-stat_master
rename to t/t4013/diff.whatchanged_--root_--patch-with-stat_main
index 9a6cc92ce7..c0b9082a2c 100644
--- a/t/t4013/diff.whatchanged_--root_--patch-with-stat_master
+++ b/t/t4013/diff.whatchanged_--root_--patch-with-stat_main
@@ -1,4 +1,4 @@
-$ git whatchanged --root --patch-with-stat master
+$ git whatchanged --root --patch-with-stat main
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
diff --git a/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_master b/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_main
similarity index 97%
rename from t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_master
rename to t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_main
index d1d32bd34c..0002c6912e 100644
--- a/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_main
@@ -1,4 +1,4 @@
-$ git whatchanged --root -c --patch-with-stat --summary master
+$ git whatchanged --root -c --patch-with-stat --summary main
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.whatchanged_--root_-p_master b/t/t4013/diff.whatchanged_--root_-p_main
similarity index 98%
rename from t/t4013/diff.whatchanged_--root_-p_master
rename to t/t4013/diff.whatchanged_--root_-p_main
index ebf1f0661e..39f3e2be74 100644
--- a/t/t4013/diff.whatchanged_--root_-p_master
+++ b/t/t4013/diff.whatchanged_--root_-p_main
@@ -1,4 +1,4 @@
-$ git whatchanged --root -p master
+$ git whatchanged --root -p main
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
diff --git a/t/t4013/diff.whatchanged_--root_master b/t/t4013/diff.whatchanged_--root_main
similarity index 97%
rename from t/t4013/diff.whatchanged_--root_master
rename to t/t4013/diff.whatchanged_--root_main
index a405cb6138..36f4d6697f 100644
--- a/t/t4013/diff.whatchanged_--root_master
+++ b/t/t4013/diff.whatchanged_--root_main
@@ -1,4 +1,4 @@
-$ git whatchanged --root master
+$ git whatchanged --root main
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
diff --git a/t/t4013/diff.whatchanged_-SF_-p_master b/t/t4013/diff.whatchanged_-SF_-p_main
similarity index 89%
rename from t/t4013/diff.whatchanged_-SF_-p_master
rename to t/t4013/diff.whatchanged_-SF_-p_main
index f39da84822..0e2e67c0df 100644
--- a/t/t4013/diff.whatchanged_-SF_-p_master
+++ b/t/t4013/diff.whatchanged_-SF_-p_main
@@ -1,4 +1,4 @@
-$ git whatchanged -SF -p master
+$ git whatchanged -SF -p main
 commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
diff --git a/t/t4013/diff.whatchanged_-SF_master b/t/t4013/diff.whatchanged_-SF_main
similarity index 86%
rename from t/t4013/diff.whatchanged_-SF_master
rename to t/t4013/diff.whatchanged_-SF_main
index 0499321d0e..34c6bf6b95 100644
--- a/t/t4013/diff.whatchanged_-SF_master
+++ b/t/t4013/diff.whatchanged_-SF_main
@@ -1,4 +1,4 @@
-$ git whatchanged -SF master
+$ git whatchanged -SF main
 commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
diff --git a/t/t4013/diff.whatchanged_-p_master b/t/t4013/diff.whatchanged_-p_main
similarity index 98%
rename from t/t4013/diff.whatchanged_-p_master
rename to t/t4013/diff.whatchanged_-p_main
index f18d43209c..18f3bdeef4 100644
--- a/t/t4013/diff.whatchanged_-p_master
+++ b/t/t4013/diff.whatchanged_-p_main
@@ -1,4 +1,4 @@
-$ git whatchanged -p master
+$ git whatchanged -p main
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
diff --git a/t/t4013/diff.whatchanged_master b/t/t4013/diff.whatchanged_main
similarity index 97%
rename from t/t4013/diff.whatchanged_master
rename to t/t4013/diff.whatchanged_main
index cd3bcc2c72..d6c83ed8b0 100644
--- a/t/t4013/diff.whatchanged_master
+++ b/t/t4013/diff.whatchanged_main
@@ -1,4 +1,4 @@
-$ git whatchanged master
+$ git whatchanged main
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
-- 
gitgitgadget

