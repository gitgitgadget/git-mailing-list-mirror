From: Philip Hofstetter <phofstetter@sensational.ch>
Subject: Re: git-mailinfo doesn't stop parsing at the end of the header
Date: Wed, 18 Nov 2009 20:57:16 +0100
Message-ID: <aa2993680911181157y750eae95sc2932b03d938d6fb@mail.gmail.com>
References: <aa2993680911180620g151d8a07t11144d150cd6e29e@mail.gmail.com> 
	<20091118155154.GA15184@coredump.intra.peff.net> <aa2993680911180911o7e3af804m4ebdc20096baa609@mail.gmail.com> 
	<20091118172424.GA24416@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 20:58:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAqfA-0006sD-4k
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 20:58:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758521AbZKRT5f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Nov 2009 14:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758517AbZKRT5e
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 14:57:34 -0500
Received: from mail.sensational.ch ([195.226.6.199]:54980 "EHLO
	mail.sensational.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758512AbZKRT5d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Nov 2009 14:57:33 -0500
Received: from [209.85.216.192] (helo=mail-px0-f192.google.com)
	by mail.sensational.ch with esmtp (Exim 4.50)
	id 1NAqeo-0002DH-1q
	for git@vger.kernel.org; Wed, 18 Nov 2009 20:57:38 +0100
Received: by pxi30 with SMTP id 30so969905pxi.14
        for <git@vger.kernel.org>; Wed, 18 Nov 2009 11:57:36 -0800 (PST)
Received: by 10.141.41.21 with SMTP id t21mr647610rvj.93.1258574256157; Wed, 
	18 Nov 2009 11:57:36 -0800 (PST)
In-Reply-To: <20091118172424.GA24416@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133198>

Hello,

On Wed, Nov 18, 2009 at 6:24 PM, Jeff King <peff@peff.net> wrote:

> =A01. It creates a bad user experience. You are not unreasonable for
> =A0 =A0 wanting to put some specific text in your commit message. Hav=
ing
> =A0 =A0 git come back and say "oops, I might get confused by this lat=
er"
> =A0 =A0 just seems like an annoyance to the user.

agreed, though it's not that bad: when learning git, you will be
confronted with the fact that the commit message has a few things that
are special (well. it's doesn't break git, but the first line should
be < 56 chars in length for example).

Not being able to have From: lines in them that are not describing an
author would then just be one of them.

> =A02. Mailinfo has to deal with data created by older versions of git=
=2E So
> =A0 =A0 in your case, the rebase was a bomb waiting to go off. If we =
can
> =A0 =A0 fix it so that an existing bomb doesn't go off, rather than n=
ot
> =A0 =A0 creating the bomb in the first place, then we are better off.

This is a very good point. I didn't quite think about that.

> =A04. Commit messages can come from other places than "git commit". W=
hat
> =A0 =A0 should we do with a commit message like this that is imported=
 from
> =A0 =A0 SVN? Reject the import? Munge the message?

I would leave that to the tool that does the import. Probably it would
have to munge it. Yes.

I DO see though that implementing the check at commit time would lead
to problems popping up at other places.

> Of course all of that presupposes that we can correctly handle the
> existing data after the fact. Even with my patch, you still can't wri=
te
> "From: foo@example.com" as the first line of your commit body. But th=
at

can't you? IMHO it would just attribute the commit to foo@example.com
which can be an equally bad, if not worse thing (I'm saying that
without the needed knowledge about git internals to really be sure, so
take this with a grain of salt)

I just have a bad feeling about trying out heuristics to see whether
thing thing after from: is an email address or not as email addresses
are notoriously hard to detect.

Typing a commit message and applying a patch from an email should be
separate things and should be handled separately. Currently they are
not and this is what's causing the problem in the first place.

Maybe that --strict thing is actually a good thing in the long run,
even though I don't quite like it either :-)

Interesting problem to have though.

Philip
