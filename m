From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Tue, 7 Jan 2014 16:30:52 -0500
Message-ID: <20140107213052.GA28798@sigill.intra.peff.net>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
 <1389028732-27760-3-git-send-email-artagnon@gmail.com>
 <xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
 <CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com>
 <xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com>
 <CALkWK0nSed9vvRvTR00_vV3tHL8mSQA=8JJ_Y7=pQchoVcvhzA@mail.gmail.com>
 <xmqqha9ghhrw.fsf@gitster.dls.corp.google.com>
 <CALkWK0=Km+a7NBm9ki5MN=R28HkzUZRqnBKcpuPZDrQKdsBesg@mail.gmail.com>
 <20140107210607.GB28102@sigill.intra.peff.net>
 <CALkWK0==wNMvjHmwnGaQi+RitXgros39+70zWH29=Q238Rkp5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 22:30:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0eEk-0005Rl-Jc
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 22:30:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753977AbaAGVaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 16:30:55 -0500
Received: from cloud.peff.net ([50.56.180.127]:56719 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751114AbaAGVay (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 16:30:54 -0500
Received: (qmail 25607 invoked by uid 102); 7 Jan 2014 21:30:54 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jan 2014 15:30:54 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jan 2014 16:30:52 -0500
Content-Disposition: inline
In-Reply-To: <CALkWK0==wNMvjHmwnGaQi+RitXgros39+70zWH29=Q238Rkp5A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240160>

On Wed, Jan 08, 2014 at 02:55:04AM +0530, Ramkumar Ramachandra wrote:

> Jeff King wrote:
> > My daily procedure is something like:
> >
> >   all_topics |
> >   while read topic; do "echo $topic $(git rev-parse $topic@{u})"; done |
> >   topo_sort |
> >   while read topic upstream; do
> >     git rebase $upstream $topic || exit 1
> >   done
> 
> Ah, I was perhaps over-specializing for my own usecase, where
> everything is based off 'master'. I never considered 'master' a "true
> upstream" because I throw away topic branches after the maintainer
> merges them. If you have long-running branches that you work on a
> daily basis, the issue is somewhat different.

What I do is maybe somewhat gross, but I continually rebase my patches
forward as master develops. So they diverge from where Junio has forked
them upstream (which does not necessarily have any relationship with
where I forked from, anyway). The nice thing about this is that
eventually the topic becomes empty, as rebase drops patches that were
merged upstream (or resolve conflicts to end up at an empty patch).

It's a nice way of tracking the progress of the patch upstream, and it
catches any differences between what's upstream and what's in the topic
(in both directions: you see where the maintainer may have marked up
your patch, and you may see a place where you added something to be
squashed but the maintainer missed it). The downside is that sometimes
the conflicts are annoying and complicated (e.g., several patches that
touch the same spot are a pain to rebase on top of themselves; the early
ones are confused that the later changes are already in place).

> My primary concern is that the proposed @{publish} should be a
> first-class citizen; if it has everything that @{u} has, then we're
> both good: you'd primarily use @{u}, while I'd primarily use
> @{publish}.

Definitely. I think that's the world we want to work towards.

-Peff
