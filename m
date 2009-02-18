From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v2] disallow providing multiple upstream branches to rebase, pull --rebase
Date: Wed, 18 Feb 2009 08:44:02 -0500
Message-ID: <1234964642-95381-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 14:45:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZmkI-0000tj-Bo
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 14:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbZBRNoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 08:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752652AbZBRNoI
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 08:44:08 -0500
Received: from an-out-0708.google.com ([209.85.132.247]:25655 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539AbZBRNoH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 08:44:07 -0500
Received: by an-out-0708.google.com with SMTP id c2so1352139anc.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 05:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=ymkiNYEUZuKuao4IgvMmqzjqsTCumNaro2WxUKepzlU=;
        b=UH2posQZ4x+Pl5gi7mhj7G93i2LHyKVV5KU3GEbymUiagoeQ50YMUzOABmFoPrlvqq
         tofC2QWuNuZutDqcwCdAjBqzK09hVIPHHfLhBI8YeZQqIE4cY7rToBK947+1uzRflY4i
         h3yVnLuF1NMuuRYyP4VqBL6LJHnGEOuTRsG54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=WFxU2oVcsd5kPKDf9LtLiV+WmxiLfE1QN1MLvdfszi8boFbaQzYhk/qm33DCMXjufG
         2rZrFhpZYwR3KlWoCHktejqGbwVecc0s/DPu9rEGRcD42ztzoUPusqzv/mO8Rzebigvj
         KvDRfAglTOndrocNt8Y0MBtHAIQsdsH8W0tBQ=
Received: by 10.64.195.20 with SMTP id s20mr4573220qbf.72.1234964645552;
        Wed, 18 Feb 2009 05:44:05 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id p9sm14960566qbp.24.2009.02.18.05.44.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Feb 2009 05:44:05 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.218.g1b4fab
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110543>

It does not make sense to provide multiple upstream branches to either
git pull --rebase, or to git rebase, so disallow both.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
This time w/o breaking git rebase $UPSTREAM $BRANCH_TO_SWITCH_TO

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
index 5d9a393..c2a9b1f 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -319,6 +319,7 @@ do
 	esac
 	shift
 done
+test $# -gt 2 && usage
 
 # Make sure we do not have $GIT_DIR/rebase-apply
 if test -z "$do_merge"
-- 
1.6.2.rc1.218.g1b4fab
