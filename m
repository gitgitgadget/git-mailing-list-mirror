Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE8FC433ED
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 02:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA64E61178
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 02:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbhDJCEN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 22:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbhDJCEL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 22:04:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACBEC061763
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 19:03:57 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 12so3777304wmf.5
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 19:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+ZbCteYk911AHUKcwxzUe7Bagc0zgojgJVYwQ6+RGQ0=;
        b=t+r++CX/rtLjF1e5Y3sWLPoZZgP5rNZbEw7JBUNhhWWkvihSl17NE+Nn8STPEHIfxO
         AzhYilab5j7hCBmoHJaMS4/7ot07WaHQChNB6BxpYQcMzgU3WfktjSEaEN/hF9OG+YAz
         065LQ9IFodieqn/Okx1ne7SfRJzaVbZYWu2N6lzqR7s5kC4i5pAgc7OVJv6G+rM88t5S
         1ftG7L43yS0YkMYAGvqCofJnCWoXpD3fz6QwixyL15RAVcuEQFo5gNXlVA1XWcK2NSM0
         5ehh4ZrTq0ZGetVIuxkayN0iymukz2Pq8ohLhxwxAeGcpospG3YRNS9egCDhlJePKrn1
         GmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+ZbCteYk911AHUKcwxzUe7Bagc0zgojgJVYwQ6+RGQ0=;
        b=S5Y6c3u2z978V6FdX3GUhiZOvmnaNB836n6xEKs6ViCNxyIl8q0iVCEYmuF/szrLha
         A2qJpZ19/WNnotVif5Ew+AOruyYMBIB0XnAxN+vRO2kVW2WaJxR1nwfGovcuDnBbCJJQ
         cXTrdEk2TKTLexNYkVF0AUkmO8OCFrNHDO4NdZZRXBch7F3INjgNTl8+J5CauXS4SMGa
         jMEAz2XuJKlyjJtphhHDGnwVBQVySi9dFPRE6f8oqAZBcgl6Mk7+Jw9L0iH1G4L5Z3iy
         IDzUv3OXSNbKv1EA6AvfAxNQDB5cliqVgLDmO7/zKjylUhn/NuvT/l4wc3Jzo+yVHLum
         nswA==
X-Gm-Message-State: AOAM530i3+wvAORk+TwYAMqmE0zu9LwXK3d+XSaoF0AcZINyTj3Njzny
        LIvC6gXtvTfOXx+PuBpFZ781OPpoc3o=
X-Google-Smtp-Source: ABdhPJzkJ3vL2809DdfPlqlGjjPQ/szrX6wkzZP7BGyUjEqrm6B7sTxCdLX3oLTpXbM1YY3uFh/YIg==
X-Received: by 2002:a1c:c341:: with SMTP id t62mr16191394wmf.27.1618020227173;
        Fri, 09 Apr 2021 19:03:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d5sm8443326wrx.0.2021.04.09.19.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 19:03:46 -0700 (PDT)
Message-Id: <pull.924.v3.git.1618020225.gitgitgadget@gmail.com>
In-Reply-To: <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
References: <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Apr 2021 02:03:42 +0000
Subject: [PATCH v3 0/3] Maintenance: adapt custom refspecs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     tom.saeger@oracle.com, gitster@pobox.com, sunshine@sunshineco.com,
        Derrick Stolee <stolee@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tom Saeger rightly pointed out [1] that the prefetch task ignores custom
refspecs. This can lead to downloading more data than requested, and it
doesn't even help the future foreground fetches that use that custom
refspec.

[1]
https://lore.kernel.org/git/20210401184914.qmr7jhjbhp2mt3h6@dhcp-10-154-148-175.vpn.oracle.com/

This series fixes this problem by carefully replacing the start of each
refspec's destination with "refs/prefetch/". If the destination already
starts with "refs/", then that is replaced. Otherwise "refs/prefetch/" is
just prepended.

This happens inside of git fetch when a --prefetch option is given. This
allows us to maniuplate a struct refspec_item instead of a full refspec
string. It also simplifies our logic in testing the prefetch task.


