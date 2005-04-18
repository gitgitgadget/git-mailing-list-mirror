From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Pretty-print date in 'git log'
Date: Mon, 18 Apr 2005 22:24:39 +1000
Message-ID: <1113827080.5286.10.camel@localhost.localdomain>
References: <E1DNPz9-0003lm-00@skye.ra.phy.cam.ac.uk>
	 <1113808105.5286.1.camel@localhost.localdomain>
	 <20050418102744.GK1461@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 14:22:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNVFi-00070E-3b
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 14:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbVDRMZL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 08:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVDRMZL
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 08:25:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:18643 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262055AbVDRMZB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 08:25:01 -0400
Received: from [203.53.50.91] (helo=[172.18.240.72])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DNVJC-00062F-JN; Mon, 18 Apr 2005 13:25:00 +0100
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050418102744.GK1461@pasky.ji.cz>
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-04-18 at 12:27 +0200, Petr Baudis wrote:
> Yes. As far as I'm concerned, I'd put such stuff to git log, and extend
> it usage so that it is possible to print individual log entries with it
> - just make it accept a _range_ of commits, and then do
> 
>         git log $commit $commit

That's fairly trivial. In the current (and misguided) version with
chronological output, rev-tree will do it all for you, in fact:

	rev-tree $1 ^$2

In the older and more useful version, it was only slightly more complex:

 base=$(gitXnormid.sh -c $1) || exit 1
 
+if [ -n "$2" ]; then
+    endpoint=$(gitXnormid.sh -c $2) || exit 1
+    if rev-tree $base $endpoint | grep -q $base:3; then
+        base=
+    else
+        rev-tree --edges $base $endpoint | sed 's/[a-z0-9]*:1//g' > $TMPCL
+    fi
+fi
 changelog $base
 rm $TMPCL $TMPCM


-- 
dwmw2

