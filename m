From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC] pull/fetch rename
Date: Wed, 21 Oct 2009 00:53:28 +0200
Message-ID: <200910210053.29794.trast@student.ethz.ch>
References: <200910201947.50423.trast@student.ethz.ch> <200910201359.30880.wjl@icecavern.net> <7vpr8hlow9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>,
	=?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Junio C Hamano <gitster@pobox.com>,
	"Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Wed Oct 21 01:08:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Nam-0005sF-94
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 00:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305AbZJTWyC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 18:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbZJTWyB
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 18:54:01 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:29445 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751284AbZJTWyA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 18:54:00 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 21 Oct
 2009 00:54:05 +0200
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 21 Oct
 2009 00:54:03 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <7vpr8hlow9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130864>

Junio C Hamano wrote:
> "Wesley J. Landaker" <wjl@icecavern.net> writes:
> > d) in mercurial, pull/push are symmetric, but fetch means pull+merge

Ugh.  I can see how they arrived at hg-pull == git-fetch, but why on
earth was the logical next step hg-fetch == git-pull?!

</aside>

> > I would love to see this change, not because I get confused about pull/fetch 
> > (it honestly only took a few days to get used to), but because having 
> > push/pull be symmetric just is so much more conceptually pure / easier 
> > explain to co-workers / separation between orthogonal operations / 
> > satisfying to my inner perfectionist / etc.
> 
> Is making "pull" a symmetric opposite of "push" the ultimate goal?
> 
> Or is making (or rather "keeping") "pull" useful more important?
> 
> It is not even an attitude that values philosophy over utility.
> 
> Fundamentally, pull and push cannot be symmetric because nobody is sitting
> in front of the repository you are pushing into (that is what a "push" is;
> you push from outside the repository---otherwise you would be "pull"ing
> from inside it in the other direction), but you know you are sitting in
> the repository, ready to resolve potential conflicts, when you say "pull".

Well, I'd rather not argue the little semantic details, but I think
with the changes to disallow pushing into HEAD, push and fetch are as
symmetric as it gets.  Both are exactly and only about transmitting
refs with their associated commits to the other side.  Which one you
pick only depends on which side you sit on.

OTOH pull is about merging.  And we can repeat the "pull = fetch +
merge" mantra to ourselves all we like, having pull as "the opposite
of push" is conceptually much easier to understand and thus far easier
to explain to new users.

> And you are doing this for what gain?  The only thing I can think of is
> "People who deliberately set 'pull.merge = yes' can no longer blame us for
> pull not being the opposite of push."  I do not consider it as a gain.
> 
> I do not buy "People who set 'pull.merge = yes' now understand why pull
> touches their work tree, because they did it themselves" either.
[...]
> But I do not know what to say when people say "push cannot update the work
> tree, so let's make pull not to update the work tree by default---it will
> make it much less useful so we will fix that regression with yet another
> configuration option".

There would not be a configuration option.

Really, the whole goal would be to make pull the opposite of push.  No
exceptions, and most certainly no little loopholes to escape into the
merging behaviour by default.  The current 'git pull' behaviour would
either be obtained through a new command, or through an explicit
switch.

> I would be much more sympathetic if the suggested approach were to make
> "push" more symmetric to "pull", or at least attempt to allow it to be, by
> giving it an option to update the associated work tree when it can [*1*].
[...]
> *1* Obviously you cannot do this most of the time _if_ the work tree has
> an interactive user sitting in front of it, but in a repository that never
> allows a non-ff push, with a work tree that is never updated except by
> such a push, can reasonably be maintained to give an illusion of push
> being an opposite of pull by fast forwarding the work tree when the push
> updates HEAD.

Well, that reminds me of

  http://thread.gmane.org/gmane.comp.version-control.git/110251

but was not really what I was aiming at.

> It's not even funny.

It was an RFC, not a joke ;-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
