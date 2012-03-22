From: Dominique Quatravaux <domq@google.com>
Subject: [PATCH] Locate git helpers with type -P, for when git --exec-path is multivalued
Date: Thu, 22 Mar 2012 10:06:59 +0100
Message-ID: <1332407219-7774-1-git-send-email-domq@google.com>
Cc: Dominique Quatravaux <domq@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 22 10:30:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAeM6-0006ix-Nw
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 10:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786Ab2CVJao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 05:30:44 -0400
Received: from mail-lb0-f202.google.com ([209.85.217.202]:64627 "EHLO
	mail-lb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756607Ab2CVJak (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 05:30:40 -0400
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Mar 2012 05:30:40 EDT
Received: by lbbgj3 with SMTP id gj3so102474lbb.1
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 02:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=JkEBDyvj/s0ecz098tG9RwBiul9lsI7hBYDLEM998X8=;
        b=k1lO9iPjoeSPTnpDRlIyaJSzCyxPQVOfxdumcKIQ/CIHROr0FNk6hcg6eLdduuI1Pj
         nPeCB0GoiQPTDbQaaJ+43hjuAvq2zvfVmRhCIP1c/K5W4lLbCLO9WG/qhkOyZx7rVHSV
         CG74JbUZJc4ykXgvyby/KcDdJrERTJbnKT9FIgmBB8LD9W6JCeTijKB+Fc+8vYz9yQNl
         a18uWyr0OeU4uNWyXK1e+wTQYZZg4BniQDiXXS0lZm2MVtg6Gh3jUpOF5fyWHRHeGmAj
         zJtZU8871lCGl0lJ7Cz69nV+aqm/efbul80dPC+SE5AD2GyvyKP5AMUMXAdqm0E0xk68
         EGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=JkEBDyvj/s0ecz098tG9RwBiul9lsI7hBYDLEM998X8=;
        b=WYvtdOFXTrWYotZFiX0ztRbrQVirZbisbS3LMth2HW+gUFvJnmvRmEgA8wYk0CWlfq
         Xf99wPMMVee0ra/YCe0dGaXbogqSnFdJZkHs0lsNQiYam8VVR++KzBYpxyEuSzN29O38
         WY09xpvtZ68J1/xuJJ+fHZNQK91UX0rZr4mIf1DvhWF8FT4J9GDHqjuAtSMMo8I18GLo
         1PK2/rReYzGxXCYcoLQP/1V6vjW/tWxUQt1g4gAJuEH5NsqaKg3NmC0fFpjlqc91WZLP
         gFs8dljso8WIUcp8SG3B5jBmyy/a9QNLk/7ZUzTkMLKIrtrevV/loSCfqvyjd6AjOjGB
         xb4A==
Received: by 10.213.21.203 with SMTP id k11mr583186ebb.24.1332407244320;
        Thu, 22 Mar 2012 02:07:24 -0700 (PDT)
Received: by 10.213.21.203 with SMTP id k11mr583179ebb.24.1332407244203;
        Thu, 22 Mar 2012 02:07:24 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id a14si3057544een.0.2012.03.22.02.07.24
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 22 Mar 2012 02:07:24 -0700 (PDT)
Received: from alliance-maui.zrh.corp.google.com (alliance-maui.zrh.corp.google.com [172.28.204.12])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 294A220004E;
	Thu, 22 Mar 2012 02:07:24 -0700 (PDT)
Received: by alliance-maui.zrh.corp.google.com (Postfix, from userid 71297)
	id DD5B560315; Thu, 22 Mar 2012 10:07:23 +0100 (CET)
X-Mailer: git-send-email 1.7.7.3
X-Gm-Message-State: ALoCoQmKYcejNStZ6LFAKqv4pqQrcBh0em2I06yyhSFFRodgKzpK1aCNjITQv5ZJu2NW3rnxb/kgIBuElzl81e/O3R7icm33TqKzj2j7mvWRQH+tP8JaKHRZ2fCBjxe31mRr/ojxBILjyzdr9BVJlPZFU4isADtT+nxedw81WwUFNx6ntzrp0aA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193637>

Under a setting of (eg) GIT_EXEC_PATH=/home/joe/bin:/usr/lib/git-core,
constructs such as

  . "$(git --exec-path)"/git-sh-setup

do not work. The proper way is

  . "$(PATH="$(git --exec-path)" type -p git-sh-setup)"
---
 Documentation/git-mergetool--lib.txt |    3 ++-
 Documentation/git-parse-remote.txt   |    2 +-
 Documentation/git-sh-i18n.txt        |    2 +-
 Documentation/git-sh-setup.txt       |    2 +-
 contrib/diffall/git-diffall          |    4 ++--
 git-mergetool--lib.sh                |    2 +-
 6 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-mergetool--lib.txt b/Documentation/git-mergetool--lib.txt
index f98a41b..c7188d3 100644
--- a/Documentation/git-mergetool--lib.txt
+++ b/Documentation/git-mergetool--lib.txt
@@ -8,7 +8,8 @@ git-mergetool--lib - Common git merge tool shell scriptlets
 SYNOPSIS
 --------
 [verse]
-'TOOL_MODE=(diff|merge) . "$(git --exec-path)/git-mergetool{litdd}lib"'
+'TOOL_MODE=(diff|merge) \
+  . "$(PATH="$(git --exec-path)" type -P git-mergetool{litdd}lib)"'
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-parse-remote.txt b/Documentation/git-parse-remote.txt
index a45ea1e..c17d7b8 100644
--- a/Documentation/git-parse-remote.txt
+++ b/Documentation/git-parse-remote.txt
@@ -9,7 +9,7 @@ git-parse-remote - Routines to help parsing remote repository access parameters
 SYNOPSIS
 --------
 [verse]
-'. "$(git --exec-path)/git-parse-remote"'
+'. "$(PATH="$(git --exec-path)" type -P git-parse-remote)"'
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-sh-i18n.txt b/Documentation/git-sh-i18n.txt
index 60cf49c..f74820c 100644
--- a/Documentation/git-sh-i18n.txt
+++ b/Documentation/git-sh-i18n.txt
@@ -8,7 +8,7 @@ git-sh-i18n - Git's i18n setup code for shell scripts
 SYNOPSIS
 --------
 [verse]
-'. "$(git --exec-path)/git-sh-i18n"'
+'. "$(PATH="$(git --exec-path)" type -P git-sh-i18n)"'
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
index 5e5f1c8..44c6aa9 100644
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -8,7 +8,7 @@ git-sh-setup - Common git shell script setup code
 SYNOPSIS
 --------
 [verse]
-'. "$(git --exec-path)/git-sh-setup"'
+'. "$(PATH="$(git --exec-path)" type -P git-sh-setup)"'
 
 DESCRIPTION
 -----------
diff --git a/contrib/diffall/git-diffall b/contrib/diffall/git-diffall
index 84f2b65..451ca98 100755
--- a/contrib/diffall/git-diffall
+++ b/contrib/diffall/git-diffall
@@ -22,10 +22,10 @@ USAGE='[--cached] [--copy-back] [-x|--extcmd=<command>] <commit>{0,2} [-- <path>
 '
 
 SUBDIRECTORY_OK=1
-. "$(git --exec-path)/git-sh-setup"
+PATH="$(PATH="$(git --exec-path)" type -P git-sh-setup)"
 
 TOOL_MODE=diff
-. "$(git --exec-path)/git-mergetool--lib"
+. "$(PATH="$(git --exec-path)" type -P git-mergetool--lib)"
 
 merge_tool="$(get_merge_tool)"
 if test -z "$merge_tool"
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index ed630b2..73d8510 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -52,7 +52,7 @@ setup_tool () {
 		tool="$1"
 		;;
 	esac
-	mergetools="$(git --exec-path)/mergetools"
+	mergetools="$(PATH="$(git --exec-path)" type -P mergetools)"
 
 	# Load the default definitions
 	. "$mergetools/defaults"
-- 
1.7.7.3
