From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2 00/11] Zsh prompt tests
Date: Wed,  4 Jun 2014 17:01:16 -0400
Message-ID: <1401915687-8602-1-git-send-email-rhansen@bbn.com>
References: <1401176460-31564-1-git-send-email-rhansen@bbn.com>
Cc: rhansen@bbn.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 23:01:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsIJZ-0005B0-Tf
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 23:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbaFDVBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 17:01:38 -0400
Received: from smtp.bbn.com ([128.33.1.81]:62185 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129AbaFDVBh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 17:01:37 -0400
Received: from socket.bbn.com ([192.1.120.102]:36562)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WsIJf-000DMA-Tk; Wed, 04 Jun 2014 17:01:48 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 0B3743FFFC
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1401176460-31564-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250781>

Changes from v1:

  * fix a bug that caused the Zsh test cases to run in Zsh's sh
    emulation mode, not Zsh "native" mode

Description:

This series adds test cases for running __git_ps1 (see
contrib/completion/git-prompt.sh) from Zsh.

This series also adds more Bash test cases to test how __git_ps1
reacts to disabling Bash's PS1 parameter expansion.  (This is related
to adding Zsh test cases:  Zsh doesn't perform parameter expansion on
PS1 by default but many users turn it on, so the Zsh test script must
test __git_ps1 in both states.  Bash expands PS1 by default and users
rarely turn it off, but testing both states in Bash improves the
symmetry with the Zsh test cases.)

This is the approach I took:

  1. delete the last test case in t9903 ("prompt - zsh color pc mode")
  2. add two new functions to t/lib-bash.sh:
         ps1_expansion_enable () { shopt -s promptvars; }
         ps1_expansion_disable () { shopt -u promptvars; }
  3. loop over the relevant test cases twice:  once after calling
     ps1_expansion_enable and once after calling ps1_expansion_disable
     (with appropriate adjustments to the expected output)
  4. move the test cases in t9903 to a separate library file and
     source it from t9903-bash-prompt.sh
  5. create two new files:
       * t/lib-zsh.sh (same as t/lib-bash.sh but tweaked for zsh)
       * t/t9904-zsh-prompt.sh (same as t/t9903-bash-prompt.sh but
         tweaked for zsh)

There are a lot of indendation changes, so I recommend examining the
changes via diff -w.


Richard Hansen (11):
  t9903: remove Zsh test from the suite of Bash prompt tests
  t9903: put the Bash pc mode prompt test cases in a function
  t9903: move test name prefix to a separate variable
  t9903: run pc mode tests again with PS1 expansion disabled
  t9903: include "Bash" in test names via new $shellname var
  t9903: move PS1 color code variable definitions to lib-bash.sh
  t9903: move prompt tests to a new lib-prompt-tests.sh file
  lib-prompt-tests.sh: put all tests inside a function
  lib-prompt-tests.sh: add variable for string that encodes percent in
    PS1
  test-lib: make it possible to override how test code is eval'd
  t9904: new __git_ps1 tests for Zsh

 t/lib-bash.sh          |  12 +
 t/lib-prompt-tests.sh  | 654 +++++++++++++++++++++++++++++++++++++++++++++++++
 t/lib-zsh.sh           |  52 ++++
 t/t9903-bash-prompt.sh | 582 +------------------------------------------
 t/t9904-zsh-prompt.sh  |  10 +
 t/test-lib.sh          |   7 +-
 6 files changed, 736 insertions(+), 581 deletions(-)
 create mode 100644 t/lib-prompt-tests.sh
 create mode 100644 t/lib-zsh.sh
 create mode 100755 t/t9904-zsh-prompt.sh

-- 
2.0.0
