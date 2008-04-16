From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: crlf with git-svn driving me nuts...
Date: Wed, 16 Apr 2008 20:10:26 +0100
Message-ID: <320075ff0804161210m46f3e83bpf7bf9d1d5816d914@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 16 21:25:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmD2L-00029K-Ox
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 21:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbYDPTKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 15:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbYDPTKc
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 15:10:32 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:35191 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbYDPTKb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 15:10:31 -0400
Received: by fk-out-0910.google.com with SMTP id 19so2926463fkr.5
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 12:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=aDofjsfTsssb8q2Ta/1adv1MHUMsD5LeSwZhEHp9wc8=;
        b=PguC/ml3cW9LWpnYPIlTSgbPgJf8xR1swNrQW33OEj8Cb+Stg3bChq3xxHb2Hz9Fcc2ci0AWRUtgtMDN/+eXsTMsRLZ/ow1Dbrdzdc/00xR2zmP4gd0KFxiVvji8AsVAwi3zOJa2HyGE2Gwd/26fgOsiVP8rBCYfCOc/djVB6lw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=d0v9vwPjiF7gqT3fJIA5fy7I6916J/zHIqyzphF2Ug3ZLbbVQgQrzdAV15VRG8cZUrAO3xSFu4vyi6xb9XIKiqVa94U+yZqZdBWAA5Fse6vb5rs7t9MqKDu7rpiT7ICPk6nxcdEzDGMc/JU0eEbF5XKS6oyjppvNAlzYj4cxhVo=
Received: by 10.82.121.20 with SMTP id t20mr584703buc.20.1208373026933;
        Wed, 16 Apr 2008 12:10:26 -0700 (PDT)
Received: by 10.82.168.20 with HTTP; Wed, 16 Apr 2008 12:10:26 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79726>

We've got projects with a mixed userbase of windows / *nix; I'm trying
to migrate some users onto git, whilst everyone else stays happy in
their SVN repo.

However, there's one issue that has been driving me slowly insane.
This is best illustrated thusly (on windows) :

  $ git init
  $ git config core.autocrlf false

-->Create a file with some text content on a few lines
  $ notepad file.txt

  $ git add file.txt
  $ git commit -m "initial checkin"

  $ git status
# On branch master
nothing to commit (working directory clean)
--> Yarp, what I wanted

  $ git config core.autocrlf true
  $ git status

# On branch master
nothing to commit (working directory clean)
--> Yarp, still all good

--> Simulate non-change happened by an editor opening file...
  $ touch file.txt
  $ git status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   file.txt
#
no changes added to commit (use "git add" and/or "git commit -a")

--> Oh Noes! I wonder what it could be
  $ git diff file.txt
diff --git a/file.txt b/file.txt
index 7a2051f..31ca3a0 100644
--- a/file.txt
+++ b/file.txt
@@ -1,3 +1,3 @@
-<xml>
-       wooot
-</xml>
+<xml>
+       wooot
+</xml>

--> Huh? ...
  $ git diff -b file.txt
diff --git a/file.txt b/file.txt
index 7a2051f..31ca3a0 100644

--> Bah... don't care! get me back to the start...
  $ git reset --hard

HEAD is now at 4762c31... initial checkin

  $ git status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   file.txt
#
no changes added to commit (use "git add" and/or "git commit -a")

--> ARGH!
  $ git config core.autocrlf false
  $ git status
# On branch master
nothing to commit (working directory clean)

  $ git config core.autocrlf true
  $ git status
# On branch master
nothing to commit (working directory clean)

--> WtF?

Why does it think in this instance that there is a change? It's CRLF
in the repo, it's CRLF in the working tree, and the checkout in either
mode ought to be identical ??

Now this is further compounded by the fact that users then typically
tend to do a 'CRLF->LF conversion' checkin - *BUT* this will cause
merge conflicts if another user actually made a genuine change (I.E.
the removal of CR and the change are both treated as significant).

Additional fun is caused because some editors 'touching' files that
they actually haven't modified, leading to all these 'null' changes.

This is a bigger deal for us than it ought to be, because we're
pulling changes from a windows-based svn repo, which is always CRLF.
Should I set core.autocrlf=input when doing 'git svn fetch' (and would
it pay any attention)? Also is it possible to tell the diff / merge
machinery that it ought to just ignore text file line endings when
merging ?

Sorry if some of this is stupid-user territory, but there's probably a
few people out there also looking at trying to migrate away from
Windows+SVN that are likely to hit the same things...
