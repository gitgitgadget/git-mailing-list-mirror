From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: cg-commit path handling problem
Date: Thu, 4 May 2006 17:12:35 +0200
Message-ID: <p04320440c07fca04afea@[192.168.40.11]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
X-From: git-owner@vger.kernel.org Thu May 04 17:12:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbfVV-0002if-1A
	for gcvg-git@gmane.org; Thu, 04 May 2006 17:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWEDPMl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 11:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWEDPMk
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 11:12:40 -0400
Received: from ethlife-b.ethz.ch ([129.132.202.8]:3968 "HELO ethlife.ethz.ch")
	by vger.kernel.org with SMTP id S1751500AbWEDPMk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 May 2006 11:12:40 -0400
Received: (qmail 2212 invoked from network); 4 May 2006 15:12:38 -0000
Received: from unknown (HELO ?192.168.40.11?) (127.0.0.1)
  by localhost with SMTP; 4 May 2006 15:12:38 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19570>

Hello

I did create a repository from a directory containing, amongst other 
stuff, files starting with a $ sign. E.g.

$ find
./foo
./bar
./var/cache
./var/cache/$foo
./var/cache/$foo::bar
./var/cache/$baz

$ cg-init
...

Now I realized that I didn't want the var directory in the repository and did

$ cg-rm -r var
$ cg-commit var

which worked without warning, but:

$ cg-status
..
D var/cache/$foo
D var/cache/$foo::bar
D var/cache/$baz

So I try again:

$ cg-commit var

will open the editor with the $.. files in the CG: part, I enter a 
commit message, exit the editor, it sayys "Refusing to make an empty 
commit".

$ cg-commit -f var

says "committed as ....", but cg-status will still show the same files as D

As per suggestion from #git, I did the equivalent of

find var -name '$*' |xargs git commit -m please_go_away --

which worked.

So I guess that the cg-commit shell script isn't protecting file 
paths against variable substitution somewhere.

This is cogito-0.17.2 and git 1.2.6 (from Debian unstable rebuilt on Sarge).

Thanks for caring,
Christian.
