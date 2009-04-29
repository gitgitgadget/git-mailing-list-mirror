From: Augie Fackler <durin42@gmail.com>
Subject: [PATCH] Don't crash if ai_canonname comes back as null
Date: Wed, 29 Apr 2009 18:04:42 -0500
Message-ID: <C2AC0D7A-3E11-4A3A-8447-5D7582547B13@gmail.com>
References: <9C355DCC-0240-4B9E-83CA-083B51C2E34C@gmail.com> <81b0412b0904291455n47f83e9ftcbdec0ff1c0ea03@mail.gmail.com> <6B7EA51D-8412-4E6A-BA7B-156FD5B755E8@gmail.com> <81b0412b0904291504k3261df5fl692d09c6c761887e@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 01:04:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzIpg-0002rW-M7
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 01:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197AbZD2XEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 19:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753090AbZD2XEo
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 19:04:44 -0400
Received: from caiajhbdccah.dreamhost.com ([208.97.132.207]:44637 "EHLO
	spunkymail-a6.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752191AbZD2XEo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2009 19:04:44 -0400
Received: from [172.16.17.71] (adsl-99-147-234-187.dsl.chcgil.sbcglobal.net [99.147.234.187])
	by spunkymail-a6.g.dreamhost.com (Postfix) with ESMTP id 55D41109F30;
	Wed, 29 Apr 2009 16:04:43 -0700 (PDT)
In-Reply-To: <81b0412b0904291504k3261df5fl692d09c6c761887e@mail.gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117974>

Fixes a weird bug where git-daemon was segfaulting
when started by sh(1) because ai_canonname was null.
---
Fixed based on feedback.

  daemon.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/daemon.c b/daemon.c
index 13401f1..ae21d92 100644
--- a/daemon.c
+++ b/daemon.c
@@ -459,7 +459,7 @@ static void parse_extra_args(char *extra_args, int  
buflen)
  				inet_ntop(AF_INET, &sin_addr->sin_addr,
  					  addrbuf, sizeof(addrbuf));
  				free(canon_hostname);
-				canon_hostname = xstrdup(ai->ai_canonname);
+				canon_hostname = ai->ai_canonname ? xstrdup(ai->ai_canonname) :  
NULL;
  				free(ip_address);
  				ip_address = xstrdup(addrbuf);
  				break;
-- 
1.6.2.GIT
