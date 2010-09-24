From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] update comment and documentation for :/foo syntax
Date: Fri, 24 Sep 2010 18:43:59 +0200
Message-ID: <1285346639-6583-1-git-send-email-Matthieu.Moy@imag.fr>
References: <7vpqw6u142.fsf@alter.siamese.dyndns.org>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 24 18:45:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzBOr-0004L5-71
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 18:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933017Ab0IXQpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 12:45:01 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52822 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932575Ab0IXQo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 12:44:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o8OGdF7O013922
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 24 Sep 2010 18:39:17 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OzBNQ-0000mr-G6; Fri, 24 Sep 2010 18:44:00 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OzBNQ-0001pE-Er; Fri, 24 Sep 2010 18:44:00 +0200
X-Mailer: git-send-email 1.7.3.2.g257b5f
In-Reply-To: <7vpqw6u142.fsf@alter.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 24 Sep 2010 18:39:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o8OGdF7O013922
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1285951160.19568@dF37wCpMDo0RtWjtiiiHpA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157022>

The documentation in revisions.txt did not match the implementation, and
the comment in sha1_name.c was incomplete.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Junio wrote:

> Isn't it "a randomly chosen recent commit whose subject contains regexp
> foo" these days?

So, that's right. Here's an updated version. I've kept the comment
short and vague, to avoid duplicating the doc, it should be sufficient
as a reminder.

 Documentation/revisions.txt |    4 +++-
 sha1_name.c                 |    1 +
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index fe846f0..3d4b79c 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -107,11 +107,13 @@ the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
   found.
 
 * A colon, followed by a slash, followed by a text (e.g. `:/fix nasty bug`): this names
-  a commit whose commit message starts with the specified text.
+  a commit whose commit message matches the specified regular expression.
   This name returns the youngest matching commit which is
   reachable from any ref.  If the commit message starts with a
   '!', you have to repeat that;  the special sequence ':/!',
   followed by something else than '!' is reserved for now.
+  The regular expression can match any part of the commit message. To
+  match messages starting with a string, one can use e.g. `:/^foo`.
 
 * A suffix ':' followed by a path (e.g. `HEAD:README`); this names the blob or tree
   at the given path in the tree-ish object named by the part
diff --git a/sha1_name.c b/sha1_name.c
index 5470a69..ba95a79 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1062,6 +1062,7 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 	/* sha1:path --> object name of path in ent sha1
 	 * :path -> object name of path in index
 	 * :[0-3]:path -> object name of path in index at stage
+	 * :/foo -> recent commit matching foo
 	 */
 	if (name[0] == ':') {
 		int stage = 0;
-- 
1.7.3.2.g257b5f
