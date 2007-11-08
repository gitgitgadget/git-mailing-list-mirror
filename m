From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] hooks--update: fix test for properly set up project description file
Date: Thu, 8 Nov 2007 14:02:00 +0000
Message-ID: <20071108140200.24902.qmail@f23d7e396b1523.315fe32.mid.smarden.org>
References: <20071106134749.24233.qmail@809f27f669039a.315fe32.mid.smarden.org> <4730726B.1000407@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Nov 08 15:03:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq7y3-0006DX-VS
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 15:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758104AbXKHOBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 09:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756982AbXKHOBm
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 09:01:42 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:48871 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756016AbXKHOBl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 09:01:41 -0500
Received: (qmail 24906 invoked by uid 1000); 8 Nov 2007 14:02:00 -0000
Content-Disposition: inline
In-Reply-To: <4730726B.1000407@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64023>

The update hook template intends to abort if the project description file
hasn't been adjusted or is empty.  This patch fixes the check for 'being
adjusted'.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---

On Tue, Nov 06, 2007 at 02:55:55PM +0100, Andreas Ericsson wrote:
> Gerrit Pape wrote:
> > # check for no description
> >-projectdesc=$(sed -e '1p' "$GIT_DIR/description")
> >-if [ -z "$projectdesc" -o "$projectdesc" = "Unnamed repository; edit
> >this
> >file to name it for gitweb" ]; then
> >+projectdesc=$(sed -ne '1p' "$GIT_DIR/description")
>
> Write this as
>       projectdesc=$(sed -e 1q "$GIT_DIR/description")
> instead. It's a little shorter, a little faster and slightly more
> portable.

I made it $(head -n 1 ...).


 templates/hooks--update |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/templates/hooks--update b/templates/hooks--update
index d8c7626..fbf664f 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -34,8 +34,8 @@ fi
 allowunannotated=$(git-repo-config --bool hooks.allowunannotated)
 
 # check for no description
-projectdesc=$(sed -e '1p' "$GIT_DIR/description")
-if [ -z "$projectdesc" -o "$projectdesc" = "Unnamed repository; edit this file to name it for gitweb" ]; then
+projectdesc=$(head -n 1 "$GIT_DIR/description")
+if [ -z "$projectdesc" -o "$projectdesc" = "Unnamed repository; edit this file to name it for gitweb." ]; then
 	echo "*** Project description file hasn't been set" >&2
 	exit 1
 fi
-- 
1.5.3.5
