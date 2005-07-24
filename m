From: Marco Costalba <mcostalba@yahoo.it>
Subject: [PATCH] Extend git-ls-files --exclude option to match against directories
Date: Sun, 24 Jul 2005 01:12:25 -0700 (PDT)
Message-ID: <20050724081225.81671.qmail@web26304.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun Jul 24 10:12:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwbbD-00012D-5Y
	for gcvg-git@gmane.org; Sun, 24 Jul 2005 10:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVGXIM1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jul 2005 04:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVGXIM1
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jul 2005 04:12:27 -0400
Received: from web26304.mail.ukl.yahoo.com ([217.146.176.15]:48724 "HELO
	web26304.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261424AbVGXIM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2005 04:12:26 -0400
Received: (qmail 81673 invoked by uid 60001); 24 Jul 2005 08:12:25 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=vkkAIT50MIuj/xnRrNZOPhYxFC5ZrhjpUY3PHQBQAUwMhYyFcybeMmMGpPTFjJRNVY5nUnluqCpNY3A8NSNENSfeS4Q8fLlZ1bi2jJDCSSxOTEc3tD2Ry+rCo2jDhLUQoRSokXrZeXUmX7OVnuOZD8jcjirxr7Kaof4Xp2CZPuA=  ;
Received: from [151.42.103.53] by web26304.mail.ukl.yahoo.com via HTTP; Sun, 24 Jul 2005 01:12:25 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Pattern in git-ls-files --exclude=<pattern> can include directories
as example git-ls-files --exclude=Documentation/* will do what you expect
---

 ls-files.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

c8fdfc1f8280a753baf13c293db573c4e50f0a99
diff --git a/ls-files.c b/ls-files.c
--- a/ls-files.c
+++ b/ls-files.c
@@ -80,10 +80,8 @@ static int excluded(const char *pathname
 {
 	int i;
 	if (nr_excludes) {
-		const char *basename = strrchr(pathname, '/');
-		basename = (basename) ? basename+1 : pathname;
 		for (i = 0; i < nr_excludes; i++)
-			if (fnmatch(excludes[i], basename, 0) == 0)
+			if (fnmatch(excludes[i], pathname, FNM_PATHNAME) == 0)
 				return 1;
 	}
 	return 0;


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
