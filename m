From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 0/7] Allow custom merge strategies
Date: Sat, 26 Jul 2008 13:54:43 +0200
Message-ID: <cover.1217037178.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 26 13:55:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMiNA-0002Vg-K0
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 13:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbYGZLya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 07:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbYGZLy2
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 07:54:28 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:54445 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbYGZLyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 07:54:25 -0400
Received: from vmobile.example.net (dsl5401C493.pool.t-online.hu [84.1.196.147])
	by yugo.frugalware.org (Postfix) with ESMTP id 526961DDC5D
	for <git@vger.kernel.org>; Sat, 26 Jul 2008 13:54:23 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 1F43B1AA738; Sat, 26 Jul 2008 13:54:52 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90217>

Hi,

This series adds support for custom merge strategies.

The first 3 patches modify builtin-help to allow using it from other
builtins. This is necessary because in the error message of 'git merge
-s foobar' we show something like 'git help -a', but we list only merge
strategies. A command is considered a merge strategy if it has a
git-merge- prefix and is listed in the all_strategy array or it is
somewhere in PATH, but outside `git --exec-path`, so that git-merge-ours
and other strategies are shown, git-merge-index and other
git-merge-named (but not strategy) commands are hidden.

The last two is about removing those problematic 'git-merge-index',
'git-merge-tree' and other bogus commands from the output of 'git merge
-s foobar'. I think the benefit of doing it that way is that we don't
have to maintain a list of commands which are named git-merge-foo but
not strategies _and_ the custom strategies can have a form of
git-merge-foo, without adding extra complexity (like forcing users to
name them git-merge-custom-foo).

NOTE: At the moment the custom strategies are named as git-merge-foo as
well, mainly because I think it's not that problematic to exclude the
already existing git-merge-fo non-strategy commands, but this can be
changed to git-merge-strategy-foo if we really want so.

Also, I'm aware that this is a feature and we are in rc freeze, I just
did not want to keep back this series till 1.6.0 is out.

Miklos Vajna (7):
  Make is_git_command() usable outside builtin-help
  builtin-help: change the current directory back in
    list_commands_in_dir()
  builtin-help: make list_commands() a bit more generic
  builtin-merge: allow using a custom strategy
  Add a new test for using a custom merge strategy
  builtin-help: make it possible to exclude some commands in
    list_commands()
  builtin-merge: avoid non-strategy git-merge commands in error message

 Makefile                |    1 +
 builtin-merge.c         |   30 +++++++++++++++++++++------
 help.c                  |   50 ++++++++++++++++++++++++----------------------
 help.h                  |   19 +++++++++++++++++
 t/t7606-merge-custom.sh |   45 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 114 insertions(+), 31 deletions(-)
 create mode 100644 help.h
 create mode 100755 t/t7606-merge-custom.sh
