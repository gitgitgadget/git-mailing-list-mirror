From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] builtin/grep: allow implicit --no-index
Date: Mon, 11 Jan 2016 12:59:19 -0500
Message-ID: <20160111175919.GA11724@sigill.intra.peff.net>
References: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
 <1452435597-12099-4-git-send-email-t.gummerer@gmail.com>
 <CACsJy8Bs3z0Gk3CjhyZGfOLA7R3pZQz7K5gk4BTytvYkZeyBtQ@mail.gmail.com>
 <20160111111015.GA10612@hank>
 <xmqqlh7wxc0y.fsf@gitster.mtv.corp.google.com>
 <20160111174817.GC10612@hank>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 18:59:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIgkY-0004b7-J1
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 18:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760317AbcAKR7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 12:59:22 -0500
Received: from cloud.peff.net ([50.56.180.127]:51401 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758586AbcAKR7W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 12:59:22 -0500
Received: (qmail 5524 invoked by uid 102); 11 Jan 2016 17:59:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jan 2016 12:59:21 -0500
Received: (qmail 2979 invoked by uid 107); 11 Jan 2016 17:59:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jan 2016 12:59:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jan 2016 12:59:19 -0500
Content-Disposition: inline
In-Reply-To: <20160111174817.GC10612@hank>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283685>

On Mon, Jan 11, 2016 at 06:48:17PM +0100, Thomas Gummerer wrote:

> > "We run 'git grep' in random places and relied on it to fail when
> > run in somewhere not under control of Git." feels so flawed at
> > multiple levels that I doubt it deserves to be kept working.  For
> > one thing, "git grep" is not the way to tell something is under
> > control of Git (rev-parse would be a better thing for scriptor to
> > use).  For another, how would such a script tell between "not a
> > git repository" and there was no hits?
> 
> I agree that scripts don't deserve to be kept working in that case.
> What about a user though who accidentally runs git grep outside of a
> repository, and is usually warned by git failing quickly, whereas with
> the changed behavior some time might go by until the user realizes the
> error.  Not sure if we want to support this use case or not?

Yeah, I don't think git would be _wrong_ here, but I could certainly see
it being annoying. Several times a week I probably run `git grep` in my
home directory, and after seeing its error, realize "oops, I meant to
`cd git`".

Having it spew nonsense results, and/or appear to hang while it
literally reads every file on my disk would be at least a minor
annoyance.

But I don't think any kind of command-line flag would help that; I'm not
going to start typing "git grep --use-index=never" for every invocation.
I think the only sensible mitigation would be a config option, so that
people who rarely use `--no-index` (and are OK with having to specify
it) do not get punished by false positives.

I dunno. Maybe I would find the new behavior so useful I would be OK
with the occasional false-positive. But when we make a release with the
new behavior and somebody _does_ complain, it sure would be nice not to
have to say "deal with it; it's the new behavior and there is no escape
hatch".

-Peff
