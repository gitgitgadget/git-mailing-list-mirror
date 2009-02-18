From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] disallow providing multiple upstream branches to rebase, pull --rebase
Date: Tue, 17 Feb 2009 23:44:22 -0500
Message-ID: <1234932262-63469-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 05:45:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZeJq-0002Ap-84
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 05:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940AbZBREoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 23:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752902AbZBREoa
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 23:44:30 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:61651 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbZBREo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 23:44:29 -0500
Received: by qyk4 with SMTP id 4so4383094qyk.13
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 20:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=uGIVvE//j7RSAPet2gbfJinV0DQJmY5rRXuVBD4teUs=;
        b=YgqSOK/Gk8idZTUVEiiItsTtp1u7ZJEGVwBQn9SdU8qYH6ksQS+rt4aapGzUDf2DNS
         YnV2RjxViZyUIXtUxrpDKFD/7WxmZ6J3RWtPG+0+DPwViH+RcGiQLm8iiIXiDFvpGVDL
         wnCP1dQ2OK60YGWJAlT5puOZOHUmn6LIP84Lg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=n72zNTemx6dspj6ZU/+zd3s65wuxuau/HZffJwc1ZlVGdxTy/GhQZzRCtW/S+KWzq9
         ui1jcr6v1iqGUBmcm5LM+soQMJE624Dp8nCpzzufcKGrxPGTWvqUqD7Ep6Cmn8DFNJE7
         rEkouPieUQfDImNAMowelkSpD+bRNEC7SfT+M=
Received: by 10.224.28.138 with SMTP id m10mr5951133qac.81.1234932266301;
        Tue, 17 Feb 2009 20:44:26 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id 5sm1578656qwg.54.2009.02.17.20.44.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Feb 2009 20:44:25 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.218.g1b4fab
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110504>

It does not make sense to provide multiple upstream branches to either
git pull --rebase, or to git rebase, so disallow both.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 git-pull.sh   |    5 +++++
 git-rebase.sh |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 2c7f432..25adddf 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -171,6 +171,11 @@ case "$merge_head" in
 		echo >&2 "Cannot merge multiple branches into empty head"
 		exit 1
 	fi
+	if test true = "$rebase"
+	then
+		echo >&2 "Cannot rebase onto multiple branches"
+		exit 1
+	fi
 	;;
 esac
 
diff --git a/git-rebase.sh b/git-rebase.sh
index 5d9a393..ffb6027 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -319,6 +319,7 @@ do
 	esac
 	shift
 done
+test $# -gt 1 && usage
 
 # Make sure we do not have $GIT_DIR/rebase-apply
 if test -z "$do_merge"
-- 
1.6.2.rc1.210.g159a
