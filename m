From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] git-pasky-0.6.2 && heads-up on upcoming changes
Date: Wed, 20 Apr 2005 18:12:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504201809170.2344@ppc970.osdl.org>
References: <20050420205633.GC19112@pasky.ji.cz> <20050420211919.GA20129@kroah.com>
 <20050420215117.GJ19112@pasky.ji.cz> <Pine.LNX.4.58.0504201503050.6467@ppc970.osdl.org>
 <20050420222815.GM19112@pasky.ji.cz> <Pine.LNX.4.58.0504201710500.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Greg KH <greg@kroah.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 03:07:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOQAC-0007a5-2x
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 03:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVDUBLZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 21:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVDUBLZ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 21:11:25 -0400
Received: from fire.osdl.org ([65.172.181.4]:31119 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261539AbVDUBKl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 21:10:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3L1AZs4024892
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Apr 2005 18:10:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3L1AYje007435;
	Wed, 20 Apr 2005 18:10:34 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <Pine.LNX.4.58.0504201710500.2344@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 20 Apr 2005, Linus Torvalds wrote:
> 
> Pasky,
>  what do you think about this change to "git log"?

Here's a slightly updated version.

It's identical to the previous one, except that it also feeds the result 
through "| ${PAGER:-less}" which makes it a lot more useful, in my 
opinion.

If you redirect the output to a non-tty, both "less" and "more" do the 
right thing and just feed the output straight through. But if the output 
is a tty, this makes "git log" a lot more friendly than a quickly 
scrolling mess..

		Linus

----
gitlog.sh: a496a864f9586e47a4d7bd3ae0af0b3e07b7deb8
--- a/gitlog.sh
+++ b/gitlog.sh
@@ -28,7 +28,7 @@ rev-tree $base | sort -rn | while read t
 				fi
 				;;
 			"")
-				echo; cat
+				echo; sed 's/^/  /'
 				;;
 			*)
 				echo $key $rest
@@ -36,5 +36,5 @@ rev-tree $base | sort -rn | while read t
 			esac
 
 		done
-	echo -e "\n--------------------------"
-done
+	echo
+done | ${PAGER:-less}
