From: Eric Lesh <eclesh@ucla.edu>
Subject: .gitlink for Summer of Code
Date: Sun, 25 Mar 2007 05:30:38 -0700
Message-ID: <1174825838.12540.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 25 14:38:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVRzr-0004QI-1Z
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 14:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503AbXCYMiw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 08:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753506AbXCYMiw
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 08:38:52 -0400
Received: from smtp-5.smtp.ucla.edu ([169.232.47.137]:58842 "EHLO
	smtp-5.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503AbXCYMiv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 08:38:51 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Mar 2007 08:38:50 EDT
Received: from mail.ucla.edu (mail.ucla.edu [169.232.47.145])
	by smtp-5.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l2PCUfXv020013
	for <git@vger.kernel.org>; Sun, 25 Mar 2007 05:30:41 -0700
Received: from [192.168.1.7] (adsl-75-26-170-64.dsl.scrm01.sbcglobal.net [75.26.170.64])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l2PCUesN028794
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Sun, 25 Mar 2007 05:30:40 -0700
X-Mailer: Evolution 2.8.1 
X-Probable-Spam: no
X-Scanned-By: smtp.ucla.edu on 169.232.47.137
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43054>

I would like to tackle .gitlink for Summer of Code.  The deadline is
about a day away, but this is a chance to make sure you still think
.gitlink is a good idea, and to see if there are any big problems with
the idea in general (before a more detailed proposal is actually submitted).

.gitlink is for a lightweight checkout of a branch into a separate
directory on the local filesystem.  A .gitlink'ed checkout has its own
index+HEAD, but otherwise refers back to the main repository for
objects, refs, etc.

Junio has said (http://www.spinics.net/lists/git/msg24964.html) he
works in a similar way with many work trees which are symlinked to his
main repo:
: gitster git.wk0; ls -l .git/
total 120
drwxrwsr-x  3 junio src  4096 Mar  5 16:22 ./
drwxrwsr-x 15 junio src 16384 Mar  5 16:23 ../
-rw-rw-r--  1 junio src    41 Mar  5 16:22 HEAD
lrwxrwxrwx  1 junio src    27 Mar  3 22:53 config -> /src/git/.git/config
lrwxrwxrwx  1 junio src    26 Mar  3 22:53 hooks -> /src/git/.git/hooks/
-rw-rw-r--  1 junio src 82455 Mar  5 16:22 index
lrwxrwxrwx  1 junio src    25 Mar  3 22:53 info -> /src/git/.git/info/
drwxrwsr-x  3 junio src  4096 Mar  3 22:59 logs/
lrwxrwxrwx  1 junio src    28 Mar  3 22:53 objects -> /src/git/.git/objects/
lrwxrwxrwx  1 junio src    32 Mar  3 22:53 packed-refs -> /src/git/.git/packed-refs
lrwxrwxrwx  1 junio src    25 Mar  3 22:53 refs -> /src/git/.git/refs/
lrwxrwxrwx  1 junio src    28 Mar  3 22:53 remotes -> /src/git/.git/remotes/
lrwxrwxrwx  1 junio src    29 Mar  3 22:53 rr-cache -> /src/git/.git/rr-cache/

A .gitlink could simplify this, ridding the directory of symlinks and
instead having a .gitlink file that specifies a $GIT_DIR to which
everything refers.

My implementation will be based on Josef Weidendorfer's "[RFC]
Lightweight checkouts via ".gitlink""
(http://thread.gmane.org/gmane.comp.version-control.git/33755), which
didn't receive much objection (or comment at all).  Hopefully this
doesn't mean you simply aren't interested.

Goals:
  o Lightweight checkouts are essentially branches that reside outside of the
    main repository on the local filesystem.
  o They act as normal git checkouts (i.e. git tools know about .gitlink)
  o They can be moved around and maintain their link to the base repo
  o They can exist within other checkouts (for eventual submodule support)
  o git-clone --light-weight option to set this up
  o porcelains (i.e. cogito) don't barf

Is this something that you would like to see?  Any other comments?

Thanks,

Eric
