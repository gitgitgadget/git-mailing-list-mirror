From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 18/24] merge: do not setup worktree twice
Date: Mon,  9 Nov 2009 09:04:58 -0600
Message-ID: <1257779104-23884-18-git-send-email-jrnieder@gmail.com>
References: <20091109150235.GA23871@progeny.tock>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 15:56:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7VfC-0002nn-VK
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 15:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978AbZKIOzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 09:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755643AbZKIOzm
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 09:55:42 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:10055 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755712AbZKIOzk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 09:55:40 -0500
Received: by ey-out-2122.google.com with SMTP id 25so182698eya.19
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 06:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=fFRpkQJ0IoL0t3udaw4noLVEK56pIWjywf67hBbH4KE=;
        b=dQQYvhr7/dHsv/thCdvKmUQoTbuBDE4TU35QtfpCJJDDlH1U5qkOeMFeqixmnshr0B
         l6pqlixr3iAsOs/ouIj5MXClTQdWO+eBOxcnZoMPnxIoSIpWjqE/8dXXxp54wldPknPD
         Sqoeo0r2qfiHxHnsX5wzlbz8sjEteo9kHrUNk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pjtqh67z9+MFvHE9s2Z/mCi1CbaDXhcSd1l/Swf0waptL3GH9AMt4h/WP4DTios+B0
         g/+M+1+HDQW9kq1KfXQR2k29csxtHvWaGVaJNv0sSO4irwBtlxBlYxmPKpQMYw+GSxi+
         Y0Y+W9Kcr0/DK2GWnOId7AzVpBLKGzKN/SnY4=
Received: by 10.216.85.68 with SMTP id t46mr2538289wee.114.1257778546094;
        Mon, 09 Nov 2009 06:55:46 -0800 (PST)
Received: from localhost.localdomain (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p37sm8922607gvf.9.2009.11.09.06.55.43
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 06:55:45 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <20091109150235.GA23871@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132476>

Builtins do not need to run setup_worktree() for themselves, since
the builtin machinery runs it for them.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This matter since '-h' cannot suppress _this_ setup_work_tree()
through the builtin machinery.

 builtin-merge.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index c69a305..1857138 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -843,7 +843,6 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	const char *best_strategy = NULL, *wt_strategy = NULL;
 	struct commit_list **remotes = &remoteheads;
 
-	setup_work_tree();
 	if (file_exists(git_path("MERGE_HEAD")))
 		die("You have not concluded your merge. (MERGE_HEAD exists)");
 	if (read_cache_unmerged())
-- 
1.6.5.2
