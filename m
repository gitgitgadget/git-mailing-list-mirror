From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Added basic color support to git add --interactive
Date: Tue, 23 Oct 2007 00:03:16 -0400
Message-ID: <20071023040315.GA28312@coredump.intra.peff.net>
References: <471045DA.5050902@gmail.com> <19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com> <20071013172745.GA2624@coredump.intra.peff.net> <20071013175127.GA3183@coredump.intra.peff.net> <47112491.8070309@gmail.com> <20071015034338.GA4844@coredump.intra.peff.net> <20071016194709.3c1cb3a8@danzwell.com> <20071017015152.GN13801@spearce.org> <20071022163244.4af72973@danzwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Dan Zwell <dzwell@zwell.net>
X-From: git-owner@vger.kernel.org Tue Oct 23 06:03:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkAzV-0003CF-Nw
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 06:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbXJWEDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 00:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbXJWEDT
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 00:03:19 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1265 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751393AbXJWEDS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 00:03:18 -0400
Received: (qmail 31310 invoked by uid 111); 23 Oct 2007 04:03:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 23 Oct 2007 00:03:17 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Oct 2007 00:03:16 -0400
Content-Disposition: inline
In-Reply-To: <20071022163244.4af72973@danzwell.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62078>

On Mon, Oct 22, 2007 at 04:32:44PM -0500, Dan Zwell wrote:

> +my ($use_color, $prompt_color, $header_color, $help_color);
> +my $color_config = qx(git config --get color.interactive);
> +if ($color_config=~/true|always/ || -t STDOUT && $color_config=~/auto/) {
> +	$use_color = "true";
> +        # Sane (visible) defaults:
> +        $prompt_color = "blue bold";
> +        $header_color = "bold";
> +        $help_color = "red bold";

Bad indentation?

> +sub print_colored {
> +	my $color = shift;
> +	my @strings = @_;
> +
> +	if ($use_color) {
> +		print Term::ANSIColor::color($color);
> +		print(@strings);
> +		print Term::ANSIColor::color("reset");
> +	} else {
> +		print @strings;
> +	}
> +}

This does nothing for embedded newlines in the strings, which means that
you can end up with ${COLOR}text\n${RESET}, which fouls up changed
backgrounds. See commit 50f575fc. Since the strings you are printing are
small, I don't see any problem with making a copy, using a regex to
insert the color coding, and printing that (I think I even posted
example code in a previous thread on this subject).

-Peff
