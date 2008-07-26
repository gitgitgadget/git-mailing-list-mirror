From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: Re: [PATCH v2] Support copy and rename detection in fast-export.
Date: Sun, 27 Jul 2008 00:52:54 +0400
Organization: TEPKOM
Message-ID: <200807270052.55370.angavrilov@gmail.com>
References: <200807211216.01694.angavrilov@gmail.com> <200807262249.18005.angavrilov@gmail.com> <20080726202103.GA15769@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jul 26 22:54:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMqmP-0006e2-8g
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 22:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755485AbYGZUxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 16:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753732AbYGZUxK
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 16:53:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:27416 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755417AbYGZUxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 16:53:09 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1862779fgg.17
        for <git@vger.kernel.org>; Sat, 26 Jul 2008 13:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ll5PQC2ycnG/huRzbaX8GPFhGVeCFnbVlRXC3d0Pro0=;
        b=tP/Zmz1vSBM0ZEgSjgxNBkBsDwzUj8dCX1P6yMWZCDIf2Er9tfDbGWQNOKbLB+HmFk
         LbUkdYg/9KuiyD75kmPdG9TjC4EPeLil6xdmIiDwAU+nJj0C/Bj3WUHPTsSAOWkwfXBA
         eT/vgAlDWIiHtUQc9sdElMGc8uQptpT/MpGZc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=V21WEEWm6seLtjx3IIdGbo14Vwsw9IXIpr8e58dDcaG8lWU5c8uaEJNsU6N9d36Xr/
         jqGSkLj22blck2Dk2CsYH5s2z5hAaP+vq+wu5MUfgvzRgqHWcbrHvXXbkZPTAAfRWE4r
         dnjUDhgUEn74dwK333E0D2VFxS5jb/N58SWFw=
Received: by 10.86.68.20 with SMTP id q20mr1171369fga.2.1217105587798;
        Sat, 26 Jul 2008 13:53:07 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id 12sm13488158fgg.0.2008.07.26.13.53.05
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 26 Jul 2008 13:53:06 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <20080726202103.GA15769@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90284>

Although it does not matter for Git itself, tools that
export to systems that explicitly track copies and
renames can benefit from such information.

This patch makes fast-export output correct action
logs when -M or -C are enabled.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

	On Sunday 27 July 2008 00:21:03 Shawn O. Pearce wrote:
	> Do you mean to say git-fast-export in the end of the first line of
	> that last paragraph?

	Yes, of course. Thank you.

	By the way, I see that http://git.kernel.org/?p=gitk/gitk.git;a=summary
	hasn't been updated for 2 months. Did the main gitk repository move
	to some other place?

	-- Alexander

 Documentation/git-fast-export.txt |    9 +++++++
 builtin-fast-export.c             |   28 +++++++++++++++++++++-
 t/t9301-fast-export.sh            |   46 +++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 332346c..bb2f9a8 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -36,6 +36,15 @@ when encountering a signed tag.  With 'strip', the tags will be made
 unsigned, with 'verbatim', they will be silently exported
 and with 'warn', they will be exported, but you will see a warning.
 
+-M, -C::
+	Perform move and/or copy detection, as described in the
+	linkgit:git-diff[1] manual page, and use it to generate
+	rename and copy commands in the output dump.
++
+Note that these options were always accepted by git-fast-export,
+but before a certain version it silently produced wrong results.
+You should always check the git version before using them.
+
 
 EXAMPLES
 --------
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 8bea269..3225e8f 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -118,10 +118,27 @@ static void show_filemodify(struct diff_queue_struct *q,
 {
 	int i;
 	for (i = 0; i < q->nr; i++) {
+		struct diff_filespec *ospec = q->queue[i]->one;
 		struct diff_filespec *spec = q->queue[i]->two;
-		if (is_null_sha1(spec->sha1))
+
+		switch (q->queue[i]->status) {
+		case DIFF_STATUS_DELETED:
 			printf("D %s\n", spec->path);
-		else {
+			break;
+
+		case DIFF_STATUS_COPIED:
+		case DIFF_STATUS_RENAMED:
+			printf("%c \"%s\" \"%s\"\n", q->queue[i]->status,
+			       ospec->path, spec->path);
+
+			if (!hashcmp(ospec->sha1, spec->sha1) &&
+			    ospec->mode == spec->mode)
+				break;
+			/* fallthrough */
+
+		case DIFF_STATUS_TYPE_CHANGED:
+		case DIFF_STATUS_MODIFIED:
+		case DIFF_STATUS_ADDED:
 			/*
 			 * Links refer to objects in another repositories;
 			 * output the SHA-1 verbatim.
@@ -134,6 +151,13 @@ static void show_filemodify(struct diff_queue_struct *q,
 				printf("M %06o :%d %s\n", spec->mode,
 				       get_object_mark(object), spec->path);
 			}
+			break;
+
+		default:
+			die("Unexpected comparison status '%c' for %s, %s",
+				q->queue[i]->status,
+				ospec->path ? ospec->path : "none",
+				spec->path ? spec->path : "none");
 		}
 	}
 }
diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index f18eec9..bb595b7 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -162,4 +162,50 @@ test_expect_success 'submodule fast-export | fast-import' '
 
 '
 
+export GIT_AUTHOR_NAME='A U Thor'
+export GIT_COMMITTER_NAME='C O Mitter'
+
+test_expect_success 'setup copies' '
+
+	git config --unset i18n.commitencoding &&
+	git checkout -b copy rein &&
+	git mv file file3 &&
+	git commit -m move1 &&
+	test_tick &&
+	cp file2 file4 &&
+	git add file4 &&
+	git mv file2 file5 &&
+	git commit -m copy1 &&
+	test_tick &&
+	cp file3 file6 &&
+	git add file6 &&
+	git commit -m copy2 &&
+	test_tick &&
+	echo more text >> file6 &&
+	echo even more text >> file6 &&
+	git add file6 &&
+	git commit -m modify &&
+	test_tick &&
+	cp file6 file7 &&
+	echo test >> file7 &&
+	git add file7 &&
+	git commit -m copy_modify
+
+'
+
+test_expect_success 'fast-export -C -C | fast-import' '
+
+	ENTRY=$(git rev-parse --verify copy) &&
+	rm -rf new &&
+	mkdir new &&
+	git --git-dir=new/.git init &&
+	git fast-export -C -C --signed-tags=strip --all > output &&
+	grep "^C \"file6\" \"file7\"\$" output &&
+	cat output |
+	(cd new &&
+	 git fast-import &&
+	 test $ENTRY = $(git rev-parse --verify refs/heads/copy))
+
+'
+
 test_done
-- 
1.5.6.3.18.gfe82
