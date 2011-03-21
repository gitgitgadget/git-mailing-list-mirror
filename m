From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: cherry-pick applies some other changes than the specified one?
Date: Mon, 21 Mar 2011 10:27:52 +0100
Message-ID: <AANLkTikE5AqJyShN+GfFYe0kBS=ShGnKQcnwbarNZrjm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 21 10:28:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1bP3-0004pR-Se
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 10:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444Ab1CUJ1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 05:27:54 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34519 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab1CUJ1w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 05:27:52 -0400
Received: by vws1 with SMTP id 1so5032222vws.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 02:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=6CwGPwkJgGQWz5Pz1m8PD2lpEiY3HIPD4+mw7tNdNFg=;
        b=sDCfqyhZps+XdxX+P3Yz6F4XpF39XO7bNQA+657W2arQPwMNsUlcafzY9dIofNGnkV
         adIWYvsndS63cXAsyxX54Zhob9IYJfxfFlJiPDYTfqh7mJyIw6mc8NYLg9gsiuy+4XxV
         mt/qNPr5SvSRXQ9b9GU4w5GwVUE5NbXVdBwpY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=DXnHjYu8D/byAigofDyoA1iJ30qtUfJqqnpOJGrxWyJWD1dlUI/DiPPnNftuOguv+n
         GPHTYxpayFuFznQcjmz1cwAICoKJe7naNFUuRuh8RBzwPo6q8K9Tj6Y+m1JxxZQ8qs/p
         4h/wknN7XnhJVepm6L80tNtS/Xy8BsGwLReEg=
Received: by 10.52.95.135 with SMTP id dk7mr5608746vdb.93.1300699672215; Mon,
 21 Mar 2011 02:27:52 -0700 (PDT)
Received: by 10.220.210.16 with HTTP; Mon, 21 Mar 2011 02:27:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169565>

Hi,

I'm cherry-picking one commint between branches. The commit is a simple
one-line addition, something like:

--- a/etc/file
+++ b/etc/file
@@ -2613,6 +2613,7 @@
line1
line2
+   line3
line4
line5


There's a conflict during the cherry-pick. git status shows:

$ git status
# On branch 9_0
# Unmerged paths:
#   (use "git add/rm <file>..." as appropriate to mark resolution)
#
#	both modified:      etc/file
#
no changes added to commit (use "git add" and/or "git commit -a")

git diff shows a lot of changes:

diff --cc etc/file
index 815c28f,b8a48da..0000000
--- a/etc/file
+++ b/etc/file
@@@ -2700,83 -2611,10 +2700,89 @@@
[...]
++<<<<<<< HEAD
 +    line
 +    line
[...]
++=======
+     here I basically can see what's code
+     look like in the commit I want to merge
++>>>>>>> c64e8ca...
       line
 +    line
[...]


If I edit the file and remove the "<<<< HEAD" marked and code
between "===" and ">>>"  then

1. git status shows there are unmerged files:

$ git status
# On branch 9_0
# Unmerged paths:
#   (use "git add/rm <file>..." as appropriate to mark resolution)
#
#	both modified:      etc/file
#
no changes added to commit (use "git add" and/or "git commit -a")

2. git diff shows nothing:

$ git diff
diff --cc etc/file
index 815c28f,b8a48da..0000000
--- a/etc/file
+++ b/etc/file

3. git diff --cached shows error? warning? info?

$ git diff --cached
* Unmerged path etc/file

4. When I git add the file then git status, git diff, git diff
--cached shows nothing:

$ git add etc/file
$ git status
# On branch 9_0
nothing to commit (working directory clean)
$ git diff
$ git diff --cached


But when I take a different approach, and in addition to this:

> If I edit the file and remove the "<<<< HEAD" marked and code
> between "===" and ">>>"  then

I also manually add the "+line" which is the change done in the cherry-picked
commit, git diff shows a lot of other changes in unrelated lines
(which lie close
but still were not modified by the patch, nor were shown previously by
git diff).


This is very weird. I understand the information I provided was very scarce,
but does anyone know what could be happening?
Or do I have to try to reproduce this behaviour and post the steps to do so?

It might be somehow related to git-svn or git-new-workdir ...

-- 
Piotr Krukowiecki
