From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 2/3] rename_ref(): handle the case when the reflog of a ref does not exist
Date: Mon, 27 Oct 2008 20:50:21 +0100
Message-ID: <5eea93aa5f6d35405eafee4fd022dc9f0b5d75b6.1225136865.git.vmiklos@frugalware.org>
References: <cover.1225136865.git.vmiklos@frugalware.org>
 <a18363084130c4c23279667f6f0bd26d585a061d.1225136865.git.vmiklos@frugalware.org>
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 20:51:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuY7H-0008Rs-A8
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 20:51:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754405AbYJ0Ttr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 15:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754400AbYJ0Ttq
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 15:49:46 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:38262 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754386AbYJ0Ttp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 15:49:45 -0400
Received: from vmobile.example.net (dsl5401C086.pool.t-online.hu [84.1.192.134])
	by yugo.frugalware.org (Postfix) with ESMTPA id 4A980446CD0;
	Mon, 27 Oct 2008 20:49:43 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id EAE078B388; Mon, 27 Oct 2008 20:50:23 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <a18363084130c4c23279667f6f0bd26d585a061d.1225136865.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1225136865.git.vmiklos@frugalware.org>
References: <cover.1225136865.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99255>

We tried to check if a reflog of a ref is a symlink without first
checking if it exists, which is a bug.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 refs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index 31a2057..116eb59 100644
--- a/refs.c
+++ b/refs.c
@@ -974,7 +974,7 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 	int log = !lstat(git_path("logs/%s", oldref), &loginfo);
 	const char *symref = NULL;
 
-	if (S_ISLNK(loginfo.st_mode))
+	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldref);
 
 	symref = resolve_ref(oldref, orig_sha1, 1, &flag);
-- 
1.6.0.2
