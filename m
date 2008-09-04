From: Pedro Melo <melo@simplicidade.org>
Subject: Failed expectations or bug?
Date: Thu, 4 Sep 2008 10:49:57 +0100
Message-ID: <EA0C3F3E-0DA8-49A7-8151-5A2EC6C7BEEA@simplicidade.org>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 11:51:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbBUd-0005Cp-GX
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 11:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754287AbYIDJuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 05:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754062AbYIDJuE
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 05:50:04 -0400
Received: from mail.sl.pt ([212.55.140.13]:60400 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751892AbYIDJuB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 05:50:01 -0400
Received: (qmail 23368 invoked from network); 4 Sep 2008 09:49:57 -0000
Received: from unknown (HELO [10.0.0.202]) (melo@[195.23.56.102])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 4 Sep 2008 09:49:57 -0000
Jabber-Id: melo@simplicidade.org
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94917>

Hi,

I was learning about git rename detection and came across a unexpected  
result. See the following sequence:

$ mkdir /tmp/test-git
$ cd /tmp/test-git/
$ git init
Initialized empty Git repository in /private/tmp/test-git/.git/
$ git config diff.renames copies
$ echo a >> a
$ echo b >> a
$ echo c >> a
$ echo d >> a
$ git add a ; git commit -m 'added a'
Created initial commit a90001f: added a
  1 files changed, 4 insertions(+), 0 deletions(-)
  create mode 100644 a
$ git checkout -b t
Switched to a new branch "t"
$ git mv a b
$ git commit -m 'moved a to b'
Created commit 5f11e2f: moved a to b
  1 files changed, 0 insertions(+), 0 deletions(-)
  rename a => b (100%)
$ cp b c
$ git add c
$ git commit -m 'added c'
Created commit 8bf67c0: added c
  1 files changed, 4 insertions(+), 0 deletions(-)
  create mode 100644 c
$ git checkout master
Switched to branch "master"
$ perl -pi -e 's/d/D/' a
$ git add a
$ git commit -m 'd is now D'
Created commit c082684: d is now D
  1 files changed, 1 insertions(+), 1 deletions(-)
$ git merge t
Merge made by recursive.
  a => b|    2 +-
  a => c|    0
  2 files changed, 1 insertions(+), 1 deletions(-)[m
  copy a => b (75%)
  rename a => c (100%)
$ ls
b	c
$ cat b
a
b
c
d
$ cat c
a
b
c
D


Maybe I have the wrong expectations, but after the merge I was  
expecting either:

  * b and c have the same content, with the modified D;
  * b has the modifications made in master, and c has the original  
content.

I did not expect the patch to 'a' in master to propagate across the  
copy to c.

What am I doing wrong here?

Thanks,
-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
