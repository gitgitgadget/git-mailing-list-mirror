From: Jeff King <peff@peff.net>
Subject: Re: Git archiving only branch work
Date: Fri, 14 Nov 2014 10:32:23 -0500
Message-ID: <20141114153222.GA23077@peff.net>
References: <5464a4e8.4a0.2bfa0e00.3067f800@geldenhuys.co.uk>
 <20141113133615.GA28346@lanh>
 <20141113200640.GB3869@peff.net>
 <xmqqvbmizu12.fsf@gitster.dls.corp.google.com>
 <20141113213318.GA7563@peff.net>
 <xmqqa93uzssv.fsf@gitster.dls.corp.google.com>
 <20141113213937.GD7563@peff.net>
 <xmqq61eizs9v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Graeme Geldenhuys <mailinglists@geldenhuys.co.uk>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 16:32:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpIrd-0000X3-VQ
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 16:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965756AbaKNPc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 10:32:27 -0500
Received: from cloud.peff.net ([50.56.180.127]:40367 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965730AbaKNPcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 10:32:25 -0500
Received: (qmail 2560 invoked by uid 102); 14 Nov 2014 15:32:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Nov 2014 09:32:24 -0600
Received: (qmail 12688 invoked by uid 107); 14 Nov 2014 15:32:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Nov 2014 10:32:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Nov 2014 10:32:23 -0500
Content-Disposition: inline
In-Reply-To: <xmqq61eizs9v.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 13, 2014 at 01:48:12PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I agree they are technically orthogonal, but I cannot think of a case
> > where I have ever generated actual _pathspecs_, which might have
> > wildcards, and needed to use "-z". The point of using "-z" is that you
> > do not know what crap you are feeding.
> 
> You do not have to generate, i.e. you should be allowed to do this:
> 
>     $ git cmd --stdin -z <list-of-patterns

Right. My point is that I am not sure anybody ever really _wants_ to do
this, versus:

  git cmd -- "$pattern1" "$pattern2"

Because patterns tend to be small in number and made with predictable
characters known to the script writer. It is sets of arbitrary filenames
that tend to be long and contain random junk.

> And this is not about "flexibility".  Unless your plan is to forbid
> a corner case you do not anticipate and always disable pathspec
> globbing, you would need to say something like:

I had just assumed we would forbid, but yeah, you could have a switch to
handle either case. That is much nicer to the corner case people.

> Which is awkward.  And "--stdin -z" is most likely used in scripts;
> we are not forcing people to keep typing --literal-pathspecs by
> leaving them orthogonal *and* people do not have to remember one
> more exception (the default of --literal-pathspecs is flipped only
> when --stdin -z is in use) to the rule.

It is not about "forcing to type". It is about "did not realize this was
a potential pitfall and did not write it in the script in the first
place".

-Peff
