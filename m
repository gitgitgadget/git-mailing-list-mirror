From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 2/3] diff.c: plug a memory leak in an error path
Date: Mon,  8 Jun 2009 22:34:30 +0200
Message-ID: <8f487369337bdb1c9884b8f6e56530d25de85472.1244492659.git.j6t@kdbg.org>
References: <cover.1244492658.git.j6t@kdbg.org>
 <e4b190906055eb86077ca3e7257c983befcfb511.1244492659.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 22:35:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDlZ8-0005ri-QM
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 22:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316AbZFHUfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 16:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753307AbZFHUfY
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 16:35:24 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:63388 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752356AbZFHUfX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 16:35:23 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 8E2781000B;
	Mon,  8 Jun 2009 22:35:24 +0200 (CEST)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 085DB1D0C2;
	Mon,  8 Jun 2009 22:35:24 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.17.g1665f
In-Reply-To: <e4b190906055eb86077ca3e7257c983befcfb511.1244492659.git.j6t@kdbg.org>
In-Reply-To: <cover.1244492658.git.j6t@kdbg.org>
References: <cover.1244492658.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121104>

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 diff.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 4d0a5b9..43835d7 100644
--- a/diff.c
+++ b/diff.c
@@ -3596,6 +3596,7 @@ static char *run_textconv(const char *pgm, struct diff_filespec *spec,
 	if (start_command(&child) != 0 ||
 	    strbuf_read(&buf, child.out, 0) < 0 ||
 	    finish_command(&child) != 0) {
+		strbuf_release(&buf);
 		remove_tempfile();
 		error("error running textconv command '%s'", pgm);
 		return NULL;
-- 
1.6.3.17.g1665f
