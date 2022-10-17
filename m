Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEDFC433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 12:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJQMJm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 08:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJQMJf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 08:09:35 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9891A10B70
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 05:09:31 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bu30so18124228wrb.8
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 05:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X60EmtfS3FYzYZZ0j0+fWt8BgOfXfIHRMMCHy1P8Dlo=;
        b=WCGcfsr+Xa5q1QPqwwU+582t+8piCGzi+mX6JwrU6QtYWl4vqThLRHmUoVYWJ3UJE1
         AIC48DPO5TMOUgA+GSdap0tRrEkNBWN3QFTaeYpjLaDGSgpVoAjSi3N+rSz4BjGLqrOv
         eYkK8fkhwZlWe1P/t6ufekiUEZdXXGSv+0YHRIKR9ONlOIfDjs8kdcM8lFIQLbKIrYB6
         Ip3pF/GJza+NkFdnXKHYm41ylSsFPkg/1h8LIwCnRPIVaVNjXAaWSNhNWGiOgw1KKZKU
         SmlLPAmVRk+rEdTHuz/iEB/IikM1RAKhCoHXOIFeBQ4QZxgHJwLqVgGwLzkeQcHFDKHe
         4dyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X60EmtfS3FYzYZZ0j0+fWt8BgOfXfIHRMMCHy1P8Dlo=;
        b=5e4dy/3RcCgcPaz+2e/FR4HVyoLKH617LFrHxfePXw7rUIX+ELfpAvYBG7MSmXjTd5
         yRPFRnWl1qeJqZGlKkdrPkueH+yJgFjqGEc8bCaeI60qcQ8DOcqlNNY1fAEHtBEYXiqi
         niSKp1llZYeb+XY3NVJn0a2s5cgITEH4w8tVKQ6E8X/ZcBPIzwQkrMe4j3gLhp3oJde1
         BpjnqOOhyqTBfpU9C9ogKoa2iXKRHv8TS/m5mQbRHYhk9NyfnV/BTbz3GiGOIpFhOrFt
         VUyGRLHbT71EeKJ0MTpezJI7OR+hYKk4Ia+s5ucs+BzmBu9j8ddSuAtb+1p/FpfIvzpm
         niCw==
X-Gm-Message-State: ACrzQf1ki7oSEFZ8ZB5b9UElIAmuMq6UU8jSN8uHWQvPmdE4SiUY2UQO
        OYe66RDpitBjChzYPyMIiExDiWPJiCwVwQ==
X-Google-Smtp-Source: AMsMyM5+9aRua4DRX6m2ixF0iptDFh3JMyX3ihdQsb1U3tAjB4irAobROjbuFWonpHD3Np42zFI2VA==
X-Received: by 2002:a05:6000:1541:b0:231:115e:9bb8 with SMTP id 1-20020a056000154100b00231115e9bb8mr6405053wry.51.1666008569000;
        Mon, 17 Oct 2022 05:09:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6-20020a1cf406000000b003c6deb5c1edsm10028770wma.45.2022.10.17.05.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 05:09:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Jonas Bernoulli <jonas@bernoul.li>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/10] submodule: make it a built-in, remove git-submodule.sh
Date:   Mon, 17 Oct 2022 14:09:15 +0200
Message-Id: <cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1091.gf9d18265e59
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On "master" any special behavior in git-submodule.sh itself has almost
entirely gone away, it's a trivial shimmy layer that dispatches to the
built-in "submodule--helper" command.

This series takes the logical next step and removes "git-submodule.sh"
entirely, replacing it wtih a "builtin/submodule.c". We leave
"builtin/submodule--helper.c" in-place and invoke its
cmd_submodule__helper() from the much smaller
"builtin/submodule.c". We should consolidate them, but let's leave
that cleanup for later.

An earlier version of this was submitted as an RFC in [1], since then
we've had various "prep" series's land to prepare for this final step,
namely:

  - 361cbe6d6d2 (Merge branch 'ab/submodule-cleanup', 2022-07-14)
  - 5647d743e39 (Merge branch 'ab/submodule-helper-prep' into ab/submodule-helper-leakfix, 2022-09-02)
  - b563638d2cf (Merge branch 'ab/submodule-helper-leakfix', 2022-09-14)

The first two made it much easier to take these last steps, as the
"submodule--helper" interface was already mostly mirroring that of
"submodule" itself. The "ab/submodule-helper-leakfix" series then made
it easier to test that our object ownership was still sane.

There's a recent report at [2] that "submodule--helper list" going
away in 5647d743e39 only left the much slower "foreach 'echo $name'"
alternative. As 07/10 and 10/10 here note rewriting this in C makes
that 'echo' version only about 0.1x slower, instead of >6x slower.

For CI & a branch that can be cloned for this series see:
https://github.com/avar/git/tree/avar/submodule-sh-dispatch-to-helper-directly-2

1. https://lore.kernel.org/git/RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com/
2. https://lore.kernel.org/git/87czatrpyb.fsf@bernoul.li/

Ævar Arnfjörð Bjarmason (10):
  git-submodule.sh: create a "case" dispatch statement
  git-submodule.sh: dispatch "sync" to helper
  git-submodule.sh: dispatch directly to helper
  git-submodule.sh: dispatch "foreach" to helper
  git-submodule.sh: dispatch "update" to helper
  git-submodule.sh: don't support top-level "--cached"
  submodule: make it a built-in, remove git-submodule.sh
  submodule: support "--" with no other arguments
  submodule: support sub-command-less "--recursive" option
  submodule: don't use a subprocess to invoke "submodule--helper"

 Documentation/git-submodule.txt |   2 +-
 Makefile                        |   2 +-
 builtin.h                       |   1 +
 builtin/submodule--helper.c     |   3 +-
 builtin/submodule.c             | 178 ++++++++++
 git-submodule.sh                | 611 --------------------------------
 git.c                           |   1 +
 t/t7400-submodule-basic.sh      |  27 +-
 8 files changed, 200 insertions(+), 625 deletions(-)
 create mode 100644 builtin/submodule.c
 delete mode 100755 git-submodule.sh

Range-diff:
 1:  0e9f13822ef <  -:  ----------- git-submodule.sh: remove unused sanitize_submodule_env()
 7:  9f5cfbb864a !  1:  2379d5dc0e0 git-submodule.sh: create a "case" dispatch statement
    @@ Commit message
     
      ## git-submodule.sh ##
     @@ git-submodule.sh: cmd_sync()
    - 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper sync ${GIT_QUIET:+--quiet} ${recursive:+--recursive} -- "$@"
    + 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper sync ${quiet:+--quiet} ${recursive:+--recursive} -- "$@"
      }
      
     -cmd_absorbgitdirs()
 9:  bd0e4a4f8b8 !  2:  46bf600820b git-submodule.sh: dispatch "sync" to helper
    @@ Commit message
      ## git-submodule.sh ##
     @@ git-submodule.sh: cmd_status()
      
    - 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper status ${GIT_QUIET:+--quiet} ${cached:+--cached} ${recursive:+--recursive} -- "$@"
    + 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper status ${quiet:+--quiet} ${cached:+--cached} ${recursive:+--recursive} -- "$@"
      }
     -#
     -# Sync remote urls for submodules
    @@ git-submodule.sh: cmd_status()
     -	do
     -		case "$1" in
     -		-q|--quiet)
    --			GIT_QUIET=1
    +-			quiet=1
     -			shift
     -			;;
     -		--recursive)
    @@ git-submodule.sh: cmd_status()
     -		esac
     -	done
     -
    --	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper sync ${GIT_QUIET:+--quiet} ${recursive:+--recursive} -- "$@"
    +-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper sync ${quiet:+--quiet} ${recursive:+--recursive} -- "$@"
     -}
      
      # This loop parses the command line arguments to find the
    @@ git-submodule.sh: case "$command" in
      	;;
     +sync)
     +	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
    -+		${GIT_QUIET:+--quiet} "$@"
    ++		${quiet:+--quiet} "$@"
     +	;;
      *)
      	"cmd_$(echo $command | sed -e s/-/_/g)" "$@"
