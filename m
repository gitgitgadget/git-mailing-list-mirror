From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 1/5] svn-fe: use svnrdump --quiet in remote-svn-alpha
Date: Tue,  5 Jul 2011 22:45:46 +0600
Message-ID: <1309884350-13415-2-git-send-email-divanorama@gmail.com>
References: <1309884350-13415-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 18:44:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qe8jv-0002em-Q9
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jul 2011 18:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756316Ab1GEQoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jul 2011 12:44:37 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48448 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756093Ab1GEQof (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2011 12:44:35 -0400
Received: by bwd5 with SMTP id 5so4899837bwd.19
        for <git@vger.kernel.org>; Tue, 05 Jul 2011 09:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=HWCgqUmXQkL2U7TYGv1GYFs7NkcFF+r5UyRYQY8aSyg=;
        b=t6MBYlsMANL+AuYOuUFTo0O7CIlVasP/824TI6MZOe9q8zt6DJ/ZMc0DhusyT2HeY1
         j0kF3MKadpwTkMefzpzb5ImYm/atYBq7Vl7lD0EWJc5BP8+s9C34fzQCJ2azZfAZmG7I
         RDEB2iz9vpFVqB2Bn3zpPCfhfGU6pM5jSx19Q=
Received: by 10.204.154.215 with SMTP id p23mr7334482bkw.113.1309884274518;
        Tue, 05 Jul 2011 09:44:34 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id l24sm6696272bkw.15.2011.07.05.09.44.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Jul 2011 09:44:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1309884350-13415-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176613>

svnrdump by default shows "Dumped revision #n" lines on stderr.
svn-fe does it too on each imported revision, so pass --quiet to
svnrdump. Once process indication is really needed it will be
custom formatted in either svn-fe or remote-svn-alpha.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 contrib/svn-fe/git-remote-svn-alpha |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/svn-fe/git-remote-svn-alpha b/contrib/svn-fe/git-remote-svn-alpha
index b2cca9f..61c9b07 100755
--- a/contrib/svn-fe/git-remote-svn-alpha
+++ b/contrib/svn-fe/git-remote-svn-alpha
@@ -15,7 +15,7 @@ usage () {
 do_import () {
 	revs=$1 url=$2
 	(svnrdump dump --non-interactive --username=Guest --password= \
-		-r"$revs" "$url" | svn-fe) 3<&0 || die "FAILURE"
+		-r"$revs" "$url" --quiet | svn-fe) 3<&0 || die "FAILURE"
 	exec 1>&-
 }
 
-- 
1.7.3.4
