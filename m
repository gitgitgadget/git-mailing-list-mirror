From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH/RFC] Make git-completion.bash a first-class citizen
Date: Fri, 8 Feb 2008 14:06:32 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802081405280.11591@racer.site>
References: <9b3e2dc20802061152q63bc61acuaecf3f33d4df8b19@mail.gmail.com> <200802062314.39440.robin.rosenberg.lists@dewire.com> <7vodatu37m.fsf@gitster.siamese.dyndns.org> <200802070123.43109.robin.rosenberg.lists@dewire.com> <20080207063412.GQ24004@spearce.org>
 <F19A1227-3803-4C23-BEA2-26F23824ACF5@zib.de> <alpine.LSU.1.00.0802081224210.11591@racer.site> <E3983D26-5DAC-48CE-A261-7C424FCB2D64@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Stephen Sinclair <radarsat1@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Feb 08 15:07:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNTsp-0007a2-SK
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 15:07:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755918AbYBHOG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 09:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754897AbYBHOG1
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 09:06:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:47245 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752133AbYBHOG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 09:06:26 -0500
Received: (qmail invoked by alias); 08 Feb 2008 14:06:24 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 08 Feb 2008 15:06:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18lwoBXP9sltizoOobxamt47aTxWkDxs6j5VxkGOH
	MtFlFDNU/ULhgc
X-X-Sender: gene099@racer.site
In-Reply-To: <E3983D26-5DAC-48CE-A261-7C424FCB2D64@zib.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73091>


This moves git-completion.bash out of contrib/, and installs it to
$sharedir/git-completion/

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Fri, 8 Feb 2008, Steffen Prohaska wrote:
	
	> On Feb 8, 2008, at 1:25 PM, Johannes Schindelin wrote:
	> 
	> > On Fri, 8 Feb 2008, Steffen Prohaska wrote:
	> > 
	> > > This improved prompt is great.  I already miss it each time 
	> > > I switch back from next to master.
	> > 
	> > Maybe we (as in msysgit) should install the 
	> > git-completion.bash script into /share/git-core/?
	> 
	> Yes.

	How about this?

 Makefile                                           |    4 ++++
 .../git-completion.bash => git-completion.bash     |    0 
 2 files changed, 4 insertions(+), 0 deletions(-)
 rename contrib/completion/git-completion.bash => git-completion.bash (100%)

diff --git a/Makefile b/Makefile
index de8c752..77efc3f 100644
--- a/Makefile
+++ b/Makefile
@@ -168,6 +168,7 @@ gitexecdir = $(bindir)
 sharedir = $(prefix)/share
 template_dir = $(sharedir)/git-core/templates
 htmldir=$(sharedir)/doc/git-doc
+completiondir = $(sharedir)/git-completion
 ifeq ($(prefix),/usr)
 sysconfdir = /etc
 else
@@ -784,6 +785,7 @@ bindir_SQ = $(subst ','\'',$(bindir))
 mandir_SQ = $(subst ','\'',$(mandir))
 infodir_SQ = $(subst ','\'',$(infodir))
 gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
+completiondir_SQ = $(subst ','\'',$(completiondir))
 template_dir_SQ = $(subst ','\'',$(template_dir))
 htmldir_SQ = $(subst ','\'',$(htmldir))
 prefix_SQ = $(subst ','\'',$(prefix))
@@ -1067,6 +1069,8 @@ install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(INSTALL) git$X '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(completiondir_SQ)'
+	$(INSTALL) git-completion.bash '$(DESTDIR_SQ)$(completiondir_SQ)'
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
 	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
 ifndef NO_TCLTK
diff --git a/contrib/completion/git-completion.bash b/git-completion.bash
similarity index 100%
rename from contrib/completion/git-completion.bash
rename to git-completion.bash
-- 
1.5.4.1261.g18335
