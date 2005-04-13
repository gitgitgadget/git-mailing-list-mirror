From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Index/hash order
Date: Thu, 14 Apr 2005 00:48:00 +0200
Message-ID: <87br8ithsv.fsf@deneb.enyo.de>
References: <425C3F12.9070606@zytor.com>
	<Pine.LNX.4.58.0504121452330.4501@ppc970.osdl.org>
	<20050412224027.GB20821@elte.hu>
	<Pine.LNX.4.58.0504121554140.4501@ppc970.osdl.org>
	<20050412230027.GA21759@elte.hu> <20050412230729.GA22179@elte.hu>
	<20050413111355.GB13865@elte.hu> <425D4E1D.4040108@zytor.com>
	<20050413165310.GA22428@elte.hu> <425D4FB1.9040207@zytor.com>
	<Pine.LNX.4.58.0504131008500.4501@ppc970.osdl.org>
	<87aco2gxu2.fsf@deneb.enyo.de>
	<Pine.LNX.4.58.0504131503180.4501@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 00:45:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLqbT-0008Qd-PD
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 00:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVDMWsO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 13 Apr 2005 18:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVDMWsO
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Apr 2005 18:48:14 -0400
Received: from mail.enyo.de ([212.9.189.167]:7358 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S261213AbVDMWsI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2005 18:48:08 -0400
Received: from deneb.enyo.de ([212.9.189.171])
	by albireo.enyo.de with esmtp id 1DLqeQ-0007Sf-LV; Thu, 14 Apr 2005 00:48:02 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.50)
	id 1DLqeO-0004M7-Ah; Thu, 14 Apr 2005 00:48:00 +0200
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504131503180.4501@ppc970.osdl.org> (Linus
	Torvalds's message of "Wed, 13 Apr 2005 15:11:57 -0700 (PDT)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Linus Torvalds:

> I will bet you that a git checkout is _faster_ than a kernel source t=
ree
> copy. The time will be dominated by the IO costs (in particular the r=
ead
> costs), and the IO costs are lower thanks to compression. So I think =
that
> the cold-cache case will beat your 40 seconds by a clear margin. It
> generally compresses to half the size, so 20 seconds is not impossibl=
e
> (although seek costs would tend to stay constant, so I'd expect it to=
 be
> somewhere in between the two).

It's indeed slightly faster (34 seconds).  The hot-cache case is about
6 seconds.  Still okay.

However, I should redo these tests with a real git.  The numbers could
be quite different because seek overhead is a bit hard to predict.
Which version should I try?

> That's actually pretty encouraging. Your 1.1GB number implies to me t=
hat a
> compressed file setup should be about half that, which in turn says t=
hat
> the cost of full-file is not at all outrageous.

I usually try to avoid the typical O(f(n)) fallacy because constant
factors do matter in practice.  But the way you put it -- maybe delta
compression isn't worth the complexity after all.  At least I'm
beginning to have doubts.

Especially since the same Subversion repository, stored by the
Berkeley DB backend, requires a whopping 1.3=A0GB of disk space.

> Or maybe I misunderstood what you were comparing?

My estimates only cover file data, not metadata.  Based on the
Subversion dumps, it might be possible to get some rough estimates for
the cost of storing directory information.  What is the average size
of a directory blob?  Is it true that for each tree revision, you need
to store a new directory blob for each directory which indirectly
contains a modified file?

Does your 50% estimate include wasted space due to the file system
block size?
