From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH] correct access right for git-svn-dcommit test
Date: Mon, 4 Aug 2008 19:30:24 +0400
Message-ID: <20080804153024.GV7008@dpotapov.dyndns.org>
References: <20080725060037.GB14756@untitled> <4889F215.9020804@kitware.com> <20080726054547.GA20494@untitled> <488B2FC5.4080801@kitware.com> <20080803220251.GB3006@untitled> <20080804141820.GT7008@dpotapov.dyndns.org> <20080804151424.GU7008@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Aug 04 17:31:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ22Q-0004Uh-3S
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 17:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834AbYHDPac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 11:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753245AbYHDPaa
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 11:30:30 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:5842 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbYHDPa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 11:30:29 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1016608fgg.17
        for <git@vger.kernel.org>; Mon, 04 Aug 2008 08:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=fKIXQycYDZEdwrJHivwevbATBnllV9cZBHDz+CfPCa8=;
        b=KdsFX9hnoJhDMSGCiiPiYe+LsdoYQqV90U2AE9IW8UEhiQfkxCgYmD9G+pwT5+lHf1
         FxjRlRzjr/OJoYmrgWV920imYnFN+jFGcCSlR6iMYbkvC0lTmN7WP2lHt7yX1TrGJ+Sn
         X8ilBpT+YSdyvOyFpOLLsj9LYOME5qCKuqjtk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=L9ULkgTJ1GEsHxSGmSrqvTvt+QT6dsZF4By4OoA+CfBzgR84DhL4tTiQbJb57mhCwF
         wNIXAv+y1jvG3auPJW28am5En5pLO4Y1RLWjYB7+NjirPfLuwK8MyAF1pnHpmrtIRj/n
         5YYGrLgmLL/PoryY7qRM2HtQy42Xlo6DCmZxY=
Received: by 10.86.94.11 with SMTP id r11mr10511054fgb.0.1217863827717;
        Mon, 04 Aug 2008 08:30:27 -0700 (PDT)
Received: from localhost ( [85.141.237.93])
        by mx.google.com with ESMTPS id l12sm50809fgb.6.2008.08.04.08.30.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Aug 2008 08:30:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080804151424.GU7008@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91373>

The tests requires anonymous write access. Therefore, "anon-access =
write" is added to conf/svnserve.conf. But because it was added to
the end of the file, it is impossible to guarantee in what section
it will be located. It turned out that on SVN 1.5, it was placed in
the wrong section and as result the test failed.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 t/t9113-git-svn-dcommit-new-file.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/t9113-git-svn-dcommit-new-file.sh b/t/t9113-git-svn-dcommit-new-file.sh
index 8da8ce5..ae78e33 100755
--- a/t/t9113-git-svn-dcommit-new-file.sh
+++ b/t/t9113-git-svn-dcommit-new-file.sh
@@ -28,6 +28,7 @@ start_svnserve () {
 
 test_expect_success 'start tracking an empty repo' '
 	svn mkdir -m "empty dir" "$svnrepo"/empty-dir &&
+	echo "[general]" > "$rawsvnrepo"/conf/svnserve.conf &&
 	echo anon-access = write >> "$rawsvnrepo"/conf/svnserve.conf &&
 	start_svnserve &&
 	git svn init svn://127.0.0.1:$SVNSERVE_PORT &&
-- 
1.6.0.rc1.74.g1e94
