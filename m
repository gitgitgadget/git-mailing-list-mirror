Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B23C4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 07:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D74D02083B
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 07:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQl3xZTG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgJGHpw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 03:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbgJGHpv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 03:45:51 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1931C061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 00:45:51 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n9so848102pgf.9
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 00:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pVI95h2tk35Oy9YSBrJ0TMYD4efCGGexOhccwRAk6pM=;
        b=cQl3xZTGP7QJ9DEtRb9qYO3bz23QWt9Z5GvsAqivMRBY5Nln67Cq9prLHdNS0A3b3K
         H5E68HPhb0l6DtbeMvVX7Qxv4zXuDx5Hlvi/mj85CCRU9XLxo9GQkXG/ZRZegLXKbqRB
         EBedRLVDiGxQoPQTkMWSi6bqd/hoY8tsDYvbSpD161zxsz9xcgYyw/nsHKYEO8v5uPoO
         W9ZKwP+eCQQ6FEOXgIvYCs2wpvq6c16l0OLU712JNPC110gB+Za97UIry4A1SyQHFHXx
         9t7cRn/y6THmr6BzIjYd2FIILk7zM8Cyi429ek7WEgMP7bdjg4VYNvM4foxsg33yk9US
         yjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pVI95h2tk35Oy9YSBrJ0TMYD4efCGGexOhccwRAk6pM=;
        b=WqsKsmdaWRShEbL4mrksgePd64ke8GWAOJ0QjS4OY5bUUeJJsmN9AipBxwu0RKPOmO
         qQpG3z/nsN+LIfQcdmQvprdXA+R0xPss5+uzHZydB3LRzvgA9ueJDWZi42ud6tZcWcc6
         9ZlsLVLgCjberYNcBjqAGhQNo9KKwzXQlLELwm7D0dU53LpcF+cUgSaAzN4LITyPBIoW
         qZLGKIu3sVgweTAanhF19w4K87Ua4kYKy8ADkBQg+izfmFpBEB5yoNqkCu+Zw+sA0+5B
         GNXhlVr71W11iYAhGz9vKEizKaAbb5zAdLwM0KxtkzO3mDQaMUnhXpTAB0fjkhD5qhdY
         5bnw==
X-Gm-Message-State: AOAM532WgvomzKGNGU6LEbT9pjSumEOMZPwaJM5WAy0rnZcTTAX9dAkx
        ZZQoUHZyDVfRAGKXXiBUwKR9J0sUe9mpVw==
X-Google-Smtp-Source: ABdhPJyCL5eIc2IZEdd4caLNyhG9nsm2u9CIZP7BHrZiE9T6UK/7RCmhSgadNdracJWW4udDfetLHw==
X-Received: by 2002:a65:5a0d:: with SMTP id y13mr1924445pgs.436.1602056750580;
        Wed, 07 Oct 2020 00:45:50 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.141])
        by smtp.gmail.com with ESMTPSA id o17sm1273728pji.30.2020.10.07.00.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 00:45:49 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, Johannes.Schindelin@gmx.de,
        liu.denton@gmail.com, Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v2 0/3] submodule: port subcommand add from shell to C
Date:   Wed,  7 Oct 2020 13:15:35 +0530
Message-Id: <20201007074538.25891-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

This is the v2 of the patch with the same title, delivered more than a
month ago as a part of my GSoC. Link to v1:
https://lore.kernel.org/git/20200824090359.403944-1-shouryashukla.oo@gmail.com/

The changelog is as follows:

    1. Introduce PATCH[1/3](dir: change the scope of function
       'directory_exists_in_index()', 2020-10-06). This was done since
       the above mentioned function will be used in the patch that
       follows.

    2. There are multiple changes in this commit:

            A. Improve the part which checks if the 'path' given as
               argument exists or not. Implementing Kaartic's
               suggestions on the patch, I had to make sure that the
               case for checking if the path has tracked contents or
               not also works.

            B. Also, wrap the aforementioned segment in a function
               since it became very long. The function is called
               'check_sm_exists()'.

            C. Also, use the function 'is_nonbare_repository_dir()'
               instead of 'is_directory()' when trying to resolve
               gitlink.

            D. Append keyword 'fatal' in front of the expected output of
               test t7400.6 since the command die()s out in case of
               absence of commits in a submodule.

            E. Remove the extra `#include "dir.h"` from
               'submodule--helper.c'.

    3. Introduce PATCH[3/3] (t7400: add test to check 'submodule add'
       for tracked paths, 2020-10-07). Kaartic pointed out that a test
       for path with tracked contents did not exist and hence it was
       necessary to write one. Therefore, this commit introduces a new
       test 't7400.18: submodule add to path with tracked contents
       fails'.

Comments and feedback are appreciated. Sorry for the month long delay, I
was on a vacation.

I am attaching a range-diff between v1 and v2 at the end of this mail.

Regards,
Shourya Shukla
-----

