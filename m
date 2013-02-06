From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Wed, 6 Feb 2013 17:56:16 -0500
Message-ID: <20130206225616.GI27507@sigill.intra.peff.net>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
 <5110BD18.3080608@alum.mit.edu>
 <20130205083327.GA4931@elie.Belkin>
 <5110DF1D.8010505@alum.mit.edu>
 <CACsJy8BhL4qDb8BgOVuaUFF_9GXvgu55urYyKqPuZMZCTCoLwA@mail.gmail.com>
 <7v4nhpckwd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 23:56:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3Dv0-0004Mc-P7
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 23:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757141Ab3BFW4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 17:56:20 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37200 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755489Ab3BFW4T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 17:56:19 -0500
Received: (qmail 11770 invoked by uid 107); 6 Feb 2013 22:57:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Feb 2013 17:57:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2013 17:56:16 -0500
Content-Disposition: inline
In-Reply-To: <7v4nhpckwd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215659>

On Wed, Feb 06, 2013 at 11:17:06AM -0800, Junio C Hamano wrote:

> Let me help unconfuse this thread.
> 
> I think the series as 8-patch series was poorly presented, and
> separating it into two will help understanding what they are about.
> 
> The first three:
> 
>   upload-pack: share more code
>   upload-pack: simplify request validation
>   upload/receive-pack: allow hiding ref hierarchies
> 
> is _the_ topic of the series.  As far as I am concerned (I am not
> speaking for Gerrit users, but am speaking as the Git maintainer),
> the topic is solely about uncluttering.  There may be refs that the
> server end may need to keep for its operation, but that remote users
> have _no_ business knowing about.  Allowing the server to keep these
> refs in the repository, while not showing these refs over the wire,
> is the problem the series solves.
> 
> In other words, it is not about "these are *usually* not wanted by
> clients, so do not show them by default".  It is about "these are
> not to be shown, ever".
> 
> OK?

Right. I am not opposed to this series, as it does have a use-case. And
if it helps Gerrit folks or other users unclutter, great. The fact that
I could throw away the custom receive.hiderefs patch we use at GitHub is
a bonus. If people want fancier things, they can do them separately.

_But_. As a potential user of the feature (to hide refs/pull/*), I do
not think it is sufficiently flexible for me to use transfer.hiderefs
(or uploadpack.hiderefs). We use "fetch" internally to migrate objects
between forks and our alternates repos. And in that case, we really do
want to see all refs. In other words, all fetches are not the same: we
would want upload-pack to understand the difference between a client
fetch and an internal administrative fetch. But this feature does not
provide that lee-way. Even if you tried:

  git fetch -u 'git -c uploadpack.hiderefs= upload-pack'

the list nature of the config variable means you cannot reset it.

This isn't a show-stopper for the series; it may just mean that it is
not a good fit for GitHub's use case, but others (like Gerrit) may
benefit. But since refs/pull is used as an example of where this could
be applied, I wanted to point out that it does not achieve that goal.

-Peff
