From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH v2] Support copy and rename detection in fast-export.
Date: Sat, 26 Jul 2008 22:49:16 +0400
Organization: TEPKOM
Message-ID: <200807262249.18005.angavrilov@gmail.com>
References: <200807211216.01694.angavrilov@gmail.com> <alpine.DEB.1.00.0807211207470.3305@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 26 20:50:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMoqf-0005h0-60
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 20:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbYGZStd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 14:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbYGZStc
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 14:49:32 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:57490 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbYGZStb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 14:49:31 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1853284fgg.17
        for <git@vger.kernel.org>; Sat, 26 Jul 2008 11:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Z3aN3QuKS1Co9v8Rexp3n0wsI/UX1Gm7YB1kzTSc/Uw=;
        b=qYahdWUtJR9U2PnHhScUkx8WpnzNC5/bTJlkK/wDBZlqyYrjbU4XTS7k+F7wE1G8RV
         HIuJ6c8OloeGJ9T2vNPmFIfCjzqmyBZxH3yeZUviREvuSIiUeualBueCJsL/Ev+erGl1
         TUUmwjQQEMG4TG3NscDsiULIsE/ZjAjbwYKPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Oiq7pSzxbM3KvZxD03FVlEPN4dGNEwja5ipabojlJL4xZMXVFNY1mXBpYLUO2PpuAx
         0zvV+/S3W428YPM/ryJW94/2bPVaWQFqrgehGKDamo/TTPSQPEYEqIburKpz1ejEy/x1
         qef8oZcCCv4iCQE77YE9ca77XB/2mPpo34fTo=
Received: by 10.86.95.20 with SMTP id s20mr1070045fgb.65.1217098170306;
        Sat, 26 Jul 2008 11:49:30 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id e20sm6997763fga.1.2008.07.26.11.49.29
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 26 Jul 2008 11:49:29 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0807211207470.3305@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90272>

Although it does not matter for Git itself, tools that
export to systems that explicitly track copies and
renames can benefit from such information.

This patch makes fast-export output correct action
logs when -M or -C are enabled.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

	Added a note to the fast-export documentation. When this patch
	is merged, it probably should be updated with the exact version.

	-- Alexander 

 Documentation/git-fast-export.txt |    9 +++++++
 builtin-fast-export.c             |   28 +++++++++++++++++++++-
 t/t9301-fast-export.sh            |   46 +++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 332346c..699b69e 100644
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
+Note that these options are always accepted by git-fast-import,
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
