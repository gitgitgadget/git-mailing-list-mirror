From: "Hunter, D. Seth" <hunter@ll.mit.edu>
Subject: [PATCH] http-push: fix xml_entities() string parsing overrun
Date: Tue, 30 Jun 2009 20:24:47 -0400
Message-ID: <D7CBF77D2B9C1D4D8C5E528FBBB35D8B58EC70ECDA@LLE2K7-BE02.mitll.ad.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 01 03:05:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLoGo-0003Md-GJ
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 03:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764362AbZGAAy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 20:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764374AbZGAAyZ
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 20:54:25 -0400
Received: from LLMAIL1.LL.MIT.EDU ([129.55.12.41]:53919 "EHLO ll.mit.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1764356AbZGAAyY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Jun 2009 20:54:24 -0400
X-Greylist: delayed 1734 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jun 2009 20:54:24 EDT
Received: (from smtp@localhost)
	by ll.mit.edu (8.12.10/8.8.8) id n610PSbV017505
	for <git@vger.kernel.org>; Tue, 30 Jun 2009 20:25:28 -0400 (EDT)
Received: from lle2k7-hub01.llan.ll.mit.edu(            ), claiming to be "LLE2K7-HUB01.mitll.ad.local"
 via SMTP by llpost, id smtpdAAAq7a4ZH; Tue Jun 30 20:24:48 2009
Received: from LLE2K7-BE02.mitll.ad.local ([            ]) by
 LLE2K7-HUB01.mitll.ad.local ([            ]) with mapi; Tue, 30 Jun 2009
 20:24:48 -0400
Thread-Topic: [PATCH] http-push: fix xml_entities() string parsing overrun
Thread-Index: Acn54lbCDh7JILGbQO6UaJh6wJg1Lw==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122558>

xml_entities() in http-push.c did not properly stop at the end of the string being examined, which would occasionally cause nonsense to be appended to escaped URL strings and result in failed DAV XML queries

Signed-off-by: Seth Hunter <hunter@ll.mit.edu>
---
 http-push.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/http-push.c b/http-push.c
index 8cc8ee0..00e83dc 100644
--- a/http-push.c
+++ b/http-push.c
@@ -193,6 +193,8 @@ static char *xml_entities(char *s)
 		case '&':
 			strbuf_addstr(&buf, "&amp;");
 			break;
+		case 0:
+			return strbuf_detach(&buf, NULL);
 		}
 		s++;
 	}
-- 
1.6.3.3
