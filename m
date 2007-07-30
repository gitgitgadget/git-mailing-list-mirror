From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: merge time
Date: Mon, 30 Jul 2007 08:10:31 +0200
Message-ID: <6FE9FFD6-B5D7-4E1D-A4E8-B6D0E9517503@zib.de>
References: <241612.78983.qm@web51007.mail.re2.yahoo.com> <alpine.LFD.0.999.0707291914451.3442@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthew L Foster <mfoster167@yahoo.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 08:09:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFOS4-00062i-GO
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 08:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762953AbXG3GJp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 02:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757270AbXG3GJp
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 02:09:45 -0400
Received: from mailer.zib.de ([130.73.108.11]:43844 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753252AbXG3GJo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 02:09:44 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l6U69c1w029825;
	Mon, 30 Jul 2007 08:09:38 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db115cf.pool.einsundeins.de [77.177.21.207])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l6U69ags014455
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 30 Jul 2007 08:09:37 +0200 (MEST)
In-Reply-To: <alpine.LFD.0.999.0707291914451.3442@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54191>


On Jul 30, 2007, at 4:29 AM, Linus Torvalds wrote:

> So there is never really any way to say that one side of a merge is
> special. The closest you can get is saying
>
>  - the first parent is special.
>
>    This is "see merges from the viewpoint of the merger", but as
>    mentioned, the person who actually did the merge isn't  
> necessarily me,
>    so while this is a totally self-consistent view, it's not really  
> the
>    view you are looking for.
>
>    You can get some of this view by using "git log --first-parent",  
> which
>    basically follows commits preferentially using the first parent,  
> and
>    thus "prefers" history as seen by whoever did the merge.

In general the first parent is not special, agreed. But could one
deliberately built a history by following certain rules that make
the first parent _always_ a special one?

I think of a quite simple example. Topic branches are always
branched off the master, and later merged back. The master, which
is the branch an official release is created from, must always be
the first parent during a merge. It doesn't matter who does the
merges or who does the releases, as long as he follows the rule
to start from the last release point and merge in all changes in
the appropriate way, such that the first parent rule is followed.

Here are two applications that I think would be interesting:

1) The kernel history. If you went from a current release back
along the first parents you'd see the changes that entered the
official kernel sorted backwards in time. I believe the history of
the kernel is already an approximation of this rule. But maybe I'm
wrong.

2) Developing using topic branches. You start topic branches and
start developing new features. Only later you fix problems on all
supported platforms, polish and review the changes. Not every
commit on the topic branch has the same quality, e.g. the early
commits may not even compile on all supported platforms. But the
tip of the topic branch passes all required tests. After a merge
of the topic branch to a stable branch it would be nice to
distinguish the stable history from the less polished commits on
the topic branch. I think this could be achieved if the first
parent always is linked to a stable commit.

I'm sure some will propose that instead of (2) I should rewrite a
topic branch such that every single commit passes all quality
requirements. But I strongly believe it is a viable choice not to
do so. It may just be too much work and often it's sufficient and
easier to polish the tip of a topic branch.

Fast-forward merges would break both of the scenarios. But would
they be possible without fast-forward merges?

Would it be possible to ensure that all commits along the
first-parent-path have 'release' quality and all release tags are
located along this path? What would be the right rules to achieve
this objective?

	Steffen
