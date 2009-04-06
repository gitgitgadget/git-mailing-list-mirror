From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 10/14] difftool: add various git-difftool tests
Date: Mon,  6 Apr 2009 01:31:25 -0700
Message-ID: <1239006689-14695-11-git-send-email-davvid@gmail.com>
References: <1239006689-14695-1-git-send-email-davvid@gmail.com>
 <1239006689-14695-2-git-send-email-davvid@gmail.com>
 <1239006689-14695-3-git-send-email-davvid@gmail.com>
 <1239006689-14695-4-git-send-email-davvid@gmail.com>
 <1239006689-14695-5-git-send-email-davvid@gmail.com>
 <1239006689-14695-6-git-send-email-davvid@gmail.com>
 <1239006689-14695-7-git-send-email-davvid@gmail.com>
 <1239006689-14695-8-git-send-email-davvid@gmail.com>
 <1239006689-14695-9-git-send-email-davvid@gmail.com>
 <1239006689-14695-10-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, charles@hashpling.org,
	markus.heidelberg@web.de, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 06 10:35:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqkIN-0002l9-6O
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 10:35:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755047AbZDFIc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 04:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755032AbZDFIc0
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 04:32:26 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:19616 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194AbZDFIcG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 04:32:06 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2100228rvb.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 01:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=BeHR2//Ps0Z+41UinXIdYVeSpzwM5qkC0qaSpfJtSbA=;
        b=Ogzuq+QUq+C3JzShaz2BY2xwofComZHhHGUi/J6spyx99PewzM5ZUgKlh9f+bfdg2y
         h20nvv/W7bFI6zfNioQg7JLMisQDlou1JEC1twbBsprecdF2UR2bf8Z4clcPwpm8a/E2
         QOxOFx/FwVHodBofY+HCEzWKPjWqUx8q0wrEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ovS7f+U3BOw7Lt2sU25pexcUMlTEfjVfM2cOSGZHjX+29C+3dVD1s6/r0G6XdRo8+9
         S3VBY5Rp73oSFPFzfY5n5IC1dONkrqTlwpIFkTUDxzCI3iLq7c35/xYyg31efYyYf5Em
         7WgjFODWrOJqaIs7myDlSVXNb2hNkpp59ezOo=
Received: by 10.114.175.16 with SMTP id x16mr2151080wae.134.1239006723028;
        Mon, 06 Apr 2009 01:32:03 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id l28sm5175310waf.65.2009.04.06.01.32.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Apr 2009 01:32:02 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.414.g81aa9
In-Reply-To: <1239006689-14695-10-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115795>