10:  498a1fd275b !  3:  97cb470c96a git-submodule.sh: dispatch directly to helper
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## git-submodule.sh ##
    -@@ git-submodule.sh: GIT_PROTOCOL_FROM_USER=0
    - export GIT_PROTOCOL_FROM_USER
    +@@ git-submodule.sh: export GIT_PROTOCOL_FROM_USER
      
      command=
    + quiet=
     -branch=
      force=
      reference=
    @@ git-submodule.sh: GIT_PROTOCOL_FROM_USER=0
     -files=
      remote=
      nofetch=
    - update=
    + rebase=
    + merge=
    + checkout=
     -custom_name=
      depth=
      progress=
    @@ git-submodule.sh: jobs=
     -			force=$1
     -			;;
     -		-q|--quiet)
    --			GIT_QUIET=1
    +-			quiet=1
     -			;;
     -		--progress)
     -			progress=1
    @@ git-submodule.sh: jobs=
     -		usage
     -	fi
     -
    --	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper add ${GIT_QUIET:+--quiet} ${force:+--force} ${progress:+"--progress"} ${branch:+--branch "$branch"} ${reference_path:+--reference "$reference_path"} ${dissociate:+--dissociate} ${custom_name:+--name "$custom_name"} ${depth:+"$depth"} -- "$@"
    +-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper add ${quiet:+--quiet} ${force:+--force} ${progress:+"--progress"} ${branch:+--branch "$branch"} ${reference_path:+--reference "$reference_path"} ${dissociate:+--dissociate} ${custom_name:+--name "$custom_name"} ${depth:+"$depth"} -- "$@"
     -}
      
     -#
    @@ git-submodule.sh: jobs=
      # submodule
      #
     @@ git-submodule.sh: cmd_foreach()
    - 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper foreach ${GIT_QUIET:+--quiet} ${recursive:+--recursive} -- "$@"
    + 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper foreach ${quiet:+--quiet} ${recursive:+--recursive} -- "$@"
      }
      
     -#
    @@ git-submodule.sh: cmd_foreach()
     -	do
     -		case "$1" in
     -		-q|--quiet)
    --			GIT_QUIET=1
    +-			quiet=1
     -			;;
     -		--)
     -			shift
    @@ git-submodule.sh: cmd_foreach()
     -		shift
     -	done
     -
    --	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper init ${GIT_QUIET:+--quiet} -- "$@"
    +-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper init ${quiet:+--quiet} -- "$@"
     -}
     -
     -#
    @@ git-submodule.sh: cmd_foreach()
     -			force=$1
     -			;;
     -		-q|--quiet)
    --			GIT_QUIET=1
    +-			quiet=1
     -			;;
     -		--all)
     -			deinit_all=t
    @@ git-submodule.sh: cmd_foreach()
     -		shift
     -	done
     -
    --	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit ${GIT_QUIET:+--quiet} ${force:+--force} ${deinit_all:+--all} -- "$@"
    +-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit ${quiet:+--quiet} ${force:+--force} ${deinit_all:+--all} -- "$@"
     -}
     -
      #
    @@ git-submodule.sh: cmd_update()
     -		shift
     -	done
     -
    --	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-branch ${GIT_QUIET:+--quiet} ${branch:+--branch "$branch"} ${default:+--default} -- "$@"
    +-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-branch ${quiet:+--quiet} ${branch:+--branch "$branch"} ${default:+--default} -- "$@"
     -}
     -
     -#
    @@ git-submodule.sh: cmd_update()
     -	do
     -		case "$1" in
     -		-q|--quiet)
    --			GIT_QUIET=1
    +-			quiet=1
     -			;;
     -		--)
     -			shift
    @@ git-submodule.sh: cmd_update()
     -		shift
     -	done
     -
    --	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-url ${GIT_QUIET:+--quiet} -- "$@"
    +-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-url ${quiet:+--quiet} -- "$@"
     -}
     -
     -#
    @@ git-submodule.sh: cmd_update()
     -	do
     -		case "$1" in
     -		-q|--quiet)
    --			GIT_QUIET=1
    +-			quiet=1
     -			;;
     -		--cached)
     -			cached=1
    @@ git-submodule.sh: cmd_update()
     -		shift
     -	done
     -
    --	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper status ${GIT_QUIET:+--quiet} ${cached:+--cached} ${recursive:+--recursive} -- "$@"
    +-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper status ${quiet:+--quiet} ${cached:+--cached} ${recursive:+--recursive} -- "$@"
     -}
     -
      # This loop parses the command line arguments to find the
    @@ git-submodule.sh: case "$command" in
      	;;
     -sync)
     -	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
    --		${GIT_QUIET:+--quiet} "$@"
    +-		${quiet:+--quiet} "$@"
     +foreach | update)
     +	"cmd_$command" "$@"
      	;;
    @@ git-submodule.sh: case "$command" in
     -	"cmd_$(echo $command | sed -e s/-/_/g)" "$@"
     +add | init | deinit | set-branch | set-url | status | summary | sync)
     +	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
    -+		${GIT_QUIET:+--quiet} ${cached:+--cached} "$@"
    ++		${quiet:+--quiet} ${cached:+--cached} "$@"
      	;;
      esac
11:  625320e13b9 !  4:  db6a09ee42a git-submodule.sh: dispatch "foreach" to helper
    @@ Commit message
     
      ## builtin/submodule--helper.c ##
     @@ builtin/submodule--helper.c: static int module_foreach(int argc, const char **argv, const char *prefix)
    - 	};
    + 	int ret = 1;
      
      	argc = parse_options(argc, argv, prefix, module_foreach_options,
     -			     git_submodule_helper_usage, 0);
    @@ builtin/submodule--helper.c: static int module_foreach(int argc, const char **ar
     +			     PARSE_OPT_STOP_AT_NON_OPTION);
      
      	if (module_list_compute(0, NULL, prefix, &pathspec, &list) < 0)
    - 		return 1;
    + 		goto cleanup;
     
      ## git-submodule.sh ##
     @@ git-submodule.sh: jobs=
    @@ git-submodule.sh: jobs=
     -	do
     -		case "$1" in
     -		-q|--quiet)
    --			GIT_QUIET=1
    +-			quiet=1
     -			;;
     -		--recursive)
     -			recursive=1
    @@ git-submodule.sh: jobs=
     -		shift
     -	done
     -
    --	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper foreach ${GIT_QUIET:+--quiet} ${recursive:+--recursive} -- "$@"
    +-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper foreach ${quiet:+--quiet} ${recursive:+--recursive} -- "$@"
     -}
     -
      #
    @@ git-submodule.sh: case "$command" in
     -add | init | deinit | set-branch | set-url | status | summary | sync)
     +add | foreach | init | deinit | set-branch | set-url | status | summary | sync)
      	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
    - 		${GIT_QUIET:+--quiet} ${cached:+--cached} "$@"
    + 		${quiet:+--quiet} ${cached:+--cached} "$@"
      	;;
