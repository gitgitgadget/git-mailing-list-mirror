From: Chris Packham <judge.packham@gmail.com>
Subject: change in behaviour of git status and/or gitk bug
Date: Thu, 6 May 2010 18:20:34 -0700
Message-ID: <n2na038bef51005061820o581b2f0aq940282264b7f083f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 07 03:22:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OACGg-0005LR-K6
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 03:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980Ab0EGBUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 21:20:38 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:62186 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705Ab0EGBUh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 21:20:37 -0400
Received: by qyk13 with SMTP id 13so697750qyk.1
        for <git@vger.kernel.org>; Thu, 06 May 2010 18:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=EHBw2C9VISOtaHPvMGpVsXwCgh6nKmafmFh6ywxrTMw=;
        b=D98cvkOSn3Qzbz2WjPqnX6hSSHERkfqAJ4k+2Fuvz1LW5qWqg/Qhk3YElBpnqLIDvA
         clQFA2Eh7n9Ecps1AAmFsHXklz6HTDdqS4jWj3B0PkjVxPCh8y/EGTEdwOtXjAh+u2il
         Ck9gh1Zi8JEZMz2yr30gGqjVEiAD3mag3wOC8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=bThODSo/pUCrVGV/pWM1dbls3TbUv63WvOq3u0grX4itAqJHDwzpIGgN4TYwLCxQZj
         Fpp+AiPEI2YViuBFMmbppik7e1L4Uq3PbpeEOXm9st91kPIprWjZ5X504QGFDlcxfICZ
         HBDsDmtOZBkkQ0NeNCeBEkwTL08pbSEZ8HP9o=
Received: by 10.229.91.16 with SMTP id k16mr6089219qcm.40.1273195234844; Thu, 
	06 May 2010 18:20:34 -0700 (PDT)
Received: by 10.229.28.3 with HTTP; Thu, 6 May 2010 18:20:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146516>

Hi,

This may or may not be the same/similar as this thread [1]

I noticed a while back that with gitk I kept on getting files shown as
"Local uncommitted changes, not checked in to index" when I'd made
modifications to them then backed them out so the working tree content
was the same as the index. I used to (with git 1.6.x) fix / work
around this by running git status.

Now, with git 1.7.1, that workaround has stopped working. No doubt
because git status was re-implemented from a wrapper of git commit to
its own real command. Its then no surprise that running git commit
"fixes" the problem even if its got nothing to commit. I think there
is even another command to update whatever info gitk is reading but I
can't find it right now. If I can ever remember the aforementioned
magic command it shouldn't be hard to get gitk to run it when the user
selects "reload" but I was wondering if this change in git status's
behaviour is causing other issues (like in the thread I mentioned).

Its fairly easy to reproduce this

$ mkdir tmp
$ cd tmp
$ git init
$ echo "foo" > foo.txt && git add foo.txt && git commit -m "Initial commit"
$ touch foo.txt

$ git status
# On branch master
nothing to commit (working directory clean)

$ gitk
# this is where you'll see foo.txt modified but not indexed

$ git commit
# On branch master
nothing to commit (working directory clean)

$ gitk
# now everything is clean

---

[1] http://article.gmane.org/gmane.comp.version-control.git/146473
