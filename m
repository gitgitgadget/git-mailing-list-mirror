From: Dan Zwell <dzwell@zwell.net>
Subject: Re: [PATCH 2/2] Let git-add--interactive read colors from
 git-config
Date: Tue, 23 Oct 2007 03:52:21 -0500
Message-ID: <20071023035221.66ea537f@danzwell.com>
References: <471045DA.5050902@gmail.com>
	<19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com>
	<20071013172745.GA2624@coredump.intra.peff.net>
	<20071013175127.GA3183@coredump.intra.peff.net>
	<47112491.8070309@gmail.com>
	<20071015034338.GA4844@coredump.intra.peff.net>
	<20071016194709.3c1cb3a8@danzwell.com>
	<20071017015152.GN13801@spearce.org>
	<20071022164048.71a3dceb@danzwell.com>
	<20071023042702.GB28312@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 23 10:55:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkFXW-0007oT-UW
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 10:55:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbXJWIyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 04:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbXJWIyH
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 04:54:07 -0400
Received: from gator290.hostgator.com ([74.53.26.226]:53400 "EHLO
	gator290.hostgator.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbXJWIyG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 04:54:06 -0400
Received: from [143.44.70.185] (port=58469 helo=danzwell.com)
	by gator290.hostgator.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <dzwell@zwell.net>)
	id 1IkFWR-0001hl-My; Tue, 23 Oct 2007 03:53:59 -0500
In-Reply-To: <20071023042702.GB28312@coredump.intra.peff.net>
X-Mailer: Claws Mail 3.0.2 (GTK+ 2.10.14; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator290.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - zwell.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62122>

On Tue, 23 Oct 2007 00:27:02 -0400
Jeff King <peff@peff.net> wrote:

> On Mon, Oct 22, 2007 at 04:40:48PM -0500, Dan Zwell wrote:
> 
> > Note: the code to parse git-style color strings to perl-style color
> > strings should eventually be added to Git.pm so that other (perl)
> > parts of git can be configured to read colors from .gitconfig in
> > a nicer way. A git-style string is "ul red black", while perl 
> > likes strings like "underline red on_black".
> 
> Why not do it as part of this patch, then?
Will do. I didn't include it in the patch because I need to learn more
about perl before I can make this change, though I can probably just
find enough examples in the other scripts that use Git.pm.

> 
> > +	# Sane (visible) defaults:
> > +	if (! @git_prompt_color) {
> > +		@git_prompt_color = ("blue", "bold");
> > +	}
> 
> I think it might be a bit more readable to keep the assignment and
> defaults together:
> 
>   my @git_prompt_color = split /\s+/,
>     qx(git config --get color.interactive.prompt) || 'blue bold';
> 
> Though I wonder why we are splitting here at all, since we just end up
> converting the list into a scalar below. And if we just turned that
> into a function, we could get a nice:
> 
>   my $prompt_color = git_color_to_ansicolor(
>     qx(git config --get color.interactive.prompt) || 'blue bold');
I agree, now that you mention it. Eventually the string must be split
(parsing it left to right by word makes more sense than trying to
mutate it with regular expressions, if only because it's a lot harder
to make mistakes), but there's no reason not to split the string inside
the loop, where it would look nicer/more contained. I will make this
change.

Dan
