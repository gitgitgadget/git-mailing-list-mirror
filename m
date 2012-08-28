From: Matthew Caron <Matt.Caron@redlion.net>
Subject: I think git show is broken
Date: Tue, 28 Aug 2012 13:38:51 -0400
Message-ID: <503D022B.6070001@redlion.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 28 19:44:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6Pq2-00009K-GL
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 19:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601Ab2H1RoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 13:44:24 -0400
Received: from msex2.hq.corp.redlion.net ([205.159.151.218]:24415 "EHLO
	msex2.hq.corp.redlion.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363Ab2H1RoX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 13:44:23 -0400
Received: from MSEX1.hq.corp.redlion.net (172.16.2.15) by
 msex2.hq.corp.redlion.net (172.16.2.18) with Microsoft SMTP Server (TLS) id
 14.0.722.0; Tue, 28 Aug 2012 13:38:53 -0400
Received: from BL-MSEX1.hq.corp.redlion.net (10.128.0.5) by
 msex1.hq.corp.redlion.net (172.16.2.15) with Microsoft SMTP Server (TLS) id
 14.1.355.2; Tue, 28 Aug 2012 13:38:52 -0400
Received: from [10.128.3.6] (10.128.3.6) by BL-MSEX1.hq.corp.redlion.net
 (10.128.0.5) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 28 Aug 2012
 13:38:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204434>

(otherwise, there was a very strange change made to its functionality, 
which the documentation does not reflect)


Old, working git:

===
$ git --version
git version 1.7.0.4
$ git show --quiet --abbrev-commit --pretty=oneline 
47a7aee54553fb718c376cfa9d7de4389a391e33
47a7aee Fix hyperlinks for dependent tickets (#7139, #4976).
===

New, "broken" git:

===
$ git --version
git version 1.7.9.5

$ git show --quiet --abbrev-commit --pretty=oneline 
47a7aee54553fb718c376cfa9d7de4389a391e33
47a7aee Fix hyperlinks for dependent tickets (#7139, #4976).
diff --git a/mastertickets/web_ui.py b/mastertickets/web_ui.py
index a91b862..698ed98 100644
--- a/mastertickets/web_ui.py
+++ b/mastertickets/web_ui.py
@@ -32,7 +32,7 @@ class MasterTicketsModule(Component):
      use_gs = BoolOption('mastertickets', 'use_gs', default=False,
                          doc='If enabled, use ghostscript to produce 
nicer output.')

-    FIELD_XPATH = 
'div[@id="ticket"]/table[@class="properties"]/td[@headers="h_%s"]/text()'
+    FIELD_XPATH = 
'.//div[@id="ticket"]/table[@class="properties"]//td[@headers="h_%s"]/text()'
      fields = set(['blocking', 'blockedby'])

      # IRequestFilter methods
===

It appears as though the new functionality always puts out a "medium" 
verbosity diff. Though the manpage says that it honors pretty=oneline, 
it does not seem to.

I searched around the message logs, etc. and would have expected this 
change to have thrown everyone else into as much upheaval as it has in 
my organization, and found nothing. Am I missing something?

Thanks in advance.
-- 
Matthew Caron, Software Build Engineer
Sixnet, a Red Lion business | www.sixnet.com
+1 (518) 877-5173 x138 office
