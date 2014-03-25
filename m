From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 087/144] t7003-filter-branch.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:32 -0700
Message-ID: <1395735989-3396-88-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:30:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMkI-00021y-Se
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:30:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380AbaCYIaB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:30:01 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:60213 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933AbaCYI2M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:12 -0400
Received: by mail-pb0-f50.google.com with SMTP id md12so133055pbc.23
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CIKjeZHXzOhVPhozpncSgDScLNwueDpE/0N9X8DvnoM=;
        b=hRlHXvzhuESa9bHYvAISLeA47dhBHv+EAZjycirHQ4mW99JOhBM5xY0q4cc1S8Rud9
         Q3SfRVSR/NQ8d18t+L8c6sVReHeySHTdOjrO6J/Cnkbb9QWLstAS13uNEt3cvnZEj3N9
         jye6v+EbDwGS8E8UlGRoUR04rkl9S/giXW5FxCtYMo4piBNoVxeKafoPLqmQgZDenb0P
         tw9irbEUqvFKAtAsBksekF2Ux6LL4WvI5Ffm50C3cW/QLgwv2PIxtA/uDcY3mQCNm2X9
         a0EdXNzs+C7j5ibiOkDa9W8jtd87yiEK0mfsrUs9WUr6HLTk/z6qfuf1UENJfJNjECI8
         OTaA==
X-Received: by 10.66.66.66 with SMTP id d2mr77290884pat.80.1395736092193;
        Tue, 25 Mar 2014 01:28:12 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.11
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244953>

The Git CodingGuidelines prefer the $( ... ) construct for command
substitution instead of using the back-quotes, or grave accents (`..`).

The backquoted form is the historical method for command substitution,
and is supported by POSIX. However,all but the simplest uses become
complicated quickly. In particular,embedded command substitutions
and/or the use of double quotes require careful escaping with the backs=
lash
character. Because of this the POSIX shell adopted the $(=E2=80=A6) fea=
ture from
the Korn shell.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t7003-filter-branch.sh |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 9496736..87459a5 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -362,7 +362,7 @@ test_expect_success 'setup submodule' '
 	git branch original HEAD
 '
=20
-orig_head=3D`git show-ref --hash --head HEAD`
+orig_head=3D$(git show-ref --hash --head HEAD)
=20
 test_expect_success 'rewrite submodule with another content' '
 	git filter-branch --tree-filter "test -d submod && {
@@ -371,7 +371,7 @@ test_expect_success 'rewrite submodule with another=
 content' '
 					 mkdir submod &&
 					 : > submod/file
 					 } || :" HEAD &&
-	test $orig_head !=3D `git show-ref --hash --head HEAD`
+	test $orig_head !=3D $(git show-ref --hash --head HEAD)
 '
=20
 test_expect_success 'replace submodule revision' '
@@ -380,7 +380,7 @@ test_expect_success 'replace submodule revision' '
 	    "if git ls-files --error-unmatch -- submod > /dev/null 2>&1
 	     then git update-index --cacheinfo 160000 01234567890123456789012=
34567890123456789 submod
 	     fi" HEAD &&
-	test $orig_head !=3D `git show-ref --hash --head HEAD`
+	test $orig_head !=3D $(git show-ref --hash --head HEAD)
 '
=20
 test_done
--=20
1.7.10.4
