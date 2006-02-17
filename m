From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make git-reset delete empty directories
Date: Fri, 17 Feb 2006 00:15:56 -0800
Message-ID: <7v7j7u8koz.fsf@assigned-by-dhcp.cox.net>
References: <20060217072616.GA15358@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 09:16:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FA0md-0003dY-FJ
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 09:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWBQIP6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 03:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbWBQIP6
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 03:15:58 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:49140 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932587AbWBQIP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 03:15:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060217081417.GKUL20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 17 Feb 2006 03:14:17 -0500
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060217072616.GA15358@spearce.org> (Shawn Pearce's message of
	"Fri, 17 Feb 2006 02:26:16 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16332>

Shawn Pearce <spearce@spearce.org> writes:

> When git-reset --hard is used and a subdirectory becomes
> empty (as it contains no tracked files in the target tree)
> the empty subdirectory should be removed.

I thought I said it would be a few-liner, but it appears I did
not send that message.

This untested one is far simpler, if less efficient, isn't it?

---

diff --git a/git-reset.sh b/git-reset.sh
index fe53fc8..195d043 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -88,6 +88,9 @@ case "$reset_type" in
 				# it is ok if this fails -- it may already
 				# have been culled by checkout-index.
 				unlink $_;
+				while (s|/[^/]*$|| && $_ ne "") {
+					rmdir($_) or last;
+				}
 			}
 		}
 	' $tmp-exists
