From: Jeff King <peff@peff.net>
Subject: Re: [GSoC update] Sequencer for inclusion
Date: Tue, 12 Jul 2011 02:47:07 -0400
Message-ID: <20110712064706.GA13375@sigill.intra.peff.net>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <20110711171713.GA5963@elie>
 <7vpqlgbjmd.fsf@alter.siamese.dyndns.org>
 <20110711221419.GE30155@sigill.intra.peff.net>
 <CALkWK0n41LZ8-ZU2M1oD_ddJ2g2A47MxuO8w+5Ew6Php8gvF+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Miles Bader <miles@gnu.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 08:47:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgWkW-0008AK-5A
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 08:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287Ab1GLGrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 02:47:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53368
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754638Ab1GLGrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 02:47:09 -0400
Received: (qmail 10115 invoked by uid 107); 12 Jul 2011 06:47:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Jul 2011 02:47:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jul 2011 02:47:07 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0n41LZ8-ZU2M1oD_ddJ2g2A47MxuO8w+5Ew6Php8gvF+g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176933>

On Tue, Jul 12, 2011 at 12:11:44PM +0530, Ramkumar Ramachandra wrote:

> > Or is it something that, like the information in .git/rebase-apply,
> > people might want to read or tweak? In that case, might it make sense to
> > follow that lead and split things into one file per item? That keeps the
> > parsing burden extremely low for things like shell scripts (or shell
> > users) who might want to read or tweak.
> 
> Yes, it's a little like the information in .git/rebase-apply.  We
> should give the user the ability to tweak it by hand: the result from
> sq_quote_argv and sq_dequote_argv would look very ugly.  Hm, I don't
> like the one-file-per-command-line-option approach because: we might
> only have a few options now, but when the sequencer is built to
> support many actions and options, the directory will be polluted with
> lots of files.  I was thinking more along the lines of something that
> can be parsed using gitconfig.

I don't consider having lots of files there "pollution", but rather "a
well-used key/value store". But I suppose it is in the eye of the
beholder. :)

Using git-config is maybe a little more self-documenting than something
like "sq_quote_argv". And probably not much more code (maybe even less,
since it can handle the file update for you).

I recently used the config code to write out a non-standard config file.
My two complaints were:

  1. You can't queue up a bunch of changes and then write the file once.
     Every time you call git_config_set, it rewrites the whole file.

  2. There's no way to write to a nonstandard file short of the horribly
     hack-ish:

       const char *saved = config_exclusive_filename;
       config_exclusive_filename = "foo.conf";
       git_config_set(...);
       config_exclusive_filename = saved;

Point (2) is pretty easy to fix. But point (1) might be a bit more
involved. I haven't really looked yet.

-Peff
