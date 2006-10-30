X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Bash snippet to show branch and patch in bash prompt
Date: Mon, 30 Oct 2006 11:59:27 +0100
Message-ID: <20061030105926.14328.55180.stgit@lathund.dewire.com>
References: <4545CC6F.90001@tromer.org>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Mon, 30 Oct 2006 10:58:26 +0000 (UTC)
Cc: Eran Tromer <git2eran@tromer.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Virus-Scanned: amavisd-new at localhost.localdomain
In-Reply-To: <4545CC6F.90001@tromer.org>
User-Agent: StGIT/0.10
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30498>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeUqS-0002oH-84 for gcvg-git@gmane.org; Mon, 30 Oct
 2006 11:58:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161243AbWJ3K6R (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 05:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161246AbWJ3K6R
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 05:58:17 -0500
Received: from [83.140.172.130] ([83.140.172.130]:42798 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S1161243AbWJ3K6Q (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 05:58:16 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id 136118030A5; Mon, 30 Oct 2006 11:54:59 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 29639-10; Mon, 30 Oct
 2006 11:54:58 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.5]) by torino.dewire.com
 (Postfix) with ESMTP id A96E28030A1; Mon, 30 Oct 2006 11:54:58 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1]) by
 lathund.dewire.com (Postfix) with ESMTP id 3712F28E71; Mon, 30 Oct 2006
 11:59:31 +0100 (CET)
Received: from lathund.dewire.com ([127.0.0.1]) by localhost
 (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025) with LMTP id
 ViV+E++5QWQx; Mon, 30 Oct 2006 11:59:27 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1]) by
 lathund.dewire.com (Postfix) with ESMTP id 727AA28E10; Mon, 30 Oct 2006
 11:59:27 +0100 (CET)
To: Catalin Marinas <catalin.marinas@arm.com>
Sender: git-owner@vger.kernel.org

From: Robin Rosenberg <robin.rosenberg@dewire.com>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 contrib/stgbashprompt.sh |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/contrib/stgbashprompt.sh b/contrib/stgbashprompt.sh
new file mode 100755
index 0000000..a79561e
--- /dev/null
+++ b/contrib/stgbashprompt.sh
@@ -0,0 +1,18 @@
+# include this in your bashrc or copy to /etc/bash_completions.d
+
+if [ "$PS1" ]; then
+    # trap 'PS1="\u@\h [$(stg top)] \w]\$ "' DEBUG
+    function stgtag
+    {
+	git_dir=$(git-rev-parse --git-dir 2> /dev/null)
+	ref=$(git-symbolic-ref HEAD 2> /dev/null)
+	br=${ref/refs\/heads\//}
+	top=$(cat $git_dir/patches/$br/current 2>/dev/null)
+	if [[ -n "$br$top" ]];then
+	    echo "[$top@$br]"
+	    return
+	fi
+    }
+    PS1='\u@\h$(stgtag)\w\$ '
+
