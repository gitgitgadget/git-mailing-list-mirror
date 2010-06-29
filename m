From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH] Add test for correct coloring of git log --decoration
Date: Tue, 29 Jun 2010 15:47:08 +0800
Message-ID: <1277797628-32466-1-git-send-email-ayiehere@gmail.com>
References: <7vbpaucs2c.fsf@alter.siamese.dyndns.org>
Cc: Nazri Ramliy <ayiehere@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 29 09:47:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTVXZ-0004I3-UC
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 09:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488Ab0F2Hr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 03:47:28 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:40740 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab0F2Hr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 03:47:27 -0400
Received: by pxi8 with SMTP id 8so2176006pxi.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 00:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6qPJQN7vIrodH5Qa1ofFf2if8pjYd4svrjsUI/f1SFM=;
        b=tTkv8ohLyU5PSWfnSFOOZgDKvY/LAPxPe31TtkSSvDi8J5kDIbA4/3dE0Wlqw3O+jE
         PpSEK2hfEHhEq5XGZVNM9S6gP004hAruXei2PDveXsIJ3idzdAzT5NmIUS25ctt3EKah
         pIrowpbtWVH07asLiOTpFrqFYrG8D7Qq7TvPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ki2rC83moTupwIo/y+HW2z8f5eLDUl6+z2iZ2EPwPyN4fYVBbhLnLxcwG3FKztXHsp
         5/42mMAb6UrtR7XkRBgSOsr/iM+7QvUhtTu8smbMFRSpvoqTl8vppItmKBywtqqYUwQH
         5F5PU13c8/r7pCTZLGaOVSsRiPOxMTJUdBmZo=
Received: by 10.143.24.32 with SMTP id b32mr5664345wfj.219.1277797646444;
        Tue, 29 Jun 2010 00:47:26 -0700 (PDT)
Received: from localhost.localdomain ([115.134.69.17])
        by mx.google.com with ESMTPS id w8sm2613607wfd.19.2010.06.29.00.47.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Jun 2010 00:47:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.363.gac4b1
In-Reply-To: <7vbpaucs2c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149889>

Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
---
On Tue, Jun 29, 2010 at 1:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Let's not expand a single-line description needlessly into a multi-line
> one.

Fixed.

>> +test_expect_success setup '
>> +  echo foo > foo.txt &&
>
> Indent these with <TAB>, like:
>
>        echo foo >foo.txt &&

Fixed.

> I think "EDITOR=cat" is doubly wrong.

Fixed.

> Do not chdir around inside test scripts without having that in a subshell,
> as people typically write "cd .." at the very end of a && chain, which may
> not be called when anything in between fails, throwing the later tests
> into chaos.

Fixed.

> In this case your excuse will be that you will run everything after this
> point in that local-clone subdirectory, but still this is not a good style
> we would want to keep around, risking to be copied by other people who do
> not think carefully.
[snip]
> I think the set-up sequence for this test script should probably be
> structured like this:
[snip]
> so that the main test is done inside the top-level directory (you wanted
> the clone only because you wanted to have remote tracking branches, not
> because you didn't want to touch the top-level directory).

Thanks for taking the time to explain it well.

I should have familiarized myself more with the utility functions in
test-lib.sh (so that I would know about test_commit).

I've updated the test to also test for the need to print 'reset' right before
restoring the commit color.  This is done by setting the tag color to "reverse
bold yellow".  Without the 'reset', the next decoration would be wrongly
printed in reverse.

nazri

 t/t4207-log-decoration-colors.sh |   65 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)
 create mode 100755 t/t4207-log-decoration-colors.sh

diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
new file mode 100755
index 0000000..5ea5865
--- /dev/null
+++ b/t/t4207-log-decoration-colors.sh
@@ -0,0 +1,65 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Nazri Ramliy
+#
+
+test_description='Test for "git log --decorate" colors'
+
+. ./test-lib.sh
+
+get_color ()
+{
+	git config --get-color no.such.slot "$1"
+}
+
+test_expect_success setup '
+	git config diff.color.commit yellow &&
+	git config color.decorate.branch green &&
+	git config color.decorate.remoteBranch red &&
+	git config color.decorate.tag "reverse bold yellow" &&
+	git config color.decorate.stash magenta &&
+	git config color.decorate.HEAD cyan &&
+
+	c_reset=$(get_color reset) &&
+
+	c_commit=$(get_color yellow) &&
+	c_branch=$(get_color green) &&
+	c_remoteBranch=$(get_color red) &&
+	c_tag=$(get_color "reverse bold yellow") &&
+	c_stash=$(get_color magenta) &&
+	c_HEAD=$(get_color cyan) &&
+
+	test_commit A &&
+	git clone . other &&
+	(
+		cd other &&
+		test_commit A1
+	) &&
+
+	git remote add -f other ./other &&
+	test_commit B &&
+	git tag v1.0 &&
+	echo >>A.t &&
+	git stash save Changes to A.t
+'
+
+cat > expected << EOF
+${c_commit}COMMIT_ID (${c_HEAD}HEAD${c_reset}${c_commit},\
+ ${c_tag}tag: v1.0${c_reset}${c_commit},\
+ ${c_tag}tag: B${c_reset}${c_commit},\
+ ${c_branch}master${c_reset}${c_commit})${c_reset} B
+${c_commit}COMMIT_ID (${c_tag}tag: A1${c_reset}${c_commit},\
+ ${c_remoteBranch}other/master${c_reset}${c_commit})${c_reset} A1
+${c_commit}COMMIT_ID (${c_stash}refs/stash${c_reset}${c_commit})${c_reset}\
+ On master: Changes to A.t
+${c_commit}COMMIT_ID (${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
+EOF
+
+# We want log to show all, but the second parent to refs/stash is irrelevant
+# to this test since it does not contain any decoration, hence --first-parent
+test_expect_success 'Commit Decorations Colored Correctly' '
+	git log --first-parent --abbrev=10 --all --decorate --oneline --color=always | sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" > out &&
+	test_cmp expected out
+'
+
+test_done
-- 
1.7.1.245.g7c42e.dirty
