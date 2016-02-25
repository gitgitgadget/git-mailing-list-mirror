From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 06/20] rename_tmp_log(): improve error reporting
Date: Thu, 25 Feb 2016 14:16:05 +0100
Message-ID: <c0614de75e2d6e23695f09cd8c043ef71bb49ddd.1456405699.git.mhagger@alum.mit.edu>
References: <cover.1456405698.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 14:16:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYvmg-0003gV-2E
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 14:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760339AbcBYNQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 08:16:42 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:65114 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759919AbcBYNQl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 08:16:41 -0500
X-AuditID: 12074413-eefff7000000516b-1b-56cefeb7b6d6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 5F.E0.20843.7BEFEC65; Thu, 25 Feb 2016 08:16:39 -0500 (EST)
Received: from michael.fritz.box (p548D63F1.dip0.t-ipconnect.de [84.141.99.241])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1PDGPrk024973
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 25 Feb 2016 08:16:38 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1456405698.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqLv937kwgxsvtSzmbzrBaNF1pZvJ
	oqH3CrPFh7WH2Cx6J/eyWtxeMZ/Z4kdLD7MDu8ff9x+YPJ5un8Ls8eJ8hcez3j2MHhcvKXss
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7ozzc/vZC1axV0xZcJ+xgfELaxcjJ4eEgInEtKc/
	WboYuTiEBLYySkw4958VwjnBJPHndBMTSBWbgK7Eop5mMFtEQE1iYtshsA5mgUeMEl37tzOC
	JIQFnCU6Hu9nA7FZBFQlLj2ewN7FyMHBKxAlcWhzAMQ2OYmWH7vBNnMKWEhcPDmdGcQWEjCX
	WHVjD/sERp4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3TN9XIzS/RSU0o3MUJCTHgH466T
	cocYBTgYlXh4I36fDRNiTSwrrsw9xCjJwaQkyrvn+bkwIb6k/JTKjMTijPii0pzU4kOMEhzM
	SiK8K/4C5XhTEiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKErybQBoFi1LT
	UyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQTEQXwyMApAUD9DeF2B7iwsSc4GiEK2nGHU5
	Fvy4vZZJiCUvPy9VSpx3OUiRAEhRRmke3ApYQnnFKA70sTCvGUgVDzAZwU16BbSECWjJzA1g
	S0oSEVJSDYycPRHsB+ecuq7Kkz+9Wy+GX9DtwYOJJmfaGP/d2pL3ydHp4QrZ79Vi59mPOkX+
	acg1VvlUwtrWxG5yY8XaZyJ3vkoclPv+NuvIc0bxHa/+b7KWPL5H4vDjHWHH1y5u 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287368>

* Don't capitalize error strings
* Report true paths of affected files

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2cb402d..ed29b3b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2430,10 +2430,11 @@ static int rename_tmp_log(const char *newrefname)
 	ret = raceproof_create_file(path, rename_tmp_log_callback, &true_errno);
 	if (ret) {
 		if (true_errno == EISDIR)
-			error("Directory not empty: %s", path);
+			error("directory not empty: %s", path);
 		else
-			error("unable to move logfile "TMP_RENAMED_LOG" to logs/%s: %s",
-				newrefname, strerror(true_errno));
+			error("unable to move logfile %s to %s: %s",
+			      git_path(TMP_RENAMED_LOG), path,
+			      strerror(true_errno));
 	}
 
 	free(path);
-- 
2.7.0
