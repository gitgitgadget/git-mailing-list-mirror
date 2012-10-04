From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: erratic behavior commit --allow-empty
Date: Thu, 4 Oct 2012 09:07:47 +0200
Message-ID: <CAB9Jk9C4Y2LSzZW5Nkz=4f===8_gk4uAG4EKDxT17kUHu4VX1A@mail.gmail.com>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
	<506AA51E.9010209@viscovery.net>
	<7vzk449449.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
	<7vhaqc7in6.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com>
	<90464C79DA97415C9D66846A77ECAA4A@PhilipOakley>
	<CAB9Jk9ARWnE-cWVjqMUFiua21QjqGEX3VhYjKQMBSotVYXXK1Q@mail.gmail.com>
	<vpq626s6kwu.fsf@grenoble-inp.fr>
	<CAB9Jk9DFb2s4s00yCNUytxFdrOQKPEKZGsXpKzwZDo5WAOdXaQ@mail.gmail.com>
	<vpqvcer4xvo.fsf@grenoble-inp.fr>
	<CAB9Jk9BTCaV7RDx6_K+MKOeJTdOQPOwvnGM0UNxg9S8KMo4D4Q@mail.gmail.com>
	<A75F75C4DE3C47C7AF43D39355C873F7@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:24:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtTh-0001w8-C5
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317Ab2JDHHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 03:07:49 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:41779 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932094Ab2JDHHs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 03:07:48 -0400
Received: by mail-vc0-f174.google.com with SMTP id fo13so174247vcb.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 00:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=20cvlcsr+zTKEapJ/Dms0tsy2DwFEc8q/KN0wSNxctw=;
        b=fty0oXLhnoxASIWK60Ri0wfnVE83ZuzAB5X1IuAfIR7NUC5QOpR2nsfoZAg1TYc3js
         eloHWur4WwuzJHdNJiwHGZ5M1KppNK/kQK5bWY3bOJNI4J6U9el6SI6xJnphZfM9iqU1
         X67Sve4DcAKf+zXPJ7m7Uk1vCBO95WwBbMPqtGg78+WWU4aMezEuM9GzxFRGJApBmCql
         84fZS1kfunGRNJW2uZ0LYc1D3KqISxY5EOenCuLr4NhmsriqqljHvmEBHAGzCJBoNUP3
         3+UPX7nWNhs0EcBxfBvXA1L2bOhW/ImBzm18wnXml2l35Q9v/cE+hjQURLSYZ6RxsShS
         BzfQ==
Received: by 10.52.90.147 with SMTP id bw19mr1886655vdb.17.1349334467397; Thu,
 04 Oct 2012 00:07:47 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Thu, 4 Oct 2012 00:07:47 -0700 (PDT)
In-Reply-To: <A75F75C4DE3C47C7AF43D39355C873F7@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206996>

Hi Philip and all,

let me explain in full what is the problem that I tried to solve, and
how along the way I stumbled in something that seems to me a git bug
(at least a documentation one).

There is an R&D team developing software using a workflow that is
similar to the integerator-manager one (the one described by Scott
Chacon in chapter 5 of ProGit).
Developers implement features using a local repository hosted on their
workstations, and when finished push on a server; integrators pull
from it and put all the contributions together.
Since integrators rebuild always the software after merging all
contribution, there is no need for the developers to push the
binaries. Not pushing them speeds up uploading.
In order to make life simpler and safer, scripts are provided to
perform the pushing, pulling, etc. operations. So, most of the git
commands shown below are actually run from within scripts.
The development of each feature is done in a dedicated topic branch,
and the commits done in it contain both the sources and the binaries
(to allow to recover fully a previous snapshot when a later change
broke a previous one). When pushing, there are these needs:

      1. push the sources only
      2. push only the last commit of the topic branch (not the whole history)

A note on point 2: the integrators are not interested in seeing all
the commits that developers did while implementing their features.
Having all the history makes their repositories cluttered.

In order to avoid pushing all the history, orphan branches are used to
parallel the topic ones.
When pushing, first a commit is done on the topic branch, and then a
snapshot is created in the parallel branch with the same files,
binaries removed. The general case is:

     source branch                              D'
                                                        :
     topic branch        A----B----C---D

In the picture, the developer made 4 commits, and pushed the sources
of the last one, D.
A D' is created on the source branch (the relationship with D is
indicated with a dotted line).
The push script must cope with all the cases that may occur:

     1.  the general one (the one in the previous figure)
     2.  none of the commits in the topic branch with binaries (i.e. D
and D' with the same tree)
     3.  push done immediately after the first commit (A)
     4.  a push done after another

The script:

     1.  creates the source branch if it does not exist yet (git
checkout --orphan),
          otherwise makes HEAD point to it
     2.  sets a .git/info/exclude file that excludes the binaries
     3.  removes the binaries from the index (git rm)
     4.  creates a commit on the source branch
     5.  pushes it
     6.  restores the HEAD and index as they were before

The operation that caused problems was nr. 4. In all the cases
enlisted above, a git commit creates a brand new and unique commit
because either it has a parent that is different from that of any
other commit, or because its tree is different. All, except case nr 3
when there are no binaries:

     source branch         A'
                                   :
     topic branch        A

In this case the parent is the same as that of A, i.e. none, and also
the tree is the same. In order to try to force the creation of a brand
new and unique commit even when the trees are the same --allow-empty
has been used, but this did not avail because git commit creates a
brand new one only when the seconds of the system clock have ticked
before it.

Some of you have suggested to create an A' that is not orphan in such
a case, which is a workaround, and some others to change the message
in it, and this is another. I choose the latter because it allows to
keep the source branch orphan in all cases. So, there are workarounds,
and the script has eventually been implemented and tested, but the
unexpected, time-dependent behavior of git commit is there and someone
could stumble on it sooner or later.

-Angelo
