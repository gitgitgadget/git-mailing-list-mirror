From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 1/9] svn-fe: use svnrdump --quiet in remote-svn-alpha
Date: Wed, 13 Jul 2011 21:26:45 +0600
Message-ID: <1310570813-16648-2-git-send-email-divanorama@gmail.com>
References: <1310570813-16648-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 17:26:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh1Ke-0002R6-KS
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 17:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755432Ab1GMP0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 11:26:31 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56795 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401Ab1GMP03 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 11:26:29 -0400
Received: by eyx24 with SMTP id 24so2112143eyx.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 08:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=HWCgqUmXQkL2U7TYGv1GYFs7NkcFF+r5UyRYQY8aSyg=;
        b=TbUd9MmctfxZLTqavME+5nvA1GDVVuazjSd5y4aXu8E0GA2EPrViTiJRfKfVtXysPm
         UN4PCCQwGygQXGAtV7fdLXaE8RSCretBGTdxmf/4iRqTu71FavVcVjgc2F4wugX62Uae
         LzoA5KQa5ysxO6K9f925ULDBWhrMWB5NFX+ug=
Received: by 10.213.17.134 with SMTP id s6mr438707eba.105.1310570788778;
        Wed, 13 Jul 2011 08:26:28 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id w28sm1969391eea.15.2011.07.13.08.26.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 08:26:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1310570813-16648-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177043>

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
