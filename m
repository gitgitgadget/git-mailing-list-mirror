From: Matt Porter <mporter@kernel.crashing.org>
Subject: Re: [PATCH] Add exclude file support to cg-status
Date: Mon, 2 May 2005 21:27:01 -0700
Message-ID: <20050502212701.B26102@cox.net>
References: <20050502171042.A24299@cox.net> <7vd5s9nmio.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 06:23:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSowD-0006EX-8h
	for gcvg-git@gmane.org; Tue, 03 May 2005 06:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVECE3P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 00:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVECE3P
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 00:29:15 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:37760 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261386AbVECE25 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 00:28:57 -0400
Received: from liberty.homelinux.org ([68.2.41.86]) by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050503042852.QVPD1367.fed1rmmtao07.cox.net@liberty.homelinux.org>;
          Tue, 3 May 2005 00:28:52 -0400
Received: (from mmporter@localhost)
	by liberty.homelinux.org (8.9.3/8.9.3/Debian 8.9.3-21) id VAA26233;
	Mon, 2 May 2005 21:27:01 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <7vd5s9nmio.fsf@assigned-by-dhcp.cox.net>; from junkio@cox.net on Mon, May 02, 2005 at 06:09:19PM -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 02, 2005 at 06:09:19PM -0700, Junio C Hamano wrote:
> >>>>> "MP" == Matt Porter <mporter@kernel.crashing.org> writes:
> 
> MP> Adds a trivial per-repository exclude file implementation for
> MP> cg-status on top of the new git-ls-files option.
> 
>  
> MP> +EXCLUDEFILE=.git/exclude
> 
> Good intentions, but shouldn't the file be .git/info/exclude
> (i.e. under .git/info)?

Ok, here is the updated version.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

--- aa6233be6d1b8bf42797c409a7c23b50593afc99/cg-status  (mode:100755 sha1:9e7f0e59284a3d15cda35bbd5579c44d8eda05d5)
+++ d69eece260c0c4fcd53991c1b37ac91b99962681/cg-status  (mode:100755 sha1:874504aa8cf9ab7076eb405e19995615b4f59eab)
@@ -7,8 +7,14 @@
 
 . cg-Xlib
 
+EXCLUDEFILE=.git/info/exclude
+EXCLUDE=
+if [ -f $EXCLUDEFILE ]; then
+	EXCLUDE="--exclude-from=$EXCLUDEFILE"
+fi
+
 {
-	git-ls-files -z -t --others --deleted --unmerged
+	git-ls-files -z -t --others --deleted --unmerged $EXCLUDE
 } | sort -z -k 2 | xargs -0 sh -c '
 while [ "$1" ]; do
 	tag=${1% *};
