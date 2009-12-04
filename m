From: Jindrich Makovicka <makovick@gmail.com>
Subject: [PATCH] git-gui: suppress the X error on exit
Date: Fri, 4 Dec 2009 10:28:44 +0100
Message-ID: <20091204102844.3c720b21@starbug.prg01.itonis.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 04 10:35:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGUZP-0003bW-5r
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 10:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485AbZLDJfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 04:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752869AbZLDJfE
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 04:35:04 -0500
Received: from lo.gmane.org ([80.91.229.12]:36148 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752028AbZLDJfD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 04:35:03 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NGUZ6-0003SO-8I
	for git@vger.kernel.org; Fri, 04 Dec 2009 10:35:04 +0100
Received: from 193.239.0.25 ([193.239.0.25])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Dec 2009 10:35:04 +0100
Received: from makovick by 193.239.0.25 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Dec 2009 10:35:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 193.239.0.25
X-Newsreader: Claws Mail 3.7.3 (GTK+ 2.18.3; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134502>

Hi,

Due to a bug in Tk, git-gui almost always (unless git-gui is closed
right after starting) produces an X window error message on exit,
something like

X Error of failed request:  RenderBadPicture (invalid Picture parameter)
  Major opcode of failed request:  150 (RENDER)
  Minor opcode of failed request:  7 (RenderFreePicture)
  Picture id in failed request: 0x3a000dc
  Serial number of failed request:  1965
  Current serial number in output stream:  1980

Respective Tk bug report is here:

http://sourceforge.net/tracker/?func=detail&atid=112997&aid=1821174&group_id=12997

This bug is triggered only when the send command is blocked via
rename send {} . The following patch re-enables send just
before quiting git-gui to suppress the error.

--- git-gui~	2009-11-17 23:28:30.000000000 +0100
+++ git-gui	2009-12-03 23:32:50.848588924 +0100
@@ -2023,6 +2023,10 @@
 	}
 
 	set ret_code $rc
+
+	# briefly re-enable send to suppress the RenderBadPicture error
+	tk appname [appname]
+
 	destroy .
 }
 
