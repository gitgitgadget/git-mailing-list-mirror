From: "Josh Boyer" <jwboyer@gmail.com>
Subject: Re: using git on flash media
Date: Wed, 19 Apr 2006 19:44:34 -0500
Message-ID: <625fc13d0604191744w1155a6c3hde184a9705669c4b@mail.gmail.com>
References: <20060419233125.89318.qmail@web86912.mail.ukl.yahoo.com>
	 <Pine.LNX.4.64.0604191651110.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "David Tweed" <tweed314@yahoo.co.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 02:44:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWNHm-0000fi-2s
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 02:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWDTAoh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 20:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWDTAog
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 20:44:36 -0400
Received: from uproxy.gmail.com ([66.249.92.175]:30583 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751170AbWDTAog convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Apr 2006 20:44:36 -0400
Received: by uproxy.gmail.com with SMTP id c2so29101ugf
        for <git@vger.kernel.org>; Wed, 19 Apr 2006 17:44:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VW79xII+j8QAKThiGAWtXZYdiruEqTmfP3d9Udi2OqHmm+VfZSaVufBHqBoCSvIH7B2AXSyZ6IVhUBK3azEE39jddgIxOrkCNfhCiv6pM7MDmEyMKnAxNkCQcQueYlkGvKtfAWgEck5pV860g8dDwkXkne50OrEqGjbWzlfazkM=
Received: by 10.78.39.16 with SMTP id m16mr1678hum;
        Wed, 19 Apr 2006 17:44:34 -0700 (PDT)
Received: by 10.78.15.16 with HTTP; Wed, 19 Apr 2006 17:44:34 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604191651110.3701@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18955>

On 4/19/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Thu, 20 Apr 2006, David Tweed wrote:
> >
> > What I'm basically checking is that it doesn't, I dunno, rewrite files
> > so frequently that on a modern flash drive it would wear out the entire
> > drive unreasonably quickly.
>
> The largely write-once nature of git should mean that the only files that
> get rewritten a lot are
>  - the directories get rewritten to, since git creates new objects at a
>    reasonable pace
>  - the branch references get rewritten.
>
> In general, I'd say that git probably does less writing than most other
> SCM's are likely to do.
>
> That said, when you say "modern flash drive", I really suspect you
> shouldn't care deeply any more. Modern flash devices can be rewritten a
> lot more than old ones could (by an order of magnitude or more), and they
> almost always have wear levelling in hw, making it even less of an issue
> (but if they don't, your biggest issue will be that you should use a
> filesystem that does it for you).

Finding one that claims to have HW wear leveling is still hard, so you
can never really tell.

> That said, if you want to be safe, I think flash memory card vendors
> guarantee only up to 10,000 write cycles (and it used to be much less).
>
> That's _complete_ rewrites, though, which is more than just a single
> sector write. They tend to guarantee 100,000 single-sector re-writes (ie
> more like the "directory update" things when you create a new object).

When talking about flash, it's the erase cycles that are counted. 
Most NOR chips guarantee 100,000 erase cycles per eraseblock.  NAND
chips, which are what most flash drives use, can vary between 10,000 -
100,000 erases depending on the technology used.

> And assuming you'd count one commit as one "total rewrite" (which sounds
> unlikely - but it's certainly more than one sector - I don't know what
> they consider a total rewrite when they make up their numbers), that

A "total rewrite" is simply something that causes an eraseblock to be
erased.  That can vary alot, but it essentially boils down to needing
to write new data to a location in an eraseblock that has already been
written to.

> implies that to be really safe, you shouldn't do more than 10,000 commits
> before you replace your flash. Quite frankly, I suspect that's _way_ more
> conservative than you should be, but hey, since you asked..

To be really conservative, just don't do it ;).  Most flash drives
don't allow access to the raw flash chips, so while you can use
something like JFFS2 on them still, the benefits of that are somewhat
lost since you never really know what is going on underneath.

> One rule: NEVER mount your flash with the "sync" option, and use "noatime"
> to avoid unnecessary inode access time updates (that's especially true for

Right.

josh
