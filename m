Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49E4C433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 19:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74805206DA
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 19:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tXfqERfE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgHLToW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgHLToV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 15:44:21 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB9EC061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 12:44:21 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j21so1560282pgi.9
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 12:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iYxwGY6HJDQUPwXNO/Rz3E2J2+MQnP+QBKPVQPMlpkI=;
        b=tXfqERfERb3cgB1C0+PeCtToxuHZ7f06Jy4YgFpPz0SBsGLPC+NRN7jnhzX3qJDYWl
         M09lN90+FYQMC7q46JHPfALEOznROxkPP2Ka+klsd2h+WYwsxKfXCLNB4OMQV0Y7Dmic
         DrTfOu9iz0ltgvlEUIRkmhQXR9nUcuM6E9NGszv18A6LskjEmaIMEnXR1C4hpy6qFznJ
         cQOJw3TXryqjLWh4/V9pJtWEJg8qx16tzOzpVsoBxN9GOgvLlzcsITYDU9eS76d38EUD
         kzJmnKenoIaep7DRlN46PcFPh+aOr22JaSDSbwJM6cULGHWyrLBYxo8Wl+VLFrEgMvde
         FsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iYxwGY6HJDQUPwXNO/Rz3E2J2+MQnP+QBKPVQPMlpkI=;
        b=CDNIAQE6skWsriYqLnxdcFSVJPMJcsKzZdTg2QFWz+18LWcIboqdB5vWZO+ywNyjoP
         A17ij/KKLAOB+CP8ws5cFew8buKfPI+WOmqX1VE/fsJUhgbIqNIEWrVmlJrYLh+6F4Bk
         zLuOyxcbZHNsgEOT2ewRQMXSnbpob9chzGr60m2U9h5x81aOsZzV/5w9kHkbTbRHLap4
         kYhRNDVCIsDHciLhdtqgLp0N65pp+olNcKBHSHwJE8bnpfaYQtwcO7HhikdZbJ6c61Dw
         P/3ZnF9X4jaf3hIV8UcH5+7DVFRnTKtUwnIwoi3xebeNKGtkUFtp8y7OsCHd2qAJiZ2L
         0ANw==
X-Gm-Message-State: AOAM5302Qo9h6w+LDN5Bw0l9dIGmt3w/SfnMvedHzQW7brybImI01N2K
        Ku+//EU+EM7WxzFk76T7o98=
X-Google-Smtp-Source: ABdhPJxDpgR+vht7Qs26D8ZvB05RXN+hJxlP59usj77JOi7OVCxfkelZlIAcn8zRFhd/KIce8WvaQw==
X-Received: by 2002:a63:925d:: with SMTP id s29mr622780pgn.423.1597261460881;
        Wed, 12 Aug 2020 12:44:20 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.132])
        by smtp.gmail.com with ESMTPSA id q17sm3183965pfh.32.2020.08.12.12.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 12:44:20 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     shouryashukla.oo@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, kaartic.sivaraam@gmail.com,
        liu.denton@gmail.com
Subject: [GSoC][PATCH v3 0/4] submodule: port subcommand 'summary' from shell to C
Date:   Thu, 13 Aug 2020 01:14:00 +0530
Message-Id: <20200812194404.17028-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200806164102.6707-1-shouryashukla.oo@gmail.com>
References: <20200806164102.6707-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings,

This is the v3 of the patch series titled 'submodule: port subcommand
'summary' from shell to C':
https://lore.kernel.org/git/20200806164102.6707-1-shouryashukla.oo@gmail.com/

After suggestions from Junio, Kaartic and Christian I made some
changes:

-> Drop the commit c063390a94 (submodule: expose the '--for-status'
   option of summary, 2020-08-02) since it felt a bit unnecessary to
   expose the option given its lack of major use cases. Hence, after
   feedback from Junio, Kaartic and Christian I dropped this patch
   for now.

-> Adapt the patch to jk/strvec. It is a big change for Git hence it was
   necessary to make the port as per this patch.

Feedback and reviews are appreciated. I am tagging along a range-diff
between the v3 and v2 for ease of review.

Regards,
Shourya Shukla

-----
range-diff:

