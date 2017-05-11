Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21E052018D
	for <e@80x24.org>; Thu, 11 May 2017 13:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756030AbdEKNsW (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 09:48:22 -0400
Received: from mout.gmx.net ([212.227.15.19]:57924 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755714AbdEKNrr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 09:47:47 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MKIEQ-1d8GTQ1KFS-001fy6; Thu, 11
 May 2017 15:47:34 +0200
Date:   Thu, 11 May 2017 15:47:33 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 00/11] Start retiring .git/remotes/ and .git/branches/ for
 good
Message-ID: <cover.1494509599.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cmr4sGHGAYT13Zj2jLgLL0/YM+D/var3lyOKOoe8280zxH97+Y3
 0e3dELY5I1gkZbLJiu2GbYUVu2qYpj8KaioonedivF5yyirgE5i9E0QVZfz1QyIHowMHsBx
 tU6TQuGtHaxzp+JpfOn7ZhgFIjBsLFRLuHFQkZZn1Mu6OIcq95/BHIXHQgZMzd7qSsH/tNk
 xjj8u6tL+9tADO0pKRIlA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/x7i7wqC9ek=:cA2BqNqlOEcpXdBWfEOfLl
 RbGcOhHF1dFJWjEbGgBBOfST9I7dEDD6Z0D/tHZI5Nye7a6ZhZE+RLlBh2TnPf/q1D9cN2R1q
 NMqaOM1gcrl+8W9cN/aAXveEwvYu2Q/w3MGs/ZREGQsFyer/QQwLwc1ajDfcc3dg7lGZ82zLE
 GIJtP5c/oWpCeJsytf8+ADUIC0hfU+PizrDO5S+6LyOwYobVrKV8rNYo8Z+YGKvBYmTSNu/xc
 QyCag4ueKehlOOA1mdk8vOg0IutlGm21lN06KXGc0oR47YeC5WQ7xv0wGHWNdGSirx/Kjo34G
 FaRY/RlHl2SsZj9aPPGwVJYhV65GgwkiQg7/uCINWyyCqrqw6jIbwbTlwtWyM4m6ftoA97TrO
 m7PThEH2IPMZjF0oge4sFYxOzhEvVk8EcAPbLgGtuaS+Nb/ZW6vxM6oIrbbv7FTvjuZYwEiBd
 MJBxlPia3OU8j/KMU/fLY3vu34+pphWtn4+kssFVLIeSvgVcbTIm0jYUFEBXzUzVyzNIB9NXW
 eN8LsEnXyR0ZLwuC7xt6a+HhamKwrXclsQ0S/HHXE9Huxp1BX/BxmbJr7kGfnNndPWrl2moPu
 kpxAsIyif7LccyxFUe46HHPLlOc3YEex76oTn0GDCHCYEr1+B+CTc8LN8hyDrTKvaF+L5OPtI
 akn2n6Es6Hr1s8ulaZahe0hHHve59C5rnTrXjBZGtGwMncPqplA8xB19cmhSBOoIKIMHf6V5T
 /nwInIYrOW8s0fP5Y5l9ENiGdLIgufj3WXeEgjlb/F2ZO+4kgwrsvQ0TEuQfgCPVp2lAxKfCs
 1TdSMn2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git uses the config for remote/upstream information in favor of the
previously-used .git/remotes/ and .git/branches/ for a decade now.

Nothing in Git writes to these files any longer, and the most prominent
user of .git/branches/ (Cogito) is long abandoned.

It is time to start not only deprecating this feature, but *really*
deprecating it. Like, really, *really*. For reals.

Half of this patch series does that.

The second half is a preview of the patches to finally rip out the code
that implements .git/remotes/ & .git/branches/ support. We we will want
to apply them to a future major version of Git, after *really*
deprecating .git/remotes/ & .git/branches/ support for at least one
major version (I would be more comfortable with three major versions,
actually).

Note: even after these patches, there is still a file mentioning
.git/remote/ (sic!) and .git/branches/:
Documentation/git-show-branch.txt. The reference is not, however,
describing Git's internals, but merely uses existing commit history
(from the olden days) in an example.

There is also a reference in contrib/examples/git-fetch.sh, but that
should remain there, for historians' purposes.

Oh, and the reason that I split out the changes to t5505, t5510, t5515 &
t5516 in the PREVIEW part is that those changes are unfortunately not
quite as trivial as I hoped, and require a bit of a rationale for the
way they were performed in the commit message. Read: I wanted to make
this patch series easier to review. And as I already split out all the
t/ patches, it felt silly to *not* split out the t0060 patch.


Johannes Schindelin (11):
  git-parse-remote: fix highly misleading man page
  Documentation: really deprecate .git/remotes/ and .git/branches/
  remote: warn loud and clear when .git/branches/ is *still* used
  remote: warn loud and clear when .git/remotes/ is *still* used
  Revert "Revert "Don't create the $GIT_DIR/branches directory on init""
  PREVIEW: t5510: convert .git/remotes/ test to use a regular remote
  PREVIEW: t5516: stop testing .git/branches/ functionality
  PREVIEW: remote: remove support for migrating ancient remotes
  PREVIEW: t5515: remove .git/remotes/ and .git/branches/ tests
  PREVIEW: t0060: stop testing support for .git/remotes/ and
    .git/branches/
  PREVIEW: remove support for .git/remotes/ and .git/branches/

 Documentation/git-parse-remote.txt                 |  7 +-
 Documentation/git-remote.txt                       |  4 -
 Documentation/gitrepository-layout.txt             | 19 +++--
 Documentation/urls-remotes.txt                     | 65 +---------------
 builtin/remote.c                                   | 27 -------
 path.c                                             |  2 -
 remote.c                                           | 89 ----------------------
 remote.h                                           |  4 +-
 t/t0060-path-utils.sh                              |  2 -
 t/t5505-remote.sh                                  | 55 -------------
 t/t5510-fetch.sh                                   | 10 +--
 t/t5515-fetch-merge-logic.sh                       | 23 ------
 t/t5515/fetch.br-branches-default                  |  8 --
 t/t5515/fetch.br-branches-default-merge            |  9 ---
 ...etch.br-branches-default-merge_branches-default |  9 ---
 t/t5515/fetch.br-branches-default-octopus          | 10 ---
 ...ch.br-branches-default-octopus_branches-default | 10 ---
 t/t5515/fetch.br-branches-default_branches-default |  8 --
 t/t5515/fetch.br-branches-one                      |  8 --
 t/t5515/fetch.br-branches-one-merge                |  9 ---
 t/t5515/fetch.br-branches-one-merge_branches-one   |  9 ---
 t/t5515/fetch.br-branches-one-octopus              |  9 ---
 t/t5515/fetch.br-branches-one-octopus_branches-one |  9 ---
 t/t5515/fetch.br-branches-one_branches-one         |  8 --
 t/t5515/fetch.br-remote-explicit                   | 11 ---
 t/t5515/fetch.br-remote-explicit-merge             | 11 ---
 .../fetch.br-remote-explicit-merge_remote-explicit | 11 ---
 t/t5515/fetch.br-remote-explicit-octopus           | 11 ---
 ...etch.br-remote-explicit-octopus_remote-explicit | 11 ---
 t/t5515/fetch.br-remote-explicit_remote-explicit   | 11 ---
 t/t5515/fetch.br-remote-glob                       | 11 ---
 t/t5515/fetch.br-remote-glob-merge                 | 11 ---
 t/t5515/fetch.br-remote-glob-merge_remote-glob     | 11 ---
 t/t5515/fetch.br-remote-glob-octopus               | 11 ---
 t/t5515/fetch.br-remote-glob-octopus_remote-glob   | 11 ---
 t/t5515/fetch.br-remote-glob_remote-glob           | 11 ---
 t/t5515/fetch.br-unconfig_branches-default         |  8 --
 t/t5515/fetch.br-unconfig_branches-one             |  8 --
 t/t5515/fetch.br-unconfig_remote-explicit          | 11 ---
 t/t5515/fetch.br-unconfig_remote-glob              | 11 ---
 t/t5515/fetch.master_branches-default              |  8 --
 t/t5515/fetch.master_branches-one                  |  8 --
 t/t5515/fetch.master_remote-explicit               | 11 ---
 t/t5515/fetch.master_remote-glob                   | 11 ---
 t/t5515/refs.br-branches-default                   | 12 ---
 t/t5515/refs.br-branches-default-merge             | 12 ---
 ...refs.br-branches-default-merge_branches-default | 12 ---
 t/t5515/refs.br-branches-default-octopus           | 12 ---
 ...fs.br-branches-default-octopus_branches-default | 12 ---
 t/t5515/refs.br-branches-default_branches-default  | 12 ---
 t/t5515/refs.br-branches-one                       | 12 ---
 t/t5515/refs.br-branches-one-merge                 | 12 ---
 t/t5515/refs.br-branches-one-merge_branches-one    | 12 ---
 t/t5515/refs.br-branches-one-octopus               | 12 ---
 t/t5515/refs.br-branches-one-octopus_branches-one  | 12 ---
 t/t5515/refs.br-branches-one_branches-one          | 12 ---
 t/t5515/refs.br-remote-explicit                    | 15 ----
 t/t5515/refs.br-remote-explicit-merge              | 15 ----
 .../refs.br-remote-explicit-merge_remote-explicit  | 15 ----
 t/t5515/refs.br-remote-explicit-octopus            | 15 ----
 ...refs.br-remote-explicit-octopus_remote-explicit | 15 ----
 t/t5515/refs.br-remote-explicit_remote-explicit    | 15 ----
 t/t5515/refs.br-remote-glob                        | 15 ----
 t/t5515/refs.br-remote-glob-merge                  | 15 ----
 t/t5515/refs.br-remote-glob-merge_remote-glob      | 15 ----
 t/t5515/refs.br-remote-glob-octopus                | 15 ----
 t/t5515/refs.br-remote-glob-octopus_remote-glob    | 15 ----
 t/t5515/refs.br-remote-glob_remote-glob            | 15 ----
 t/t5515/refs.br-unconfig_branches-default          | 12 ---
 t/t5515/refs.br-unconfig_branches-one              | 12 ---
 t/t5515/refs.br-unconfig_remote-explicit           | 15 ----
 t/t5515/refs.br-unconfig_remote-glob               | 15 ----
 t/t5515/refs.master_branches-default               | 12 ---
 t/t5515/refs.master_branches-one                   | 12 ---
 t/t5515/refs.master_remote-explicit                | 15 ----
 t/t5515/refs.master_remote-glob                    | 15 ----
 t/t5516-fetch-push.sh                              | 55 +------------
 templates/branches--                               |  1 -
 78 files changed, 20 insertions(+), 1089 deletions(-)
 delete mode 100644 t/t5515/fetch.br-branches-default
 delete mode 100644 t/t5515/fetch.br-branches-default-merge
 delete mode 100644 t/t5515/fetch.br-branches-default-merge_branches-default
 delete mode 100644 t/t5515/fetch.br-branches-default-octopus
 delete mode 100644 t/t5515/fetch.br-branches-default-octopus_branches-default
 delete mode 100644 t/t5515/fetch.br-branches-default_branches-default
 delete mode 100644 t/t5515/fetch.br-branches-one
 delete mode 100644 t/t5515/fetch.br-branches-one-merge
 delete mode 100644 t/t5515/fetch.br-branches-one-merge_branches-one
 delete mode 100644 t/t5515/fetch.br-branches-one-octopus
 delete mode 100644 t/t5515/fetch.br-branches-one-octopus_branches-one
 delete mode 100644 t/t5515/fetch.br-branches-one_branches-one
 delete mode 100644 t/t5515/fetch.br-remote-explicit
 delete mode 100644 t/t5515/fetch.br-remote-explicit-merge
 delete mode 100644 t/t5515/fetch.br-remote-explicit-merge_remote-explicit
 delete mode 100644 t/t5515/fetch.br-remote-explicit-octopus
 delete mode 100644 t/t5515/fetch.br-remote-explicit-octopus_remote-explicit
 delete mode 100644 t/t5515/fetch.br-remote-explicit_remote-explicit
 delete mode 100644 t/t5515/fetch.br-remote-glob
 delete mode 100644 t/t5515/fetch.br-remote-glob-merge
 delete mode 100644 t/t5515/fetch.br-remote-glob-merge_remote-glob
 delete mode 100644 t/t5515/fetch.br-remote-glob-octopus
 delete mode 100644 t/t5515/fetch.br-remote-glob-octopus_remote-glob
 delete mode 100644 t/t5515/fetch.br-remote-glob_remote-glob
 delete mode 100644 t/t5515/fetch.br-unconfig_branches-default
 delete mode 100644 t/t5515/fetch.br-unconfig_branches-one
 delete mode 100644 t/t5515/fetch.br-unconfig_remote-explicit
 delete mode 100644 t/t5515/fetch.br-unconfig_remote-glob
 delete mode 100644 t/t5515/fetch.master_branches-default
 delete mode 100644 t/t5515/fetch.master_branches-one
 delete mode 100644 t/t5515/fetch.master_remote-explicit
 delete mode 100644 t/t5515/fetch.master_remote-glob
 delete mode 100644 t/t5515/refs.br-branches-default
 delete mode 100644 t/t5515/refs.br-branches-default-merge
 delete mode 100644 t/t5515/refs.br-branches-default-merge_branches-default
 delete mode 100644 t/t5515/refs.br-branches-default-octopus
 delete mode 100644 t/t5515/refs.br-branches-default-octopus_branches-default
 delete mode 100644 t/t5515/refs.br-branches-default_branches-default
 delete mode 100644 t/t5515/refs.br-branches-one
 delete mode 100644 t/t5515/refs.br-branches-one-merge
 delete mode 100644 t/t5515/refs.br-branches-one-merge_branches-one
 delete mode 100644 t/t5515/refs.br-branches-one-octopus
 delete mode 100644 t/t5515/refs.br-branches-one-octopus_branches-one
 delete mode 100644 t/t5515/refs.br-branches-one_branches-one
 delete mode 100644 t/t5515/refs.br-remote-explicit
 delete mode 100644 t/t5515/refs.br-remote-explicit-merge
 delete mode 100644 t/t5515/refs.br-remote-explicit-merge_remote-explicit
 delete mode 100644 t/t5515/refs.br-remote-explicit-octopus
 delete mode 100644 t/t5515/refs.br-remote-explicit-octopus_remote-explicit
 delete mode 100644 t/t5515/refs.br-remote-explicit_remote-explicit
 delete mode 100644 t/t5515/refs.br-remote-glob
 delete mode 100644 t/t5515/refs.br-remote-glob-merge
 delete mode 100644 t/t5515/refs.br-remote-glob-merge_remote-glob
 delete mode 100644 t/t5515/refs.br-remote-glob-octopus
 delete mode 100644 t/t5515/refs.br-remote-glob-octopus_remote-glob
 delete mode 100644 t/t5515/refs.br-remote-glob_remote-glob
 delete mode 100644 t/t5515/refs.br-unconfig_branches-default
 delete mode 100644 t/t5515/refs.br-unconfig_branches-one
 delete mode 100644 t/t5515/refs.br-unconfig_remote-explicit
 delete mode 100644 t/t5515/refs.br-unconfig_remote-glob
 delete mode 100644 t/t5515/refs.master_branches-default
 delete mode 100644 t/t5515/refs.master_branches-one
 delete mode 100644 t/t5515/refs.master_remote-explicit
 delete mode 100644 t/t5515/refs.master_remote-glob
 delete mode 100644 templates/branches--


base-commit: b06d3643105c8758ed019125a4399cb7efdcce2c
Published-As: https://github.com/dscho/git/releases/tag/retire-cogito-branches-v1
Fetch-It-Via: git fetch https://github.com/dscho/git retire-cogito-branches-v1

-- 
2.12.2.windows.2.800.gede8f145e06

