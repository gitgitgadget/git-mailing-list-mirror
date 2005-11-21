From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-config-set: Properly terminate strings with '\0'
Date: Mon, 21 Nov 2005 11:18:20 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511211117530.13161@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Nov 21 11:19:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ee8kj-0007tG-UY
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 11:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbVKUKSW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 05:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbVKUKSW
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 05:18:22 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:35733 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932253AbVKUKSV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 05:18:21 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7578614042E; Mon, 21 Nov 2005 11:18:20 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5D8E99F3A5; Mon, 21 Nov 2005 11:18:20 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4BE439C8E8; Mon, 21 Nov 2005 11:18:20 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3833F14042E; Mon, 21 Nov 2005 11:18:20 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12436>


When a lowercase version of the key was generated, it was not
terminated. Strangely enough, it worked on Linux and macosx anyway.
Just cygwin barfed.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 config-set.c |    1 +
 config.c     |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

applies-to: f7083280a1a5b84bbf5c6e74177e21807d5ee56b
6da767ad3f7ca0c1e86e7ec42765fcb01417d695
diff --git a/config-set.c b/config-set.c
index 5f654f7..d938f96 100644
--- a/config-set.c
+++ b/config-set.c
@@ -38,6 +38,7 @@ static int get_value(const char* key_, c
 	key = malloc(strlen(key_)+1);
 	for (i = 0; key_[i]; i++)
 		key[i] = tolower(key_[i]);
+	key[i] = 0;
 
 	if (regex_) {
 		if (regex_[0] == '!') {
diff --git a/config.c b/config.c
index 38c0edd..357c1ca 100644
--- a/config.c
+++ b/config.c
@@ -433,6 +433,7 @@ int git_config_set_multivar(const char* 
 			return 1;
 		} else
 			store.key[i] = tolower(key[i]);
+	store.key[i] = 0;
 
 	/*
 	 * The lock_file serves a purpose in addition to locking: the new
---
0.99.9.GIT
