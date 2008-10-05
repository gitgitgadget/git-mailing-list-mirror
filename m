From: Avi Kivity <avi@redhat.com>
Subject: git rebase -i -p broken?
Date: Sun, 05 Oct 2008 17:30:06 +0200
Message-ID: <48E8DD7E.9040706@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080107000103050906020209"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 05 17:31:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmVZp-0004pq-GZ
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 17:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092AbYJEPaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 11:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754088AbYJEPaK
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 11:30:10 -0400
Received: from mx2.redhat.com ([66.187.237.31]:56126 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752477AbYJEPaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 11:30:09 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id m95FU83j007662
	for <git@vger.kernel.org>; Sun, 5 Oct 2008 11:30:08 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m95FU7D6002423;
	Sun, 5 Oct 2008 11:30:08 -0400
Received: from balrog.qumranet.com (vpn-12-25.rdu.redhat.com [10.11.12.25])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id m95FU6vZ004520;
	Sun, 5 Oct 2008 11:30:07 -0400
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97511>

This is a multi-part message in MIME format.
--------------080107000103050906020209
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Consider this scenario:
- commit some patch (named 'a')
- merge a random branch
- commit a fix to patch a
- since I haven't pushed yet, I want to squash a and a-fix together, to 
prevent bisect problems
- fire up 'git rebase -i -p a^'

Now the problems begin:
- the todo list shows up the branch's commits as well as my current 
branch.  But I don't want to commit the branch's commits in my own 
branch.  Replaying the merge should be enough.  Looks like a missing 
--first-parent somewhere.
- removing the spurious commit from the todo, and moving a-fix after a 
and marking it as a squash action, I get
   Refusing to squash a merge: 51ca22d7afb7433332ae41d0c2e3bab598048c21
  even though that's not a merge
- using git commit --amend instead of squash confuses git in some other way

Attached is a script that generates a test case.  With some $EDITOR 
hacks it can even be convinced to be an automated test case.

All this using 1.6.0.2.

-- 
error compiling committee.c: too many arguments to function


--------------080107000103050906020209
Content-Type: text/plain;
 name="rebase-merge"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="rebase-merge"

ISMvYmluL3NoIC1lCgpnaXQgLS12ZXJzaW9uCm1rZGlyIHJlcG8KY2QgcmVwbwpnaXQgaW5p
dAp0b3VjaCBhCnRvdWNoIDAKZ2l0IGFkZCAwCmdpdCBjb21taXQgLW0gJ3plcm90aCBjb21t
aXQnCmdpdCBhZGQgYQpnaXQgY29tbWl0IC1tICdmaXJzdCBjb21taXQnCmdpdCBjaGVja291
dCAtYiBicmFuY2gKdG91Y2ggYgpnaXQgYWRkIGIKZ2l0IGNvbW1pdCAtbSAnc2Vjb25kIGNv
bW1pdCAoYnJhbmNoKScKZ2l0IGNoZWNrb3V0IG1hc3Rlcgp0b3VjaCBjCmdpdCBhZGQgYwpn
aXQgY29tbWl0IC1tICd0aGlyZCBjb21taXQnCmdpdCBtZXJnZSBicmFuY2gKdG91Y2ggZApn
aXQgYWRkIGQKZ2l0IGNvbW1pdCAtbSAnZmlmdGggY29tbWl0JwpnaXQgcmViYXNlIC1pIC1w
IEhFQUR+NA==
--------------080107000103050906020209--
