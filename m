From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH] tests: add initial bash completion tests
Date: Fri,  6 Apr 2012 22:28:39 +0300
Message-ID: <1333740519-3792-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 06 21:29:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGEqE-0003Sb-1y
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 21:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757792Ab2DFT25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 15:28:57 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:36834 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757784Ab2DFT24 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Apr 2012 15:28:56 -0400
Received: by lahj13 with SMTP id j13so2315900lah.19
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 12:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=jaIaZlK6jqlShrm366RHxoDWqz5DNvQZSPg/J/SDTZE=;
        b=G9LzbJo1dqrLnp022j6ELY+CkLIHgdCUeI9yI4tKBWH0Irf3jCqEVjuWRjU8fhErrc
         X7goKQ7OwlJSOi7KJmkqqcD9erhWgQgXoonp+yuU8rvAWKHMCX3e7JwNPBAi5NsE8X+G
         p3D9EaKu5rJp88QDKp2cff+Y07WMvSe2qFKhoncTDhddYIZ9svJJFn+UMV/MpXbWzeJf
         Hik6kC73ary2D5x2yZttpOsfClUYwb1uuI5H7rFBYgEhQHkf71DKGTM8SwiBguO015B5
         H1/9rIzdCyYLbX91M1nm2oAw5EVDQb9bYeTa4fywrAsTGzOZyEAvgxYLDEqHdFoFWEZT
         LbvQ==
Received: by 10.152.111.198 with SMTP id ik6mr10089575lab.38.1333740535282;
        Fri, 06 Apr 2012 12:28:55 -0700 (PDT)
Received: from localhost (80-186-93-53.elisa-mobile.fi. [80.186.93.53])
        by mx.google.com with ESMTPS id nq2sm7196096lab.6.2012.04.06.12.28.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 06 Apr 2012 12:28:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194897>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Something is better than nothing.

 t/t9902-completion.sh |  198 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 198 insertions(+)
 create mode 100755 t/t9902-completion.sh

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
new file mode 100755
index 0000000..a037dff
--- /dev/null
+++ b/t/t9902-completion.sh
@@ -0,0 +1,198 @@
+#!/bin/bash
+#
+# Copyright (c) 2012 Felipe Contreras
+#
+
+test_description='test bash completion'
+
+. ./test-lib.sh
+
+complete ()
+{
+	# do nothing
+	return 0
+}
+
+. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"
+
+print_comp ()
+{
+	local IFS=$'\n'
+	echo "${COMPREPLY[*]}" > out
+}
+
+print_words ()
+{
+	local w=(foo foo. --foo=bar)
+	local IFS=$'\n'
+	echo "${w[*]}"
+}
+
+_get_comp_words_by_ref ()
+{
+	while [ $# -gt 0 ]; do
+		case "$1" in
+		cur)
+			cur=${_words[_cword]}
+			;;
+		prev)
+			prev=${_words[_cword-1]}
+			;;
+		words)
+			words=("${_words[@]}")
+			;;
+		cword)
+			cword=$_cword
+			;;
+		esac
+		shift
+	done
+}
+
+test_completion ()
+{
+	local -a COMPREPLY _words
+	local _cword
+	_words=( $1 )
+	(( _cword = ${#_words[@]} - 1 ))
+	_git && print_comp &&
+	test_cmp expected out
+}
+
+test_expect_success 'git' '
+	cat >expected <<-\EOF &&
+	help 
+	add 
+	gc 
+	reflog 
+	get-tar-commit-id 
+	relink 
+	grep 
+	relink.perl 
+	am 
+	remote 
+	am.sh 
+	help 
+	annotate 
+	apply 
+	archimport.perl 
+	imap-send 
+	archive 
+	bisect 
+	init 
+	repack 
+	bisect.sh 
+	instaweb 
+	repack.sh 
+	blame 
+	instaweb.sh 
+	replace 
+	branch 
+	log 
+	bundle 
+	request-pull 
+	lost-found.sh 
+	request-pull.sh 
+	reset 
+	checkout 
+	cherry 
+	revert 
+	cherry-pick 
+	merge 
+	rm 
+	clean 
+	send-email 
+	clone 
+	send-email.perl 
+	commit 
+	config 
+	shortlog 
+	credential-cache 
+	show 
+	show-branch 
+	credential-store 
+	cvsexportcommit.perl 
+	stage 
+	stash 
+	cvsimport.perl 
+	stash.sh 
+	mergetool 
+	status 
+	cvsserver.perl 
+	mergetool.sh 
+	submodule 
+	describe 
+	submodule.sh 
+	diff 
+	mv 
+	svn 
+	name-rev 
+	svn.perl 
+	notes 
+	tag 
+	difftool 
+	difftool.perl 
+	fetch 
+	pull 
+	pull.sh 
+	filter-branch 
+	push 
+	filter-branch.sh 
+	quiltimport.sh 
+	format-patch 
+	rebase 
+	fsck 
+	rebase.sh 
+	whatchanged 
+	cccmd 
+	proxy 
+	send-pull 
+	EOF
+	test_completion "git" &&
+
+	cat >expected <<-\EOF &&
+	help 
+	help 
+	EOF
+	test_completion "git he"
+
+	cat >expected <<-\EOF &&
+	fetch 
+	filter-branch 
+	filter-branch.sh 
+	format-patch 
+	fsck 
+	EOF
+	test_completion "git f"
+'
+
+test_expect_success 'git (double dash)' '
+	cat >expected <<-\EOF &&
+	--paginate 
+	--no-pager 
+	--git-dir=
+	--bare 
+	--version 
+	--exec-path 
+	--html-path 
+	--work-tree=
+	--namespace=
+	--help 
+	EOF
+	test_completion "git --"
+
+	cat >expected <<-\EOF &&
+	--quiet 
+	--ours 
+	--theirs 
+	--track 
+	--no-track 
+	--merge 
+	--conflict=
+	--orphan 
+	--patch 
+	EOF
+	test_completion "git checkout --"
+'
+
+test_done
-- 
1.7.9.6
