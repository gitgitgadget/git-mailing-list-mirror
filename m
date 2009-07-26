From: Alex Vandiver <alex@chmrr.net>
Subject: [PATCH] Make git config fail on variables with no section, as documented
Date: Sun, 26 Jul 2009 12:18:22 -0400
Message-ID: <1248625102-472-1-git-send-email-alex@chmrr.net>
References: <1248474081-sup-2762@utwig>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 26 18:18:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MV6Qo-0001Yc-ML
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 18:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753777AbZGZQS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 12:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753775AbZGZQS2
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 12:18:28 -0400
Received: from chmrr.net ([209.67.253.66]:55271 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753754AbZGZQS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 12:18:28 -0400
Received: from c-67-186-135-139.hsd1.ma.comcast.net ([67.186.135.139] helo=localhost.localdomain)
	by utwig.chmrr.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <alex@chmrr.net>)
	id 1MV6Qd-0008L3-Nt
	for git@vger.kernel.org; Sun, 26 Jul 2009 12:18:28 -0400
X-Mailer: git-send-email 1.6.3.3.473.gb74fc4.dirty
In-Reply-To: <1248474081-sup-2762@utwig>
X-Authenticated-User: chmrr
X-Authenticator: plain
X-Sender-Verify: SUCCEEDED (sender exists & accepts mail)
X-Spam-Score: -3.9
X-Spam-Score-Int: -38
X-Exim-Version: 4.69 (build at 07-Feb-2009 20:08:51)
X-Date: 2009-07-26 12:18:28
X-Connected-IP: 67.186.135.139:45797
X-Message-Linecount: 38
X-Body-Linecount: 29
X-Message-Size: 1166
X-Body-Size: 791
X-Received-Count: 1
X-Recipient-Count: 1
X-Local-Recipient-Count: 1
X-Local-Recipient-Defer-Count: 0
X-Local-Recipient-Fail-Count: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124125>

Documentation/config.txt claims:

    Each variable must belong to some section, which means that there
    must be a section header before the first setting of a variable.

However, the parsing code did not enforce this.  This change makes it
a syntax error to defined a variable before the first section header.

Signed-off-by: Alex Vandiver <alex@chmrr.net>
---
 config.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/config.c b/config.c
index 1b3823d..447ad00 100644
--- a/config.c
+++ b/config.c
@@ -248,6 +248,8 @@ static int git_parse_file(config_fn_t fn, void *data)
 		}
 		if (!isalpha(c))
 			break;
+		if (baselen == 0)
+			break;
 		var[baselen] = tolower(c);
 		if (get_value(fn, data, var, baselen+1) < 0)
 			break;
-- 
1.6.3.3.473.gb74fc4.dirty
