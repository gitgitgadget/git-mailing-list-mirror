From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: [PATCH] describe: match pattern for lightweight tags too
Date: Wed, 4 Jun 2008 21:06:31 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0806042101080.3410@pollux>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 21:07:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3yKX-0004He-TZ
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 21:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757183AbYFDTGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 15:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754413AbYFDTGg
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 15:06:36 -0400
Received: from mailout11.t-online.de ([194.25.134.85]:38858 "EHLO
	mailout11.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089AbYFDTGf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 15:06:35 -0400
Received: from fwd33.aul.t-online.de 
	by mailout11.sul.t-online.de with smtp 
	id 1K3yJd-0002wP-00; Wed, 04 Jun 2008 21:06:33 +0200
Received: from [192.168.2.100] (E1Yh8rZCghxHekDACuY2RH83V1oGwdofVPyFk0htGXnQns5Xu41YWCZt8CfVZHxZaw@[84.163.197.25]) by fwd33.t-online.de
	with esmtp id 1K3yJZ-0F6rcu0; Wed, 4 Jun 2008 21:06:29 +0200
X-X-Sender: michael@pollux
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
X-ID: E1Yh8rZCghxHekDACuY2RH83V1oGwdofVPyFk0htGXnQns5Xu41YWCZt8CfVZHxZaw
X-TOI-MSGID: 2c7e2eaf-ef0c-46c5-ac15-524aa8086091
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83810>


So far git describe --match <pattern> would apply the <pattern> only
to tag objects not to lightweight tags. This change make describe apply
the <pattern> to lightweight tags too.

Signed-off-by: Michael Dressel <MichaelTiloDressel@t-online.de>
---
  builtin-describe.c |    9 +++++----
  1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index df554b3..3da99c1 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -80,12 +80,13 @@ static int get_name(const char *path, const unsigned char *sha1, int flag, void
  	 * Otherwise only annotated tags are used.
  	 */
  	if (might_be_tag) {
-		if (is_tag) {
+		if (is_tag)
  			prio = 2;
-			if (pattern && fnmatch(pattern, path + 10, 0))
-				prio = 0;
-		} else
+		else
  			prio = 1;
+
+		if (pattern && fnmatch(pattern, path + 10, 0))
+			prio = 0;
  	}
  	else
  		prio = 0;
-- 
1.5.5.3
