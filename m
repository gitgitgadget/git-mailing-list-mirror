From: Paul Mackerras <paulus@samba.org>
Subject: Re: .gitk should created hidden in windows
Date: Mon, 23 Mar 2009 21:37:51 +1100
Message-ID: <18887.26239.115820.450313@cargo.ozlabs.ibm.com>
References: <49BFA97A.1030203@lanwin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steve Wagner <lists@lanwin.de>
X-From: git-owner@vger.kernel.org Mon Mar 23 12:03:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llhvi-0004uR-4o
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 12:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757243AbZCWLAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 07:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754377AbZCWLAI
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 07:00:08 -0400
Received: from bilbo.ozlabs.org ([203.10.76.25]:44351 "EHLO bilbo.ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757243AbZCWLAC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 07:00:02 -0400
Received: by bilbo.ozlabs.org (Postfix, from userid 1003)
	id 895E7B7066; Mon, 23 Mar 2009 22:00:00 +1100 (EST)
In-Reply-To: <49BFA97A.1030203@lanwin.de>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114288>

Steve Wagner writes:

> The problem is that windows dose not hides files beginning with a dot as
> it is in unix. So the .gitk file is created as visible in the windows
> user profile. Problematic too is that i can no set the hidden attribute
> to this file, because it is recreated every time i start gitk, so the
> hidden attribute gets lost.
> 
> Can you control this and create the file with the hidden attribute on
> windows?

Please try this patch and let me know if it does what you want.

Paul.

diff --git a/gitk b/gitk
index d7de27e..54f3f2b 100755
--- a/gitk
+++ b/gitk
@@ -2487,6 +2487,9 @@ proc savestuff {w} {
     if {![winfo viewable .]} return
     catch {
 	set f [open "~/.gitk-new" w]
+	if {$::tcl_platform(platform) eq {windows}} {
+	    file attributes "~/.gitk-new" -hidden true
+	}
 	puts $f [list set mainfont $mainfont]
 	puts $f [list set textfont $textfont]
 	puts $f [list set uifont $uifont]
