From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: erratic behavior commit --allow-empty
Date: Thu, 4 Oct 2012 22:17:04 +0100
Organization: OPDS
Message-ID: <20C3105FC8D94F749FAEB7444325B34A@PhilipOakley>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com><506AA51E.9010209@viscovery.net><7vzk449449.fsf@alter.siamese.dyndns.org><CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com><7vhaqc7in6.fsf@alter.siamese.dyndns.org><CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com><90464C79DA97415C9D66846A77ECAA4A@PhilipOakley><CAB9Jk9ARWnE-cWVjqMUFiua21QjqGEX3VhYjKQMBSotVYXXK1Q@mail.gmail.com><vpq626s6kwu.fsf@grenoble-inp.fr><CAB9Jk9DFb2s4s00yCNUytxFdrOQKPEKZGsXpKzwZDo5WAOdXaQ@mail.gmail.com><vpqvcer4xvo.fsf@grenoble-inp.fr><CAB9Jk9BTCaV7RDx6_K+MKOeJTdOQPOwvnGM0UNxg9S8KMo4D4Q@mail.gmail.com><A75F75C4DE3C47C7AF43D39355C873F7@PhilipOakley> <CAB9Jk9C4Y2LSzZW5Nkz=4f===8_gk4uAG4EKDxT17kUHu4VX1A@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"git" <git@vger.kernel.org>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
To: "Angelo Borsotti" <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:55:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtpR-0003Zr-MC
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750Ab2JDWTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 18:19:09 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:8140 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757644Ab2JDVQx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Oct 2012 17:16:53 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhMKAPH7bVBcGnKf/2dsb2JhbABFi06yPQOBCIEJghsFAQEEAQgBAS4eAQEaBwUGAgMFAgEDFQELJRQBBAgSBgcXBhMIAgECAwEIAodYAwkKpCeKJA2JVIpaZGwChE9gA4gjhUaET4FcjHaFC4Ju
X-IronPort-AV: E=Sophos;i="4.80,537,1344207600"; 
   d="scan'208";a="386615724"
Received: from host-92-26-114-159.as13285.net (HELO PhilipOakley) ([92.26.114.159])
  by out1.ip04ir2.opaltelecom.net with SMTP; 04 Oct 2012 22:16:50 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207033>

From: "Angelo Borsotti" <angelo.borsotti@gmail.com>
Sent: Thursday, October 04, 2012 8:07 AM
> Hi Philip and all,
>
> let me explain in full what is the problem that I tried to solve, and
> how along the way I stumbled in something that seems to me a git bug
> (at least a documentation one).
>
> There is an R&D team developing software using a workflow that is
> similar to the integerator-manager one (the one described by Scott
> Chacon in chapter 5 of ProGit).

This has the developers having a full copy/history of the integrators 
relevant branches, so that when the pull of the developers branch occurs 
there is a proper link to the integrators history.

> Developers implement features using a local repository hosted on their
> workstations, and when finished push on a server; integrators pull
> from it and put all the contributions together.
> Since integrators rebuild always the software after merging all
> contribution, there is no need for the developers to push the
> binaries. Not pushing them speeds up uploading.
> In order to make life simpler and safer, scripts are provided to
> perform the pushing, pulling, etc. operations. So, most of the git
> commands shown below are actually run from within scripts.
> The development of each feature is done in a dedicated topic branch,
> and the commits done in it contain both the sources and the binaries
> (to allow to recover fully a previous snapshot when a later change
> broke a previous one). When pushing, there are these needs:
>
>      1. push the sources only
>      2. push only the last commit of the topic branch (not the whole 
> history)
>
> A note on point 2: the integrators are not interested in seeing all
> the commits that developers did while implementing their features.
> Having all the history makes their repositories cluttered.
>
> In order to avoid pushing all the history, orphan branches are used to
> parallel the topic ones.

There are other ways to create a branch which has all the developers 
feature history removed, rather tha using an --orphan, which removes the 
integrators history as well.

> When pushing, first a commit is done on the topic branch, and then a
> snapshot is created in the parallel branch with the same files,
> binaries removed. The general case is:
>
>     source branch                              D'
>                                                        :
>     topic branch        A----B----C---D
>
> In the picture, the developer made 4 commits, and pushed the sources
> of the last one, D.
> A D' is created on the source branch (the relationship with D is
> indicated with a dotted line).

The disconnection of the D' source branch makes it sound like you have a 
second SCM system that you have to put stuff into, which is independent 
of the development teams git repos. I have this [hassle] at my 
$dayjob -one almost has to hide git from the powers-that-be.

> The push script must cope with all the cases that may occur:
>
>     1.  the general one (the one in the previous figure)
>     2.  none of the commits in the topic branch with binaries (i.e. D
> and D' with the same tree)
>     3.  push done immediately after the first commit (A)
>     4.  a push done after another
>
> The script:
>
>     1.  creates the source branch if it does not exist yet (git
> checkout --orphan),
>          otherwise makes HEAD point to it
>     2.  sets a .git/info/exclude file that excludes the binaries
>     3.  removes the binaries from the index (git rm)
>     4.  creates a commit on the source branch
>     5.  pushes it
>     6.  restores the HEAD and index as they were before
>
> The operation that caused problems was nr. 4. In all the cases
> enlisted above, a git commit creates a brand new and unique commit
> because either it has a parent that is different from that of any
> other commit, or because its tree is different. All, except case nr 3
> when there are no binaries:
>
>     source branch         A'
>                                   :
>     topic branch        A
>
> In this case the parent is the same as that of A, i.e. none, and also
> the tree is the same.
True.

>In order to try to force the creation of a brand
> new and unique commit even when the trees are the same --allow-empty
> has been used, but this did not avail because

It was --orphan,  --allow-empty (a common tree), the --root commit, and 
scripted with both branches using the same clock tick...

> git commit creates a
> brand new one only when the seconds of the system clock have ticked
> before it.
>
> Some of you have suggested to create an A' that is not orphan in such
> a case, which is a workaround, and some others to change the message
> in it, and this is another. I choose the latter

A reasonable solution. You can also create a sentinel (--root) commit 
for any time that you need to create the source branch, just so it (the 
real source code commit) has a different parent when on source branch to 
that on the binaries branch.

However, personally, I'd have wanted the source branch to show real 
history and actually match with the integrators repo history, but no 
doubt local conditions & politics have their influence.

> because it allows to
> keep the source branch orphan in all cases. So, there are workarounds,
> and the script has eventually been implemented and tested, but the
> unexpected, time-dependent behavior of git commit is there and someone
> could stumble on it sooner or later.
>
> -Angelo
