From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH v2] git-gui: Adapt discovery of oguilib to execdir 'libexec/git-core'
Date: Mon,  4 Aug 2008 22:09:46 +0200
Message-ID: <1217880586.4897620ad4e6a@webmail.nextra.at>
References: <1217177383-25272-1-git-send-email-prohaska@zib.de> <1217177383-25272-2-git-send-email-prohaska@zib.de> <20080727212405.GA10075@spearce.org> <AF6C526A-57ED-4386-A4CF-5260D82026B7@zib.de> <1217756103.48957bc76eda2@webmail.nextra.at> <58FBF585-377C-40A7-818E-6B47F8FD2EB8@zib.de> <1217879912.48975f6809e10@webmail.nextra.at> <20080804200049.GA29485@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 04 22:12:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ6OM-0005Ol-3S
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 22:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758157AbYHDUJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 16:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755000AbYHDUJv
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 16:09:51 -0400
Received: from smtp3.srv.eunet.at ([193.154.160.89]:52516 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273AbYHDUJu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 16:09:50 -0400
Received: from webmail01.si.eunet.at (webmail01.srv.eunet.at [193.154.180.195])
	by smtp3.srv.eunet.at (Postfix) with ESMTPS id 1D24C10A716;
	Mon,  4 Aug 2008 22:09:48 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by webmail01.si.eunet.at (8.13.1/8.13.1) with ESMTP id m74K9kwo022244;
	Mon, 4 Aug 2008 22:09:47 +0200
Received: from 77.118.59.205 ([77.118.59.205]) 
	by webmail.nextra.at (IMP) with HTTP 
	for <johsixt@mbox.eunet.at>; Mon,  4 Aug 2008 22:09:46 +0200
In-Reply-To: <20080804200049.GA29485@spearce.org>
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 77.118.59.205
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91390>

The new execdir has is two levels below the root directory, while
the old execdir 'bin' was only one level below.  This commit
adapts the discovery of oguilib that uses relative paths
accordingly. We determine whether we have the extra level in the same
way in which the Makefile defines sharedir, i.e. whether the last
directory part is 'git-core'.

Inspired-by: Steffen Prohaska <prohaska@zib.de>
Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---

Zitat von "Shawn O. Pearce" <spearce@spearce.org>:
> Johannes Sixt <johannes.sixt@telecom.at> wrote:
> > +	if {[lindex [file split $oguilib] end] eq {git-core}} {
>
> Isn't that what [file tail] does?

Yes, it is. I missed it in the myriad of file's options. Here's the updated
version of the patch.

-- Hannes

 git-gui/git-gui.sh |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index fd3875a..60f376d 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -52,7 +52,11 @@ catch {rename send {}} ; # What an evil concept...
 set oguilib {@@GITGUI_LIBDIR@@}
 set oguirel {@@GITGUI_RELATIVE@@}
 if {$oguirel eq {1}} {
-	set oguilib [file dirname [file dirname [file normalize $argv0]]]
+	set oguilib [file dirname [file normalize $argv0]]
+	if {[file tail $oguilib] eq {git-core}} {
+		set oguilib [file dirname $oguilib]
+	}
+	set oguilib [file dirname $oguilib]
 	set oguilib [file join $oguilib share git-gui lib]
 	set oguimsg [file join $oguilib msgs]
 } elseif {[string match @@* $oguirel]} {
-- 
1.6.0.rc1.958.gb3893