-:  ---------- > 1:  bdac00494e dir: change the scope of function 'directory_exists_in_index()'
1:  b08d81e179 ! 2:  3e20d0fe04 submodule: port submodule subcommand 'add' from shell to C
    @@ Commit message
         'git-submodule.sh'.

         Also, since the command die()s out in case of absence of commits in the
    -    submodule and exits with exit status 1 when we try adding a submodule
    -    which is mentioned in .gitignore, the keyword 'fatal' is prefixed in the
    -    error messages. Therefore, prepend the keyword in the expected outputs
    -    of tests t7400.6 and t7400.16.
    +    submodule, the keyword 'fatal' is prefixed in the error messages.
    +    Therefore, prepend the keyword in the expected output of test t7400.6.
    +
    +    While at it, eliminate the extra preprocessor directive
    +    `#include "dir.h"` at the start of 'submodule--helper.c'.

         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Mentored-by: Stefan Beller <stefanbeller@gmail.com>
    @@ Commit message
         Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>

      ## builtin/submodule--helper.c ##
    +@@
    + #include "diffcore.h"
    + #include "diff.h"
    + #include "object-store.h"
    +-#include "dir.h"
    + #include "advice.h"
    +
    + #define OPT_QUIET (1 << 0)
     @@ builtin/submodule--helper.c: static int module_set_branch(int argc, const char **argv, const char *prefix)
        return !!ret;
      }
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, const char *
     +  free(url);
     +}
     +
    ++static int check_sm_exists(unsigned int force, const char *path) {
    ++
    ++  int cache_pos, dir_in_cache = 0;
    ++  if (read_cache() < 0)
    ++          die(_("index file corrupt"));
    ++
    ++  cache_pos = cache_name_pos(path, strlen(path));
    ++  if(cache_pos < 0 && (directory_exists_in_index(&the_index,
    ++     path, strlen(path)) == index_directory))
    ++          dir_in_cache = 1;
    ++
    ++  if (!force) {
    ++          if (cache_pos >= 0 || dir_in_cache)
    ++                  die(_("'%s' already exists in the index"), path);
    ++  } else {
    ++          struct cache_entry *ce = NULL;
    ++          if (cache_pos >= 0)
    ++                  ce = the_index.cache[cache_pos];
    ++          if (dir_in_cache || (ce && !S_ISGITLINK(ce->ce_mode)))
    ++                  die(_("'%s' already exists in the index and is not a "
    ++                        "submodule"), path);
    ++  }
    ++  return 0;
    ++}
    ++
     +static void modify_remote_v(struct strbuf *sb)
     +{
     +  int i;
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, const char *
     +  if (is_dir_sep(path[strlen(path) -1]))
     +          path[strlen(path) - 1] = '\0';
     +
    -+  if (!force) {
    -+          if (is_directory(path) && submodule_from_path(the_repository, &null_oid, path))
    -+                  die(_("'%s' already exists in the index"), path);
    -+  } else {
    -+          int err;
    -+          if (index_name_pos(&the_index, path, strlen(path)) >= 0 &&
    -+              !is_submodule_populated_gently(path, &err))
    -+                  die(_("'%s' already exists in the index and is not a "
    -+                        "submodule"), path);
    -+  }
    ++  if (check_sm_exists(force, path))
    ++          return 1;
     +
     +  strbuf_addstr(&sb, path);
    -+  if (is_directory(path)) {
    ++  if (is_nonbare_repository_dir(&sb)) {
     +          struct object_id oid;
     +          if (resolve_gitlink_ref(path, "HEAD", &oid) < 0)
     +                  die(_("'%s' does not have a commit checked out"), path);
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, const char *
     +          cp.no_stdout = 1;
     +          strvec_pushl(&cp.args, "add", "--dry-run", "--ignore-missing",
     +                       "--no-warn-embedded-repo", path, NULL);
    -+          if (pipe_command(&cp, NULL, 0, NULL, 0, &sb, 0))
    -+                  die(_("%s"), sb.buf);
    ++          if (pipe_command(&cp, NULL, 0, NULL, 0, &sb, 0)) {
    ++                  fprintf(stderr, _("%s"), sb.buf);
    ++                  return 1;
    ++          }
     +          strbuf_release(&sb);
     +  }
     +
    @@ t/t7400-submodule-basic.sh: test_expect_success 'submodule update aborts on miss
        EOF
        git init repo-no-commits &&
        test_must_fail git submodule add ../a ./repo-no-commits 2>actual &&
    -@@ t/t7400-submodule-basic.sh: test_expect_success 'submodule add to .gitignored path fails' '
    -   (
    -           cd addtest-ignore &&
    -           cat <<-\EOF >expect &&
    --          The following paths are ignored by one of your .gitignore files:
    -+          fatal: The following paths are ignored by one of your .gitignore files:
    -           submod
    -           hint: Use -f if you really want to add them.
    -           hint: Turn this message off by running
    -           hint: "git config advice.addIgnoredFile false"
    -+
    -           EOF
    -           # Does not use test_commit due to the ignore
    -           echo "*" > .gitignore &&
-:  ---------- > 3:  98b05eb46d t7400: add test to check 'submodule add' for tracked paths
-----

Prathamesh Chavan (1):
  submodule: port submodule subcommand 'add' from shell to C

Shourya Shukla (2):
  dir: change the scope of function 'directory_exists_in_index()'
  t7400: add test to check 'submodule add' for tracked paths

 builtin/submodule--helper.c | 391 +++++++++++++++++++++++++++++++++++-
 dir.c                       |  10 +-
 dir.h                       |   9 +
 git-submodule.sh            | 161 +--------------
 t/t7400-submodule-basic.sh  |  13 +-
 5 files changed, 414 insertions(+), 170 deletions(-)

-- 
2.28.0

