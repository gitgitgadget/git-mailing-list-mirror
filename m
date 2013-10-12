From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 3/7] pull: add --merge option
Date: Sat, 12 Oct 2013 02:01:57 -0500
Message-ID: <1381561322-20059-3-git-send-email-felipe.contreras@gmail.com>
References: <1381561322-20059-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:08:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtJD-0002E2-BS
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778Ab3JLHIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:08:11 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:47956 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab3JLHIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:08:09 -0400
Received: by mail-oa0-f47.google.com with SMTP id i1so3071427oag.6
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SUn0zrWa5QvwFp16RGtvJWhstwWUnEZh7vmH+egDmLU=;
        b=ZkkjrmKbuD5S69VsYFFuEqO9l3+VKwGnaTeCkGXTiP8ZUmSfW58uZ7McQpGs9HeEUX
         eRVeV0uc1IypwmOUy7RBoX8ioitKw/NvsUAVc8blUeFKG0t8fONJh4SpbLoItiSVOpo3
         57zrMtp5B41QZ+VRYl1xGVH40JrmPhWv1s6HI+JhL9MmgAHMNRlwJhqsoDRr3KyzyW0w
         8qSn4FU3+E4p3F+39vejNtAw+yBKEQZDoKMsmt9w4bHCImRji+gyYaY1iGsbM3onQxnu
         RtMH0hXgriIyloWlMducdPxXXJpbjLmi0n26ZmMdhzMu0Tbe+ENXUp+h9t4c/7z5D29c
         JdgQ==
X-Received: by 10.60.116.230 with SMTP id jz6mr18125554oeb.21.1381561689235;
        Sat, 12 Oct 2013 00:08:09 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hs4sm28623109obb.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:08:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561322-20059-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235950>

Also, deprecate --no-rebase since there's no need for it any more.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-pull.txt | 8 ++++++--
 git-pull.sh                | 6 +++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 991352f..e09f004 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -119,8 +119,12 @@ It rewrites history, which does not bode well when you
 published that history already.  Do *not* use this option
 unless you have read linkgit:git-rebase[1] carefully.
 
---no-rebase::
-	Override earlier --rebase.
+-m::
+--merge::
+	Force a merge.
++
+See `pull.mode`, `branch.<name>.pullmode` in linkgit:git-config[1] if you want
+to make `git pull` always use `--merge`.
 
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/git-pull.sh b/git-pull.sh
index f53d193..fbb8a9b 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -127,8 +127,12 @@ do
 	-r|--r|--re|--reb|--reba|--rebas|--rebase)
 		mode=rebase
 		;;
+	-m|--m|--me|--mer|--merg|--merge)
+		mode=merge
+		;;
 	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
-		mode=
+		mode=merge
+		echo "--no-rebase is deprecated, please use --merge instead"
 		;;
 	--recurse-submodules)
 		recurse_submodules=--recurse-submodules
-- 
1.8.4-fc
