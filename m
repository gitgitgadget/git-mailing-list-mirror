From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Gitk strangeness..
Date: Mon, 27 Mar 2006 18:57:42 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603271856070.15714@g5.osdl.org>
References: <7v64lzo1j7.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0603271802030.15714@g5.osdl.org> <17448.40941.256361.866229@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 28 04:58:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FO4P1-000755-Re
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 04:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWC1C5t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 21:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWC1C5s
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 21:57:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49117 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751209AbWC1C5s (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Mar 2006 21:57:48 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2S2vhDZ023675
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 27 Mar 2006 18:57:44 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2S2vggY011724;
	Mon, 27 Mar 2006 18:57:43 -0800
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17448.40941.256361.866229@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=-6 required=5 tests=PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18106>



On Tue, 28 Mar 2006, Paul Mackerras wrote:
>
> The other option would be to make git-rev-list list the open-circle
> commits explicitly, with an indication that they are not in the
> requested set but are parents of commits in the requested set.

Just as an indication of _how_ simple that is, here's a stupid patch.

It just puts a "-" after a parent that isn't going to be shown.

Play with it (and it probably needs a new flag to enable it, since doing 
it unconditionally like this will break old versions of gitk and 
probably anything else that uses the "--parent" flag).

		Linus

----
diff --git a/rev-list.c b/rev-list.c
index 441c437..822a740 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -60,6 +60,8 @@
 			if (o->flags & TMP_MARK)
 				continue;
 			printf(" %s", sha1_to_hex(o->sha1));
+			if (o->flags & UNINTERESTING)
+				putchar('-');
 			o->flags |= TMP_MARK;
 		}
 		/* TMP_MARK is a general purpose flag that can
