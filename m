From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] Added diff hunk coloring to git-add--interactive
Date: Thu, 22 Nov 2007 07:25:41 -0500
Message-ID: <20071122122540.GH12913@sigill.intra.peff.net>
References: <20071017015152.GN13801@spearce.org> <20071022164048.71a3dceb@danzwell.com> <20071023042702.GB28312@coredump.intra.peff.net> <20071023035221.66ea537f@danzwell.com> <20071102224100.71665182@paradox.zwell.net> <20071104045735.GA12359@segfault.peff.net> <7v640ivagv.fsf@gitster.siamese.dyndns.org> <20071104054305.GA13929@sigill.intra.peff.net> <20071110180109.34febc3f@paradox.zwell.net> <20071122045624.405e2b2b@paradox.zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Dan Zwell <dzwell@zwell.net>
X-From: git-owner@vger.kernel.org Thu Nov 22 13:26:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvB85-0003OJ-S5
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 13:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbXKVMZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 07:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752019AbXKVMZn
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 07:25:43 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2634 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751633AbXKVMZn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 07:25:43 -0500
Received: (qmail 23563 invoked by uid 111); 22 Nov 2007 12:25:41 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 22 Nov 2007 07:25:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2007 07:25:41 -0500
Content-Disposition: inline
In-Reply-To: <20071122045624.405e2b2b@paradox.zwell.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65817>

On Thu, Nov 22, 2007 at 04:56:24AM -0600, Dan Zwell wrote:

> -		else { # set up colors
> -			# Grab the 3 main colors in git color string format, with sane
> -			# (visible) defaults:
> -			$prompt_color = Git::color_to_ansi_code(
> -				scalar $repo->config_default('color.interactive.prompt',
> -					'bold blue'));

These were just added in the last patch. I know sometimes it is worth
showing the progression of work as the patches go, but in this case, I
think it is simpler for the reviewers if the first patch which adds a
chunk of code does it in the final way (even if you need to just say "I
did it this way because there will be reasons later on.").

> +	sub get_color {
> +		my ($key, $default) = @_;
> +		return Git::color_to_ansi_code(
> +			scalar $repo->config_default($key, $default));
> +	}

Ah, so you agree that this is a good route. I think this should probably
be Git::config_color.

There is also a subtle issue, which is that it pulls the "$repo"
variable from the outer lexical scope (as Git::config_color, it would
take it as the first parameter).

> +		$prompt_color = get_color('color.interactive.prompt', 'bold blue');
> +		$header_color = get_color('color.interactive.header', 'bold');
> +		$help_color = get_color('color.interactive.help', 'red bold');
> +		$normal_color = Git::color_to_ansi_code('normal');

Yeah, much nicer to read.

> +	if ($diff_use_color) {
> +		$new_color = get_color('color.diff.new', 'green');
> +		$old_color = get_color('color.diff.old', 'red');
> +		$fraginfo_color = get_color('color.diff.frag', 'cyan');
> +		$metainfo_color = get_color('color.diff.meta', 'bold');
> +		$normal_color = Git::color_to_ansi_code('normal');
> +		# Not implemented:
> +		#$whitespace_color = get_color('color.diff.whitespace',
> +			#'normal red');

Unfortunately, there is a historical wart that probably still needs
supporting, which is that the original names were diff.color.*. Or have
we officially removed support for that yet?

-Peff
