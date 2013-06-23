From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/4] fast-import: set valid mode on root tree in "ls"
Date: Sun, 23 Jun 2013 15:58:20 +0100
Message-ID: <093e9ce49bf92d81c3a7a11d91292be675eaf6fa.1371999369.git.john@keeping.me.uk>
References: <cover.1371999369.git.john@keeping.me.uk>
Cc: Dave Abrahams <dave@boostpro.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 23 16:59:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uqlkp-00018d-EE
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 16:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738Ab3FWO6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 10:58:55 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:60843 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706Ab3FWO6y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 10:58:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 85A8D606504;
	Sun, 23 Jun 2013 15:58:54 +0100 (BST)
X-Quarantine-ID: <UcFYUl2-VySS>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UcFYUl2-VySS; Sun, 23 Jun 2013 15:58:54 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 1E4A06064FD;
	Sun, 23 Jun 2013 15:58:54 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 11DBD161E424;
	Sun, 23 Jun 2013 15:58:54 +0100 (BST)
X-Quarantine-ID: <oZaYGe5APJvd>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oZaYGe5APJvd; Sun, 23 Jun 2013 15:58:53 +0100 (BST)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id EA4F7161E3F1;
	Sun, 23 Jun 2013 15:58:44 +0100 (BST)
X-Mailer: git-send-email 1.8.3.1.676.gaae6535
In-Reply-To: <cover.1371999369.git.john@keeping.me.uk>
In-Reply-To: <cover.1371999369.git.john@keeping.me.uk>
References: <cover.1371999369.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228743>

This prevents a failure later when we lift the restriction on ls with
the empty path.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 fast-import.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fast-import.c b/fast-import.c
index 23f625f..bdbadea 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3051,6 +3051,8 @@ static void parse_ls(struct branch *b)
 		struct object_entry *e = parse_treeish_dataref(&p);
 		root = new_tree_entry();
 		hashcpy(root->versions[1].sha1, e->idx.sha1);
+		if (!is_null_sha1(root->versions[1].sha1))
+			root->versions[1].mode = S_IFDIR;
 		load_tree(root);
 		if (*p++ != ' ')
 			die("Missing space after tree-ish: %s", command_buf.buf);
-- 
1.8.3.1.676.gaae6535
