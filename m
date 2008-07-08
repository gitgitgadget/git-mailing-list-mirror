From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: git-rebase eats empty commits
Date: Tue, 08 Jul 2008 15:59:16 +0200
Message-ID: <g4vrrm$g35$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050803030603030107090109"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 16:00:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGDk8-0001hw-7R
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 16:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbYGHN7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 09:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752701AbYGHN7e
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 09:59:34 -0400
Received: from main.gmane.org ([80.91.229.2]:54747 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752983AbYGHN7d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 09:59:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KGDj3-0000lT-A7
	for git@vger.kernel.org; Tue, 08 Jul 2008 13:59:25 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 13:59:25 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 13:59:25 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87765>

This is a multi-part message in MIME format.
--------------050803030603030107090109
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

"git commit" allows empty commits with the "--allow-empty" option, i.e. 
commits which introduce no change at all. This is sometimes useful for 
keeping a log of untracked work related to tracked content.

"git rebase" removes empty commits, for the good reason that rebasing 
may make certain commits obsolete; but I don't want that in the case 
mentioned above. Is there any way to specify "--preserve-empty" or similar?

The attached script and log show the effect: a series A B C D of commits 
is rebased onto A'; the result is A' C', with the empty commits B and D 
disappearing.

grafts and filter-branch helped me solve a particular case of that 
effect, but I think it will show up again, so an option for rebase would 
be useful.

Michael

P.S.: I also noticed that 'Switched to a new branch "temp"' is written 
to stderr, everything else to stdout. Is that as intended?

--------------050803030603030107090109
Content-Type: text/x-log;
 name="empty.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="empty.log"

Initialized empty Git repository in /tmp/mjg/t/empty/.git/
Created initial commit b3104c1: 1
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 a
Created commit 7265e0c: empty 1
Created commit 9b67221: 2
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 b
Created commit 0778af2: empty 2
0778af2a5003df310cb9dc3c4fff1f8992619610 empty 2
9b67221a363103ebc78fc052c382637a87ef04e6 2
7265e0c1a35c95bd6fcf739a9f815b300ba9d9cc empty 1
b3104c148e1dd6ce8fd23cddb71734e45e7d9132 1
Switched to a new branch "temp"
Created commit d9ad4bc: rewritten 1
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 a
First, rewinding head to replay your work on top of it...
Applying 2
d81ec616edd3ed600a60dbd63d4d0f4a7263387f 2
d9ad4bcd2fb5e78f2f430733f2dc36453a653221 rewritten 1

--------------050803030603030107090109
Content-Type: application/x-shellscript;
 name="empty.sh"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="empty.sh"

IyEvYmluL3NoCnJtIC1SZiBlbXB0eQpta2RpciBlbXB0eQpjZCBlbXB0eQpnaXQgaW5pdApl
Y2hvIDEgPiBhCmdpdCBhZGQgYQpnaXQgY29tbWl0IC1tIDEKZ2l0IHRhZyByZXdyaXRlCmdp
dCBjb21taXQgLS1hbGxvdy1lbXB0eSAtbSAiZW1wdHkgMSIKZWNobyAyID4gYgpnaXQgYWRk
IGIKZ2l0IGNvbW1pdCAtbSAyCmdpdCBjb21taXQgLS1hbGxvdy1lbXB0eSAtbSAiZW1wdHkg
MiIKZ2l0IGxvZyAtLXByZXR0eT1vbmVsaW5lCiNub3cgcmViYXNlCmdpdCBjaGVja291dCAt
YiB0ZW1wIHJld3JpdGUKZWNobyBvbmUgPiBhCmdpdCBjb21taXQgLS1hbWVuZCAtYSAtbSAi
cmV3cml0dGVuIDEiCmdpdCByZWJhc2UgLS1vbnRvIHRlbXAgcmV3cml0ZSBtYXN0ZXIKZ2l0
IGxvZyAtLXByZXR0eT1vbmVsaW5lCg==
--------------050803030603030107090109--
