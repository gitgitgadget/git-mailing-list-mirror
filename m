From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 00/10] Build in merge
Date: Thu,  5 Jun 2008 22:44:26 +0200
Message-ID: <cover.1212698317.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 22:45:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4MKs-000606-Ny
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 22:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672AbYFEUod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 16:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbYFEUod
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 16:44:33 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:60240 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbYFEUoc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 16:44:32 -0400
Received: from vmobile.example.net (dsl5401CC68.pool.t-online.hu [84.1.204.104])
	by yugo.frugalware.org (Postfix) with ESMTP id 566661DDC5D
	for <git@vger.kernel.org>; Thu,  5 Jun 2008 22:44:29 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 3897F18E2A8; Thu,  5 Jun 2008 22:44:36 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83967>

This series is a rewrite of git-merge in C.

I already sent a WIP version of this series, it already worked at that
time, but I had numerous internal TODOs in the code.

I also tried to use the internal API wherever it was possible to avoid
the expensive run_command() calls.

At the moment I am not aware of any bugs in ugly parts in the code, so I
would appreciate if I could get some comments (positive or negative) on
it.

And yes, I'm aware that it's already late for 1.5.6, I'm sending it out
so that I can work on issues pointed out by others in the meantime.

Thanks.

Miklos Vajna (10):
  Move split_cmdline() to alias.c
  Move commit_list_count() to commit.c
  Move builtin-remote's skip_prefix() to git-compat-util.h
  Add new test to ensure git-merge handles pull.twohead and
    pull.octopus
  parseopt: add a new PARSE_OPT_ARGV0_IS_AN_OPTION option
  Move read_cache_unmerged() to read-cache.c
  git-fmt-merge-msg: make it useable from other builtins
  Introduce commit_list_append() in commit.c
  Introduce get_octopus_merge_bases() in commit.c
  Build in merge

 Makefile                                      |    2 +-
 alias.c                                       |   54 ++
 builtin-fmt-merge-msg.c                       |  157 ++--
 builtin-merge-recursive.c                     |    8 -
 builtin-merge.c                               | 1147 +++++++++++++++++++++++++
 builtin-read-tree.c                           |   24 -
 builtin-remote.c                              |    6 -
 builtin.h                                     |    4 +
 cache.h                                       |    3 +
 commit.c                                      |   59 ++
 commit.h                                      |    3 +
 git-merge.sh => contrib/examples/git-merge.sh |    0 
 git-compat-util.h                             |    6 +
 git.c                                         |   54 +--
 parse-options.c                               |   19 +-
 parse-options.h                               |    1 +
 read-cache.c                                  |   24 +
 t/t7601-merge-pull-config.sh                  |   57 ++
 18 files changed, 1460 insertions(+), 168 deletions(-)
 create mode 100644 builtin-merge.c
 rename git-merge.sh => contrib/examples/git-merge.sh (100%)
 create mode 100755 t/t7601-merge-pull-config.sh
