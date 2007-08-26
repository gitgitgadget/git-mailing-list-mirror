From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: git-daemon on NSLU2
Date: Sun, 26 Aug 2007 14:06:25 -0400
Message-ID: <9e4733910708261106u3fecde67m8045ddba3aa57650@mail.gmail.com>
References: <9e4733910708232254w4e74ca72o917c7cadae4ee0f4@mail.gmail.com>
	 <20070824062106.GV27913@spearce.org>
	 <9e4733910708241238n1899f332j4fafbd6d7ccc48b9@mail.gmail.com>
	 <alpine.LFD.0.999.0708241618070.16727@xanadu.home>
	 <9e4733910708241417l44c55306xaa322afda69c6beb@mail.gmail.com>
	 <alpine.LFD.0.999.0708241616390.25853@woody.linux-foundation.org>
	 <9e4733910708250844n7074cb8coa5844fa6c46b40f0@mail.gmail.com>
	 <20070826093331.GC30474@coredump.intra.peff.net>
	 <9e4733910708260934i1381e73ftb31c7de0d23f6cae@mail.gmail.com>
	 <alpine.LFD.0.999.0708260959050.25853@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, jnareb@gmail.com,
	"Nicolas Pitre" <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 26 20:06:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPMVW-0007Sn-4h
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 20:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754579AbXHZSG2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 14:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754323AbXHZSG1
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 14:06:27 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:15785 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754554AbXHZSG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 14:06:26 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1773711wah
        for <git@vger.kernel.org>; Sun, 26 Aug 2007 11:06:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W91pVwvYZIRi+hKSfTtPH7mGiGmepQJbcaE0tpLYXfCS11S6sEcXG9Fgktns4Va/7hpUhXP611VN7nNiup53ADNmFy8S6BGjokInD1ewwnsMEGw91WU9kfUoahRxQE0BjeHZJASkfbQE1FzChkNk8KVYquT/9D0WBhEtg8WtmRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bi9PLbpuRtIXWC5q9FOiCh9uGna3SNdenKj88axS3ZV1V4PzEb68aM+/10+ZvzbP5hWqdcafh+7gJUUsW6Ait1+F5d5uawgBX0U5LT42hWNPs7aFea43XWFL389lYSg2EflEcNPFG31fpEKKjs4JUdz25sh6aUlR51BGIgMy1fs=
Received: by 10.115.79.1 with SMTP id g1mr5471022wal.1188151585381;
        Sun, 26 Aug 2007 11:06:25 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Sun, 26 Aug 2007 11:06:25 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0708260959050.25853@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56706>

On 8/26/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> And there's actually a deeper problem: the current native protocol
> guarantees that the objects sent over are only those that are reachable.
> That matters. It matters for subtle security issues (maybe you are
> exporting some repository that was rebased, and has objects that you
> didn't *intend* to make public!), but it also matters for issues like git
> "alternates" files.

Are these objects visible through the other protocols? It seems
dangerous to leave something on an open server that you want to keep
hidden.

> If you only ever look at a single repo, you'll never see the alternates
> issue, but if you're seriously looking at serving git repositories, I
> don't really see the "single repo" case as being at all the most common or
> interesting case.
>
> And if you look at something like kernel.org, the "alternates" thing is
> *much* more important than how much memory git-daemon uses! Yes,
> kernel.org would probably be much happier if git-daemon wasn't such a
> memory pig occasionally, but on the other hand, the win from using
> alternates and being able to share 99% of all objects in all the various
> related kernel repositories is actually likely to be a *bigger* memory win
> than any git-daemon memory usage, because now the disk caching works a
> hell of a lot better!

Doesn't kernel.org use alternates or something equivalent for serving
up all those nearly identical kernel trees?

I've been handling the problem locally by using remotes and fetching
all the repos I'm interested in into a single git db.

>
> So it's not actually clear how the initial clone thing can be optimized on
> the server side.
>
> It's easier to optimize on the *client* side: just do the initial clone
> with rsync/http (and "git gc" it on the client afterwards), and then
> change it to the git native protocol after the clone.

Even better, get them to clone from kernel.org and then just fetch in
the differences from my server. It's an educational problem.

How about changing initial clone to refuse to use the git protocol?

>
> That may not sound very user-friendly, but let's face it, I think there is
> exactly one person in the whole universe that tries to use an NSLU2 as a
> git server. So the "client-side workaround" is likely to affect a very
> limited number of clients ;)

I'll send you one and double the size of the user base. I have this
fancy new 20Mb FIOS connection and I can't come up with anything to
use the bandwidth on.

Anyway, I already gave up and moved on to a hosting provider. Repo is
here: http://git.digispeaker.com/ There's nothing there yet but a
clone of the 2.6 tree.
I don't  think there is a solution for running a git daemon on a shared host.

Petr pointed out to me that an NSLU2 is late 90's equivalent not early
so my memory if faulty too.


>
>                 Linus
>


-- 
Jon Smirl
jonsmirl@gmail.com
