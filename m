From: Yann Droneaud <ydroneaud@opteya.com>
Subject: [PATCH 00/15] Use test_config
Date: Sun, 24 Mar 2013 22:05:59 +0100
Message-ID: <cover.1364158574.git.ydroneaud@opteya.com>
References: <7vvc8j8p9m.fsf@alter.siamese.dyndns.org>
Cc: Yann Droneaud <ydroneaud@opteya.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 22:07:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJs8B-0007Yh-Rs
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 22:07:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754382Ab3CXVGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 17:06:40 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:51015 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754027Ab3CXVGk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 17:06:40 -0400
Received: from test.quest-ce.net (unknown [IPv6:2a01:e35:2e9f:6ac0:c8b1:2f86:54cb:a84a])
	by smtp1-g21.free.fr (Postfix) with ESMTP id DA85E940194;
	Sun, 24 Mar 2013 22:06:29 +0100 (CET)
Received: from test.quest-ce.net (localhost.localdomain [127.0.0.1])
	by test.quest-ce.net (8.14.5/8.14.5) with ESMTP id r2OL6R9J007251;
	Sun, 24 Mar 2013 22:06:27 +0100
Received: (from ydroneaud@localhost)
	by test.quest-ce.net (8.14.5/8.14.5/Submit) id r2OL6Qw2007248;
	Sun, 24 Mar 2013 22:06:26 +0100
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <7vvc8j8p9m.fsf@alter.siamese.dyndns.org>
References: <1363704914.6289.39.camel@test.quest-ce.net> <loom.20130321T212911-611@post.gmane.org> <cdc4f45e7520ce1fc48588c260214717@meuh.org> <1363946943-30269-1-git-send-email-ydroneaud@opteya.com> <7vvc8j8p9m.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vvc8j8p9m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218980>

Please find some patches to use test_config/test_unconfig

Instead of using construct such as:
   test_when_finished "git config --unset <key>"
   git config <key> <value>
uses
   test_config <key> <value>
The latter takes care of removing <key> at the end of the test.
    
Additionally, instead of
   git config <key> ""
or
   git config --unset <key>
 uses
   test_unconfig <key>
The latter doesn't failed if <key> is not defined.

Patch "t7600: use test_config to set/unset git config variables"
is more important than the other and must be carefully reviewed
regarded to the --no-log --no-ff behavior.

Others patches are fairly simple.

Testsuite results are the same after the patches.
Tested against master, 7b592fadf1e23b10b913e0771b9f711770597266

Yann Droneaud (15):
  t4018: remove test_config implementation
  t7810: remove test_config implementation
  t7811: remove test_config implementation
  t3400: use test_config to set/unset git config variables
  t4304: use test_config to set/unset git config variables
  t4034: use test_config/test_unconfig to set/unset git config
    variables
  t4202: use test_config/test_unconfig to set/unset git config
    variables
  t5520: use test_config to set/unset git config variables
  t5541: use test_config to set/unset git config variables
  t7500: use test_config to set/unset git config variables
  t7502: use test_config to set/unset git config variables
  t7508: use test_config to set/unset git config variables
  t7600: use test_config to set/unset git config variables
  t9500: use test_config to set/unset git config variables
  t7502: remove clear_config

 t/t3400-rebase.sh                      |  3 +-
 t/t3404-rebase-interactive.sh          |  3 +-
 t/t4018-diff-funcname.sh               |  5 ---
 t/t4034-diff-words.sh                  |  7 ++--
 t/t4202-log.sh                         | 28 +++++-----------
 t/t5520-pull.sh                        | 12 +++----
 t/t5541-http-push.sh                   |  3 +-
 t/t7500-commit.sh                      |  6 ++--
 t/t7502-commit.sh                      | 40 +++++------------------
 t/t7508-status.sh                      | 46 +++++++++-----------------
 t/t7600-merge.sh                       | 60 +++++++++++++++-------------------
 t/t7810-grep.sh                        |  5 ---
 t/t7811-grep-open.sh                   |  5 ---
 t/t9500-gitweb-standalone-no-errors.sh |  3 +-
 14 files changed, 72 insertions(+), 154 deletions(-)

-- 
1.7.11.7
