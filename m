From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] post-receive-email hook: handle order of arguments consistently
Date: Tue, 7 Aug 2007 13:58:49 +0000
Message-ID: <20070807135849.24926.qmail@49810ee852ce6e.315fe32.mid.smarden.org>
References: <20070614090929.31616.qmail@c76df6d65db410.315fe32.mid.smarden.org> <200706141119.18724.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 15:58:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIPa2-0002v0-R2
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 15:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760582AbXHGN6a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 09:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758310AbXHGN6a
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 09:58:30 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:46952 "HELO a.mx.smarden.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with SMTP
	id S1760175AbXHGN63 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 09:58:29 -0400
Received: (qmail 24927 invoked by uid 1000); 7 Aug 2007 13:58:49 -0000
Mail-Followup-To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <200706141119.18724.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55258>

The post-receive-email hook usually gets its arguments through stdin,
but also supports them to be specified at the command line.  The order
of the arguments should consistently follow the documentation no matter
how they are passed to the script.

This was noticed and suggested by martin f krafft through
 http://bugs.debian.org/428413

Signed-off-by: Gerrit Pape <pape@smarden.org>
---

On Thu, Jun 14, 2007 at 11:19:17AM +0100, Andy Parkins wrote:
> On Thursday 2007 June 14, Gerrit Pape wrote:
> > The post-receive-email hook usually gets its arguments through stdin, but
> > also supports them to be specified at the command line.  The order of the
> > arguments should consistently follow the documentation no matter how they
> > are passed to the script.
> 
> That wasn't done casually.  It was done so that the same script would work as 
> an update hook as well.
> 
> I have no objection to the change, as the update hook was not the right place 
> for generating emails.  However, it let me use that same update hook on a 
> system that did not have a git with support for the post-receive hook.

Hi, I suggest to apply this patch for 1.5.3.  Thanks, Gerrit.


 contrib/hooks/post-receive-email |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index c589a39..f84532f 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -605,7 +605,7 @@ envelopesender=$(git-repo-config hooks.envelopesender)
 if [ -n "$1" -a -n "$2" -a -n "$3" ]; then
 	# Output to the terminal in command line mode - if someone wanted to
 	# resend an email; they could redirect the output to sendmail themselves
-	PAGER= generate_email $2 $3 $1
+	PAGER= generate_email $1 $2 $3
 else
 	if [ -n "$envelopesender" ]; then
 		envelopesender="-f '$envelopesender'"
-- 
1.5.3.GIT
