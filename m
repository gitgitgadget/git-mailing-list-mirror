From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 2/2] git-patch-id: do not trip over "no newline" markers
Date: Fri, 18 Feb 2011 05:40:35 -0500
Message-ID: <20110218104035.GA7262@sigill.intra.peff.net>
References: <d27aa07556df763b34b980d3706320216094d592.1297928549.git.git@drmicha.warpmail.net>
 <536855b39d0ab5bb657ee6117a7e7c6bb0de0027.1297928549.git.git@drmicha.warpmail.net>
 <20110218041609.GA12348@sigill.intra.peff.net>
 <4D5E278F.2010509@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 18 11:40:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqNld-0005mz-NG
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 11:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191Ab1BRKkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 05:40:41 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:56720 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932076Ab1BRKkj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 05:40:39 -0500
Received: (qmail 30950 invoked by uid 111); 18 Feb 2011 10:40:37 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 18 Feb 2011 10:40:37 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Feb 2011 05:40:35 -0500
Content-Disposition: inline
In-Reply-To: <4D5E278F.2010509@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167194>

On Fri, Feb 18, 2011 at 09:02:23AM +0100, Michael J Gruber wrote:

> > Wow, that's pretty obscure. I wonder if the test should be factored out
> > into line_is_no_newline_at_end_of_file() (or surely there is some more
> > sensible name), and used by both apply and patch-id. Along with a nice
> > comment (which I see apply already has) describing what in the world the
> > magic number 12 means.
> 
> So, where do you suggest it should go? As far as I can see, we have two
> places reading these markers (the above builtins) and two places writing
> them (diff.c, xdiff/xutils.c), at least for git-core.

I think you could ignore the writers, as they are much more
straightforward.  But...

> (git-gui's diff.tcl has its own strict check etc.)

Ugh. Factoring that out with the C code would not be easy. :)

> I would opt for putting a more detailed explanation in the commit
> message (reasoning + ref. to apply.c) rather then trying to factor this.

I think that's OK. It's not a lot of code, it's just very non-obvious.
So a comment is probably as good as a refactor.

> After all, our code is largely undocumented as far as inline
> documentation goes (it has frustrated me a few times), and the more
> comprehensive documentation are the commit messages which git blame
> points you to.

Yeah, it is sometimes annoying. On the other hand, you know that a
comment in the commit log cannot be stale, because you are viewing it in
context (well, it can be, but theoretically you have the tools to
determine that).

I'm not sure what the right balance is. I tend to write inline comments
for small non-obvious things (e.g., why a variable is being strdup'd),
and describe the bigger picture in the commit message (e.g., why a
particular algorithm was chosen).

But it has only been a few years that we've had version control systems
where history browsing wasn't absolutely horrendous. Maybe in another
decade or so there will be best practices for this sort of thing. :)

-Peff
