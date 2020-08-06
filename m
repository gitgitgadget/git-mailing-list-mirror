Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9732C433E3
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E54C92086A
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnY2mqZ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbgHFQz7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbgHFQlR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 12:41:17 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0A0C0A8937
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 09:41:15 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t11so8078207plr.5
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 09:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g4yHqekC6VzCmdVoVkI577KL2oI3KlAuH2XeOs0iAtM=;
        b=jnY2mqZ0TFrORYIC+94miDNbaClnxkcic+DV6jVMwr6Uadzk87Rn5YLma+IlYop4zX
         pYqf4Z5eHXLxeFXXyBw0Y91gunk7VWLRSWeXxs7LjmAyzq4nrN28uW6nRWGTKo7bkFhi
         r6OE33OWVg8v6WhkAWuhBn1OsirCgb6Dca80XOdv86kFwIlB1k00Zm+ceaHdRXkCXjDS
         j+4D0o1BomZk+49juMBN0wOeupl6oMADzYVeTEEFjF2nM0w0f83TcS2vV8LPI7MCVqsN
         DpgShhI2W3LJZiI0WUcF+knpKMJg4UM70+ia+TWK+Dz0hCE8ZOE5eOJTTnljocF0t/d5
         CfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g4yHqekC6VzCmdVoVkI577KL2oI3KlAuH2XeOs0iAtM=;
        b=EpBMkuqh8wEHfbTFnpdiLSSZSks8IKn7ShdyyCvAapdT1DuIZh6ljBwzo9f/yEj8mb
         ghwIblUggTRSQwTIPcaTioo4RPFURNydFhD5QBdqKHyCDIP6Y5V43xt8OFtSkWAuONh1
         7LbiedRSYNSz86LH41MtKeI6/F+XEMo0yZL7aP46HoGvExSbwxj5sa6q3HElkPadhQuw
         dyecOOLuDqX2g6hizXP0b/4f0qNil/nDQMg2bYJIg679YO7ZQzj2LMkH3vv3LPBmlV7c
         TDdix77UWDvJc9EsGGLuMqNChNQuAeHVn+ly86aaBVRnCqDw2JCa1c85tECMi6ENyYMH
         aO4g==
X-Gm-Message-State: AOAM533+k2SzuTu2Rm+T0iy2h+GzC8s2mze/rX/m3PXHokDX+KFN1jsF
        7D7NJBzL5/wZER8NPdq7ONN19LJJLko=
X-Google-Smtp-Source: ABdhPJxT31hKzxavAmHRG99LQkoXLa0otGDGxyt0lIHRyyMiuaxiRF4z8mzdNdM3xhSQGg6wD5FgLQ==
X-Received: by 2002:a17:90a:fa8c:: with SMTP id cu12mr9593859pjb.229.1596732073324;
        Thu, 06 Aug 2020 09:41:13 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.60])
        by smtp.gmail.com with ESMTPSA id w16sm8008381pjd.50.2020.08.06.09.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 09:41:12 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, johannes.schindelin@gmx.de,
        liu.denton@gmail.com, Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [GSoC][PATCH v2 0/5] submodule: port subcommand 'summary' from shell to C
Date:   Thu,  6 Aug 2020 22:10:57 +0530
Message-Id: <20200806164102.6707-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings,

After a long list of changes proposed by Johannes in the v1, here I
present the v2 of the patch series porting 'summary' from shell to C.
Apart from requested changes in 'submodule--helper.c' and dropping the
commit changing the scope of the 'count_lines()' function, there are
two new commits: one documents the 'for-status' option and one
introduces the test 't7421-submodule-summary-add.sh'. Link to the v1:
https://lore.kernel.org/git/20200702192409.21865-1-shouryashukla.oo@gmail.com/

The reasons for the introduction of the test are covered in a previous
patch series delivered by me last night regarding t7401:
https://lore.kernel.org/git/20200805174921.16000-1-shouryashukla.oo@gmail.com/

But I will touch upon it again in this patch. The test script
't7401-submodule-summary.sh' adds submodules using 'git add' instead of
'git submodule add'. Therefore, some commands such as
'git submodule init' and 'git submodule deinit' do not give the desired
effects since there is no .gitmodules file. Note that, 'summary'
works without issues as it does not depend on the existence of
.gitmodules.

I will tag along the 'range-diff' between this v2 and the v1 at the end
of the cover letter for ease of review.

The changelog:

- Introduce commit [PATCH 1/5] 4f0e4f6ace (submodule: document the
  '--for-status' option, 2020-08-02).

- Improve commit message of [PATCH 2/5] 6e42cc99a7 (submodule: remove
  extra line feeds between callback struct and macro, 2020-06-25).

- Drop commit (Previously [PATCH 3/4]) 745f2bd92e (diff: change scope
  of the function count_lines(), 2017-07-11).

- Introduce commit [PATCH 4/5] ef4cf4be0f (t7421: introduce a test
  script for verifying 'summary' output, 2020-07-23).

