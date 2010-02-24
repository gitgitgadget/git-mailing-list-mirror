From: Tuomas Suutari <tuomas.suutari@gmail.com>
Subject: [PATCH 2/2] t9150,t9151: Add rewrite-root option to init
Date: Wed, 24 Feb 2010 20:09:02 +0200
Message-ID: <1267034942-31581-2-git-send-email-tuomas.suutari@gmail.com>
References: <1267034942-31581-1-git-send-email-tuomas.suutari@gmail.com>
Cc: Tuomas Suutari <tuomas.suutari@gmail.com>,
	Sam Vilain <sam@vilain.net>, Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 19:09:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkLg6-0005FY-S4
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 19:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755227Ab0BXSJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 13:09:35 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:62040 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754794Ab0BXSJd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 13:09:33 -0500
Received: by fxm19 with SMTP id 19so5362917fxm.21
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 10:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=UrRFMEiLV79DOFEtJ3YsQb0aKqHxMjjdzPgJfiwCNBY=;
        b=snhBP7AduJbtgCdJ0mt7tCYMx1m008fCRFpYm0B9ZIX+thWdL3gl3rVNNaT80/d2Xk
         NWwkWpcitNTs5UbaZH/x/3Nt1BhYFVaTMcvMXb7XYTJM5YRIm0r7XA16SkbQcazcEJ18
         JfjGSLPb8fYlH89/0IlIcDRnTWiVA7m4lyFTE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tzoJTaW7CwVFBsPUfHe6Bh4StdJM0WIpr00VLoDhPwqfSYKB8NaFJGiO6EKHi4u5F1
         cSMmSPJYuIZY3bDD8wWy6o7MII9KeDK8T/u4utTT4QA6L2Bv3r2AeTev/Ge3sXNgcfPL
         DYbXS2+bwHmqxvK5GkhNUrlejJoHcg5p6So8c=
Received: by 10.87.47.3 with SMTP id z3mr504280fgj.70.1267034971665;
        Wed, 24 Feb 2010 10:09:31 -0800 (PST)
Received: from localhost.localdomain (ws-26-184.laitilanpuhelin.fi [188.123.26.184])
        by mx.google.com with ESMTPS id l19sm11598420fgb.0.2010.02.24.10.09.30
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 10:09:30 -0800 (PST)
X-Mailer: git-send-email 1.7.0.2.ged48
In-Reply-To: <1267034942-31581-1-git-send-email-tuomas.suutari@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140965>

The rewrite-root option seems to be a bit problematic with merge
detecting, so it's better to have a merge detecting test with it
turned on.

Signed-off-by: Tuomas Suutari <tuomas.suutari@gmail.com>
---

This is mainly for supporting the first patch. Try applying this
before the first patch to see the problem it addresses.

After this is applied, then there are no merge detecting tests without
rewrite-root. Could this be a problem?

 t/t9150-svk-mergetickets.sh |    1 +
 t/t9151-svn-mergeinfo.sh    |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/t/t9150-svk-mergetickets.sh b/t/t9150-svk-mergetickets.sh
index 5358142..24c2421 100755
--- a/t/t9150-svk-mergetickets.sh
+++ b/t/t9150-svk-mergetickets.sh
@@ -11,6 +11,7 @@ test_expect_success 'load svk depot' "
 	svnadmin load -q '$rawsvnrepo' \
 	  < '$TEST_DIRECTORY/t9150/svk-merge.dump' &&
 	git svn init --minimize-url -R svkmerge \
+	  --rewrite-root=http://svn.example.org \
 	  -T trunk -b branches '$svnrepo' &&
 	git svn fetch --all
 	"
diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
index 3569c62..c415775 100755
--- a/t/t9151-svn-mergeinfo.sh
+++ b/t/t9151-svn-mergeinfo.sh
@@ -11,6 +11,7 @@ test_expect_success 'load svn dump' "
 	svnadmin load -q '$rawsvnrepo' \
 	  < '$TEST_DIRECTORY/t9151/svn-mergeinfo.dump' &&
 	git svn init --minimize-url -R svnmerge \
+	  --rewrite-root=http://svn.example.org \
 	  -T trunk -b branches '$svnrepo' &&
 	git svn fetch --all
 	"
-- 
1.7.0.2.ged48
