From: Jeffrey Middleton <jefromi@gmail.com>
Subject: remote's HEAD not detected correctly
Date: Mon, 28 Feb 2011 14:52:42 -0600
Message-ID: <AANLkTimWieViK4JcJQuTDiRiAdyvHuwkwy8fL+XUV+i-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 28 21:59:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuABJ-00062p-V3
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 21:59:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754995Ab1B1U65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 15:58:57 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52709 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754788Ab1B1U64 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 15:58:56 -0500
Received: by wyg36 with SMTP id 36so4033570wyg.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 12:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=0Gyct6tumIFUJMMRFJw3b5TEpjcDuWp4ssBWTPo7BV8=;
        b=jli70t1bRUWs0q0PCzwhdYysmhHH7VbTnSI8yBZc9SJutFAuQ4y5RDx8qcG3JEjHX0
         S3/1yq/bajOYoybquLcUIST8IB03Olsmoz4Of8vJhrhDxQBnfr6jbE4RN51GmQ8cHtKY
         OagnVdHN45GZK/Pv2i8oHamX4NJeOEgDHtRpE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=xwYuayzZbrlWTEYlnf+J+7fLyCdB/odXZC+lrjv9brgQlGPVryRFvuEIJ4iM9AnTIS
         hYqNWeP1xJPLlh66kUc6JCtIy6wU114U6W/BHnfEIZION6YI03K0b0zXomXPy2bE4R0X
         kvjDE+veUZGNlezGivU24bvM5XwoB0lAKdZME=
Received: by 10.216.18.76 with SMTP id k54mr2577950wek.61.1298926735149; Mon,
 28 Feb 2011 12:58:55 -0800 (PST)
Received: by 10.216.164.132 with HTTP; Mon, 28 Feb 2011 12:52:42 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168144>

There appears to be some weirdness here - git isn't properly looking
at the HEAD of the remote repository

#!/bin/bash

(mkdir project &&
cd project &&
git init -q &&
touch a &&
git add a &&
git commit -q -m "add a" &&
git checkout -q -b pu) &&
git clone -q project project.clone &&
(cd project.clone &&
echo -n "HEAD: " && git symbolic-ref HEAD &&
echo -n "origin/HEAD: " && git symbolic-ref refs/remotes/origin/HEAD &&
git remote show origin)


The output is:

HEAD: refs/heads/master
origin/HEAD: refs/remotes/origin/master
* remote origin
  Fetch URL: /home/jefromi/sandbox/project
  Push  URL: /home/jefromi/sandbox/project
  HEAD branch (remote HEAD is ambiguous, may be one of the following):
    master
    pu
8< more git remote output 8<

So somehow, the clone misses the fact that origin's HEAD is pu, not
master, and git remote is only partially aware of this. It looks like
this only happens when the two branches in question are pointing to
the same commit; perhaps git is trying to guess what HEAD is via the
SHA1? I know that ls-remote prints an SHA1, not a refname, for HEAD -
is it not actually possible to get that information through a general
transport protocol?


Jeffrey
