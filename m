From: Jeff King <peff@peff.net>
Subject: Re: start of git2 (based on libgit2)
Date: Sat, 26 Mar 2011 09:29:15 -0400
Message-ID: <20110326132915.GA2859@sigill.intra.peff.net>
References: <20110325231203.GA7961@jakstys.lt>
 <4D8D2B31.4040908@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Motiejus =?utf-8?Q?Jak=C5=A1tys?= <desired.mta@gmail.com>,
	git@vger.kernel.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Sat Mar 26 14:29:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3TYR-0005ku-TD
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 14:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838Ab1CZN3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2011 09:29:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51656
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751660Ab1CZN3S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2011 09:29:18 -0400
Received: (qmail 23941 invoked by uid 107); 26 Mar 2011 13:29:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 26 Mar 2011 09:29:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Mar 2011 09:29:15 -0400
Content-Disposition: inline
In-Reply-To: <4D8D2B31.4040908@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170052>

On Sat, Mar 26, 2011 at 12:54:25AM +0100, Vincent van Ravesteijn wrote:

> http://librelist.com/browser/libgit2/
> >According to Jeff King[2], I should start with plumbing commands. I
> >agree.  However, how deep?  I.e. do I have to make sure all git rev-list
> >possible arguments are implemented?
> 
> I guess a lot can be copied from Git itself. Actually
> builtin/rev-list.c consists mostly of command line arguments parsing
> methods, and outputting functions. The key is to parse what you want
> to know and ask libgit2 to provide the info. If libgit2 has
> implemented the basic functionality that is needed, the rest would be
> relatively simple.

I wouldn't worry about having _every_ argument. Some arguments are much
less frequently used than others. For example, start with basic stuff,
like including and excluding commits (e.g., "branch1 ^branch2"),
--max-count, --{min,max}-age, --grep, and others. Do common things like
path limiting. And then once all that is done and tested, start worrying
about things like --cherry-pick (or maybe not, and focus on the basics
of other simple commands).

> >Are we aiming for a distributed 100s of executables architecture
> >(current git), or single huge binary? I would go for single executable
> >for to higher portability. Is that ok?
> 
> AFAICS, current git is a single binary on Windows already.

Even on Linux, most of the commands are just hardlinks to the git
executable. Most commands are built-in these days. A few are still
external but written in C (sometimes because we want to keep them small
and external, like git-daemon and git-shell). But there are still some
commands written in other languages, like pull, stash, and
add--interactive.

Check out the BUILTIN_OBJS, PROGRAM_OBJS, and SCRIPT_* variables in the
Makefile.

So yeah, for basic commands, one monolithic binary is probably fine.

-Peff