1:  c063390a94 < -:  ---------- submodule: expose the '--for-status' option of summary
2:  561d03351b = 1:  2a66d8c2bb submodule: remove extra line feeds between callback struct and macro
3:  e0e0c3ba4b = 2:  0ae3b92e31 submodule: rename helper functions to avoid ambiguity
4:  ec6e6c9e64 ! 3:  e2912a042f t7421: introduce a test script for verifying 'summary' output
    @@ Commit message
         do not work as expected.

         So, introduce a test script for verifying the 'summary' output for
    -    submodules added using 'git submodule add'.
    +    submodules added using 'git submodule add' and notify regarding the
    +    above mentioned behaviour in t7401 itself.

         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
         Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>

    + ## t/t7401-submodule-summary.sh ##
    +@@ t/t7401-submodule-summary.sh: test_description='Summary support for submodules
    +
    + This test tries to verify the sanity of summary subcommand of git submodule.
    + '
    ++# NOTE: This test script uses 'git add' instead of 'git submodule add' to add
    ++# submodules to the superproject. Some submodule subcommands such as init and
    ++# deinit might not work as expected in this script. t7421 does not have this
    ++# caveat.
    +
    + . ./test-lib.sh
    +
    +
      ## t/t7421-submodule-summary-add.sh (new) ##
     @@
     +#!/bin/sh
