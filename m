From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] allow user aliases for the --author parameter
Date: Wed, 27 Aug 2008 08:40:10 -0400
Message-ID: <20080827124010.GA13094@coredump.intra.peff.net>
References: <20080821200255.GB27705@coredump.intra.peff.net> <48AE786C.20201@fastmail.fm> <20080822165047.GA3339@sigill.intra.peff.net> <7vzln492pc.fsf@gitster.siamese.dyndns.org> <20080822211902.GA31884@coredump.intra.peff.net> <48B3B8B0.4020609@fastmail.fm> <7vsksr1hgt.fsf@gitster.siamese.dyndns.org> <20080827001944.GA7347@coredump.intra.peff.net> <7v7ia3rnnq.fsf@gitster.siamese.dyndns.org> <48B52037.7030405@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Wed Aug 27 14:41:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYKKt-00034B-2o
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 14:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281AbYH0MkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 08:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754176AbYH0MkN
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 08:40:13 -0400
Received: from peff.net ([208.65.91.99]:2016 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754120AbYH0MkM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 08:40:12 -0400
Received: (qmail 12012 invoked by uid 111); 27 Aug 2008 12:40:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 27 Aug 2008 08:40:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2008 08:40:10 -0400
Content-Disposition: inline
In-Reply-To: <48B52037.7030405@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93891>

[resend, copy git list. Gah, Michael there is something about your
messages that causes me to keep dropping the git list when I reply. It
looks like maybe you send one message to the author without git@vger
cc'd, and then you send a different one 'to' the git list without the
original 'from' in the cc?]

On Wed, Aug 27, 2008 at 11:36:55AM +0200, Michael J Gruber wrote:

> I don't see a namespace problem as long as nobody uses "name" or "email"
> as $key.

It also ties our hands for putting more things in user.* later, since
now we will hurt users who have put their arbitrary aliases in user.*
(and who will rightly complain when we break their config).

> That said I'd suggest useralias.$key.{name,email} then which gives a
> cleaner separation and leaves the possibility to

I would be fine with that. Though I do think Junio's "automatic" version
is even nicer.

> - use the alias for other cases than --author - use other fields than
> name, email

I think the big user would be send-email; I don't know if that will ever
get converted to C, though.

> People who don't use this feature don't have any entries and don't pay
> anything.
> People who use this feature and have a moderate number of entries don't
> pay a recognizable price.
> People who use this feature and have a vast amount of entries should be
> told to implement an alias file parser ;)

This I agree with. :)

> I'd be happy with that approach as well for my use case. In general it
> may suffer from the uniqueness problem: If there's a recent commit
> authored by "Michael@Jeff.com" your "--author=Jeff" will resolve
> differently from yesterday, and you won't even notice (not even commit
> -v tells you). [ A typo is punished by a search through all commits;
> that's fine.]

The commit message template should say:

  Author: A U Thor <author@example.com>

but of course you won't see that if you are using "-m".

I wonder if there is a good way to warn that we have multiple matches.
Of course we expect many _exact_ matches if the author has multiple
commits, but we could look for distinct matches. However, even that will
turn up false positives, since some authors have multiple email
addresses.

-Peff
