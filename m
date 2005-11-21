From: Junio C Hamano <junkio@cox.net>
Subject: Re: git daemon broken?
Date: Sun, 20 Nov 2005 23:30:12 -0800
Message-ID: <7vpsouwj97.fsf@assigned-by-dhcp.cox.net>
References: <20051121.154733.64482215.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 08:31:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ee683-0005qH-9O
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 08:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbVKUHaQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 02:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbVKUHaP
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 02:30:15 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:31131 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751003AbVKUHaO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 02:30:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051121072856.EZNW17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 21 Nov 2005 02:28:56 -0500
To: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20051121.154733.64482215.yoshfuji@linux-ipv6.org> (YOSHIFUJI
	Hideaki's message of "Mon, 21 Nov 2005 15:47:33 +0900 (JST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12426>

I think this should fix it; the problem analysis I did in my
previous mail was half-baked, and the thing about '||' vs '&&'
was completely faulty.  Obviously I am not thinking straight
tonight, so I'll go to bed.

---

diff --git a/path.c b/path.c
index 84b3272..4d88947 100644
--- a/path.c
+++ b/path.c
@@ -181,7 +181,7 @@ char *enter_repo(char *path, int strict)
 		return NULL;
 
 	if (strict) {
-		if((path[0] != '/') || chdir(path) < 0)
+		if (chdir(path) < 0)
 			return NULL;
 	}
 	else {
