From: Jeff King <peff@peff.net>
Subject: Re: [BUG] 'add -u' doesn't work from untracked subdir
Date: Sat, 5 Sep 2009 03:20:17 -0400
Message-ID: <20090905072017.GA5152@coredump.intra.peff.net>
References: <20090902080305.GA11549@neumann>
 <20090902081917.GA5447@coredump.intra.peff.net>
 <20090904070216.GA3996@darc.dnsalias.org>
 <20090905061804.GB29863@coredump.intra.peff.net>
 <7v8wgt98ms.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Clemens Buchacher <drizzd@aon.at>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 09:26:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjpfG-0002TF-Qc
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 09:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbZIEHUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 03:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbZIEHUT
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 03:20:19 -0400
Received: from peff.net ([208.65.91.99]:55713 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089AbZIEHUT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 03:20:19 -0400
Received: (qmail 25485 invoked by uid 107); 5 Sep 2009 07:20:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 05 Sep 2009 03:20:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Sep 2009 03:20:17 -0400
Content-Disposition: inline
In-Reply-To: <7v8wgt98ms.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127787>

On Sat, Sep 05, 2009 at 12:02:35AM -0700, Junio C Hamano wrote:

> The intent of 1.7.0 is to fix usability glitches and warts that everybody
> has long agreed are problematic.  People have *just started* discussing
> about this---it is not remotely close to "everybody has long agreed are
> problematic" criteria.  It is too late for 1.7.0.

What about a config option that could change the behavior? True, the
time-frame for discussion is much shorter, but we are not proposing to
make a change that would affect users who do not agree to it. And I
think the point of giving a long time-frame for discussion is to let
people decide whether a change that users do not agree to may affect
them in a bad way.

The real danger here is that users of the config option may be breaking
an interface that is used by scripts. But I feel that 1.7.0 is probably
the best time in the forseeable future to do that, as script-writers
already must be wary of the version change.

> I personally find "add -u" that defaults to the current directory more
> natural than always going to the root; same preference for "grep".
> Besides, "add -u subdir" must add subdir relative to the cwd, without
> going to the root.  Why should "add -u" sans argument behave drastically
> differently?

I agree that there is a certain consistency to the current behavior. But
I also find it terribly annoying, because I _always_ want it to do the
other thing, and it silently accepts the command without even telling
me, leaving me to find out ten minutes later that what I thought was
added was not ("git add", by contrast, yells at you in the same
situation).

I also happen to prefer the other behavior because it is easy to switch
the two options: "git add -u" versus "git add -u .", whereas with
current behavior I am stuck calculating (and typing) the correct number
of "../" markers.

But I respect the fact that even if we had infinite time for discussion,
there would be people who prefer it the opposite way to me. So how about
that config option?

> Speaking of cwd-ness, I sometimes find ls-tree irritating, but I think
> this is in "if we had known better we would have designed it differently,
> but because we didn't, because many scripts already depend on the current
> behaviour, and because we have an --full-name escape hatch, we are not
> likely to change it, ever" category.

I assume you mean "ls-files".  I have every once in a while been annoyed
by that, but given how infrequently I run ls-files, it is not a big
deal. :)

> If "git add -u ../.." (I mean "the grand parent directory", not "an
> unnamed subdirectory") did not work, it would be unexcusable and we would
> want to devise an migration path, but otherwise I do not think it is such
> a big deal.  I would say the commands that are used to incrementally build

As I mentioned above, not only is that annoying to use, but the real
problem is that I _expect_ the other behavior and it silently does the
opposite of what I want. You can argue that my brain is defective (for
not remembering, I mean -- we _know_ it's defective in other ways), but
certainly a config option would be useful to me.

> Oh, "git grep -e foo ../..", however, does not seem to work.  That might be
> something people may want to tackle.

Thanks for mentioning "git grep"; I had forgotten that I have been
bitten by expecting full-tree behavior from that in the past, too. A
config option should cover that, too. ;)

-Peff
