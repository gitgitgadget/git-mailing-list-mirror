From: Thomas Rast <trast@inf.ethz.ch>
Subject: git-status does not propagate -uall to submodules
Date: Fri, 17 Feb 2012 10:18:57 +0100
Message-ID: <874nupq0la.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Jens Lehmann <Jens.Lehmann@web.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 17 10:19:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyJyH-0000ec-Ng
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 10:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730Ab2BQJTC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 04:19:02 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:30647 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751533Ab2BQJTA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 04:19:00 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 17 Feb
 2012 10:18:54 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 17 Feb
 2012 10:18:58 +0100
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190942>

Hi,

While helping with the submodule display on #git I noticed that if you
have a submodule with status.showuntrackedfiles=no, and run 'git status
-uall' from the superproject, then this does not propagate into the
submodule's status.  In code:

  $ (cd bar && git config status.showuntrackedfiles)                  
  no                                                                                                 
  $ git ls-files -s                                                   
  100644 926c01b7259c489a422442a8dc5cb5ea7c58f60c 0       .gitmodules                                
  160000 eb5af46e1a938d064c9f7bae9561013654a43316 0       bar                                        
  $ (cd bar && git status -s -unormal)
  ?? otheruntracked                                                                                  
  ?? untracked
  $ git status
  # On branch master
  nothing to commit (working directory clean)

So far that's expected; after all the submodule is configured not to
display untracked files.  But with -uall:

  $ git status -uall
  # On branch master
  nothing to commit (working directory clean)

Shouldn't the -uall propagate, since the user is explicitly asking for
it?  That is, the display should summarize what git-status *with the
same arguments* would show inside the submodules?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
