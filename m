From: Jeff King <peff@peff.net>
Subject: Re: What's in git.git (stable frozen)
Date: Sun, 6 Jan 2008 15:59:46 -0500
Message-ID: <20080106205946.GA17482@coredump.intra.peff.net>
References: <7vve78qhtf.fsf@gitster.siamese.dyndns.org> <7vbq8v5n0u.fsf_-_@gitster.siamese.dyndns.org> <7vy7btaf4p.fsf@gitster.siamese.dyndns.org> <7vfxxtu5ov.fsf@gitster.siamese.dyndns.org> <7v63y8ble8.fsf@gitster.siamese.dyndns.org> <20080106042409.GA4843@coredump.intra.peff.net> <20080106042935.GB4843@coredump.intra.peff.net> <7vejcv5is3.fsf@gitster.siamese.dyndns.org> <20080106111725.GA11603@coredump.intra.peff.net> <7vy7b33zjk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 22:00:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBcbn-0005Fh-5V
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 22:00:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024AbYAFU7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 15:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754646AbYAFU7u
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 15:59:50 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4892 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754691AbYAFU7t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 15:59:49 -0500
Received: (qmail 1109 invoked by uid 111); 6 Jan 2008 20:59:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 06 Jan 2008 15:59:47 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Jan 2008 15:59:46 -0500
Content-Disposition: inline
In-Reply-To: <7vy7b33zjk.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69744>

On Sun, Jan 06, 2008 at 04:32:15AM -0800, Junio C Hamano wrote:

> Yeah, I like that much better, especially the renaming of
> $use_color to more descriptive (but is it really about "menu", I
> wonder?).

I thought that, too, but I didn't know what better word to use
(something like "display" doesn't make it clear that it doesn't involve
the diff).

> I might consider rewriting this part
> 
> > +my $menu_use_color = $repo->get_colorbool('color.interactive');
> > +my ($prompt_color, $header_color, $help_color) =
> > +	$menu_use_color ? (
> > +		$repo->get_color('color.interactive.prompt', 'bold blue'),
> > +		$repo->get_color('color.interactive.header', 'bold'),
> > +		$repo->get_color('color.interactive.help', 'red bold'),
> > +	) : ();
> 
> like this:
> 
> 	my ($prompt_color, $header_color, $help_color, $fraginfo_color);
>         if ($colored_prompt) {
>         	$prompt_color = ...;
>                 $header_color = ...;
>         }
> 	if ($colored_diff) {
>         	$fraginfo_color = ...;
> 	}

Actually, that's more or less how it's written before my patch (in fact,
you could eliminate that part of my patch and just move $normal_color
outside of the conditional). However I didn't like having the
declaration and the assignment so far apart (and duplicated). But I will
admit my version is a little nested. Please feel free to switch it when
you apply.

> or even like this:
> 
> 	my (%palette);
>         if ($colored_prompt) {
> 		my %default = (
>                 	prompt => 'bold blue',
>                         header => 'bold',
>                         ...
> 		);
>                 while (my ($k,$v) = each %default) {
>                     $palette{$k} = $repo->get_color("color.interactive.$k",$v);
> 		}
> 	}
> 
> But I realize that's going overboard.  Certainly the last one is
> doing unnecessary generalization for generalization's sake.

Yes, I considered making a %palette, as well, but it just seemed a
little gratuitous (and the nice thing about using variables is that they
catch typos better).

-Peff