16:  08abadda7c3 !  5:  7d9c13eb637 git-submodule.sh: dispatch "update" to helper
    @@ Commit message
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## Documentation/git-submodule.txt ##
    -@@ Documentation/git-submodule.txt: SYNOPSIS
    - 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
    - 'git submodule' [--quiet] init [--] [<path>...]
    - 'git submodule' [--quiet] deinit [-f|--force] (--all|[--] <path>...)
    --'git submodule' [--quiet] update [-v] [<options>] [--] [<path>...]
    -+'git submodule' [--quiet] update [-v | --verbose] [<options>] [--] [<path>...]
    - 'git submodule' [--quiet] set-branch [<options>] [--] <path>
    - 'git submodule' [--quiet] set-url [--] <path> <newurl>
    - 'git submodule' [--quiet] summary [<options>] [--] [<path>...]
    -@@ Documentation/git-submodule.txt: If you really want to remove a submodule from the repository and commit
    - that use linkgit:git-rm[1] instead. See linkgit:gitsubmodules[7] for removal
    - options.
    - 
    --update [-v] [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter <filter spec>] [--] [<path>...]::
    -+update [-v | --verbose] [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter <filter spec>] [--] [<path>...]::
    - +
    - --
    - Update the registered submodules to match what the superproject
    -@@ Documentation/git-submodule.txt: OPTIONS
    - 	Only print error messages.
    - 
    - -v::
    -+--verbose::
    - 	Don't be quiet. This option is only valid for the update command.
    - 
    - --progress::
    -
      ## git-submodule.sh ##
    -@@ git-submodule.sh: GIT_PROTOCOL_FROM_USER=0
    - export GIT_PROTOCOL_FROM_USER
    +@@ git-submodule.sh: export GIT_PROTOCOL_FROM_USER
      
      command=
    + quiet=
     -force=
     -reference=
      cached=
    @@ git-submodule.sh: GIT_PROTOCOL_FROM_USER=0
     -	do
     -		case "$1" in
     -		-q|--quiet)
    --			GIT_QUIET=1
    --			;;
    --		-v)
    --			unset GIT_QUIET
    +-			quiet=1
     -			;;
     -		--progress)
     -			progress=1
    @@ git-submodule.sh: GIT_PROTOCOL_FROM_USER=0
     -	done
     -
     -	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper update \
    --		${GIT_QUIET:+--quiet} \
    +-		${quiet:+--quiet} \
     -		${force:+--force} \
     -		${progress:+"--progress"} \
     -		${remote:+--remote} \
    @@ git-submodule.sh: absorbgitdirs)
      update)
     -	cmd_update "$@"
     +	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
    -+		${GIT_QUIET:+--quiet} ${wt_prefix:+--prefix "$wt_prefix"} "$@"
    ++		${quiet:+--quiet} ${wt_prefix:+--prefix "$wt_prefix"} "$@"
      	;;
      add | foreach | init | deinit | set-branch | set-url | status | summary | sync)
      	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
 4:  f27723aa0a2 !  6:  25fadf3ffc1 git-submodule.sh: normalize parsing of "--branch"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    git-submodule.sh: normalize parsing of "--branch"
    +    git-submodule.sh: don't support top-level "--cached"
     
    -    In 5c08dbbdf1a (git-submodule: fix subcommand parser, 2008-01-15) the
    -    "--branch" option was supported as an option to "git submodule"
    -    itself, i.e. "git submodule --branch" as a side-effect of its
    -    implementation.
    +    Since the preceding commit all sub-commands of "git submodule" have
    +    been dispatched to "git submodule--helper" directly, we therefore
    +    don't need to emit "usage()" if we see "--cached" without the
    +    sub-command being "status" or "summary", we can trust that
    +    parse_options() will spot that and barf on it.
     
    -    Then in b57e8119e6e (submodule: teach set-branch subcommand,
    -    2019-02-08) when the "set-branch" subcommand was added the assertion
    -    that we shouldn't have "--branch" anywhere except as an argument to
    -    "add" and "set-branch" was copy/pasted from the adjacent check for
    -    "--cache" added (or rather modified) in 496eeeb19b9 (git-submodule.sh:
    -    avoid "test <cond> -a/-o <cond>", 2014-06-10).
    +    This does change one obscure aspect of undocumented behavior, for
    +    "status" and "summary" we supported these undocumented forms:
     
    -    But there's been a logic error in that check, this looked like it
    -    should be supporting:
    +        git submodule --cached (status | summary)
     
    -        git submodule --branch <branch> (add | set-branch) [<options>]
    +    As noted in a preceding commit to git-submodule.sh which removed the
    +    "--branch" special-case, this comes down to emergent behavior seen in
    +    5c08dbbdf1a (git-submodule: fix subcommand parser,
    +    2008-01-15). I.e. we wanted to support was for subcommand-less invocations like:
     
    -    But due to "||" in the condition (as opposed to "&&" for "--cache") if
    -    we have "--branch" here already we'll emit usage, even for "add" and
    -    "set-branch".
    +        git submodule --cached
     
    -    Since nobody's complained about "--branch <branch>" not being
    -    supported as argument to "git submodule" itself, i.e. we want to
    -    support:
    +    To be synonymous with invocations that explicitly named the "status"
    +    sub-command:
     
    -        git submodule (add | set-branch) --branch <branch>  [<options>]
    +        git submodule status --cached
     
    -    But not the first form noted above. Let's just remove this code, we've
    -    never documented "--branch" as a top-level option (unlike "--quiet"),
    -    so this looks like it was an accident of the implementation, which we
    -    broke v2.22.0, so we also know it must not have been important to
    -    anyone.
    +    But we did not intend to mix the two, and allow "--cached" to be an
    +    option to the top-level "submodule" command when the "status" or
    +    "summary" sub-commands were explicitly provided.
    +
    +    Let's remove this undocumented edge case, which makes a subsequent
    +    removal of git-submodule.sh easier to reason about. The test case
    +    added here is duplicated from the existing for-loop, except for the
    +    different and desired handling of "git submodule --cached status".
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## git-submodule.sh ##
     @@ git-submodule.sh: do
    - 	-q|--quiet)
    - 		GIT_QUIET=1
    + 		quiet=1
      		;;
    --	-b|--branch)
    --		case "$2" in
    --		'')
    --			usage
    --			;;
    --		esac
    --		branch="$2"; shift
    --		;;
      	--cached)
    - 		cached="$1"
    +-		cached=1
    ++		if test -z "$command"
    ++		then
    ++			cached=1 &&
    ++			shift &&
    ++			break
    ++		else
    ++			usage
    ++		fi
      		;;
    + 	--)
    + 		break
     @@ git-submodule.sh: then
          fi
      fi
      
    --# "-b branch" is accepted only by "add" and "set-branch"
    --if test -n "$branch" && (test "$command" != add || test "$command" != set-branch)
    +-# "--cached" is accepted only by "status" and "summary"
    +-if test -n "$cached" && test "$command" != status && test "$command" != summary
     -then
     -	usage
     -fi
     -
    - # "--cached" is accepted only by "status" and "summary"
    - if test -n "$cached" && test "$command" != status && test "$command" != summary
    - then
    + case "$command" in
    + absorbgitdirs)
    + 	git submodule--helper "$command" --prefix "$wt_prefix" "$@"
    +
    + ## t/t7400-submodule-basic.sh ##
    +@@ t/t7400-submodule-basic.sh: test_expect_success 'submodule usage: status --' '
    + 	test_expect_code 1 git submodule --end-of-options
    + '
    + 
    +-for opt in '--quiet' '--cached'
    ++for opt in '--quiet'
    + do
    + 	test_expect_success "submodule usage: status $opt" '
    + 		git submodule $opt &&
    +@@ t/t7400-submodule-basic.sh: do
    + 	'
    + done
    + 
    ++for opt in '--cached'
    ++do
    ++	test_expect_success "submodule usage: status $opt" '
    ++		git submodule $opt &&
    ++		git submodule status $opt &&
    ++		test_expect_code 1 git submodule $opt status >out 2>err &&
    ++		grep "^usage: git submodule" err &&
    ++		test_must_be_empty out
    ++	'
    ++done
    ++
    + test_expect_success 'submodule deinit works on empty repository' '
    + 	git submodule deinit --all
    + '
    +@@ t/t7400-submodule-basic.sh: test_expect_success 'status should be "modified" after submodule commit' '
    + '
    + 
    + test_expect_success 'the --cached sha1 should be rev1' '
    +-	git submodule --cached status >list &&
    ++	git submodule status --cached >list &&
    + 	grep "^+$rev1" list
    + '
    + 
