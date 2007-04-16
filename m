From: "Theodore Ts'o" <tytso@mit.edu>
Subject: git-receive-pack doesn't understand objects/info/alternates?
Date: Mon, 16 Apr 2007 08:22:13 -0400
Message-ID: <E1HdQDl-0005ia-Bn@candygram.thunk.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 14:22:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdQEC-0006Wc-N4
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 14:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030501AbXDPMWW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 08:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbXDPMWW
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 08:22:22 -0400
Received: from thunk.org ([69.25.196.29]:37536 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030501AbXDPMWV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 08:22:21 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HdQKF-0007Te-Ou; Mon, 16 Apr 2007 08:28:56 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HdQDl-0005ia-Bn; Mon, 16 Apr 2007 08:22:13 -0400
Full-Name: Theodore Ts'o
Phone: (781) 391-3464
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44641>


When I push a kernel repository to master.kernel.org, where the
repository only has at most a dozen changes on top of 2.6.21-rc7, I
noticed that it tried to push a *lot* of objects over ssh.  As in:

% git push master
updating 'refs/heads/master'
  from 5a8f676142f0c4714c7820793f58a63d33bf4c2a
  to   e8bea23a40138e4958728dc06b00e9a730456b68
updating 'refs/heads/2.6.21-rc7-ext4-1'
  from 0000000000000000000000000000000000000000
  to   e8bea23a40138e4958728dc06b00e9a730456b68
Generating pack...
Done counting 49509 objects.
Result has 42471 objects.
Deltifying 42471 objects.
 100% (42471/42471) done
Writing 42471 objects.
   9% (3823/42471) done

Ouch.  This problem seems to occur locally as well, but I had always
ignored it since it wasn't that annoying, and I could always do a "git
gc --prune" to get rid of the mess afterwards.  It seems that
git-receive-pack isn't communicating the fact that there's no need to
send objects that can be referenced via the alternates file.

Am I doing something wrong?  Is there a better way of dealing with this
situation?  At this point I'm thinking scp'ing over the 252k pack file,
installing it in my git tree on master.kernel.org, and then running "git
gc --prune".  Is there a better way?

						- Ted