t7800-difftool.sh tests the various command-line flags,
git-config variables, and environment settings supported by
git-difftool.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 t/t7800-difftool.sh |  147 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 147 insertions(+), 0 deletions(-)
 create mode 100755 t/t7800-difftool.sh

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
new file mode 100755
index 0000000..85946d9
--- /dev/null
+++ b/t/t7800-difftool.sh
@@ -0,0 +1,147 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 David Aguilar
+#
+
+test_description='git-difftool
+
+Testing basic diff tool invocation
+'
+
+. ./test-lib.sh
+
+remove_config_vars()
+{
+	# Unset all config variables used by git-difftool
+	git config --unset diff.tool
+	git config --unset difftool.test-tool.cmd
+	git config --unset merge.tool
+	git config --unset mergetool.test-tool.cmd
+	return 0
+}
+
+restore_test_defaults()
+{
+	# Restores the test defaults used by several tests
+	remove_config_vars
+	unset GIT_DIFF_TOOL
+	unset GIT_MERGE_TOOL
+	unset GIT_DIFFTOOL_NO_PROMPT
+	git config diff.tool test-tool &&
+	git config difftool.test-tool.cmd 'cat $LOCAL'
+}
+
+# Create a file on master and change it on branch
+test_expect_success 'setup' '
+	echo master >file &&
+	git add file &&
+	git commit -m "added file" &&
+
+	git checkout -b branch master &&
+	echo branch >file &&
+	git commit -a -m "branch changed file" &&
+	git checkout master
+'
+
+# Configure a custom difftool.<tool>.cmd and use it
+test_expect_success 'custom commands' '
+	restore_test_defaults &&
+	git config difftool.test-tool.cmd "cat \$REMOTE" &&
+
+	diff=$(git difftool --no-prompt branch) &&
+	test "$diff" = "master" &&
+
+	restore_test_defaults &&
+	diff=$(git difftool --no-prompt branch) &&
+	test "$diff" = "branch"
+'
+
+# Ensures that git-difftool ignores bogus --tool values
+test_expect_success 'difftool ignores bad --tool values' '
+	diff=$(git difftool --no-prompt --tool=bogus-tool branch)
+	test "$?" = 1 &&
+	test "$diff" = ""
+'
+
+# Specify the diff tool using $GIT_DIFF_TOOL
+test_expect_success 'GIT_DIFF_TOOL variable' '
+	git config --unset diff.tool
+	GIT_DIFF_TOOL=test-tool &&
+	export GIT_DIFF_TOOL &&
+
+	diff=$(git difftool --no-prompt branch) &&
+	test "$diff" = "branch" &&
+
+	restore_test_defaults
+'
+
+# Test the $GIT_*_TOOL variables and ensure
+# that $GIT_DIFF_TOOL always wins unless --tool is specified
+test_expect_success 'GIT_DIFF_TOOL overrides' '
+	git config diff.tool bogus-tool &&
+	git config merge.tool bogus-tool &&
+
+	GIT_MERGE_TOOL=test-tool &&
+	export GIT_MERGE_TOOL &&
+	diff=$(git difftool --no-prompt branch) &&
+	test "$diff" = "branch" &&
+	unset GIT_MERGE_TOOL &&
+
+	GIT_MERGE_TOOL=bogus-tool &&
+	GIT_DIFF_TOOL=test-tool &&
+	export GIT_MERGE_TOOL &&
+	export GIT_DIFF_TOOL &&
+
+	diff=$(git difftool --no-prompt branch) &&
+	test "$diff" = "branch" &&
+
+	GIT_DIFF_TOOL=bogus-tool &&
+	export GIT_DIFF_TOOL &&
+
+	diff=$(git difftool --no-prompt --tool=test-tool branch) &&
+	test "$diff" = "branch" &&
+
+	restore_test_defaults
+'
+
+# Test that we don't have to pass --no-prompt to difftool
+# when $GIT_DIFFTOOL_NO_PROMPT is true
+test_expect_success 'GIT_DIFFTOOL_NO_PROMPT variable' '
+	GIT_DIFFTOOL_NO_PROMPT=true &&
+	export GIT_DIFFTOOL_NO_PROMPT &&
+
+	diff=$(git difftool branch) &&
+	test "$diff" = "branch" &&
+
+	restore_test_defaults
+'
+
+# git-difftool falls back to git-mergetool config variables
+# so test that behavior here
+test_expect_success 'difftool + mergetool config variables' '
+	remove_config_vars
+	git config merge.tool test-tool &&
+	git config mergetool.test-tool.cmd "cat \$LOCAL" &&
+
+	diff=$(git difftool --no-prompt branch) &&
+	test "$diff" = "branch" &&
+
+	# set merge.tool to something bogus, diff.tool to test-tool
+	git config merge.tool bogus-tool &&
+	git config diff.tool test-tool &&
+
+	diff=$(git difftool --no-prompt branch) &&
+	test "$diff" = "branch" &&
+
+	restore_test_defaults
+'
+
+test_expect_success 'difftool.<tool>.path' '
+	git config difftool.tkdiff.path echo &&
+	diff=$(git difftool --no-prompt -t tkdiff branch) &&
+	git config --unset difftool.tkdiff.path &&
+	lines=$(echo "$diff" | grep file | wc -l) &&
+	test "$lines" = 1
+'
+
+test_done
-- 
1.6.2.2.414.g81aa9
