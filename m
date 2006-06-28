From: Pavel Roskin <proski@gnu.org>
Subject: Re: Quick merge status updates.
Date: Wed, 28 Jun 2006 06:05:03 -0400
Message-ID: <1151489103.28036.6.camel@dv>
References: <7vodwe5dr8.fsf@assigned-by-dhcp.cox.net>
	 <1151471040.4940.17.camel@dv>  <7v7j3164xd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 12:05:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvWv2-0000Ie-CT
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 12:05:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423254AbWF1KFI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 06:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423255AbWF1KFI
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 06:05:08 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:10627 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1423254AbWF1KFG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 06:05:06 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FvWuv-0007rM-KN
	for git@vger.kernel.org; Wed, 28 Jun 2006 06:05:05 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FvWut-0000QI-SN; Wed, 28 Jun 2006 06:05:03 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j3164xd.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.7.3 (2.7.3-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22797>

On Wed, 2006-06-28 at 01:49 -0700, Junio C Hamano wrote:

> I suspect this is either FC perl-dev package is broken (I doubt
> it) or your installation procedure is pecurilar (much more
> likely).  I pass the same set of prefix, bindir and friends to
> "make" and "make install" and do not see the problem.

I think my Perl 5.8.8 is "too new".  "man perlfunc" says about "use":

"Imports some semantics into the current package from the named module,
generally by aliasing certain subroutine or variable names into your
package.  It is exactly equivalent to

      BEGIN { require Module; import Module LIST; }

except that Module must be a bareword."

I think the BEGIN block has priority over other statements.  My solution
was to put the @INC change in the BEGIN block as well.

This patch is working for me:

diff --git a/git-fmt-merge-msg.perl b/git-fmt-merge-msg.perl
index e8fad02..1b23fa1 100755
--- a/git-fmt-merge-msg.perl
+++ b/git-fmt-merge-msg.perl
@@ -5,7 +5,7 @@ #
 # Read .git/FETCH_HEAD and make a human readable merge message
 # by grouping branches and tags together to form a single line.
 
-unshift @INC, '@@INSTLIBDIR@@';
+BEGIN { unshift @INC, '@@INSTLIBDIR@@'; }
 use strict;
 use Git;
 use Error qw(:try);


-- 
Regards,
Pavel Roskin
