From: Roman Shaposhnik <rvs@sun.com>
Subject: Re: Making submodules easier to work with (auto-update on checkout	or
 merge, stash & restore submodules)
Date: Wed, 30 Apr 2008 12:55:45 -0700
Message-ID: <1209585345.25663.797.camel@work.sfbay.sun.com>
References: <8B885217-8C18-417E-8F11-BB6661792CD3@gmail.com>
 <alpine.DEB.1.00.0804301121240.17469@eeepc-johanness>
 <32541b130804300947s6083156etc6514cc13c24af13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 21:52:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrILh-0002ei-LT
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 21:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbYD3Tv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 15:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbYD3Tv0
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 15:51:26 -0400
Received: from sca-es-mail-1.Sun.COM ([192.18.43.132]:53858 "EHLO
	sca-es-mail-1.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932532AbYD3TvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 15:51:25 -0400
Received: from fe-sfbay-09.sun.com ([192.18.43.129])
	by sca-es-mail-1.sun.com (8.13.7+Sun/8.12.9) with ESMTP id m3UJpN8k021818
	for <git@vger.kernel.org>; Wed, 30 Apr 2008 12:51:23 -0700 (PDT)
Received: from conversion-daemon.fe-sfbay-09.sun.com by fe-sfbay-09.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0K0500401LLMCH00@fe-sfbay-09.sun.com> (original mail from rvs@sun.com)
 for git@vger.kernel.org; Wed, 30 Apr 2008 12:51:23 -0700 (PDT)
Received: from [129.146.84.200] by fe-sfbay-09.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPSA id <0K0500MW5LTLSHB0@fe-sfbay-09.sun.com>; Wed,
 30 Apr 2008 12:51:21 -0700 (PDT)
In-reply-to: <32541b130804300947s6083156etc6514cc13c24af13@mail.gmail.com>
X-Mailer: Evolution 2.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80867>

On Wed, 2008-04-30 at 12:47 -0400, Avery Pennarun wrote:
> On 4/30/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> That said, it makes submodule folders act completely inconsistently
> with normal folders, which is highly undesirable.  The current
> behaviour strongly encourages me to avoid submodules when I would
> otherwise like to use them, just to keep the rest of my team members
> (who are not git experts) from going insane.

Well said. I find myself in exactly the same situation wrt. submodules.
To give an analogy imagine that everytime you had a mount-point in
your path you'd have to do something special in order to cross it.
IOW, open("/tmp/foo/bar/baz.c") would just work, where
open("/mnt/point1/foo.c") would require you to first cross /mnt/point1
somehow. Currently submodules feel very much like the second case
to me. Now, I've shut up for the time being on that other thread,
since I'd like to come up with a clearly defined workflow first.
But for the record: the way submodules are implemented right now
in a porcelain make them pretty much an impossible sell to those
in my org who don't want to know much about SCMs.

> >  But once you did "submodule init", you will never need to run it again,
> >  since it edits your .git/config, which does not change when switching
> >  branches.
> 
> Not true.  If ".gitmodules" is different between branches, then
> .git/config will have the wrong information.  I think this was the
> reason for the "read .gitmodules directly and don't worry about
> .git/config" discussion/patches earlier.

Exactly!

> >  And as for "submodule update", I like the fact that the submodule is not
> >  updated automatically.  For example, when I actively develop a submodule,
> >  but have to rebase the superproject, I would _hate_ it if the submodule
> >  wass updated.
> 
> Why?  Every other folder in your entire project gets updated when you
> "git checkout".  Why are submodules different?  I can personally vouch
> that this is confusing for almost everyone I've seen who tried it.

+1 ;-)


> >  > PITFALLS:
> >  > pitfall)
> >  > If you commit a change on a submodule that's not on a branch, auto-updating
> >  > submodules will make it difficult to revive that change.
> >  >
> >  > workaround)
> >  > Don't allow the user to commit unless they are on a branch.
> >  >
> >  > ... couldn't think of anymore.  Anyone?
> 
> We had some discussion on the list earlier about having submodule
> checkouts automatically acquire a branch name, so that commits don't
> get lost as easily.  I was going to think about this more and
> eventually submit a patch, but I haven't gotten to it yet.  Anyway,
> the idea is that you have a branch by default, so that you don't end
> up in the useless situation of not being on a branch, which encourages
> checking in without being on a branch, in the first place.

Can you give a gmane pointer to that thread?

Thanks,
Roman.
