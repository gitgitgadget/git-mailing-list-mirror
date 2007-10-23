From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Let git-add--interactive read colors from
	git-config
Date: Tue, 23 Oct 2007 00:27:02 -0400
Message-ID: <20071023042702.GB28312@coredump.intra.peff.net>
References: <471045DA.5050902@gmail.com> <19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com> <20071013172745.GA2624@coredump.intra.peff.net> <20071013175127.GA3183@coredump.intra.peff.net> <47112491.8070309@gmail.com> <20071015034338.GA4844@coredump.intra.peff.net> <20071016194709.3c1cb3a8@danzwell.com> <20071017015152.GN13801@spearce.org> <20071022164048.71a3dceb@danzwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Dan Zwell <dzwell@zwell.net>
X-From: git-owner@vger.kernel.org Tue Oct 23 06:27:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkBMQ-0008B7-9D
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 06:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbXJWE1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 00:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbXJWE1I
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 00:27:08 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1636 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846AbXJWE1H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 00:27:07 -0400
Received: (qmail 31410 invoked by uid 111); 23 Oct 2007 04:27:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 23 Oct 2007 00:27:03 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Oct 2007 00:27:02 -0400
Content-Disposition: inline
In-Reply-To: <20071022164048.71a3dceb@danzwell.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62081>

On Mon, Oct 22, 2007 at 04:40:48PM -0500, Dan Zwell wrote:

> Note: the code to parse git-style color strings to perl-style color
> strings should eventually be added to Git.pm so that other (perl)
> parts of git can be configured to read colors from .gitconfig in
> a nicer way. A git-style string is "ul red black", while perl 
> likes strings like "underline red on_black".

Why not do it as part of this patch, then?

> +	# Sane (visible) defaults:
> +	if (! @git_prompt_color) {
> +		@git_prompt_color = ("blue", "bold");
> +	}

I think it might be a bit more readable to keep the assignment and
defaults together:

  my @git_prompt_color = split /\s+/,
    qx(git config --get color.interactive.prompt) || 'blue bold';

Though I wonder why we are splitting here at all, since we just end up
converting the list into a scalar below. And if we just turned that into
a function, we could get a nice:

  my $prompt_color = git_color_to_ansicolor(
    qx(git config --get color.interactive.prompt) || 'blue bold');

-Peff
