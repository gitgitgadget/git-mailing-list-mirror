From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 1/2] pull: pass --strategy along to to rebase
Date: Fri, 22 Feb 2008 19:52:29 -0500
Message-ID: <1203727950-14980-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 23 01:53:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSie6-0005OG-66
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 01:53:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936948AbYBWAwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 19:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937614AbYBWAwn
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 19:52:43 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:34573 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937379AbYBWAwh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 19:52:37 -0500
Received: by an-out-0708.google.com with SMTP id d31so163539and.103
        for <git@vger.kernel.org>; Fri, 22 Feb 2008 16:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=WzWf9OLO6EnnrxmZ4sjAtyBZCRRqSp82vUSGM/uG8G0=;
        b=GKUcXFOwkA8Nayzgyz9B6mqr4073+LUwE4qaGDNWlIeQNTe/tRDnJ6pX6EMbtYx5jp5AFMSxkS30iswIAOfp12EQh1y789QhTH3hv9+UHYZOdZyZN6a6W7MaaC0NWHjFP7d1sbzVUdxTMJBaGwaPQieFAH+DOFrIZfsPpGh21Hk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=W8q6y3MAnB+avL+VDyq+9Pfc1o9M5HA6QmQ0KYxIeg9f767ncc5SHhDbJm7OlSOTzqomgltaZj8LYDKh3rIkeHPZB4I0m1xptz0+G9rWuu+y//WbTxE2SAs61HnGMkD41HiMkaI3NDpD1RnkBCVGZOlPCO7AkMfV/cU/DGpYi/4=
Received: by 10.100.151.5 with SMTP id y5mr1371865and.113.1203727954036;
        Fri, 22 Feb 2008 16:52:34 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id b29sm3541258ana.19.2008.02.22.16.52.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Feb 2008 16:52:33 -0800 (PST)
X-Mailer: git-send-email 1.5.4.2.285.g1e9f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74773>

rebase supports --strategy, so pull should pass the option along to it.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
I noticed the other day that pull didn't pass --strategy along to rebase, but
forgot I'd noticed, even though Johannes replied w/a patch. Anyway, my next
patch documents pull's usage via its OPTIONS_SPEC and I noticed the problem
again. I fix it here so that I can document its use in the next patch. :-)

 git-pull.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 46da0f4..3ce32b5 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -174,6 +174,7 @@ fi
 
 merge_name=$(git fmt-merge-msg <"$GIT_DIR/FETCH_HEAD") || exit
 test true = "$rebase" &&
-	exec git-rebase --onto $merge_head ${oldremoteref:-$merge_head}
+	exec git-rebase $strategy_args --onto $merge_head \
+	${oldremoteref:-$merge_head}
 exec git-merge $no_summary $no_commit $squash $no_ff $strategy_args \
 	"$merge_name" HEAD $merge_head
-- 
1.5.4.2.285.g1e9f
