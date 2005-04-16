From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Byteorder fix for read-tree, new -m semantics version.
Date: Sat, 16 Apr 2005 02:27:08 -0700
Message-ID: <7vacnzcbrn.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	<20050414121624.GZ25711@pasky.ji.cz>
	<7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
	<20050414193507.GA22699@pasky.ji.cz>
	<7vmzs1osv1.fsf@assigned-by-dhcp.cox.net>
	<20050414233159.GX22699@pasky.ji.cz>
	<7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net>
	<20050414223039.GB28082@64m.dyndns.org>
	<7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net>
	<20050415062807.GA29841@64m.dyndns.org>
	<7vfyxsi9bq.fsf@assigned-by-dhcp.cox.net>
	<7vaco0i3t9.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504151138490.7211@ppc970.osdl.org>
	<7vmzrzhkd3.fsf@assigned-by-dhcp.cox.net>
	<7vfyxrhfsw.fsf_-_@assigned-by-dhcp.cox.net>
	<7vmzrzfwe4.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504151755590.7211@ppc970.osdl.org>
	<7v7jj3fjky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504152152580.7211@ppc970.osdl.org>
	<Pine.LNX.4.58.0504152256520.7211@ppc970.osdl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 11:24:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMjWx-0005K9-Kn
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 11:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVDPJ10 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 05:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVDPJ10
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 05:27:26 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:62645 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261516AbVDPJ1W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 05:27:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050416092718.FPXU19936.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 16 Apr 2005 05:27:18 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vis2ncf8j.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 16 Apr 2005 01:12:12 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The ce_namelen field has been renamed to ce_flags and split into
the top 2-bit unused, next 2-bit stage number and the lowest
12-bit name-length, stored in the network byte order.  A new
macro create_ce_flags() is defined to synthesize this value from
length and stage, but it forgets to turn the value into the
network byte order.  Here is a fix.

The patch is against 9c03bd47892d11d0bb28c442184786db3c189978.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 cache.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- cache.h
+++ cache.h	2005-04-16 02:22:05.000000000 -0700
@@ -66,7 +66,7 @@
 #define CE_NAMEMASK  (0x0fff)
 #define CE_STAGEMASK (0x3000)
 
-#define create_ce_flags(len, stage) ((len) | ((stage) << 12))
+#define create_ce_flags(len, stage) htons((len) | ((stage) << 12))
 
 const char *sha1_file_directory;
 struct cache_entry **active_cache;