- Improve the commit [PATCH 5/5] 331cc1a487 (submodule: port submodule
  subcommand 'summary' from shell to C, 2017-07-11) which includes:
    -> Improve the commit message, focusing more on the specialities of
       the commit rather than describing the flow of the subcommand.

    -> Rename the function 'verify_submodule_object_name()' to
       'verify_submodule_committish()' as the latter is more accurate.
       While at it, rename its argument 'const char *sha1' to 'const
       char *committish' since Git is shifting to SHA256 (covered in the
       patch series by Brian M. Carlson) and we look for a committish in
       the 'rev-parse' called in the function. Also, pass a '--short' in
       the call to 'rev-parse' as this option does the job of '--verify'
       and also shortens the hash the way we desire.

    -> Reuse the hash obtained from the function
      'verify_submodule_committish()' instead of incorrectly calling
      'find_unique_abbrev()' multiple times. Also eliminate the usage
      of 'oid_to_hex()' and instead reuse the aforementioned hash.

    -> Eliminate the variable 'is_sm_git_dir' and therefore, simplify
       the checks involving it since the GIT_DIR is already set to
       '.git/' and therefore we need to check it again.

    -> Eliminate the NEEDSWORK in 'generate_submodule_summary()' and
       instead call the function 'refs_head_ref()' (successor of
       'head_ref_submodule()').

    -> Use 'index_fd()' instead of spawning a process to run 'git
       hash-object' to find the 'oid_dst' in case of a regular file or
       a symbolic link.

    -> In case of an unexpected file mode, give a warning() and continue
       instead of die()ing.

    -> Simplify the 'range' computation by cuddling up a couple of lines
       and thus removing the 'range' variable since it will be useless.
       The 'range' is the range of commits whose summary will be
       computed.

    -> Eliminate the usage of 'count_lines()' since 'git rev-list
       --count' does the job anyway.

    -> Compute the error messages in 'generate_submodule_summary()'
       itself instead of 'print_submodule_summary()' and therefore, pass
       the err_msg into the latter as a 'char *'.

    -> Simplify the if-statement in case of 'for-status' by cuddling up
       various lines and thus removing one whole level of indentation.

    -> Remove the OPT__QUIET from the option struct since 'summary' does
       not support 'quiet'.

    -> Decapitalise the first letter of the option descriptions since
       the guidelines mention so.

    -> Instead of spawning a child process, use
       'is_nonbare_repository_dir()' to check if the submodules are
       checked out or not.

    -> Call 'get_oid()' to find the hash of 'HEAD' instead of spawning a
       process to call 'rev-parse' in 'module_summary()'. While at it,
       simplify the set of if-else statements which fetch the revision
       of the superproject to calculate the summary of.

    -> Pass the revision computed above to
       'compute_summary_module_list()' as 'struct object_id *' instead of
       passing it as a string.

There is a behavioural difference between the shell and the C version.
The shell version printed two newlines at the end of the output
when executed outside the tests but one newline when executed in the
tests. On the other hand, the C version printed only one newline
irrespective of where it was executed. This is due to the difference
in the way they call 'git log'. The shell version does a
'--pretty=format:<fmt>' whereas the C version does a '--pretty=<fmt>'.
The latter is indirectly a '--pretty=tformat:<fmt>' which causes the
difference between the two.

Also, when we try to pass an option-like argument after a non-option
argument:

	git submodule summary HEAD --foo-bar

That argument would be treated like a path to the submodule for which
the user is requesting a summary. So, the option ends up having no
effect. Though, passing `--quiet` is an exception to this:

	git submodule summary HEAD --quiet

While 'summary' doesn't support '--quiet', we don't get an output for
the above command as '--quiet' is treated as a path which means we get
an output only if a submodule whose path is '--quiet' exists.

Also, I want to ask a couple of things:

	1.Whether we can suppress the error message that we get when
	  trying to find the summary of non-existent submodules?
	  For example:

	  fatal: exec 'rev-parse': cd to 'my-subm' failed: No such file or directory
	   * my-subm 35b40f1...0000000:

	 Will it be OK to suppress the above error message?

	2.Is it fine to document and expose the 'for-status' option in
	  'git-submodule.txt'?

Feedback and reviews are appreciated.

Regards,
Shourya Shukla
-----

-:  ---------- > 1:  c063390a94 submodule: expose the '--for-status' option of summary
1:  add55c1d22 ! 2:  561d03351b submodule: amend extra line feed between callback struct and macro
    @@ Metadata
     Author: Shourya Shukla <shouryashukla.oo@gmail.com>
     
      ## Commit message ##
    -    submodule: amend extra line feed between callback struct and macro
    +    submodule: remove extra line feeds between callback struct and macro
     
    -    All subcommands of 'git submodule' using a callback mechanism had
    -    absence of an extra linefeed between their callback structs and
    -    macros. Subcommands 'init', 'status' and 'sync' did not follow suit.
    -    Amend the extra line feed.
    +    Many `submodule--helper` subcommands follow the convention that a struct
    +    defines their callback data, and the declaration of that struct is
    +    followed immediately by a macro to use in static initializers, without
    +    any separating empty line.
    +
    +    Let's align the `init`, `status` and `sync` subcommands with that convention.
     
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
    +    Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
    +    Helped-by: Philip Oakley <philipoakley@iee.email>
         Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
     
      ## builtin/submodule--helper.c ##
