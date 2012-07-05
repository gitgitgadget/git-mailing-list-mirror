From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 00/12] git-remote-mediawiki: tests and optimizations
Date: Thu,  5 Jul 2012 09:36:00 +0200
Message-ID: <1341473772-28023-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 05 09:36:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Smgc3-0008UY-3t
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 09:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546Ab2GEHg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 03:36:26 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58588 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752581Ab2GEHgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 03:36:25 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q657ZJFP029084
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Jul 2012 09:35:19 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Smgbs-0006Vn-Rc; Thu, 05 Jul 2012 09:36:20 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Smgbs-0007gz-ML; Thu, 05 Jul 2012 09:36:20 +0200
X-Mailer: git-send-email 1.7.11.1.147.g47a574d
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 05 Jul 2012 09:35:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q657ZJFP029084
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1342078520.21168@UP4QI78Z+6gldWfv4X4uCA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201024>

This patch serie starts with the implementation of an automated
testsuite for git-remote-mediawiki. It was already discussed here:

  http://thread.gmane.org/gmane.comp.version-control.git/199718/focus=199905

but has been reworked a bit (no huge change in behavior, but a lot of
style fixes). The first two patches implement the infrastructure, the
next few ones provide a set of testcases for existing features.

On top of that, a new fetch strategy is implemented, that is much
faster than the existing on wikis with little activity and many pages.
The existing tests for push and pull are reused to be tested with this
new strategy. This part can be split in a separate patch serie if
needed.

Guillaume Sasdy (4):
  git-remote-mediawiki: scripts to install, delete and clear a
    MediaWiki
  git-remote-mediawiki: test environment of git-remote-mediawiki
  git-remote-mediawiki (t9360): test git-remote-mediawiki clone
  git-remote-mediawiki (t9361): test git-remote-mediawiki pull and push

Matthieu Moy (6):
  git-remote-mediawiki: support for uploading file in test environment
  git-remote-mediawiki: change return type of get_mw_pages
  git-remote-mediawiki: refactor loop over revision ids
  git-remote-mediawiki: extract revision-importing loop to a function
  git-remote-mediawiki: more efficient 'pull' in the best case
  git-remote-mediawiki: be more defensive when requests fail

NGUYEN Kim Thuat (1):
  git-remote-mediawiki (t9363): test 'File:' import and export

Simon Cathebras (1):
  git-remote-mediawiki (t9362): test git-remote-mediawiki with UTF8
    characters

 contrib/mw-to-git/Makefile                         |  48 +++
 contrib/mw-to-git/git-remote-mediawiki             | 151 +++++--
 contrib/mw-to-git/t/.gitignore                     |   4 +
 contrib/mw-to-git/t/Makefile                       |  32 ++
 contrib/mw-to-git/t/README                         | 124 ++++++
 contrib/mw-to-git/t/install-wiki.sh                |  45 +++
 contrib/mw-to-git/t/install-wiki/.gitignore        |   1 +
 contrib/mw-to-git/t/install-wiki/LocalSettings.php | 129 ++++++
 contrib/mw-to-git/t/install-wiki/db_install.php    | 120 ++++++
 contrib/mw-to-git/t/push-pull-tests.sh             | 144 +++++++
 contrib/mw-to-git/t/t9360-mw-to-git-clone.sh       | 257 ++++++++++++
 contrib/mw-to-git/t/t9361-mw-to-git-push-pull.sh   |  24 ++
 contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh        | 301 ++++++++++++++
 .../mw-to-git/t/t9363-mw-to-git-export-import.sh   | 198 ++++++++++
 contrib/mw-to-git/t/t9364-pull-by-rev.sh           |  17 +
 contrib/mw-to-git/t/test-gitmw-lib.sh              | 435 +++++++++++++++++++++
 contrib/mw-to-git/t/test-gitmw.pl                  | 225 +++++++++++
 contrib/mw-to-git/t/test.config                    |  35 ++
 18 files changed, 2263 insertions(+), 27 deletions(-)
 create mode 100644 contrib/mw-to-git/Makefile
 create mode 100644 contrib/mw-to-git/t/.gitignore
 create mode 100644 contrib/mw-to-git/t/Makefile
 create mode 100644 contrib/mw-to-git/t/README
 create mode 100755 contrib/mw-to-git/t/install-wiki.sh
 create mode 100644 contrib/mw-to-git/t/install-wiki/.gitignore
 create mode 100644 contrib/mw-to-git/t/install-wiki/LocalSettings.php
 create mode 100644 contrib/mw-to-git/t/install-wiki/db_install.php
 create mode 100644 contrib/mw-to-git/t/push-pull-tests.sh
 create mode 100755 contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
 create mode 100755 contrib/mw-to-git/t/t9361-mw-to-git-push-pull.sh
 create mode 100755 contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
 create mode 100755 contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
 create mode 100755 contrib/mw-to-git/t/t9364-pull-by-rev.sh
 create mode 100755 contrib/mw-to-git/t/test-gitmw-lib.sh
 create mode 100755 contrib/mw-to-git/t/test-gitmw.pl
 create mode 100644 contrib/mw-to-git/t/test.config

-- 
1.7.11.1.147.g47a574d
