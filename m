From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v6 32/32] tests: add ref-storage argument
Date: Mon, 29 Feb 2016 23:52:53 +0100
Message-ID: <1456786373-6644-1-git-send-email-szeder@ira.uka.de>
References: <1456354744-8022-33-git-send-email-dturner@twopensource.com>
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 23:54:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaWhw-00035j-AU
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 23:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbcB2WyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 17:54:24 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:53483 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750729AbcB2WyY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Feb 2016 17:54:24 -0500
Received: from x590c46ff.dyn.telefonica.de ([89.12.70.255] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aaWho-0000aX-85; Mon, 29 Feb 2016 23:54:21 +0100
X-Mailer: git-send-email 2.7.2.410.g92cb358
In-Reply-To: <1456354744-8022-33-git-send-email-dturner@twopensource.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1456786461.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287924>

Hi,

> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 2ba62fb..d5751e2 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -126,7 +126,7 @@ actual="$TRASH_DIRECTORY/actual"
>  
>  test_expect_success 'setup for __gitdir tests' '
>  	mkdir -p subdir/subsubdir &&
> -	git init otherrepo
> +	git init $ref_storage_arg otherrepo
>  '
>  
>  test_expect_success '__gitdir - from command line (through $__git_dir)' '
> @@ -177,6 +177,7 @@ test_expect_success '__gitdir - cwd is a .git directory' '
>  test_expect_success '__gitdir - parent is a .git directory' '
>  	echo "$(pwd -P)/.git" >expected &&
>  	(
> +		mkdir -p .git/refs/heads &&
>  		cd .git/refs/heads &&
>  		__gitdir >"$actual"
>  	) &&
> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> index ffbfa0e..caa706c 100755
> --- a/t/t9903-bash-prompt.sh
> +++ b/t/t9903-bash-prompt.sh
> @@ -148,6 +148,7 @@ test_expect_success 'prompt - inside .git directory' '
>  test_expect_success 'prompt - deep inside .git directory' '
>  	printf " (GIT_DIR!)" >expected &&
>  	(
> +		mkdir -p .git/refs/heads &&
>  		cd .git/refs/heads &&
>  		__git_ps1 >"$actual"
>  	) &&

As far as these tests are concerned any subdirectory under .git/ would
do, it doesn't have to be .git/refs/heads.  How about cd-ing into a
different directory instead of creating the missing ones?

 ----  >8  ----
Subject: [PATCH] fixup! tests: add ref-storage argument

---
 t/t9902-completion.sh  | 3 +--
 t/t9903-bash-prompt.sh | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index d5751e25eb50..605816a9b996 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -177,8 +177,7 @@ test_expect_success '__gitdir - cwd is a .git directory' '
 test_expect_success '__gitdir - parent is a .git directory' '
 	echo "$(pwd -P)/.git" >expected &&
 	(
-		mkdir -p .git/refs/heads &&
-		cd .git/refs/heads &&
+		cd .git/objects &&
 		__gitdir >"$actual"
 	) &&
 	test_cmp expected "$actual"
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 683b4705167f..6068ccb92eb9 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -148,8 +148,7 @@ test_expect_success 'prompt - inside .git directory' '
 test_expect_success 'prompt - deep inside .git directory' '
 	printf " (GIT_DIR!)" >expected &&
 	(
-		mkdir -p .git/refs/heads &&
-		cd .git/refs/heads &&
+		cd .git/objects &&
 		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
-- 
2.7.2.410.g92cb358
