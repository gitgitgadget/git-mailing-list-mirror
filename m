From: =?UTF-8?Q?J=C4=81nis_Ruk=C5=A1=C4=81ns?= <janis.ruksans@gmail.com>
Subject: Submodule, subtree, or something else?
Date: Sat, 22 Aug 2015 01:47:42 +0300
Message-ID: <1440197262.23145.191.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 00:48:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSv6f-0007EW-52
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 00:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbbHUWsM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 18:48:12 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33305 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbbHUWsL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 18:48:11 -0400
Received: by lbbsx3 with SMTP id sx3so52056352lbb.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 15:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:date:content-type:mime-version
         :content-transfer-encoding;
        bh=ztRHPXp4oNWH1Fpiy+Yq58ZSnI/M8C+d0ig7rBWgp/U=;
        b=x/A427wvAQyOtFVRHq7B9GYE3P5OYlrQM0yDJ2xSMp/eA1gXT9vHuGxHq+fpPiOhIq
         ttRUwbNEGOz6YUkzInvhiH/HFyXuhH6R/l8az8vUTU3n2bAWEYJl5dZ5msSQ5hBmMiGR
         jqBIFG3yOhBhv/yzIf43zbeVFvTS3KIUSmDb/biKkf5casSboZgLkTFFJRFKW0RgVpQo
         l5mgP+fgNLnl07DMxRapT0r6JbbnP1LbsOZEtD5uPqh6XzEDsRUoFyNSUrtMtNzQ7f4N
         Gj03MhtVhuYS+al1cyvWE8UsF8IHQuF+JvytOWbLdaeK33/4fl6UQsxBP3RPKi6gRTYZ
         +Eow==
X-Received: by 10.112.219.70 with SMTP id pm6mr9596874lbc.41.1440197289820;
        Fri, 21 Aug 2015 15:48:09 -0700 (PDT)
Received: from ganja ([46.109.200.48])
        by smtp.googlemail.com with ESMTPSA id ut5sm2701642lbc.33.2015.08.21.15.48.08
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2015 15:48:08 -0700 (PDT)
X-Mailer: Evolution 3.12.11 (3.12.11-1.fc21) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276340>

Hello,


=46irst of all, I apologise for the wall of text that follows; obviousl=
y I
am bad at this.

My $DAYJOB is switching from Subversion to Git, primarily because of
it's distributed nature (we are scattered all across the globe), and th=
e
ease of branching and merging.  One issue that has popped up is how to
manage code shared between multiple projects.

Our SVN setup used a shared repository for all projects, either using
externals for shared code, or, more often than not, simply merging the
code between projects as needed.  Ignoring the fact that merging with
SVN is somewhat cumbersome, overall it has worked quite well for us,
especially when combined with git-svn.

=46or external libraries that rarely change, submodules appear to be th=
e
obvious choice when using Git.  On the other hand, I've found them
somewhat cumbersome to use, and subtree merging (either using git
subtree, or directly with git merge -s subtree) is closer to what we
were doing in SVN.  A major drawback of submodules in my opinion is the
inability to make a full clone from an existing one without having
access to the central repository, which is something I have to do from
time to time.

=46or internal libraries, the situation is even less clear.  For many o=
f
these libraries, most of the development happens within the context of =
a
single project, with commits to main project being interleaved with
commits to the subproject(s), resulting in histories resembling:

 (using git submodule)

   A---B---S1---S2---C---S3
          ,=C2=B4   ,=C2=B4       ,=C2=B4
     N---O----P----Q---R

 (using git subtree with --rejoin)

   A---B---N---O---M1---M2---Q---C---R---M3
                  /    /                /
             N'--O'---P--------Q'------R'

 (using merge -s subtree)

   A---B---M1---M2---C---M3
          /    /        /
     N---O----P----Q---R

where A, B and C are changes to the main project, N, O, P, Q and R are
changes to library code, and Sn and Mn are submodule updates and merge
commits, respectively.

=46rom what I have gathered, submodules have issues with branching and
merging, therefore, unless I'm mistaken, submodules are kinda out of
question.  Of the remaining two options, merging directly results in a
nicer history, but requires making all changes to the library repo firs=
t
(although I am quite sure that a similar effect can be achieved with
plumbing, similarly to how git subtree split works), and is harder to
use than git subtree.  Also, all three options can result in the main
project history being cluttered with extra commits.

Lastly, there is a particularly painful 3rd party library that has an
enormous amount of local modifications that are never going to make it
upstream, essentially making it a fork, project specific changes that
are required for one project, but would break others, separate language
bindings that access the internals (often requiring bug fixes to be mad=
e
simultaneously to both), and, if that wasn't enough, it *requires*
several source files to be modified for each individual project that
uses it.  It's a complete mess, but we're stuck with it for the existin=
g
projects, as switching to an alternative would be too time consuming.


To sum up, I'm looking for something that would let us share code
between multiple projects, allow for:

1) separate histories with relatively easy branching and merging

2) distributed workflow without having to set up a multiple repositorie=
s
everywhere (eg. work <-> home <-> laptop)

3) to work on the shared code within a project using it

4) inspection of the complete history

5) modifications that are not shared with other projects

and would not result in lots of clutter in the history.

Repository size is somewhat less of an issue, because each submodule ha=
s
to be checked out anyway.

Submodules let you have #3, and #1, #2 and #5 to a point, after which i=
t
becomes a pain.  git subtree allows #1, #2, #3 and #4, and #5 with some
pain (?), but results in duplicate commits.  Using subtree merge
strategy directly gives everything except #3, but is harder to use than
submodules or subtree.

Are there any other options beside these three for sharing (or in some
cases, not sharing) common code between projects using Git, that would
address the above points better?  Or, alternatively, ways to work aroun=
d
the drawbacks of the existing tools?

Lastly, I will be grateful for any suggestions about how to handle the
messy case described above better.

Thanks,
J=C4=81nis
