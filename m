From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 005/144] git-rebase.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:10 -0700
Message-ID: <1395735989-3396-6-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:38:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMsr-00048n-Ff
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165AbaCYIiW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:38:22 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:58210 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626AbaCYI0l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:26:41 -0400
Received: by mail-pb0-f50.google.com with SMTP id md12so131628pbc.23
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vxaG8YXK6XqCHMcDvpITAbt3bjbMgwfCYMuYEyhnhPE=;
        b=znidtRWLN7T7o6uUsa3T3e8+CvarQD9uUepA66VnUBl4ovMS1D1ZpncZLnWUdkqH2V
         r5T5mlk07ek/yvvfrOrGnDz/7Inahgff6xuVLK4O5ku0Pe4yAihlC2Mq0cFvtUM+Sp4W
         2If8fObI5dtXXHtoYgiJs1Aq2xTpMAi3TTas96PemVs53u1I9IJE/QL01BNqMt/WhGHf
         8QkoCZf4k1drd6L2evZZNt5T/SY7ftMsmSPaXPZ0kKJrqW2px/d42Ff6xN80jp5RLXhw
         xAKh7NZvulrO9+7/V8QtLiCRNoYonTSgdTtTvQ3vJWk1BZ6UCWoCxrpuMIfkcFaBBp5O
         7RWA==
X-Received: by 10.66.141.144 with SMTP id ro16mr14207420pab.131.1395736001091;
        Tue, 25 Mar 2014 01:26:41 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.26.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:26:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245014>

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
 git-rebase.sh |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 5f6732b..a209ab9 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -462,8 +462,8 @@ then
 else
 	if test -z "$onto"
 	then
-		empty_tree=3D`git hash-object -t tree /dev/null`
-		onto=3D`git commit-tree $empty_tree </dev/null`
+		empty_tree=3D$(git hash-object -t tree /dev/null)
+		onto=3D$(git commit-tree $empty_tree </dev/null)
 		squash_onto=3D"$onto"
 	fi
 	unset upstream_name
@@ -521,10 +521,10 @@ case "$#" in
 	;;
 0)
 	# Do not need to switch branches, we are already on it.
-	if branch_name=3D`git symbolic-ref -q HEAD`
+	if branch_name=3D$(git symbolic-ref -q HEAD)
 	then
 		head_name=3D$branch_name
-		branch_name=3D`expr "z$branch_name" : 'zrefs/heads/\(.*\)'`
+		branch_name=3D$(expr "z$branch_name" : 'zrefs/heads/\(.*\)')
 	else
 		head_name=3D"detached HEAD"
 		branch_name=3DHEAD ;# detached
--=20
1.7.10.4
