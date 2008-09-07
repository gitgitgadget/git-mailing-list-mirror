From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [PATCH 1/2] pretty.c: add %% format specifier
Date: Mon,  8 Sep 2008 01:05:40 +0200
Message-ID: <1220828741-91050-1-git-send-email-pdebie@ai.rug.nl>
References: <7vd4jgpkce.fsf@gitster.siamese.dyndns.org>
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailinglist <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 08 01:07:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcTLf-0002pm-Bt
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 01:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbYIGXF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 19:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbYIGXF4
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 19:05:56 -0400
Received: from smtp-2.orange.nl ([193.252.22.242]:24531 "EHLO smtp-2.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887AbYIGXFz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 19:05:55 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6107.online.nl (SMTP Server) with ESMTP id 6A2DA7000082;
	Mon,  8 Sep 2008 01:05:51 +0200 (CEST)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6107.online.nl (SMTP Server) with ESMTP id B61017000081;
	Mon,  8 Sep 2008 01:05:42 +0200 (CEST)
X-ME-UUID: 20080907230550745.B61017000081@mwinf6107.online.nl
X-Mailer: git-send-email 1.6.0.1.346.g880d9.dirty
In-Reply-To: <7vd4jgpkce.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95187>

This adds a %% format which just prints a literal %

Signed-off-by: Pieter de Bie <pdebie@ai.rug.nl>
---

On 7 sep 2008, at 07:59, Junio C Hamano wrote:
>Junio C Hamano <gitster@pobox.com> writes:
>>I somehow suspect it might be much simpler, more contained and robust if you:
>
>Ah, that would not work, sorry, because this if() statement is only about
>an uninteresting case of --allow-empty.  You need to do this the hard way
>and teach get_commit_format_string() quote % characters in branch names.

Yes, here is patch for this. Sorry for the style issues. I also fixed the
strbuf issue.

 Documentation/pretty-formats.txt |    1 +
 pretty.c                         |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index f18d33e..b91db86 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -127,6 +127,7 @@ The placeholders are:
 - '%m': left, right or boundary mark
 - '%n': newline
 - '%x00': print a byte from a hex code
+- '%%': print a literal '%'
 
 * 'tformat:'
 +
diff --git a/pretty.c b/pretty.c
index 8beafa0..f66d687 100644
--- a/pretty.c
+++ b/pretty.c
@@ -538,6 +538,9 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 			return 3;
 		} else
 			return 0;
+	case '%':
+		strbuf_addch(sb, '%');
+		return 1;
 	}
 
 	/* these depend on the commit */
-- 
1.6.0.1.346.g880d9.dirty
