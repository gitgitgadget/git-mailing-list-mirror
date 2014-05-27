From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH 00/10] Zsh prompt tests
Date: Tue, 27 May 2014 03:40:50 -0400
Message-ID: <1401176460-31564-1-git-send-email-rhansen@bbn.com>
References: <xmqqbnusz46e.fsf@gitster.dls.corp.google.com>
Cc: rhansen@bbn.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 09:41:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpC0u-0003O6-6h
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 09:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbaE0Hld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 03:41:33 -0400
Received: from smtp.bbn.com ([128.33.0.80]:35567 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751581AbaE0Hla (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 03:41:30 -0400
Received: from socket.bbn.com ([192.1.120.102]:50697)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WpC0m-000PGu-Ub; Tue, 27 May 2014 03:41:28 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 87C3940217
X-Mailer: git-send-email 1.9.3
In-Reply-To: <xmqqbnusz46e.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250147>

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

Richard Hansen (10):
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
  t9904: new __git_ps1 tests for Zsh

 t/lib-bash.sh          |  12 +
 t/lib-prompt-tests.sh  | 633 +++++++++++++++++++++++++++++++++++++++++++++++++
 t/lib-zsh.sh           |  30 +++
 t/t9903-bash-prompt.sh | 582 +--------------------------------------------
 t/t9904-zsh-prompt.sh  |  10 +
 5 files changed, 687 insertions(+), 580 deletions(-)
 create mode 100644 t/lib-prompt-tests.sh
 create mode 100644 t/lib-zsh.sh
 create mode 100755 t/t9904-zsh-prompt.sh

-- 
1.9.3
