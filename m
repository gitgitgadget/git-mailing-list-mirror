From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH 10/10] t9904: new __git_ps1 tests for Zsh
Date: Tue, 27 May 2014 03:41:00 -0400
Message-ID: <1401176460-31564-11-git-send-email-rhansen@bbn.com>
References: <xmqqbnusz46e.fsf@gitster.dls.corp.google.com>
 <1401176460-31564-1-git-send-email-rhansen@bbn.com>
Cc: rhansen@bbn.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 09:41:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpC11-0003Yz-Ii
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 09:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbaE0Hlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 03:41:42 -0400
Received: from smtp.bbn.com ([128.33.1.81]:43710 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751928AbaE0Hld (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 03:41:33 -0400
Received: from socket.bbn.com ([192.1.120.102]:58085)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WpC12-0005Ue-1Y; Tue, 27 May 2014 03:41:44 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 6C6F540217
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1401176460-31564-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250150>

These are the same tests as in t9903, but run in zsh instead of bash.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 t/lib-zsh.sh          | 30 ++++++++++++++++++++++++++++++
 t/t9904-zsh-prompt.sh | 10 ++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 t/lib-zsh.sh
 create mode 100755 t/t9904-zsh-prompt.sh

diff --git a/t/lib-zsh.sh b/t/lib-zsh.sh
new file mode 100644
index 0000000..fa6fcd9
--- /dev/null
+++ b/t/lib-zsh.sh
@@ -0,0 +1,30 @@
+# Shell library sourced instead of ./test-lib.sh by tests that need to
+# run under Zsh; primarily intended for tests of the git-prompt.sh
+# script.
+
+if test -n "$ZSH_VERSION" && test -z "$POSIXLY_CORRECT"; then
+	true
+elif command -v zsh >/dev/null 2>&1; then
+	unset POSIXLY_CORRECT
+	exec zsh "$0" "$@"
+else
+	echo '1..0 #SKIP skipping Zsh-specific tests; zsh not available'
+	exit 0
+fi
+
+# ensure that we are in full-on Zsh mode
+emulate -R zsh || exit 1
+
+shellname=Zsh
+
+ps1_expansion_enable () { setopt PROMPT_SUBST; }
+ps1_expansion_disable () { unsetopt PROMPT_SUBST; }
+set_ps1_format_vars () {
+	percent='%%%%'
+	c_red='%%F{red}'
+	c_green='%%F{green}'
+	c_lblue='%%F{blue}'
+	c_clear='%%f'
+}
+
+emulate sh -c '. ./test-lib.sh'
diff --git a/t/t9904-zsh-prompt.sh b/t/t9904-zsh-prompt.sh
new file mode 100755
index 0000000..a38a3fd
--- /dev/null
+++ b/t/t9904-zsh-prompt.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+
+test_description='test git-specific Zsh prompt functions'
+
+. ./lib-zsh.sh
+. "$TEST_DIRECTORY"/lib-prompt-tests.sh
+
+run_prompt_tests
+
+test_done
-- 
1.9.3
