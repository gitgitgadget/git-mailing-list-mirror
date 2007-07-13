From: Wincent Colaiuta <win@wincent.com>
Subject: Possible to make a totally empty repository for remote access?
Date: Fri, 13 Jul 2007 23:41:29 +0200
Message-ID: <54C69B03-C589-480E-80D3-75166DBF2D29@wincent.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 23:42:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9Sti-000471-AL
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 23:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755217AbXGMVlx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 17:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755197AbXGMVlx
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 17:41:53 -0400
Received: from wincent.com ([72.3.236.74]:46429 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755070AbXGMVlw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 17:41:52 -0400
Received: from [192.168.1.99] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l6DLfleF003111
	for <git@vger.kernel.org>; Fri, 13 Jul 2007 16:41:50 -0500
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52415>

For a new project (no code yet) I wanted to make an empty, bare  
repository (no working copy) on a remote public server as a starting  
point, clone it locally, and gradually create content locally and  
push it out to the remote, public server.

But so far I've been unable to do so in a straightfoward fashion...

mkdir test.git
cd test.git
git --bare init
touch git-daemon-export-ok

If I try to clone such an empty repository I get:

fatal: no matching remote head

And GIT_DIR/HEAD points to refs/heads/master, which doesn't exist yet.

Same if I go for a non-bare, but still empty repository:

mkdir test
cd test
git init
touch .git/git-daemon-export-ok

Only after adding actual content can I clone without getting the "no  
matching remote head" error:

echo "foo" > bar
git add bar
git commit -m "foobar"

Then cloning works.

I understand that Git is a *content* manager and a totally empty  
repository has no content, and therefore no tree object which the  
HEAD can point to. But the trouble with adding content the way I  
describe above, is that my public repository is no longer bare; it  
now has a working copy, which I didn't really want.

What's the way around this? Do I start with a non-bare repository,  
add any old bogus content, and then convert it to bare and blow away  
the working copy?

mkdir test
cd test
git init
touch .git/git-daemon-export-ok
touch .gitignore
git add .gitignore
git commit -m "Initial empty repository containing only an  
empty .gitignore file"
git config core.bare true
mv .git ../test.git
cd ..
rm -r test

Is there a better way? Am I missing something obvious?

Cheers,
Wincent
