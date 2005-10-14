From: David Ho <davidkwho@gmail.com>
Subject: Re: git-whatchanged does not show merge result?
Date: Fri, 14 Oct 2005 12:33:51 -0400
Message-ID: <4dd15d180510140933j7a730c49hb9cdaa98ea0a5b07@mail.gmail.com>
References: <4dd15d180510140929x2c69f61ag19a1409cfd993e7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Oct 14 18:35:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQSVI-0000EL-6L
	for gcvg-git@gmane.org; Fri, 14 Oct 2005 18:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbVJNQdx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Oct 2005 12:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbVJNQdx
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Oct 2005 12:33:53 -0400
Received: from qproxy.gmail.com ([72.14.204.197]:32212 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750789AbVJNQdw convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2005 12:33:52 -0400
Received: by qproxy.gmail.com with SMTP id z1so366254qbc
        for <git@vger.kernel.org>; Fri, 14 Oct 2005 09:33:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fU1OEwPbRvV40wDfxkHqeH9BZ+C/JII230T1R7sB82r9+Ii3uZv0AcfenK8iicjGRd6e0njQfwlq+TXhnnspCa9hVK2oONw4uOOXCp3ZQfR/BL1hKuNraLcHr7Bn3pWaXOgcd5KpLywOj82cX4IWdNIAb9cXLOnUfYiV1dH43Qg=
Received: by 10.65.43.3 with SMTP id v3mr829528qbj;
        Fri, 14 Oct 2005 09:33:51 -0700 (PDT)
Received: by 10.65.35.5 with HTTP; Fri, 14 Oct 2005 09:33:51 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <4dd15d180510140929x2c69f61ag19a1409cfd993e7b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10113>

Hi,

Maybe someone can clear up a confusion I have with git-whatchanged.
I created a new repo with just one file hello, split out a new branch "mybranch.
When I merged back the changes from mybranch, git-whatchanged -p did
not should the diff of the merge.
Does it have some special behaviour I am not aware of.  I'd appreciate
if you can clarify.
Notice that git-whatchange does not show the diff between (last
commit) fd494be and 83ac91a1

Thanks, David

git version 0.99.7b

commands used (roughly to repeat the test)

mkdir git-tutorial
cd git-tutorial
git-init-db
echo "Hello World" >hello
git-update-index --add hello
echo "It's a new day for git" >>hello
echo "Initial commit" | git-commit-tree $(git-write-tree) > .git/HEAD
git -m "added It's a new day..." commit hello
git checkout -b mybranch
git checkout mybranch
echo "Work, work, work" >>hello
git commit -m 'Some work.' hello
git checkout master
echo "Play, play, play" >>hello
git commit -m 'Some fun.' hello
git pull . mybranch
vi hello (merge the change by hand...)
git -m "merge work,work,... from mybranch" commit hello

last commit
#cat .git/HEAD
fd494becb20a8d9eddad01921de1cc9fe2cbf354

output from git-whatchanged -p hello

diff-tree 83ac91a13297887760f252aa9026e76235adcdd9 (from
7a78a9c5bb38ad4db1b5c9b14c1d409b2f36c0b0)
Author:  <davidho@penguin.nanometrics.ca>
Date:   Fri Oct 14 12:02:50 2005 -0400

    Some fun.

diff --git a/hello b/hello
--- a/hello
+++ b/hello
@@ -1,2 +1,3 @@
 Hello World
 It's a new day for git
+Play, play, play

diff-tree b12ea5026dbc9ad651fcad6b44a683548fda47a7 (from
7a78a9c5bb38ad4db1b5c9b14c1d409b2f36c0b0)
Author:  <davidho@penguin.nanometrics.ca>
Date:   Fri Oct 14 12:02:22 2005 -0400

    Some work.

diff --git a/hello b/hello
--- a/hello
+++ b/hello
@@ -1,2 +1,3 @@
 Hello World
 It's a new day for git
+Work, work, work

diff-tree 7a78a9c5bb38ad4db1b5c9b14c1d409b2f36c0b0 (from
e45b23ab79bec72ba4ef0a79820a3c172751e59b)
Author:  <davidho@penguin.nanometrics.ca>
Date:   Fri Oct 14 12:00:48 2005 -0400

    Add line "It's a new day..."

diff --git a/hello b/hello
--- a/hello
+++ b/hello
@@ -1 +1,2 @@
 Hello World
+It's a new day for git