2:  75c986a5e0 = 3:  e0e0c3ba4b submodule: rename helper functions to avoid ambiguity
3:  745f2bd92e < -:  ---------- diff: change scope of the function count_lines()
-:  ---------- > 4:  ec6e6c9e64 t7421: introduce a test script for verifying 'summary' output
4:  c5baf68ecf ! 5:  9222b4168b submodule: port submodule subcommand 'summary' from shell to C
    @@ Metadata
      ## Commit message ##
         submodule: port submodule subcommand 'summary' from shell to C
     
    -    The submodule subcommand 'summary' is ported in the process of
    -    making git-submodule a builtin. The function cmd_summary() from
    -    git-submodule.sh is ported to functions module_summary(),
    -    compute_summary_module_list(), prepare_submodule_summary() and
    -    generate_submodule_summary(), print_submodule_summary().
    +    Convert submodule subcommand 'summary' to a builtin and call it via
    +    'git-submodule.sh'.
     
    -    The first function module_summary() parses the options of submodule
    -    subcommand and also acts as the front-end of this subcommand.
    -    After parsing them, it calls the compute_summary_module_list()
    +    The shell version had to call $diff_cmd twice, once to find the modified
    +    modules cared by the user and then again, with that list of modules
    +    to do various operations for computing the summary of those modules.
    +    On the other hand, the C version does not need a second call to
    +    $diff_cmd since it reuses the module list from the first call to do the
    +    aforementioned tasks.
     
    -    The functions compute_summary_module_list() runs the diff_cmd,
    -    and generates the modules list, as required by the subcommand.
    -    The generation of this module list is done by the using the
    -    callback function submodule_summary_callback(), and stored in the
    -    structure module_cb.
    +    In the C version, we use the combination of setting a child process'
    +    working directory to the submodule path and then calling
    +    'prepare_submodule_repo_env()' which also sets the 'GIT_DIR' to '.git',
    +    so that we can be certain that those spawned processes will not access
    +    the superproject's ODB by mistake.
     
    -    Once the module list is generated, prepare_submodule_summary()
    -    further goes through the list and filters the list, for
    -    eventually calling the generate_submodule_summary() function.
    +    A behavioural difference between the C and the shell version is that the
    +    shell version outputs two line feeds after the 'git log' output when run
    +    outside of the tests while the C version outputs one line feed in any
    +    case. The reason for this is that the shell version calls log with
    +    '--pretty=format:<fmt>' whose output is followed by two echo
    +    calls; 'format' does not have "terminator" semantics like its 'tformat'
    +    counterpart. So, the log output is terminated by a newline only when
    +    invoked by the user and not when invoked from the scripts. This results
    +    in the one & two line feed differences in the shell version.
    +    On the other hand, the C version calls log with '--pretty=<fmt>'
    +    which is equivalent to '--pretty:tformat:<fmt>' which is then
    +    followed by a 'printf("\n")'. Due to its "terminator" semantics the
    +    log output is always terminated by newline and hence one line feed in
    +    any case.
     
    -    The function generate_submodule_summary() takes care of generating
    -    the summary for each submodule and then calls the function
    -    print_submodule_summary() for printing it.
    +    Also, when we try to pass an option-like argument after a non-option
    +    argument, for instance:
     
    -    Mentored-by: Christian Couder <christian.couder@gmail.com>
    -    Mentored-by: Stefan Beller <sbeller@google.com>
    +        git submodule summary HEAD --foo-bar
    +
    +        (or)
    +
    +        git submodule summary HEAD --cached
    +
    +    That argument would be treated like a path to the submodule for which
    +    the user is requesting a summary. So, the option ends up having no
    +    effect. Though, passing '--quiet' is an exception to this:
    +
    +        git submodule summary HEAD --quiet
    +
    +    While 'summary' doesn't support '--quiet', we don't get an output for
    +    the above command as '--quiet' is treated as a path which means we get
    +    an output only if a submodule whose path is '--quiet' exists.
    +
    +    The error message in case of computing a summary for non-existent
    +    submodules in the C version is different from that of the shell version.
    +    Since the new error message is not marked for translation, change the
    +    'test_i18ngrep' in t7421.4 to 'grep'.
    +
    +    Mentored-by: Christian Couder <chriscool@tuxfamily.org>
    +    Mentored-by: Stefan Beller <stefanbeller@gmail.com>
         Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
    +    Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
         Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
         Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
     
    @@ builtin/submodule--helper.c: static int module_name(int argc, const char **argv,
     +  const char *prefix;
     +  unsigned int cached: 1;
     +  unsigned int for_status: 1;
    -+  unsigned int quiet: 1;
     +  unsigned int files: 1;
     +  int summary_limit;
     +};
    -+#define SUMMARY_CB_INIT { 0, NULL, NULL, 0, 0, 0, 0, 0 }
    ++#define SUMMARY_CB_INIT { 0, NULL, NULL, 0, 0, 0, 0 }
     +
     +enum diff_cmd {
     +  DIFF_INDEX,
     +  DIFF_FILES
     +};
     +
    -+static int verify_submodule_object_name(const char *sm_path,
    -+                                    const char *sha1)
    ++static char* verify_submodule_committish(const char *sm_path,
    ++                                   const char *committish)
     +{
     +  struct child_process cp_rev_parse = CHILD_PROCESS_INIT;
    ++  struct strbuf result = STRBUF_INIT;
     +
     +  cp_rev_parse.git_cmd = 1;
    -+  cp_rev_parse.no_stdout = 1;
     +  cp_rev_parse.dir = sm_path;
     +  prepare_submodule_repo_env(&cp_rev_parse.env_array);
     +  argv_array_pushl(&cp_rev_parse.args, "rev-parse", "-q",
    -+                   "--verify", NULL);
    -+  argv_array_pushf(&cp_rev_parse.args, "%s^0", sha1);
    ++                   "--short", NULL);
    ++  argv_array_pushf(&cp_rev_parse.args, "%s^0", committish);
    ++  argv_array_push(&cp_rev_parse.args, "--");
     +
    -+  if (run_command(&cp_rev_parse))
    -+          return 1;
    ++  if (capture_command(&cp_rev_parse, &result, 0))
    ++          return NULL;
     +
    -+  return 0;
    ++  strbuf_trim_trailing_newline(&result);
    ++  return strbuf_detach(&result, NULL);
     +}
     +
    -+static void print_submodule_summary(struct summary_cb *info, int errmsg,
    -+                                int total_commits, int missing_src,
    -+                                int missing_dst, const char *displaypath,
    -+                                int is_sm_git_dir, struct module_cb *p)
    ++static void print_submodule_summary(struct summary_cb *info, char* errmsg,
    ++                              int total_commits, const char *displaypath,
    ++                              const char *src_abbrev, const char *dst_abbrev,
    ++                              int missing_src, int missing_dst,
    ++                              struct module_cb *p)
     +{
     +  if (p->status == 'T') {
     +          if (S_ISGITLINK(p->mod_dst))
     +                  printf(_("* %s %s(blob)->%s(submodule)"),
    -+                           displaypath, find_unique_abbrev(&p->oid_src, 7),
    -+                           find_unique_abbrev(&p->oid_dst, 7));
    ++                           displaypath, src_abbrev, dst_abbrev);
     +          else
     +                  printf(_("* %s %s(submodule)->%s(blob)"),
    -+                           displaypath, find_unique_abbrev(&p->oid_src, 7),
    -+                           find_unique_abbrev(&p->oid_dst, 7));
    ++                           displaypath, src_abbrev, dst_abbrev);
     +  } else {
     +          printf("* %s %s...%s",
    -+                  displaypath, find_unique_abbrev(&p->oid_src, 7),
    -+                  find_unique_abbrev(&p->oid_dst, 7));
    ++                  displaypath, src_abbrev, dst_abbrev);
     +  }
     +
     +  if (total_commits < 0)
    @@ builtin/submodule--helper.c: static int module_name(int argc, const char **argv,
     +          printf(" (%d):\n", total_commits);
     +
     +  if (errmsg) {
    -+          /*
    -+           * Don't give error msg for modification whose dst is not
    -+           * submodule, i.e. deleted or changed to blob
    -+           */
    -+          if (S_ISGITLINK(p->mod_src)) {
    -+                  if (missing_src && missing_dst) {
    -+                          printf(_("  Warn: %s doesn't contain commits %s and %s\n"),
    -+                                 displaypath, oid_to_hex(&p->oid_src),
    -+                                 oid_to_hex(&p->oid_dst));
    -+                  } else if (missing_src) {
    -+                          printf(_("  Warn: %s doesn't contain commit %s\n"),
    -+                                 displaypath, oid_to_hex(&p->oid_src));
    -+                  } else {
    -+                          printf(_("  Warn: %s doesn't contain commit %s\n"),
    -+                                 displaypath, oid_to_hex(&p->oid_dst));
    -+                  }
    -+          }
    -+  } else if (is_sm_git_dir) {
    ++          printf(_("%s"), errmsg);
    ++  } else if (total_commits > 0) {
     +          struct child_process cp_log = CHILD_PROCESS_INIT;
     +
     +          cp_log.git_cmd = 1;
    @@ builtin/submodule--helper.c: static int module_name(int argc, const char **argv,
     +                  argv_array_pushl(&cp_log.args, "--pretty=  %m %s",
     +                                   "--first-parent", NULL);
     +                  argv_array_pushf(&cp_log.args, "%s...%s",
    -+                                   oid_to_hex(&p->oid_src),
    -+                                   oid_to_hex(&p->oid_dst));
    ++                                   src_abbrev,
    ++                                   dst_abbrev);
     +          } else if (S_ISGITLINK(p->mod_dst)) {
     +                  argv_array_pushl(&cp_log.args, "--pretty=  > %s",
    -+                                   "-1", oid_to_hex(&p->oid_dst), NULL);
    ++                                   "-1", dst_abbrev, NULL);
     +          } else {
     +                  argv_array_pushl(&cp_log.args, "--pretty=  < %s",
    -+                                   "-1", oid_to_hex(&p->oid_src), NULL);
    ++                                   "-1", src_abbrev, NULL);
     +          }
     +          run_command(&cp_log);
     +  }
    @@ builtin/submodule--helper.c: static int module_name(int argc, const char **argv,
     +static void generate_submodule_summary(struct summary_cb *info,
     +                                 struct module_cb *p)
     +{
    -+  int missing_src = 0;
    -+  int missing_dst = 0;
    -+  char *displaypath;
    -+  int errmsg = 0;
    ++  char *displaypath, *src_abbrev, *dst_abbrev;
    ++  int missing_src = 0, missing_dst = 0;
    ++  char *errmsg = NULL;
     +  int total_commits = -1;
    -+  int is_sm_git_dir = 0;
    -+  struct strbuf sm_git_dir_sb = STRBUF_INIT;
     +
     +  if (!info->cached && oideq(&p->oid_dst, &null_oid)) {
     +          if (S_ISGITLINK(p->mod_dst)) {
    -+                  /*
    -+                   * NEEDSWORK: avoid using separate process with
    -+                   * the help of the function head_ref_submodule()
    -+                   */
    -+                  struct child_process cp_rev_parse = CHILD_PROCESS_INIT;
    -+                  struct strbuf sb_rev_parse = STRBUF_INIT;
    -+
    -+                  cp_rev_parse.git_cmd = 1;
    -+                  cp_rev_parse.no_stderr = 1;
    -+                  cp_rev_parse.dir = p->sm_path;
    -+                  prepare_submodule_repo_env(&cp_rev_parse.env_array);
    -+
    -+                  argv_array_pushl(&cp_rev_parse.args, "rev-parse",
    -+                                   "HEAD", NULL);
    -+                  if (!capture_command(&cp_rev_parse, &sb_rev_parse, 0)) {
    -+                          strbuf_strip_suffix(&sb_rev_parse, "\n");
    -+                          get_oid_hex(sb_rev_parse.buf, &p->oid_dst);
    -+                  }
    -+                  strbuf_release(&sb_rev_parse);
    ++                  struct ref_store *refs = get_submodule_ref_store(p->sm_path);
    ++                  if (refs)
    ++                          refs_head_ref(refs, handle_submodule_head_ref, &p->oid_dst);
     +          } else if (S_ISLNK(p->mod_dst) || S_ISREG(p->mod_dst)) {
    -+                  struct child_process cp_hash_object = CHILD_PROCESS_INIT;
    -+                  struct strbuf sb_hash_object = STRBUF_INIT;
    -+
    -+                  cp_hash_object.git_cmd = 1;
    -+                  argv_array_pushl(&cp_hash_object.args, "hash-object",
    -+                                   p->sm_path, NULL);
    -+                  if (!capture_command(&cp_hash_object,
    -+                                       &sb_hash_object, 0)) {
    -+                          strbuf_strip_suffix(&sb_hash_object, "\n");
    -+                          get_oid_hex(sb_hash_object.buf, &p->oid_dst);
    -+                  }
    -+                  strbuf_release(&sb_hash_object);
    ++                  struct stat st;
    ++                  int fd = open(p->sm_path, O_RDONLY);
    ++
    ++                  if (fd < 0 || fstat(fd, &st) < 0 ||
    ++                      index_fd(&the_index, &p->oid_dst, fd, &st, OBJ_BLOB,
    ++                               p->sm_path, 0))
    ++                          error(_("couldn't hash object from '%s'"), p->sm_path);
     +          } else {
    ++                  /* for a submodule removal (mode:0000000), don't warn */
     +                  if (p->mod_dst)
    -+                          die(_("unexpected mode %d\n"), p->mod_dst);
    ++                          warning(_("unexpected mode %d\n"), p->mod_dst);
     +          }
     +  }
     +
    -+  strbuf_addstr(&sm_git_dir_sb, p->sm_path);
    -+  if (is_nonbare_repository_dir(&sm_git_dir_sb))
    -+          is_sm_git_dir = 1;
    -+
    -+  if (is_sm_git_dir && S_ISGITLINK(p->mod_src))
    -+          missing_src = verify_submodule_object_name(p->sm_path,
    -+                                                     oid_to_hex(&p->oid_src));
    ++  if (S_ISGITLINK(p->mod_src)) {
    ++          src_abbrev = verify_submodule_committish(p->sm_path,
    ++                                                   oid_to_hex(&p->oid_src));
    ++          if (!src_abbrev) {
    ++                  missing_src = 1;
    ++                  /*
    ++                   * As `rev-parse` failed, we fallback to getting
    ++                   * the abbreviated hash using oid_src. We do
    ++                   * this as we might still need the abbreviated
    ++                   * hash in cases like a submodule type change, etc.
    ++                   */
    ++                  src_abbrev = xstrndup(oid_to_hex(&p->oid_src), 7);
    ++          }
    ++  } else {
    ++          /*
    ++           * The source does not point to a submodule.
    ++           * So, we fallback to getting the abbreviation using
    ++           * oid_src as we might still need the abbreviated
    ++           * hash in cases like submodule add, etc.
    ++           */
    ++          src_abbrev = xstrndup(oid_to_hex(&p->oid_src), 7);
    ++  }
     +
    -+  if (is_sm_git_dir && S_ISGITLINK(p->mod_dst))
    -+          missing_dst = verify_submodule_object_name(p->sm_path,
    -+                                                     oid_to_hex(&p->oid_dst));
    ++  if (S_ISGITLINK(p->mod_dst)) {
    ++          dst_abbrev = verify_submodule_committish(p->sm_path,
    ++                                                   oid_to_hex(&p->oid_dst));
    ++          if (!dst_abbrev) {
    ++                  missing_dst = 1;
    ++                  /*
    ++                   * As `rev-parse` failed, we fallback to getting
    ++                   * the abbreviated hash using oid_dst. We do
    ++                   * this as we might still need the abbreviated
    ++                   * hash in cases like a submodule type change, etc.
    ++                   */
    ++                  dst_abbrev = xstrndup(oid_to_hex(&p->oid_dst), 7);
    ++          }
    ++  } else {
    ++          /*
    ++           * The destination does not point to a submodule.
    ++           * So, we fallback to getting the abbreviation using
    ++           * oid_dst as we might still need the abbreviated
    ++           * hash in cases like a submodule removal, etc.
    ++           */
    ++          dst_abbrev = xstrndup(oid_to_hex(&p->oid_dst), 7);
    ++  }
     +
     +  displaypath = get_submodule_displaypath(p->sm_path, info->prefix);
     +
    -+  if (!missing_dst && !missing_src) {
    -+          if (is_sm_git_dir) {
    -+                  struct child_process cp_rev_list = CHILD_PROCESS_INIT;
    -+                  struct strbuf sb_rev_list = STRBUF_INIT;
    -+                  char *range;
    -+
    -+                  if (S_ISGITLINK(p->mod_src) && S_ISGITLINK(p->mod_dst))
    -+                          range = xstrfmt("%s...%s", oid_to_hex(&p->oid_src),
    -+                                          oid_to_hex(&p->oid_dst));
    -+                  else if (S_ISGITLINK(p->mod_src))
    -+                          range = xstrdup(oid_to_hex(&p->oid_src));
    -+                  else
    -+                          range = xstrdup(oid_to_hex(&p->oid_dst));
    -+
    -+                  cp_rev_list.git_cmd = 1;
    -+                  cp_rev_list.dir = p->sm_path;
    -+                  prepare_submodule_repo_env(&cp_rev_list.env_array);
    -+
    -+                  argv_array_pushl(&cp_rev_list.args, "rev-list",
    -+                                   "--first-parent", range, "--", NULL);
    -+                  if (!capture_command(&cp_rev_list, &sb_rev_list, 0)) {
    -+                          if (sb_rev_list.len)
    -+                                  total_commits = count_lines(sb_rev_list.buf,
    -+                                                              sb_rev_list.len);
    -+                          else
    -+                                  total_commits = 0;
    -+                  }
    ++  if (!missing_src && !missing_dst) {
    ++          struct child_process cp_rev_list = CHILD_PROCESS_INIT;
    ++          struct strbuf sb_rev_list = STRBUF_INIT;
     +
    -+                  free(range);
    -+                  strbuf_release(&sb_rev_list);
    -+          }
    ++          argv_array_pushl(&cp_rev_list.args, "rev-list",
    ++                           "--first-parent", "--count", NULL);
    ++          if (S_ISGITLINK(p->mod_src) && S_ISGITLINK(p->mod_dst))
    ++                  argv_array_pushf(&cp_rev_list.args, "%s...%s",
    ++                                   src_abbrev,
    ++                                   dst_abbrev);
    ++          else
    ++                  argv_array_push(&cp_rev_list.args,
    ++                                  S_ISGITLINK(p->mod_src) ?
    ++                                  src_abbrev :
    ++                                  dst_abbrev);
    ++          argv_array_push(&cp_rev_list.args, "--");
    ++
    ++          cp_rev_list.git_cmd = 1;
    ++          cp_rev_list.dir = p->sm_path;
    ++          prepare_submodule_repo_env(&cp_rev_list.env_array);
    ++
    ++          if (!capture_command(&cp_rev_list, &sb_rev_list, 0))
    ++                  total_commits = atoi(sb_rev_list.buf);
    ++
    ++          strbuf_release(&sb_rev_list);
     +  } else {
    -+          errmsg = 1;
    ++          /*
    ++           * Don't give error msg for modification whose dst is not
    ++           * submodule, i.e., deleted or changed to blob
    ++           */
    ++          if (S_ISGITLINK(p->mod_dst)) {
    ++                  struct strbuf errmsg_str = STRBUF_INIT;
    ++                  if (missing_src && missing_dst) {
    ++                          strbuf_addf(&errmsg_str, "  Warn: %s doesn't contain commits %s and %s\n",
    ++                                      displaypath, oid_to_hex(&p->oid_src),
    ++                                      oid_to_hex(&p->oid_dst));
    ++                  } else {
    ++                          strbuf_addf(&errmsg_str, "  Warn: %s doesn't contain commit %s\n",
    ++                                      displaypath, missing_src ?
    ++                                      oid_to_hex(&p->oid_src) :
    ++                                      oid_to_hex(&p->oid_dst));
    ++                  }
    ++                  errmsg = strbuf_detach(&errmsg_str, NULL);
    ++          }
     +  }
     +
     +  print_submodule_summary(info, errmsg, total_commits,
    -+                          missing_src, missing_dst,
    -+                          displaypath, is_sm_git_dir, p);
    ++                          displaypath, src_abbrev,
    ++                          dst_abbrev, missing_src,
    ++                          missing_dst, p);
     +
     +  free(displaypath);
    -+  strbuf_release(&sm_git_dir_sb);
    ++  free(src_abbrev);
    ++  free(dst_abbrev);
     +}
     +
     +static void prepare_submodule_summary(struct summary_cb *info,
    @@ builtin/submodule--helper.c: static int module_name(int argc, const char **argv,
     +{
     +  int i;
     +  for (i = 0; i < list->nr; i++) {
    ++          const struct submodule *sub;
     +          struct module_cb *p = list->entries[i];
    -+          struct child_process cp_rev_parse = CHILD_PROCESS_INIT;
    ++          struct strbuf sm_gitdir = STRBUF_INIT;
     +
     +          if (p->status == 'D' || p->status == 'T') {
     +                  generate_submodule_summary(info, p);
     +                  continue;
     +          }
     +
    -+          if (info->for_status) {
    -+                  char *config_key;
    -+                  const char *ignore_config = "none";
    ++          if (info->for_status && p->status != 'A' &&
    ++              (sub = submodule_from_path(the_repository,
    ++                                         &null_oid, p->sm_path))) {
    ++                  char *config_key = NULL;
     +                  const char *value;
    -+                  const struct submodule *sub = submodule_from_path(the_repository,
    -+                                                                    &null_oid,
    -+                                                                    p->sm_path);
    -+
    -+                  if (sub && p->status != 'A') {
    -+                          config_key = xstrfmt("submodule.%s.ignore",
    -+                                               sub->name);
    -+                          if (!git_config_get_string_const(config_key, &value))
    -+                                  ignore_config = value;
    -+                          else if (sub->ignore)
    -+                                  ignore_config = sub->ignore;
    -+
    -+                          free(config_key);
    -+                          if (!strcmp(ignore_config, "all"))
    -+                                  continue;
    -+                  }
    ++                  int ignore_all = 0;
    ++
    ++                  config_key = xstrfmt("submodule.%s.ignore",
    ++                                       sub->name);
    ++                  if (!git_config_get_string_const(config_key, &value))
    ++                          ignore_all = !strcmp(value, "all");
    ++                  else if (sub->ignore)
    ++                          ignore_all = !strcmp(sub->ignore, "all");
    ++
    ++                  free(config_key);
    ++                  if (ignore_all)
    ++                          continue;
     +          }
     +
     +          /* Also show added or modified modules which are checked out */
    -+          cp_rev_parse.dir = p->sm_path;
    -+          cp_rev_parse.git_cmd = 1;
    -+          cp_rev_parse.no_stderr = 1;
    -+          cp_rev_parse.no_stdout = 1;
    -+
    -+          argv_array_pushl(&cp_rev_parse.args, "rev-parse",
    -+                           "--git-dir", NULL);
    -+
    -+          if (!run_command(&cp_rev_parse))
    ++          strbuf_addstr(&sm_gitdir, p->sm_path);
    ++          if (is_nonbare_repository_dir(&sm_gitdir))
     +                  generate_submodule_summary(info, p);
    ++          strbuf_release(&sm_gitdir);
     +  }
     +}
     +
    @@ builtin/submodule--helper.c: static int module_name(int argc, const char **argv,
     +  }
     +}
     +
    -+static int compute_summary_module_list(char *head,
    -+                                   struct summary_cb *info,
    -+                                   enum diff_cmd diff_cmd)
    ++static int compute_summary_module_list(struct object_id *head_oid,
    ++                                 struct summary_cb *info,
    ++                                 enum diff_cmd diff_cmd)
     +{
     +  struct argv_array diff_args = ARGV_ARRAY_INIT;
     +  struct rev_info rev;
    @@ builtin/submodule--helper.c: static int module_name(int argc, const char **argv,
     +          argv_array_push(&diff_args, "--cached");
     +  argv_array_pushl(&diff_args, "--ignore-submodules=dirty", "--raw",
     +                   NULL);
    -+  if (head)
    -+          argv_array_push(&diff_args, head);
    ++  if (head_oid)
    ++          argv_array_push(&diff_args, oid_to_hex(head_oid));
     +  argv_array_push(&diff_args, "--");
     +  if (info->argc)
     +          argv_array_pushv(&diff_args, info->argv);
    @@ builtin/submodule--helper.c: static int module_name(int argc, const char **argv,
     +  rev.diffopt.format_callback_data = &list;
     +
     +  if (!info->cached) {
    -+          if (diff_cmd ==  DIFF_INDEX)
    ++          if (diff_cmd == DIFF_INDEX)
     +                  setup_work_tree();
     +          if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
     +                  perror("read_cache_preload");
    @@ builtin/submodule--helper.c: static int module_name(int argc, const char **argv,
     +  struct summary_cb info = SUMMARY_CB_INIT;
     +  int cached = 0;
     +  int for_status = 0;
    -+  int quiet = 0;
     +  int files = 0;
     +  int summary_limit = -1;
    -+  struct child_process cp_rev = CHILD_PROCESS_INIT;
    -+  struct strbuf sb = STRBUF_INIT;
     +  enum diff_cmd diff_cmd = DIFF_INDEX;
    ++  struct object_id head_oid;
     +  int ret;
     +
     +  struct option module_summary_options[] = {
    -+          OPT__QUIET(&quiet, N_("Suppress output of summarising submodules")),
     +          OPT_BOOL(0, "cached", &cached,
    -+                   N_("Use the commit stored in the index instead of the submodule HEAD")),
    ++                   N_("use the commit stored in the index instead of the submodule HEAD")),
     +          OPT_BOOL(0, "files", &files,
    -+                   N_("To compare the commit in the index with that in the submodule HEAD")),
    ++                   N_("to compare the commit in the index with that in the submodule HEAD")),
     +          OPT_BOOL(0, "for-status", &for_status,
    -+                   N_("Skip submodules with 'ignore_config' value set to 'all'")),
    ++                   N_("skip submodules with 'ignore_config' value set to 'all'")),
     +          OPT_INTEGER('n', "summary-limit", &summary_limit,
    -+                       N_("Limit the summary size")),
    ++                       N_("limit the summary size")),
     +          OPT_END()
     +  };
     +
    @@ builtin/submodule--helper.c: static int module_name(int argc, const char **argv,
     +  if (!summary_limit)
     +          return 0;
     +
    -+  cp_rev.git_cmd = 1;
    -+  argv_array_pushl(&cp_rev.args, "rev-parse", "-q", "--verify",
    -+                   argc ? argv[0] : "HEAD", NULL);
    -+
    -+  if (!capture_command(&cp_rev, &sb, 0)) {
    -+          strbuf_strip_suffix(&sb, "\n");
    ++  if (!get_oid(argc ? argv[0] : "HEAD", &head_oid)) {
     +          if (argc) {
     +                  argv++;
     +                  argc--;
     +          }
     +  } else if (!argc || !strcmp(argv[0], "HEAD")) {
     +          /* before the first commit: compare with an empty tree */
    -+          struct stat st;
    -+          struct object_id oid;
    -+          if (fstat(0, &st) < 0 || index_fd(&the_index, &oid, 0, &st, 2,
    -+                                            prefix, 3))
    -+                  die("Unable to add %s to database", oid.hash);
    -+          strbuf_addstr(&sb, oid_to_hex(&oid));
    ++          oidcpy(&head_oid, the_hash_algo->empty_tree);
     +          if (argc) {
     +                  argv++;
     +                  argc--;
     +          }
     +  } else {
    -+          strbuf_addstr(&sb, "HEAD");
    ++          if (get_oid("HEAD", &head_oid))
    ++                  die(_("could not fetch a revision for HEAD"));
     +  }
     +
     +  if (files) {
    @@ builtin/submodule--helper.c: static int module_name(int argc, const char **argv,
     +  info.argv = argv;
     +  info.prefix = prefix;
     +  info.cached = !!cached;
    ++  info.files = !!files;
     +  info.for_status = !!for_status;
    -+  info.quiet = quiet;
    -+  info.files = files;
     +  info.summary_limit = summary_limit;
     +
    -+  ret = compute_summary_module_list((diff_cmd == DIFF_FILES) ? NULL : sb.buf,
    -+                                     &info, diff_cmd);
    -+  strbuf_release(&sb);
    ++  ret = compute_summary_module_list((diff_cmd == DIFF_INDEX) ? &head_oid : NULL,
    ++                                    &info, diff_cmd);
     +  return ret;
     +}
     +
    @@ git-submodule.sh: cmd_summary() {
     -          fi
     -          echo
     -  done
    -+  git ${wt_prefix:+-C "$wt_prefix"} submodule--helper summary ${GIT_QUIET:+--quiet} ${prefix:+--prefix "$prefix"} ${for_status:+--for-status} ${files:+--files} ${cached:+--cached} ${summary_limit:+-n $summary_limit} "$@"
    ++  git ${wt_prefix:+-C "$wt_prefix"} submodule--helper summary ${prefix:+--prefix "$prefix"} ${files:+--files} ${cached:+--cached} ${for_status:+--for-status} ${summary_limit:+-n $summary_limit} -- "$@"
      }
      #
      # List all submodules, prefixed with:
    +
    + ## t/t7421-submodule-summary-add.sh ##
    +@@ t/t7421-submodule-summary-add.sh: test_expect_success 'submodule summary output for submodules with changed paths'
    +   git commit -m "change submodule path" &&
    +   rev=$(git -C sm rev-parse --short HEAD^) &&
    +   git submodule summary HEAD^^ -- my-subm >actual 2>err &&
    +-  test_i18ngrep "fatal:.*my-subm" err &&
    ++  grep "fatal:.*my-subm" err &&
    +   cat >expected <<-EOF &&
    +   * my-subm ${rev}...0000000:
    + 

Prathamesh Chavan (1):
  submodule: port submodule subcommand 'summary' from shell to C

Shourya Shukla (4):
  submodule: expose the '--for-status' option of summary
  submodule: remove extra line feeds between callback struct and macro
  submodule: rename helper functions to avoid ambiguity
  t7421: introduce a test script for verifying 'summary' output

 Documentation/git-submodule.txt        |   8 +-
 builtin/submodule--helper.c            | 439 ++++++++++++++++++++++++-
 contrib/completion/git-completion.bash |   2 +-
 diff.c                                 |   2 +-
 git-submodule.sh                       | 188 +----------
 submodule.c                            |  10 +-
 submodule.h                            |   2 +-
 t/t7421-submodule-summary-add.sh       |  69 ++++
 8 files changed, 522 insertions(+), 198 deletions(-)
 create mode 100755 t/t7421-submodule-summary-add.sh

-- 
2.28.0

