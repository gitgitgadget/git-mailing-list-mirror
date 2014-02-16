From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/5] notes-utils: handle boolean notes.rewritemode correctly
Date: Sun, 16 Feb 2014 16:06:02 +0000
Message-ID: <be9b384ec77fc39b939b8c5505862a6e1c641faa.1392565571.git.john@keeping.me.uk>
References: <cover.1392565571.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 16 17:07:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WF4FB-00088c-EP
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 17:07:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbaBPQGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Feb 2014 11:06:46 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:35740 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474AbaBPQGY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Feb 2014 11:06:24 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id C84D5CDA590;
	Sun, 16 Feb 2014 16:06:23 +0000 (GMT)
X-Quarantine-ID: <7hXWBvNBO-fT>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7hXWBvNBO-fT; Sun, 16 Feb 2014 16:06:23 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 712DACDA2D4;
	Sun, 16 Feb 2014 16:06:23 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 68C64161E4C1;
	Sun, 16 Feb 2014 16:06:23 +0000 (GMT)
X-Quarantine-ID: <eT2D637ewWhh>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eT2D637ewWhh; Sun, 16 Feb 2014 16:06:23 +0000 (GMT)
Received: from river.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 31EE2161E262;
	Sun, 16 Feb 2014 16:06:18 +0000 (GMT)
X-Mailer: git-send-email 1.9.rc0.187.g6292fff
In-Reply-To: <cover.1392565571.git.john@keeping.me.uk>
In-Reply-To: <cover.1392565571.git.john@keeping.me.uk>
References: <cover.1392565571.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242231>

If we carry on after outputting config_error_nonbool then we're
guaranteed to dereference a null pointer.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 notes-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/notes-utils.c b/notes-utils.c
index 2975dcd..4aa7023 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -75,7 +75,7 @@ static int notes_rewrite_config(const char *k, const char *v, void *cb)
 		return 0;
 	} else if (!c->mode_from_env && !strcmp(k, "notes.rewritemode")) {
 		if (!v)
-			config_error_nonbool(k);
+			return config_error_nonbool(k);
 		c->combine = parse_combine_notes_fn(v);
 		if (!c->combine) {
 			error(_("Bad notes.rewriteMode value: '%s'"), v);
-- 
1.9.rc0.187.g6292fff
