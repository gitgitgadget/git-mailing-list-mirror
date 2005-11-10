From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: hgmq vs. StGIT
Date: Thu, 10 Nov 2005 16:20:03 +0000
Message-ID: <b0943d9e0511100820h2f10a011g@mail.gmail.com>
References: <20051101002554.GA7634@thunk.org>
	 <b0943d9e0511010123i1f9eb679w@mail.gmail.com>
	 <436787BD.9080705@citi.umich.edu>
	 <20051101153650.GB26847@watt.suse.com>
	 <b0943d9e0511010918ob2dbcfcv@mail.gmail.com>
	 <20051101181352.GD26847@watt.suse.com>
	 <b0943d9e0511011330v7045c568u@mail.gmail.com>
	 <20051102154108.GM26847@watt.suse.com>
	 <b0943d9e0511051223g74c2be43h@mail.gmail.com>
	 <20051109233255.GI30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Chris Mason <mason@suse.com>, Chuck Lever <cel@citi.umich.edu>,
	Theodore Ts'o <tytso@mit.edu>,
	Joel Becker <Joel.Becker@oracle.com>,
	Junio C Hamano <junkio@cox.net>, pavel@ucw.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 17:23:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaF9m-0004eK-4j
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 17:20:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbVKJQUG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 11:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbVKJQUG
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 11:20:06 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:28529 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751112AbVKJQUE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 11:20:04 -0500
Received: by xproxy.gmail.com with SMTP id i30so517225wxd
        for <git@vger.kernel.org>; Thu, 10 Nov 2005 08:20:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZqlC2J4LC5d2hEzOs3k7rx8BBVLFKTb4FY8rR4h1hxnPFz3gXngoDNGFsMbtum88m/4CQEzZt9PLNq29X3kZJFUGA2B2/Jvjd3mbGYMGDtH48y7GRBBf+GD70zEs2cBcnZzZcEcwjIFFX57RX+vXyZjWuOnSDpPKk8EHjU5bjyM=
Received: by 10.70.100.12 with SMTP id x12mr968486wxb;
        Thu, 10 Nov 2005 08:20:03 -0800 (PST)
Received: by 10.70.31.3 with HTTP; Thu, 10 Nov 2005 08:20:03 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051109233255.GI30496@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11489>

On 09/11/05, Petr Baudis <pasky@suse.cz> wrote:
> A night city, the snow slowly falling. Approaching the roofs covered in
> white and illuminated by the yellow street lighting, dark windows - but
> one dimly glowing, a computer screen inside. Close-up on a hacker:
> $EDITOR opened, lost deep in hack mode, fingers dancing over the
> keyboard.  Dreamy-monumental music in the background.

I agree with Pavel here :-)

> StGIT user, only part of the patches in stack, and the rest depends on
> the one currently edited, and I want to record my work on this one.
> I can either:
>
> (i) Just keep per-patch history only.

That's probably the simplest.

> (ii) Keep _both_ per-patch and per-stack history (since I don't want to
> record the stack when I have to keep some patches out of it - the
> history would look like randomly removing and adding tons of patches,
> and jumping around would be difficult because of this too).

It happens to me to keep some patches popped which aren't really part
of the stack (i.e. splitting a big patch, I still keep it in the
unapplied patches to push it later and check what was left after
splitting). From this point of view, (ii) would be better but with the
drawback that you need to have a valid stack with all the patches
pushed.

> (iii) Keep per-patchlist history - do not actually record only our
> current stack, but all the patches StGIT knows about. The patches
> depending on the one currently being changed will not be in consistent
> state, but that's tough. Actually, this seems to be the most viable
> strategy. One question is whether to record if some patch is actually
> applied right now or not (I'd say don't record it since you again have
> the "bouncing problem" otherwise).

(iii) is the most comprehensive method and, as Pavel said, we should
record what patches were applied or not and reproduce them exactly
when retrieving a different state.

Another big problem is the base of the stack, which can change. Would
retrieving an old state of the stack also restore the old the base? I
think it should and its up to the user to rebase it.

A simple way to partially achieve (iii) is to extend the existing
'branch' command to clone the whole series into a new one, including
all the patches. The problem with this approach is that there is no
temporal relation between branches.

How would you expect to switch between different states of the stack?
As Chris Mason mentioned, once you start doing this people might ask
for full SCM features (like diffs between revisions) where the objects
are stack states. This would complicate StGIT quite a lot.

--
Catalin