Update in V3
============

 * The fix is almost completely rewritten as an update to 'git fetch'. See
   the new PATCH 2 for this update.

 * There was some discussion of rewriting test_subcommand, but that can be
   delayed until a proper solution is found to complications around softer
   matches.


Updates in V2
=============

Thanks for the close eye on this series. I appreciate the recommendations,
which I believe I have responded to them all:

 * Fixed typos.
 * Made refspec_item_format() re-entrant. Consumers must free the buffer.
 * Cleaned up style (quoting and tabbing).

Thanks, -Stolee

Derrick Stolee (3):
  maintenance: simplify prefetch logic
  fetch: add --prefetch option
  maintenance: use 'git fetch --prefetch'

 Documentation/fetch-options.txt   |  5 +++
 Documentation/git-maintenance.txt |  6 ++--
 builtin/fetch.c                   | 56 +++++++++++++++++++++++++++++++
 builtin/gc.c                      | 36 +++++---------------
 t/t5582-fetch-negative-refspec.sh | 30 +++++++++++++++++
 t/t7900-maintenance.sh            | 14 ++++----
 6 files changed, 109 insertions(+), 38 deletions(-)


base-commit: 89b43f80a514aee58b662ad606e6352e03eaeee4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-924%2Fderrickstolee%2Fmaintenance%2Frefspec-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-924/derrickstolee/maintenance/refspec-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/924