19:  1423950de08 !  7:  2c77ed38d90 submodule: make it a built-in, remove git-submodule.sh
    @@ Metadata
      ## Commit message ##
         submodule: make it a built-in, remove git-submodule.sh
     
    -    Replace the now-trivial git-submodule.sh script with a built-in
    -    builtin/submodule.c. For now this new command is only a dumb
    +    Replace the "git-submodule.sh" script with a built-in
    +    "builtin/submodule.c. For" now this new command is only a dumb
         dispatcher that uses run-command.c to invoke "git submodule--helper",
         just as "git-submodule.sh" used to do.
     
    -    This is obviously not ideal, and we should follow-up and merge the
    -    builtin/submodule--helper.c code into builtin/submodule.c, but doing it
    -    this way makes it easy to review that this new C implementation isn't
    -    doing anything more clever than the old shellscript implementation.
    +    This is obviously not ideal, and we should eventually follow-up and
    +    merge the "builtin/submodule--helper.c" code into
    +    "builtin/submodule.c". Doing it this way makes it easy to review that
    +    this new C implementation isn't doing anything more clever than the
    +    old shellscript implementation.
     
    -    The "define BUILTIN_" macros will help with that, i.e. the usage
    -    information we emit can be merged with what
    -    builtin/submodule--helper.c is now emitting. See
    -    8757b35d443 (commit-graph: define common usage with a macro,
    -    2021-08-23) and 1e91d3faf6c (reflog: move "usage" variables and use
    -    macros, 2022-03-17) for prior art using this pattern.
    +    This is a large win for performance, we're now more than 4x as fast as
    +    before in terms of the fixed cost of invoking any "git submodule"
    +    command[1]:
    +
    +            $ git hyperfine -L rev HEAD~1,HEAD -s 'make CFLAGS=-O3' './git --exec-path=$PWD submodule foreach "echo \$name"'
    +            Benchmark 1: ./git --exec-path=$PWD submodule foreach "echo \$name"' in 'HEAD~1
    +              Time (mean ± σ):      42.2 ms ±   0.4 ms    [User: 34.9 ms, System: 9.1 ms]
    +              Range (min … max):    41.3 ms …  43.2 ms    70 runs
    +
    +            Benchmark 2: ./git --exec-path=$PWD submodule foreach "echo \$name"' in 'HEAD
    +              Time (mean ± σ):       9.7 ms ±   0.1 ms    [User: 7.6 ms, System: 2.2 ms]
    +              Range (min … max):     9.5 ms …  10.3 ms    282 runs
    +
    +            Summary
    +              './git --exec-path=$PWD submodule foreach "echo \$name"' in 'HEAD' ran
    +                4.33 ± 0.07 times faster than './git --exec-path=$PWD submodule foreach "echo \$name"' in 'HEAD~1'
    +
    +    We're taking pains here to faithfully reproduce existing
    +    "git-submodule.sh" behavior, even when that behavior is stupid. Some
    +    of it we'll fix in subsequent commits, but let's first faithfully
    +    reproduce the behavior.
    +
    +    One exception is the change in the behavior of the exit code
    +    stand-alone "-h" and "--" yield, see the altered tests. Returning 129
    +    instead of 0 and 1 for "-h" and "--" respectively is a concession to
    +    basic sanity.
    +
    +    The pattern of using "define BUILTIN_" macros here isn't needed for
    +    now, but as we'll move code out of "builtin/submodule--helper.c" we'll
    +    want to re-use these strings. See 8757b35d443 (commit-graph: define
    +    common usage with a macro, 2021-08-23) and 1e91d3faf6c (reflog: move
    +    "usage" variables and use macros, 2022-03-17) for prior art using this
    +    pattern.
     
         The "(argc < 2 || !strcmp(argv[1], "-h"))" path at the top of
         cmd_submodule__helper() could now be a "(argc < 2)" if not for
         t0012-help.sh (which invokes all built-ins manually with "-h"). Let's
         leave it for now, eventually we'll consolidate the two.
     
    +    1. Using the "git hyperfine" wrapper for "hyperfine":
    +       https://lore.kernel.org/git/211201.86r1aw9gbd.gmgdl@evledraar.gmail.com/
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Makefile ##
    @@ builtin/submodule.c (new)
     +};
     +
     +static void setup_helper_args(int argc, const char **argv, const char *prefix,
    -+			      int quiet, int cached, struct strvec *args)
    ++			      int quiet, int cached, struct strvec *args,
    ++			      const struct option *options)
     +{
     +	const char *cmd;
     +	int do_quiet_cache = 1;
    @@ builtin/submodule.c (new)
     +		return;
     +	}
     +
    ++	/* Did we get --cached with a command? */
    ++	if (cached)
    ++		usage_msg_optf(_("'%s' option is only supported with explicit 'status'"),
    ++			       git_submodule_usage, options, "--cached");
    ++
    ++
     +	/* Either a valid command, or submodule--helper will barf! */
     +	cmd = argv[0];
     +	strvec_push(args, cmd);
     +	argv++;
     +	argc--;
     +
    ++	/*
    ++	  * This is stupid, but don't support "[--]" to
    ++	 * subcommand-less "git-submodule" for now.
    ++	 */
    ++	if (!strcmp(cmd, "--") || !strcmp(cmd, "--end-of-options"))
    ++		usage_msg_optf(_("need explicit sub-command name to delimit with '%s'"),
    ++			       git_submodule_usage, options, cmd);
    ++
     +	/* Options that need to go before user-supplied options */
     +	if (!strcmp(cmd, "absorbgitdirs"))
     +		do_quiet_cache = 0;
    @@ builtin/submodule.c (new)
     +			 N_("print the OID of submodules")),
     +		OPT_END()
     +	};
    -+	int ret;
     +
     +	argc = parse_options(argc, argv, prefix, options, git_submodule_usage,
    -+			     PARSE_OPT_STOP_AT_NON_OPTION);
    ++			     PARSE_OPT_STOP_AT_NON_OPTION | PARSE_OPT_KEEP_DASHDASH);
     +
     +	/*
     +	 * Tell the rest of git that any URLs we get don't come
     +	 * directly from the user, so it can apply policy as appropriate.
     +	 */
    -+	strvec_push(&cp.env_array, "GIT_PROTOCOL_FROM_USER=0");
    ++	strvec_push(&cp.env, "GIT_PROTOCOL_FROM_USER=0");
     +	setup_helper_args(argc, argv, prefix, opt_quiet, opt_cached,
    -+			  &cp.args);
    ++			  &cp.args, options);
     +
     +	cp.git_cmd = 1;
     +	cp.no_stdin = 0; /* for git submodule foreach */
     +	cp.dir = startup_info->original_cwd;
    -+	ret = run_command(&cp);
     +
    -+	return ret;
    ++	return run_command(&cp);
     +}
     
      ## git-submodule.sh (deleted) ##
    @@ git-submodule.sh (deleted)
     -   or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
     -   or: $dashless [--quiet] init [--] [<path>...]
     -   or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
    --   or: $dashless [--quiet] update [-v] [--init [--filter=<filter-spec>]] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--[no-]single-branch] [--] [<path>...]
    +-   or: $dashless [--quiet] update [--init [--filter=<filter-spec>]] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--[no-]single-branch] [--] [<path>...]
     -   or: $dashless [--quiet] set-branch (--default|--branch <branch>) [--] <path>
     -   or: $dashless [--quiet] set-url [--] <path> <newurl>
     -   or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    @@ git-submodule.sh (deleted)
     -GIT_PROTOCOL_FROM_USER=0
     -export GIT_PROTOCOL_FROM_USER
     -
    +-command=
     -quiet=
     -cached=
     -
    --while test $# != 0
    +-while test $# != 0 && test -z "$command"
     -do
     -	case "$1" in
    +-	add | foreach | init | deinit | update | set-branch | set-url | status | summary | sync | absorbgitdirs)
    +-		command=$1
    +-		;;
     -	-q|--quiet)
    --		quiet=1 &&
    --		shift
    +-		quiet=1
     -		;;
     -	--cached)
    --		cached=1 &&
    --		shift
    +-		if test -z "$command"
    +-		then
    +-			cached=1 &&
    +-			shift &&
    +-			break
    +-		else
    +-			usage
    +-		fi
    +-		;;
    +-	--)
    +-		break
    +-		;;
    +-	-*)
    +-		usage
     -		;;
     -	*)
     -		break
     -		;;
     -	esac
    +-	shift
     -done
     -
     -# No command word defaults to "status"
    --command=
    --if test $# = 0
    +-if test -z "$command"
     -then
    +-    if test $# = 0
    +-    then
     -	command=status
    --else
    --	case "$1" in
    --	add | foreach | init | deinit | update | set-branch | set-url | status | summary | sync | absorbgitdirs)
    --		command=$1 &&
    --		shift
    --		;;
    --	*)
    --		usage
    --	esac
    +-    else
    +-	usage
    +-    fi
     -fi
     -
     -case "$command" in
    @@ git-submodule.sh (deleted)
     -	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
     -		${quiet:+--quiet} ${wt_prefix:+--prefix "$wt_prefix"} "$@"
     -	;;
    --*)
    +-add | foreach | init | deinit | set-branch | set-url | status | summary | sync)
     -	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
     -		${quiet:+--quiet} ${cached:+--cached} "$@"
     -	;;
    @@ git.c: static struct cmd_struct commands[] = {
      	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX | NO_PARSEOPT },
      	{ "switch", cmd_switch, RUN_SETUP | NEED_WORK_TREE },
      	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
    +
    + ## t/t7400-submodule-basic.sh ##
    +@@ t/t7400-submodule-basic.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + . ./test-lib.sh
    + 
    + test_expect_success 'submodule usage: -h' '
    +-	git submodule -h >out 2>err &&
    ++	test_expect_code 129 git submodule -h >out 2>err &&
    + 	grep "^usage: git submodule" out &&
    + 	test_must_be_empty err
    + '
    + 
    + test_expect_success 'submodule usage: --recursive' '
    +-	test_expect_code 1 git submodule --recursive >out 2>err &&
    +-	grep "^usage: git submodule" err &&
    +-	test_must_be_empty out
    ++	test_expect_code 129 git submodule --recursive
    + '
    + 
    + test_expect_success 'submodule usage: status --' '
    +-	test_expect_code 1 git submodule -- &&
    +-	test_expect_code 1 git submodule --end-of-options
    ++	test_expect_code 129 git submodule -- &&
    ++	test_expect_code 129 git submodule --end-of-options
    + '
    + 
    + for opt in '--quiet'
    +@@ t/t7400-submodule-basic.sh: do
    + 	test_expect_success "submodule usage: status $opt" '
    + 		git submodule $opt &&
    + 		git submodule status $opt &&
    +-		test_expect_code 1 git submodule $opt status >out 2>err &&
    ++		test_expect_code 129 git submodule $opt status >out 2>err &&
    + 		grep "^usage: git submodule" err &&
    + 		test_must_be_empty out
    + 	'
 3:  6c774505ac5 !  8:  8dbb81e2fa5 git-submodule.sh: remove unused --super-prefix logic
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    git-submodule.sh: remove unused --super-prefix logic
    +    submodule: support "--" with no other arguments
     
    -    The "$prefix" variable has not been set since b3c5f5cb048 (submodule:
    -    move core cmd_update() logic to C, 2022-03-15), so we'd never pass the
    -    --super-prefix option to "git submodule--helper", and can therefore
    -    remove the handling of it from builtin/submodule--helper.c as well.
    +    Address an edge case that "git-submodule.sh" has had all along, but
    +    which became painfully obvious in the *.sh to *.c migration in the
    +    preceding commit.
    +
    +    We didn't support the "--" delimiter in the argument-less
    +    invocation. Let's not bend over backwards to behave unusually in this
    +    scenario, simply accepting "--" is harmless.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: static int module_add(int argc, const char **argv, const char *prefix)
    - 	return 0;
    - }
    + ## Documentation/git-submodule.txt ##
    +@@ Documentation/git-submodule.txt: git-submodule - Initialize, update or inspect submodules
    + SYNOPSIS
    + --------
    + [verse]
    +-'git submodule' [--quiet] [--cached]
    ++'git submodule' [--quiet] [--cached] [--]
    + 'git submodule' [--quiet] add [<options>] [--] <repository> [<path>]
    + 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
    + 'git submodule' [--quiet] init [--] [<path>...]
    +
    + ## builtin/submodule.c ##
    +@@
    + #include "strvec.h"
    + 
    + #define BUILTIN_SUBMODULE_USAGE \
    +-	"git submodule [--quiet] [--cached]"
    ++	"git submodule [--quiet] [--cached] [--]"
      
    --#define SUPPORT_SUPER_PREFIX (1<<0)
    + #define BUILTIN_SUBMODULE_ADD_USAGE \
    + 	N_("git submodule [--quiet] add [-b <branch>] [-f | --force] [--name <name>]\n" \
    +@@ builtin/submodule.c: static void setup_helper_args(int argc, const char **argv, const char *prefix,
    + 	argv++;
    + 	argc--;
    + 
    +-	/*
    +-	  * This is stupid, but don't support "[--]" to
    +-	 * subcommand-less "git-submodule" for now.
    +-	 */
    +-	if (!strcmp(cmd, "--") || !strcmp(cmd, "--end-of-options"))
    +-		usage_msg_optf(_("need explicit sub-command name to delimit with '%s'"),
    +-			       git_submodule_usage, options, cmd);
     -
    - struct cmd_struct {
    - 	const char *cmd;
    - 	int (*fn)(int, const char **, const char *);
    --	unsigned option;
    - };
    + 	/* Options that need to go before user-supplied options */
    + 	if (!strcmp(cmd, "absorbgitdirs"))
    + 		do_quiet_cache = 0;
    +@@ builtin/submodule.c: int cmd_submodule(int argc, const char **argv, const char *prefix)
    + 	};
      
    - static struct cmd_struct commands[] = {
    --	{"list", module_list, 0},
    --	{"name", module_name, 0},
    --	{"clone", module_clone, 0},
    --	{"add", module_add, SUPPORT_SUPER_PREFIX},
    --	{"update", module_update, 0},
    --	{"resolve-relative-url-test", resolve_relative_url_test, 0},
    --	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
    --	{"init", module_init, SUPPORT_SUPER_PREFIX},
    --	{"status", module_status, SUPPORT_SUPER_PREFIX},
    --	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
    --	{"deinit", module_deinit, 0},
    --	{"summary", module_summary, SUPPORT_SUPER_PREFIX},
    --	{"push-check", push_check, 0},
    --	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
    --	{"is-active", is_active, 0},
    --	{"check-name", check_name, 0},
    --	{"config", module_config, 0},
    --	{"set-url", module_set_url, 0},
    --	{"set-branch", module_set_branch, 0},
    --	{"create-branch", module_create_branch, 0},
    -+	{"list", module_list},
    -+	{"name", module_name},
    -+	{"clone", module_clone},
    -+	{"add", module_add},
    -+	{"update", module_update},
    -+	{"resolve-relative-url-test", resolve_relative_url_test},
    -+	{"foreach", module_foreach},
    -+	{"init", module_init},
    -+	{"status", module_status},
    -+	{"sync", module_sync},
    -+	{"deinit", module_deinit},
    -+	{"summary", module_summary},
    -+	{"push-check", push_check},
    -+	{"absorb-git-dirs", absorb_git_dirs},
    -+	{"is-active", is_active},
    -+	{"check-name", check_name},
    -+	{"config", module_config},
    -+	{"set-url", module_set_url},
    -+	{"set-branch", module_set_branch},
    -+	{"create-branch", module_create_branch},
    - };
    + 	argc = parse_options(argc, argv, prefix, options, git_submodule_usage,
    +-			     PARSE_OPT_STOP_AT_NON_OPTION | PARSE_OPT_KEEP_DASHDASH);
    ++			     PARSE_OPT_STOP_AT_NON_OPTION);
      
    - int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
    -@@ builtin/submodule--helper.c: int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
    - 	if (argc < 2 || !strcmp(argv[1], "-h"))
    - 		usage("git submodule--helper <command>");
    + 	/*
    + 	 * Tell the rest of git that any URLs we get don't come
    +
    + ## t/t7400-submodule-basic.sh ##
    +@@ t/t7400-submodule-basic.sh: test_expect_success 'submodule usage: --recursive' '
    + '
      
    --	for (i = 0; i < ARRAY_SIZE(commands); i++) {
    --		if (!strcmp(argv[1], commands[i].cmd)) {
    --			if (get_super_prefix() &&
    --			    !(commands[i].option & SUPPORT_SUPER_PREFIX))
    --				die(_("%s doesn't support --super-prefix"),
    --				    commands[i].cmd);
    -+	for (i = 0; i < ARRAY_SIZE(commands); i++)
    -+		if (!strcmp(argv[1], commands[i].cmd))
    - 			return commands[i].fn(argc - 1, argv + 1, prefix);
    --		}
    --	}
    + test_expect_success 'submodule usage: status --' '
    +-	test_expect_code 129 git submodule -- &&
    +-	test_expect_code 129 git submodule --end-of-options
    ++	git submodule -- &&
    ++	git submodule --end-of-options
    + '
      
    - 	die(_("'%s' is not a valid submodule--helper "
    - 	      "subcommand"), argv[1]);
    + for opt in '--quiet'
20:  b2aaad5c008 !  9:  7f232c5e503 submodule: add a subprocess-less submodule.useBuiltin setting
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    submodule: add a subprocess-less submodule.useBuiltin setting
    +    submodule: support sub-command-less "--recursive" option
     
    -    Add an experimental setting to avoid the subprocess invocation of "git
    -    submodule--helper", instead we'll call cmd_submodule__helper()
    -    directly.
    +    The inability to specify "--recursive" when we're not providing a
    +    sub-command name appears to have been an omission in 15fc56a8536 (git
    +    submodule foreach: Add --recursive to recurse into nested submodules,
    +    2009-08-19). Let's support it along with the other "status" options.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## Documentation/config/submodule.txt ##
    -@@ Documentation/config/submodule.txt: setting.
    - * `branch` is supported only if `submodule.propagateBranches` is
    - enabled
    - 
    -+submodule.useBuiltin::
    -+	Set to `true` to use a faster but possibly less stable subprocess-less
    -+	implementation of linkgit:git-submodule[1]. Is `false` by default.
    -+
    - submodule.propagateBranches::
    - 	[EXPERIMENTAL] A boolean that enables branching support when
    - 	using `--recurse-submodules` or `submodule.recurse=true`.
    + ## Documentation/git-submodule.txt ##
    +@@ Documentation/git-submodule.txt: git-submodule - Initialize, update or inspect submodules
    + SYNOPSIS
    + --------
    + [verse]
    +-'git submodule' [--quiet] [--cached] [--]
    ++'git submodule' [--quiet] [--cached] [--recursive] [--]
    + 'git submodule' [--quiet] add [<options>] [--] <repository> [<path>]
    + 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
    + 'git submodule' [--quiet] init [--] [<path>...]
     
      ## builtin/submodule.c ##
    -@@
    - #include "parse-options.h"
    - #include "run-command.h"
    - #include "strvec.h"
    -+#include "config.h"
    +@@ builtin/submodule.c: static const char * const git_submodule_usage[] = {
    + };
      
    - #define BUILTIN_SUBMODULE_USAGE \
    - 	"git submodule [--quiet] [--cached]"
    + static void setup_helper_args(int argc, const char **argv, const char *prefix,
    +-			      int quiet, int cached, struct strvec *args,
    ++			      int quiet, int cached, int recursive,
    ++			      struct strvec *args,
    + 			      const struct option *options)
    + {
    + 	const char *cmd;
     @@ builtin/submodule.c: static void setup_helper_args(int argc, const char **argv, const char *prefix,
    - 	strvec_pushv(args, argv);
    - }
    + 		return;
    + 	}
      
    -+static int get_use_builtin(void)
    -+{
    -+	int v;
    -+
    -+	if (git_env_bool("GIT_TEST_SUBMODULE_USE_BUILTIN", 0))
    -+		v = 1;
    -+	else if (!git_config_get_bool("submodule.usebuiltin", &v))
    -+		;
    -+	else if (!git_config_get_bool("feature.experimental", &v))
    -+	      ;
    -+
    -+	return v;
    -+}
    +-	/* Did we get --cached with a command? */
    ++	/* Did we get a forbidden top-level option with a command? */
    + 	if (cached)
    + 		usage_msg_optf(_("'%s' option is only supported with explicit 'status'"),
    + 			       git_submodule_usage, options, "--cached");
    ++	if (recursive)
    ++		usage_msg_optf(_("'%s' option is only supported with explicit 'status'"),
    ++			       git_submodule_usage, options, "--recursive");
    + 
    + 
    + 	/* Either a valid command, or submodule--helper will barf! */
    +@@ builtin/submodule.c: static void setup_helper_args(int argc, const char **argv, const char *prefix,
    + 	argc--;
    + 
    + 	/* Options that need to go before user-supplied options */
    ++	if (!strcmp(cmd, "status") && recursive)
    ++		strvec_push(args, "--recursive");
     +
    - int cmd_submodule(int argc, const char **argv, const char *prefix)
    + 	if (!strcmp(cmd, "absorbgitdirs"))
    + 		do_quiet_cache = 0;
    + 	else if (!strcmp(cmd, "update"))
    +@@ builtin/submodule.c: int cmd_submodule(int argc, const char **argv, const char *prefix)
      {
      	int opt_quiet = 0;
      	int opt_cached = 0;
    ++	int opt_recursive = 0;
      	struct child_process cp = CHILD_PROCESS_INIT;
    -+	struct strvec args = STRVEC_INIT;
      	struct option options[] = {
      		OPT__QUIET(&opt_quiet, N_("be quiet")),
      		OPT_BOOL(0, "cached", &opt_cached,
      			 N_("print the OID of submodules")),
    ++		OPT_BOOL(0, "recursive", &opt_recursive,
    ++			 N_("recurse into nested submodules")),
      		OPT_END()
      	};
    -+	const int use_builtin = get_use_builtin();
    - 	int ret;
      
    - 	argc = parse_options(argc, argv, prefix, options, git_submodule_usage,
     @@ builtin/submodule.c: int cmd_submodule(int argc, const char **argv, const char *prefix)
    - 	 * Tell the rest of git that any URLs we get don't come
    - 	 * directly from the user, so it can apply policy as appropriate.
      	 */
    --	strvec_push(&cp.env_array, "GIT_PROTOCOL_FROM_USER=0");
    -+	if (use_builtin)
    -+		xsetenv("GIT_PROTOCOL_FROM_USER", "0", 1);
    -+	else
    -+		strvec_push(&cp.env_array, "GIT_PROTOCOL_FROM_USER=0");
    -+
    + 	strvec_push(&cp.env, "GIT_PROTOCOL_FROM_USER=0");
      	setup_helper_args(argc, argv, prefix, opt_quiet, opt_cached,
    --			  &cp.args);
    -+			  use_builtin ? &args : &cp.args);
    -+
    -+	if (use_builtin) {
    -+		ret = cmd_submodule__helper(args.nr, args.v, prefix);
    -+		goto cleanup;
    -+	}
    +-			  &cp.args, options);
    ++			  opt_recursive, &cp.args, options);
      
      	cp.git_cmd = 1;
      	cp.no_stdin = 0; /* for git submodule foreach */
    - 	cp.dir = startup_info->original_cwd;
    - 	ret = run_command(&cp);
    - 
    -+cleanup:
    -+	if (!use_builtin)
    -+		/* TODO: Double free? */
    -+		strvec_clear(&args);
    -+
    - 	return ret;
    - }
    -
    - ## ci/run-build-and-tests.sh ##
    -@@ ci/run-build-and-tests.sh: linux-TEST-vars)
    - 	export GIT_TEST_MULTI_PACK_INDEX=1
    - 	export GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=1
    - 	export GIT_TEST_ADD_I_USE_BUILTIN=0
    -+	export GIT_TEST_SUBMODULE_USE_BUILTIN=1
    - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
    - 	export GIT_TEST_WRITE_REV_INDEX=1
    - 	export GIT_TEST_CHECKOUT_WORKERS=2
     
    - ## t/README ##
    -@@ t/README: GIT_TEST_ADD_I_USE_BUILTIN=<boolean>, when false, disables the
    - built-in version of git add -i. See 'add.interactive.useBuiltin' in
    - git-config(1).
    + ## t/t7400-submodule-basic.sh ##
    +@@ t/t7400-submodule-basic.sh: test_expect_success 'submodule usage: -h' '
    + 	test_must_be_empty err
    + '
      
    -+GIT_TEST_SUBMODULE_USE_BUILTIN=<boolean>, when true, enables the
    -+built-in subprocess-less invocation of "git submodule--helper".
    -+See 'submodule.useBuiltin' in git-config(1).
    -+
    - GIT_TEST_INDEX_THREADS=<n> enables exercising the multi-threaded loading
    - of the index for the whole test suite by bypassing the default number of
    - cache entries and thread minimums. Setting this to 1 will make the
    +-test_expect_success 'submodule usage: --recursive' '
    +-	test_expect_code 129 git submodule --recursive
    +-'
    +-
    + test_expect_success 'submodule usage: status --' '
    + 	git submodule -- &&
    + 	git submodule --end-of-options
    +@@ t/t7400-submodule-basic.sh: do
    + 	'
    + done
    + 
    +-for opt in '--cached'
    ++for opt in '--cached' '--recursive'
    + do
    + 	test_expect_success "submodule usage: status $opt" '
    + 		git submodule $opt &&
 2:  8fcd832e58f ! 10:  81f138e460c git-submodule.sh: remove unused $prefix variable
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    git-submodule.sh: remove unused $prefix variable
    +    submodule: don't use a subprocess to invoke "submodule--helper"
     
    -    Remove the $prefix variable which is never set, and never resulted in
    -    an option being passed to our "git submodule--helper". The
    -    --recursive-prefix option to "git submodule--helper" is still used,
    -    but only when it invokes itself.
    +    In a preceding commit we created "builtin/submodule.c" and faithfully
    +    tried to reproduce every aspect of "git-submodule.sh", including its
    +    invocation of "git submodule--helper" as a sub-process.
    +
    +    Let's do away with the sub-process and invoke
    +    "cmd_submodule__helper()" directly. Eventually we'll want to do away
    +    with "builtin/submodule--helper.c" altogether, but let's not do that
    +    for now to avoid conflicts with other in-flight topics. Even without
    +    those conflicts the resulting diff would be large. We can leave that
    +    for a later cleanup.
    +
    +    This speeds up invocations of all "git submodule" commands, E.g. a
    +    trivial "foreach" command on git.git is around 1.50 times
    +    faster[1]. For more expensive commands this'll make less of a
    +    difference, as the fixed cost of invoking the sub-process will be
    +    amortized away.
    +
    +            $ git hyperfine -L rev HEAD~1,HEAD -s 'make CFLAGS=-O3' './git submodule foreach "echo \$name"'
    +            Benchmark 1: ./git submodule foreach "echo \$name"' in 'HEAD~1
    +              Time (mean ± σ):       9.7 ms ±   0.1 ms    [User: 7.6 ms, System: 2.1 ms]
    +              Range (min … max):     9.4 ms …  10.2 ms    285 runs
    +
    +            Benchmark 2: ./git submodule foreach "echo \$name"' in 'HEAD
    +              Time (mean ± σ):       6.6 ms ±   0.1 ms    [User: 5.1 ms, System: 1.5 ms]
    +              Range (min … max):     6.2 ms …   7.2 ms    414 runs
    +
    +            Summary
    +              './git submodule foreach "echo \$name"' in 'HEAD' ran
    +                1.48 ± 0.04 times faster than './git submodule foreach "echo \$name"' in 'HEAD~1'
    +
    +    It's also worth noting that some users were using e.g. "git
    +    submodule--helper list" directly for performance reasons[2]. With
    +    31955475d1c (submodule--helper: remove unused "list" helper,
    +    2022-09-01) released with v2.38.0 the "list" command was no longer
    +    provided. Users who had to switch to "git submodule--helper foreach"
    +    were given a command that (on my system) is around 6.5x slower.
    +
    +    Now the "foreach" is around 0.10x slower (due to the slight shell
    +    overhead), with 31955475d1c reverted on top of this:
    +
    +            $ hyperfine './git submodule--helper list' './git submodule foreach --quiet "echo \$name"' --warmup 10
    +            Benchmark 1: ./git submodule--helper list
    +              Time (mean ± σ):       6.4 ms ±   0.1 ms    [User: 5.0 ms, System: 1.5 ms]
    +              Range (min … max):     6.2 ms …   7.2 ms    427 runs
    +
    +            Benchmark 2: ./git submodule foreach --quiet "echo \$name"
    +              Time (mean ± σ):       7.0 ms ±   0.1 ms    [User: 4.8 ms, System: 2.3 ms]
    +              Range (min … max):     6.8 ms …   7.4 ms    390 runs
    +
    +            Summary
    +              './git submodule--helper list' ran
    +                1.10 ± 0.03 times faster than './git submodule foreach --quiet "echo \$name"'
    +
    +    I think it would make sense to implement a "--format" option for "git
    +    submodule foreach" to help anyone who cares about that remaining
    +    performance (and to improve the API, e.g. by supporting "-z"), but as
    +    far as performance goes this makes the runtime acceptable again.
    +
    +    The pattern in "cmd_submodule_builtin()" of saving "struct strvec"
    +    arguments to a "struct string_list" and free()-ing them after the
    +    "argv" has been modified by "cmd_submodule__helper()" is new, without
    +    it we'd get various already-passing tests failing under SANITIZE=leak.
    +
    +    1. Using the "git hyperfine" wrapper for "hyperfine":
    +       https://lore.kernel.org/git/211201.86r1aw9gbd.gmgdl@evledraar.gmail.com/
    +    2. https://lore.kernel.org/git/87czatrpyb.fsf@bernoul.li/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## git-submodule.sh ##
    -@@ git-submodule.sh: files=
    - remote=
    - nofetch=
    - update=
    --prefix=
    - custom_name=
    - depth=
    - progress=
    -@@ git-submodule.sh: cmd_add()
    - 		usage
    - 	fi
    - 
    --	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper add ${GIT_QUIET:+--quiet} ${force:+--force} ${progress:+"--progress"} ${branch:+--branch "$branch"} ${reference_path:+--reference "$reference_path"} ${dissociate:+--dissociate} ${custom_name:+--name "$custom_name"} ${depth:+"$depth"} -- "$@"
    -+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper add ${GIT_QUIET:+--quiet} ${force:+--force} ${progress:+"--progress"} ${branch:+--branch "$branch"} ${reference_path:+--reference "$reference_path"} ${dissociate:+--dissociate} ${custom_name:+--name "$custom_name"} ${depth:+"$depth"} -- "$@"
    + ## builtin/submodule.c ##
    +@@ builtin/submodule.c: static void setup_helper_args(int argc, const char **argv, const char *prefix,
    + 	strvec_pushv(args, argv);
      }
      
    - #
    -@@ git-submodule.sh: cmd_init()
    - 		shift
    - 	done
    ++static int cmd_submodule_builtin(struct strvec *args, const char *prefix)
    ++{
    ++	size_t i;
    ++	struct string_list to_free = STRING_LIST_INIT_DUP;
    ++	int ret;
    ++
    ++	/*
    ++	 * The cmd_submodule__helper() will treat the argv as
    ++	 * its own and modify it, so e.g. for "git submodule
    ++	 * add" the "add" argument will be removed, and we'll
    ++	 * thus leak from the strvec_push()'s in
    ++	 * setup_helper_args().
    ++	 *
    ++	 * So in lieu of some generic "snapshot for a free"
    ++	 * API for "struct strvec" squirrel away the pointers
    ++	 * to free with string_list_clear() later.
    ++	 */
    ++	for (i = 0; i < args->nr; i++)
    ++		string_list_append_nodup(&to_free, (char *)args->v[i]);
    ++
    ++	ret = cmd_submodule__helper(args->nr, args->v, prefix);
    ++
    ++	string_list_clear(&to_free, 0);
    ++	free(strvec_detach(args));
    ++
    ++	return ret;
    ++}
    ++
    + int cmd_submodule(int argc, const char **argv, const char *prefix)
    + {
    + 	int opt_quiet = 0;
    + 	int opt_cached = 0;
    + 	int opt_recursive = 0;
    +-	struct child_process cp = CHILD_PROCESS_INIT;
    ++	struct strvec args = STRVEC_INIT;
    + 	struct option options[] = {
    + 		OPT__QUIET(&opt_quiet, N_("be quiet")),
    + 		OPT_BOOL(0, "cached", &opt_cached,
    +@@ builtin/submodule.c: int cmd_submodule(int argc, const char **argv, const char *prefix)
    + 	 * Tell the rest of git that any URLs we get don't come
    + 	 * directly from the user, so it can apply policy as appropriate.
    + 	 */
    +-	strvec_push(&cp.env, "GIT_PROTOCOL_FROM_USER=0");
    +-	setup_helper_args(argc, argv, prefix, opt_quiet, opt_cached,
    +-			  opt_recursive, &cp.args, options);
    ++	xsetenv("GIT_PROTOCOL_FROM_USER", "0", 1);
      
    --	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper init ${GIT_QUIET:+--quiet} -- "$@"
    -+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper init ${GIT_QUIET:+--quiet} -- "$@"
    - }
    +-	cp.git_cmd = 1;
    +-	cp.no_stdin = 0; /* for git submodule foreach */
    +-	cp.dir = startup_info->original_cwd;
    ++	setup_helper_args(argc, argv, prefix, opt_quiet, opt_cached,
    ++			  opt_recursive, &args, options);
      
    - #
    -@@ git-submodule.sh: cmd_update()
    - 		${init:+--init} \
    - 		${nofetch:+--no-fetch} \
    - 		${wt_prefix:+--prefix "$wt_prefix"} \
    --		${prefix:+--recursive-prefix "$prefix"} \
    - 		${update:+--update "$update"} \
    - 		${reference:+"$reference"} \
    - 		${dissociate:+"--dissociate"} \
    +-	return run_command(&cp);
    ++	return cmd_submodule_builtin(&args, prefix);
    + }
 5:  124c062e3a1 <  -:  ----------- git-submodule.sh: normalize parsing of --cached
 6:  b1ca1183885 <  -:  ----------- submodule--helper: rename "absorb-git-dirs" to "absorbgitdirs"
 8:  0c1a5063653 <  -:  ----------- submodule--helper: pretend to be "git submodule" in "-h" output
12:  57b9df29ea6 <  -:  ----------- submodule--helper: have --require-init imply --init
13:  20db979a094 <  -:  ----------- submodule--helper: understand --checkout, --merge and --rebase synonyms
14:  1cb40a5f42e <  -:  ----------- git-submodule doc: document the -v" option to "update"
15:  0c388eed1d1 <  -:  ----------- submodule--helper: understand -v option for "update"
17:  59a72296967 <  -:  ----------- git-submodule.sh: use "$quiet", not "$GIT_QUIET"
18:  c5796878f0b <  -:  ----------- git-submodule.sh: simplify parsing loop
-- 
2.38.0.1091.gf9d18265e59