5:  9222b4168b ! 4:  879cb902b2 submodule: port submodule subcommand 'summary' from shell to C
    @@ builtin/submodule--helper.c: static int module_name(int argc, const char **argv,
     +  cp_rev_parse.git_cmd = 1;
     +  cp_rev_parse.dir = sm_path;
     +  prepare_submodule_repo_env(&cp_rev_parse.env_array);
    -+  argv_array_pushl(&cp_rev_parse.args, "rev-parse", "-q",
    -+                   "--short", NULL);
    -+  argv_array_pushf(&cp_rev_parse.args, "%s^0", committish);
    -+  argv_array_push(&cp_rev_parse.args, "--");
    ++  strvec_pushl(&cp_rev_parse.args, "rev-parse", "-q", "--short", NULL);
    ++  strvec_pushf(&cp_rev_parse.args, "%s^0", committish);
    ++  strvec_push(&cp_rev_parse.args, "--");
     +
     +  if (capture_command(&cp_rev_parse, &result, 0))
     +          return NULL;
    @@ builtin/submodule--helper.c: static int module_name(int argc, const char **argv,
     +          cp_log.git_cmd = 1;
     +          cp_log.dir = p->sm_path;
     +          prepare_submodule_repo_env(&cp_log.env_array);
    -+          argv_array_pushl(&cp_log.args, "log", NULL);
    ++          strvec_pushl(&cp_log.args, "log", NULL);
     +
     +          if (S_ISGITLINK(p->mod_src) && S_ISGITLINK(p->mod_dst)) {
     +                  if (info->summary_limit > 0)
    -+                          argv_array_pushf(&cp_log.args, "-%d",
    -+                                           info->summary_limit);
    -+
    -+                  argv_array_pushl(&cp_log.args, "--pretty=  %m %s",
    -+                                   "--first-parent", NULL);
    -+                  argv_array_pushf(&cp_log.args, "%s...%s",
    -+                                   src_abbrev,
    -+                                   dst_abbrev);
    ++                          strvec_pushf(&cp_log.args, "-%d",
    ++                                       info->summary_limit);
    ++
    ++                  strvec_pushl(&cp_log.args, "--pretty=  %m %s",
    ++                               "--first-parent", NULL);
    ++                  strvec_pushf(&cp_log.args, "%s...%s",
    ++                               src_abbrev, dst_abbrev);
     +          } else if (S_ISGITLINK(p->mod_dst)) {
    -+                  argv_array_pushl(&cp_log.args, "--pretty=  > %s",
    -+                                   "-1", dst_abbrev, NULL);
    ++                  strvec_pushl(&cp_log.args, "--pretty=  > %s",
    ++                               "-1", dst_abbrev, NULL);
     +          } else {
    -+                  argv_array_pushl(&cp_log.args, "--pretty=  < %s",
    -+                                   "-1", src_abbrev, NULL);
    ++                  strvec_pushl(&cp_log.args, "--pretty=  < %s",
    ++                               "-1", src_abbrev, NULL);
     +          }
     +          run_command(&cp_log);
     +  }
    @@ builtin/submodule--helper.c: static int module_name(int argc, const char **argv,
     +          struct child_process cp_rev_list = CHILD_PROCESS_INIT;
     +          struct strbuf sb_rev_list = STRBUF_INIT;
     +
    -+          argv_array_pushl(&cp_rev_list.args, "rev-list",
    -+                           "--first-parent", "--count", NULL);
    ++          strvec_pushl(&cp_rev_list.args, "rev-list",
    ++                       "--first-parent", "--count", NULL);
     +          if (S_ISGITLINK(p->mod_src) && S_ISGITLINK(p->mod_dst))
    -+                  argv_array_pushf(&cp_rev_list.args, "%s...%s",
    -+                                   src_abbrev,
    -+                                   dst_abbrev);
    ++                  strvec_pushf(&cp_rev_list.args, "%s...%s",
    ++                               src_abbrev, dst_abbrev);
     +          else
    -+                  argv_array_push(&cp_rev_list.args,
    -+                                  S_ISGITLINK(p->mod_src) ?
    -+                                  src_abbrev :
    -+                                  dst_abbrev);
    -+          argv_array_push(&cp_rev_list.args, "--");
    ++                  strvec_push(&cp_rev_list.args, S_ISGITLINK(p->mod_src) ?
    ++                              src_abbrev : dst_abbrev);
    ++          strvec_push(&cp_rev_list.args, "--");
     +
     +          cp_rev_list.git_cmd = 1;
     +          cp_rev_list.dir = p->sm_path;
    @@ builtin/submodule--helper.c: static int module_name(int argc, const char **argv,
     +                                 struct summary_cb *info,
     +                                 enum diff_cmd diff_cmd)
     +{
    -+  struct argv_array diff_args = ARGV_ARRAY_INIT;
    ++  struct strvec diff_args = STRVEC_INIT;
     +  struct rev_info rev;
     +  struct module_cb_list list = MODULE_CB_LIST_INIT;
     +
    -+  argv_array_push(&diff_args, get_diff_cmd(diff_cmd));
    ++  strvec_push(&diff_args, get_diff_cmd(diff_cmd));
     +  if (info->cached)
    -+          argv_array_push(&diff_args, "--cached");
    -+  argv_array_pushl(&diff_args, "--ignore-submodules=dirty", "--raw",
    -+                   NULL);
    ++          strvec_push(&diff_args, "--cached");
    ++  strvec_pushl(&diff_args, "--ignore-submodules=dirty", "--raw", NULL);
     +  if (head_oid)
    -+          argv_array_push(&diff_args, oid_to_hex(head_oid));
    -+  argv_array_push(&diff_args, "--");
    ++          strvec_push(&diff_args, oid_to_hex(head_oid));
    ++  strvec_push(&diff_args, "--");
     +  if (info->argc)
    -+          argv_array_pushv(&diff_args, info->argv);
    ++          strvec_pushv(&diff_args, info->argv);
     +
     +  git_config(git_diff_basic_config, NULL);
     +  init_revisions(&rev, info->prefix);
     +  rev.abbrev = 0;
    -+  precompose_argv(diff_args.argc, diff_args.argv);
    -+
    -+  diff_args.argc = setup_revisions(diff_args.argc, diff_args.argv,
    -+                                   &rev, NULL);
    ++  precompose_argv(diff_args.nr, diff_args.v);
    ++  setup_revisions(diff_args.nr, diff_args.v, &rev, NULL);
     +  rev.diffopt.output_format = DIFF_FORMAT_NO_OUTPUT | DIFF_FORMAT_CALLBACK;
     +  rev.diffopt.format_callback = submodule_summary_callback;
     +  rev.diffopt.format_callback_data = &list;
    @@ builtin/submodule--helper.c: static int module_name(int argc, const char **argv,
     +  else
     +          run_diff_files(&rev, 0);
     +  prepare_submodule_summary(info, &list);
    ++  strvec_clear(&diff_args);
     +  return 0;
     +}
     +

-----

Prathamesh Chavan (1):
  submodule: port submodule subcommand 'summary' from shell to C

Shourya Shukla (3):
  submodule: remove extra line feeds between callback struct and macro
  submodule: rename helper functions to avoid ambiguity
  t7421: introduce a test script for verifying 'summary' output

 builtin/submodule--helper.c      | 432 ++++++++++++++++++++++++++++++-
 diff.c                           |   2 +-
 git-submodule.sh                 | 186 +------------
 submodule.c                      |  10 +-
 submodule.h                      |   2 +-
 t/t7401-submodule-summary.sh     |   4 +
 t/t7421-submodule-summary-add.sh |  69 +++++
 7 files changed, 510 insertions(+), 195 deletions(-)
 create mode 100755 t/t7421-submodule-summary-add.sh

-- 
2.28.0

