From: "Jones, Brian P CTR SPAWARSYSCEN-PACIFIC, 63600" 
	<brian.p.jones4.ctr@navy.mil>
Subject: RE: Making git history strictly time safe
Date: Thu, 17 May 2012 08:51:35 -0700
Message-ID: <2EDEF5ABBE208442B7547C8D36B9D8840C4A04@nawespscez09v.nadsuswe.nads.navy.mil>
References: <2EDEF5ABBE208442B7547C8D36B9D8840C4A03@nawespscez09v.nadsuswe.nads.navy.mil> <CAH5451m33+4Y6sRzeji-Zvh2meN12ZxHKQMGRZ0Zwid8uGOyBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <git@vger.kernel.org>
To: "Andrew Ardill" <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 17 17:52:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SV300-0001qj-Dn
	for gcvg-git-2@plane.gmane.org; Thu, 17 May 2012 17:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755195Ab2EQPwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 May 2012 11:52:15 -0400
Received: from NAWESDNIAX10O.nmci.navy.mil ([138.163.1.90]:63748 "EHLO
	NAWESDNIAX10O.nmci.navy.mil" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754879Ab2EQPwO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2012 11:52:14 -0400
X-AuditID: 8aa30159-b7c07ae000000e25-fb-4fb519056849
Received: from nawesdnieg09v.nadsuswe.nads.navy.mil (Gate1-Sandiego.nmci.navy.mil [138.163.0.41])
	by  (Symantec Mail Security) with SMTP id 63.8C.03621.50915BF4; Thu, 17 May 2012 15:28:05 +0000 (GMT)
Received: from nawesdnieb10v.nadsuswe.nads.navy.mil ([10.0.10.27]) by nawesdnieg09v.nadsuswe.nads.navy.mil with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 17 May 2012 08:51:36 -0700
Received: from nawespsceb02v.nadsuswe.nads.navy.mil ([10.1.120.16]) by nawesdnieb10v.nadsuswe.nads.navy.mil with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 17 May 2012 08:51:36 -0700
Received: from nawespscez09v.nadsuswe.nads.navy.mil ([10.1.120.174]) by nawespsceb02v.nadsuswe.nads.navy.mil with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 17 May 2012 08:51:35 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Making git history strictly time safe
Thread-Index: Ac0zz5yTDJGgBwNjTuWCwSLFajc3fQAdIw35
X-OriginalArrivalTime: 17 May 2012 15:51:35.0658 (UTC) FILETIME=[F03D44A0:01CD3444]
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197920>

Andrew,
 
If I had a tag pointing to a commit that was so latter hidden could I easily return to the commit and say build it by referencing that tag without having to do any git magic?
 
Brian
 
________________________________

From: Andrew Ardill [mailto:andrew.ardill@gmail.com]
Sent: Wed 5/16/2012 6:50 PM
To: Jones, Brian P CTR SPAWARSYSCEN-PACIFIC, 63600
Cc: git@vger.kernel.org
Subject: Re: Making git history strictly time safe



Brian,

The first thing to know is that given a unique identifier for a
commit, it's sha-1, it is guaranteed that the history of that commit
will never change. Perhaps more accurately, the history is encoded
with the commit contents as part of the sha-1, so it is as secure as
sha-1.

What can change are references to commits - branches, the HEAD
reference, tags etc. Someone could take the contents of each commit,
and use them to create a new history that is slightly altered, but
this would be recorded as a different commit object, with a different
sha-1. At this point they could point a reference, such as a branch,
at this new commit object, and try to convince everyone that the
history hasn't changed. Git will viciously warn everyone when they try
to update this reference, requiring a force update to continue.

My understanding is that the config options you show are enough to
stop a remote user from updating a reference that changes history in
the way I mentioned. If they did update a reference like this, the
previous history would still exist, it would just not be referenced by
the branch name etc.

Regards,

Andrew Ardill


On 17 May 2012 08:47, Jones, Brian P CTR SPAWARSYSCEN-PACIFIC, 63600
<brian.p.jones4.ctr@navy.mil> wrote:
> I am working towards git adoption on a project. One of the concerns is the fear that git history is not guaranteed to be time safe. How can I configure a git repository so users cannot push or pull changes into it that change it's history? This includes keeping users who work directly in the repository from doing a rebase.
>
> I've found...
> http://stackoverflow.com/questions/2085871/strategy-for-preventing-or-catching-git-history-rewrite
>
> Which recommends setting...
>
>  git config --system receive.denyNonFastforwards true
>  git config --system receive.denyDeletes true
>
> ...Is this enough to guarantee time safe history?
>
> Notes:
> 1. Only certain process-central repositories would need time safe history.
> 2. Developers can change their history provided it does not impact anyone else. I don't care about this case (yet).
>
> Brian P. Jones
> Senior Software Engineer
> Configuration Management
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
