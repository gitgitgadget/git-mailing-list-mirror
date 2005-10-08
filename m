From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH Cogito] cg-fetch: fix local cloning with symbolic refs
Date: Sat, 8 Oct 2005 19:48:57 +0200
Message-ID: <20051008174857.GB28875@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 19:50:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOIpA-0007Uy-CM
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 19:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbVJHRtZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Oct 2005 13:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVJHRtZ
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Oct 2005 13:49:25 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:5852 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S932174AbVJHRtZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Oct 2005 13:49:25 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id A8E4C6E0D9C; Sat,  8 Oct 2005 19:49:12 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 747036E0223; Sat,  8 Oct 2005 19:49:12 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 0116F60F95; Sat,  8 Oct 2005 19:49:23 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9844>

Ugly workaround for making the HEAD getter use 'git-symbolic-ref HEAD'
so that git-local-fetch is passed the proper ID and not 'ref: ...'.

---

Yeah, it is ugly, it assumes we are getting the HEAD (which is currently
the only one using the -b flag.

diff --git a/cg-fetch b/cg-fetch
index d0d37e1..57096cd 100755
--- a/cg-fetch
+++ b/cg-fetch
@@ -248,9 +248,10 @@ fetch_ssh()
 
 get_local()
 {
+	symref=
 	cp_flags_l="-vdpR"
 	if [ "$1" = "-b" ]; then
-		cp_flags_l="-vb" # Dereference symlinks
+		symref=1
 		shift
 	fi
 
@@ -270,6 +271,7 @@ get_local()
 
 	src="$1"
 	dest="$2"
+	[ "$symref" ] && src="$(dirname $src)/$(git-symbolic-ref HEAD)"
 	[ "$cut_last" ] && dest=${dest%/*}
 
 	cp $cp_flags_l "$src" "$dest"

-- 
Jonas Fonseca
