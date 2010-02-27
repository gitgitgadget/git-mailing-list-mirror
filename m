From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: [PATCHv4 0/4] Using git-mailsplit in mixed line ending environment
Date: Sat, 27 Feb 2010 15:20:24 +0100
Message-ID: <1267280428-18223-1-git-send-email-stefan.hahn@s-hahn.de>
References: <1266080362-24760-1-git-send-email-stefan.hahn@s-hahn.de>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 15:21:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlNXd-0008BS-Jf
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 15:21:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968395Ab0B0OVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 09:21:09 -0500
Received: from moutng.kundenserver.de ([212.227.17.10]:52553 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968380Ab0B0OUw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 09:20:52 -0500
Received: from scotty.home (port-92-203-94-156.dynamic.qsc.de [92.203.94.156])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0LpRgn-1NHZAL2AZ3-00f6PS; Sat, 27 Feb 2010 15:20:49 +0100
Received: from scotty.home (hs@localhost [127.0.0.1])
	by scotty.home (8.14.3/8.14.3/Debian-5) with ESMTP id o1REKkPV019189;
	Sat, 27 Feb 2010 15:20:46 +0100
Received: (from hs@localhost)
	by scotty.home (8.14.3/8.14.3/Submit) id o1REKkc1019188;
	Sat, 27 Feb 2010 15:20:46 +0100
X-Mailer: git-send-email 1.7.0.98.g42448
In-Reply-To: <1266080362-24760-1-git-send-email-stefan.hahn@s-hahn.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on scotty.home
X-Virus-Scanned: clamav-milter 0.95.3 at scotty
X-Virus-Status: Clean
X-Provags-ID: V01U2FsdGVkX1/7Z02U3xOECXw3aOkfcFYCLmW74HBAHRJVKn1
 CEi509IPN9DGhWf6SaljXr+ZIeJqvs4AvCuL6SDGCcXrXVjVCw
 Rb7xCsdOcTi7fCqoj6hLg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141214>

Hello,

I'm using git in environments with files having dos or unix line
ending. I apply patches using 'git format-patch ... | git am ...'.
A change in git-mailsplit in commit c2ca1d79 introduced a change in
the default behaviour of git-mailsplit when splitting mbox patches. It
makes dos line endings to unix line endings. With this behaviour it is
impossible to apply patches.

The following patches introduce the '--kepp-cr', '--no-keep-cr'
parameter to git-am an an additional possibility to set '--keep-cr'
via configuration for git-am. Also I added missing description for
'--keep-cr' of git-mailsplit.

Second round:
I changed 'mailsplit.keep-cr' to 'mailsplit.keepcr' as suggested by Jakub
and comment in the testcase.

Third round:
I moved configuration 'mailsplit.keepcr' to 'am.keepcr' because
git-mailsplit can be used outside a git repository (thx Junio).

Fourth round:
I considered the replies from Junio and split up the patch introducing 
configuration am.keepcr in two. I introduced an '--no-keep-cr' to overwrite
configuration. I removed git-mailsplit tests from the test suite, they only 
showed the behaviour when using dos line ending.
I added some tests to show the correct behaviour in different situations
using the new parameters and configuration.


Stefan

[PATCH 1/4] git-mailsplit: Show parameter '--keep-cr' in usage and documentation
[PATCH 2/4] git-am: Add command line parameter `--keep-cr` passing it to git-mailsplit.
[PATCH 3/4] git-am: Add configuration am.keepcr and parameter --no-keep-cr to override configuration.
[PATCH 4/4] git-am: Adding tests for `--keep-cr`, `--no-keep-cr` and `am.keepcr`.
 
Documentation/config.txt        |    7 +++
Documentation/git-am.txt        |    9 +++-
Documentation/git-mailsplit.txt |    5 ++-
builtin-mailsplit.c             |    2 +-
git-am.sh                       |   32 ++++++++++---
t/t4253-am-keep-cr-dos.sh       |   96 +++++++++++++++++++++++++++++++++++++++
6 files changed, 141 insertions(+), 10 deletions(-)
