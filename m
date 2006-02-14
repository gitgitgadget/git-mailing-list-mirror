From: Greg KH <greg@kroah.com>
Subject: Re: diffstat wierdness with 'git format-patch' output
Date: Mon, 13 Feb 2006 22:42:56 -0800
Message-ID: <20060214064256.GA19667@kroah.com>
References: <20060214055425.GA32261@kroah.com> <20060214055648.GA592@kroah.com> <7vveviv5d1.fsf@assigned-by-dhcp.cox.net> <20060214063420.GA11851@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 07:43:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8ttn-0005Yv-M4
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 07:42:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030416AbWBNGmx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 01:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030493AbWBNGmx
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 01:42:53 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:25274
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030416AbWBNGmw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 01:42:52 -0500
Received: from press.kroah.org ([192.168.0.25] helo=localhost)
	by aria.kroah.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.54)
	id 1F8ttm-00023G-CW; Mon, 13 Feb 2006 22:42:54 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060214063420.GA11851@kroah.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16122>

On Mon, Feb 13, 2006 at 10:34:20PM -0800, Greg KH wrote:
> > I personally find it useful to see the trend of version of tools
> > people use on the public mailing list, and that was the primary
> > reason it is there.
> 
> Why not just add a "X-Git-Version: 1.2.0" flag to the message instead?

And here's a patch that does just that.

-----------------

Subject: change git-format-patch to put the git version in the mail header

This is more like other tools that create mail messages, and fixes an
issue of the diffstat program thinking that an extra line was removed
from the patch.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff --git a/git-format-patch.sh b/git-format-patch.sh
index e54c9e4..5f6a921 100755
--- a/git-format-patch.sh
+++ b/git-format-patch.sh
@@ -216,6 +216,7 @@ while (<FH>) {
 
 	    print "From: $author_ident\n";
 	    print "Date: $author_date\n";
+	    print "X-Git-Version: @@GIT_VERSION@@\n";
 	}
 	next;
     }
@@ -250,8 +251,6 @@ close FH or die "close $commsg pipe";
 	git-diff-tree -p $diff_opts "$commit" | git-apply --stat --summary
 	echo
 	git-diff-tree -p $diff_opts "$commit"
-	echo "-- "
-	echo "@@GIT_VERSION@@"
 
 	echo
 }