Range-diff vs v2:

 1:  5aa0cb06c3f2 = 1:  4c0e983ba56f maintenance: simplify prefetch logic
 2:  d58a3e042ee8 < -:  ------------ test-lib: use exact match for test_subcommand
 3:  96388d949b98 < -:  ------------ refspec: output a refspec item
 4:  bf296282323a < -:  ------------ test-tool: test refspec input/output
 -:  ------------ > 2:  7f488eea6dbd fetch: add --prefetch option
 5:  9592224e3d42 ! 3:  ed055d772452 maintenance: allow custom refspecs during prefetch
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    maintenance: allow custom refspecs during prefetch
     +    maintenance: use 'git fetch --prefetch'
      
     -    The prefetch task previously used the default refspec source plus a
     -    custom refspec destination to avoid colliding with remote refs:
     +    The 'prefetch' maintenance task previously forced the following refspec
     +    for each remote:
      
                  +refs/heads/*:refs/prefetch/<remote>/*
      
     -    However, some users customize their refspec to reduce how much data they
     -    download from specific remotes. This can involve restrictive patterns
     -    for fetching or negative patterns to avoid downloading some refs.
     +    If a user has specified a more strict refspec for the remote, then this
     +    prefetch task downloads more objects than necessary.
      
     -    Modify fetch_remote() to iterate over the remote's refspec list and
     -    translate that into the appropriate prefetch scenario. Specifically,
     -    re-parse the raw form of the refspec into a new 'struct refspec' and
     -    modify the 'dst' member to replace a leading "refs/" substring with
     -    "refs/prefetch/", or prepend "refs/prefetch/" to 'dst' otherwise.
     -    Negative refspecs do not have a 'dst' so they can be transferred to the
     -    'git fetch' command unmodified.
     -
     -    This prefix change provides the benefit of keeping whatever collisions
     -    may exist in the custom refspecs, if that is a desirable outcome.
     -
     -    This changes the names of the refs that would be fetched by the default
     -    refspec. Instead of "refs/prefetch/<remote>/<branch>" they will now go
     -    to "refs/prefetch/remotes/<remote>/<branch>". While this is a change, it
     -    is not a seriously breaking one: these refs are intended to be hidden
     -    and not used.
     +    The previous change introduced the '--prefetch' option to 'git fetch'
     +    which manipulates the remote's refspec to place all resulting refs into
     +    refs/prefetch/, with further partitioning based on the destinations of
     +    those refspecs.
      
          Update the documentation to be more generic about the destination refs.
     -    Do not mention custom refpecs explicitly, as that does not need to be
     +    Do not mention custom refspecs explicitly, as that does not need to be
          highlighted in this documentation. The important part of placing refs in
     -    refs/prefetch remains.
     +    refs/prefetch/ remains.
      
          Reported-by: Tom Saeger <tom.saeger@oracle.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## Documentation/git-maintenance.txt ##
     -@@ Documentation/git-maintenance.txt: prefetch::
     +@@ Documentation/git-maintenance.txt: commit-graph::
     + prefetch::
     + 	The `prefetch` task updates the object directory with the latest
       	objects from all registered remotes. For each remote, a `git fetch`
     - 	command is run. The refmap is custom to avoid updating local or remote
     - 	branches (those in `refs/heads` or `refs/remotes`). Instead, the
     +-	command is run. The refmap is custom to avoid updating local or remote
     +-	branches (those in `refs/heads` or `refs/remotes`). Instead, the
      -	remote refs are stored in `refs/prefetch/<remote>/`. Also, tags are
      -	not updated.
     -+	refs are stored in `refs/prefetch/`. Also, tags are not updated.
     ++	command is run. The configured refspec is modified to place all
     ++	requested refs within `refs/prefetch/`. Also, tags are not updated.
       +
       This is done to avoid disrupting the remote-tracking branches. The end users
       expect these refs to stay unmoved unless they initiate a fetch.  With prefetch
      
       ## builtin/gc.c ##
     -@@
     - #include "remote.h"
     - #include "object-store.h"
     - #include "exec-cmd.h"
     -+#include "refspec.h"
     - 
     - #define FAILED_RUN "failed to run %s"
     - 
      @@ builtin/gc.c: static int fetch_remote(struct remote *remote, void *cbdata)
     - {
     - 	struct maintenance_run_opts *opts = cbdata;
       	struct child_process child = CHILD_PROCESS_INIT;
     -+	int i;
       
       	child.git_cmd = 1;
     - 	strvec_pushl(&child.args, "fetch", remote->name, "--prune", "--no-tags",
     -@@ builtin/gc.c: static int fetch_remote(struct remote *remote, void *cbdata)
     +-	strvec_pushl(&child.args, "fetch", remote->name, "--prune", "--no-tags",
     ++	strvec_pushl(&child.args, "fetch", remote->name,
     ++		     "--prefetch", "--prune", "--no-tags",
     + 		     "--no-write-fetch-head", "--recurse-submodules=no",
     +-		     "--refmap=", NULL);
     ++		     NULL);
     + 
       	if (opts->quiet)
       		strvec_push(&child.args, "--quiet");
       
      -	strvec_pushf(&child.args, "+refs/heads/*:refs/prefetch/%s/*", remote->name);
     -+	for (i = 0; i < remote->fetch.nr; i++) {
     -+		struct refspec_item replace;
     -+		struct refspec_item *rsi = &remote->fetch.items[i];
     -+		struct strbuf new_dst = STRBUF_INIT;
     -+		size_t ignore_len = 0;
     -+		char *replace_string;
     -+
     -+		if (rsi->negative) {
     -+			strvec_push(&child.args, remote->fetch.raw[i]);
     -+			continue;
     -+		}
     -+
     -+		refspec_item_init(&replace, remote->fetch.raw[i], 1);
     -+
     -+		/*
     -+		 * If a refspec dst starts with "refs/" at the start,
     -+		 * then we will replace "refs/" with "refs/prefetch/".
     -+		 * Otherwise, we will prepend the dst string with
     -+		 * "refs/prefetch/".
     -+		 */
     -+		if (!strncmp(replace.dst, "refs/", 5))
     -+			ignore_len = 5;
     -+
     -+		strbuf_addstr(&new_dst, "refs/prefetch/");
     -+		strbuf_addstr(&new_dst, replace.dst + ignore_len);
     -+		free(replace.dst);
     -+		replace.dst = strbuf_detach(&new_dst, NULL);
     -+
     -+		replace_string = refspec_item_format(&replace);
     -+		strvec_push(&child.args, replace_string);
     -+		free(replace_string);
     -+
     -+		refspec_item_clear(&replace);
     -+	}
     - 
     +-
       	return !!run_command(&child);
       }
     + 
      
       ## t/t7900-maintenance.sh ##
      @@ t/t7900-maintenance.sh: test_expect_success 'prefetch multiple remotes' '
     + 	test_commit -C clone1 one &&
       	test_commit -C clone2 two &&
       	GIT_TRACE2_EVENT="$(pwd)/run-prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
     - 	fetchargs="--prune --no-tags --no-write-fetch-head --recurse-submodules=no --refmap= --quiet" &&
     --	test_subcommand git fetch remote1 $fetchargs "+refs/heads/*:refs/prefetch/remote1/*" <run-prefetch.txt &&
     --	test_subcommand git fetch remote2 $fetchargs "+refs/heads/*:refs/prefetch/remote2/*" <run-prefetch.txt &&
     -+	test_subcommand git fetch remote1 $fetchargs "+refs/heads/*:refs/prefetch/remotes/remote1/*" <run-prefetch.txt &&
     -+	test_subcommand git fetch remote2 $fetchargs "+refs/heads/*:refs/prefetch/remotes/remote2/*" <run-prefetch.txt &&
     +-	fetchargs="--prune --no-tags --no-write-fetch-head --recurse-submodules=no --refmap= --quiet" &&
     +-	test_subcommand git fetch remote1 $fetchargs +refs/heads/\\*:refs/prefetch/remote1/\\* <run-prefetch.txt &&
     +-	test_subcommand git fetch remote2 $fetchargs +refs/heads/\\*:refs/prefetch/remote2/\\* <run-prefetch.txt &&
     ++	fetchargs="--prefetch --prune --no-tags --no-write-fetch-head --recurse-submodules=no --quiet" &&
     ++	test_subcommand git fetch remote1 $fetchargs <run-prefetch.txt &&
     ++	test_subcommand git fetch remote2 $fetchargs <run-prefetch.txt &&
       	test_path_is_missing .git/refs/remotes &&
      -	git log prefetch/remote1/one &&
      -	git log prefetch/remote2/two &&
     @@ t/t7900-maintenance.sh: test_expect_success 'prefetch multiple remotes' '
       
       	test_cmp_config refs/prefetch/ log.excludedecoration &&
       	git log --oneline --decorate --all >log &&
     - 	! grep "prefetch" log
     - '
     - 
     -+test_expect_success 'prefetch custom refspecs' '
     -+	git -C clone1 branch -f special/fetched HEAD &&
     -+	git -C clone1 branch -f special/secret/not-fetched HEAD &&
     -+
     -+	# create multiple refspecs for remote1
     -+	git config --add remote.remote1.fetch "+refs/heads/special/fetched:refs/heads/fetched" &&
     -+	git config --add remote.remote1.fetch "^refs/heads/special/secret/not-fetched" &&
     -+
     -+	GIT_TRACE2_EVENT="$(pwd)/prefetch-refspec.txt" git maintenance run --task=prefetch 2>/dev/null &&
     -+
     -+	fetchargs="--prune --no-tags --no-write-fetch-head --recurse-submodules=no --refmap= --quiet" &&
     -+
     -+	# skips second refspec because it is not a pattern type
     -+	rs1="+refs/heads/*:refs/prefetch/remotes/remote1/*" &&
     -+	rs2="+refs/heads/special/fetched:refs/prefetch/heads/fetched" &&
     -+	rs3="^refs/heads/special/secret/not-fetched" &&
     -+
     -+	test_subcommand git fetch remote1 $fetchargs "$rs1" "$rs2" "$rs3" <prefetch-refspec.txt &&
     -+	test_subcommand git fetch remote2 $fetchargs "+refs/heads/*:refs/prefetch/remotes/remote2/*" <prefetch-refspec.txt &&
     -+
     -+	# first refspec is overridden by second
     -+	test_must_fail git rev-parse refs/prefetch/special/fetched &&
     -+	git rev-parse refs/prefetch/heads/fetched &&
     -+
     -+	# possible incorrect places for the non-fetched ref
     -+	test_must_fail git rev-parse refs/prefetch/remotes/remote1/secret/not-fetched &&
     -+	test_must_fail git rev-parse refs/prefetch/remotes/remote1/not-fetched &&
     -+	test_must_fail git rev-parse refs/heads/secret/not-fetched &&
     -+	test_must_fail git rev-parse refs/heads/not-fetched
     -+'
     -+
     - test_expect_success 'prefetch and existing log.excludeDecoration values' '
     - 	git config --unset-all log.excludeDecoration &&
     - 	git config log.excludeDecoration refs/remotes/remote1/ &&

-- 
gitgitgadget
