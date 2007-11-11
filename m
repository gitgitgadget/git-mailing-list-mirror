From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Subject: [PATCH 1/3] Added basic color support to git add --interactive
Date: Sun, 11 Nov 2007 11:56:29 -0800
Message-ID: <7vve88d09e.fsf@gitster.siamese.dyndns.org>
References: <47112491.8070309@gmail.com>
	<20071015034338.GA4844@coredump.intra.peff.net>
	<20071016194709.3c1cb3a8@danzwell.com>
	<20071017015152.GN13801@spearce.org>
	<20071022164048.71a3dceb@danzwell.com>
	<20071023042702.GB28312@coredump.intra.peff.net>
	<20071023035221.66ea537f@danzwell.com>
	<20071102224100.71665182@paradox.zwell.net>
	<20071104045735.GA12359@segfault.peff.net>
	<7v640ivagv.fsf@gitster.siamese.dyndns.org>
	<20071104054305.GA13929@sigill.intra.peff.net>
	<20071110202319.1f89a755@paradox.zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Dan Zwell <dzwell@zwell.net>
X-From: git-owner@vger.kernel.org Sun Nov 11 20:57:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrIvS-0004qe-LT
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 20:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756365AbXKKT4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 14:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753016AbXKKT4n
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 14:56:43 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40973 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755874AbXKKT4m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 14:56:42 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 619082F2;
	Sun, 11 Nov 2007 14:57:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id B4F70946C1;
	Sun, 11 Nov 2007 14:56:52 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64506>

Dan Zwell <dzwell@zwell.net> writes:

> Added function "colored()" that prints text with a color that
> is passed in. Converted many calls to "print" to being calls to
> "print colored".

You said "Let me know if other things need correction."  I think
most of the comments you recieved were about improvements not
correction, and I think I am going to say in this message will
also mostly fall into that category.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 8d5d200..3712d6a 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -382,6 +382,12 @@ color.diff.<slot>::
>  	whitespace).  The values of these variables may be specified as
>  	in color.branch.<slot>.
>  
> +color.interactive::
> +	When true (or `always`), always use colors in `git add
> +	--interactive`.  When false (or `never`), never.  When set to
> +	`auto`, use colors only when the output is to the
> +	terminal. Defaults to false.
> +

I think "auto" should disable colors even when the output is "-t
STDOUT" if $TERM eq "dumb" (see color.c::git_config_colorbool()).

> @@ -175,7 +207,7 @@ sub list_and_choose {
>  			if (!$opts->{LIST_FLAT}) {
>  				print "     ";
>  			}
> -			print "$opts->{HEADER}\n";
> +			print colored $header_color, "$opts->{HEADER}\n";

I agree with Jeff's suggestion to stick to more C-ish style to
always use parentheses around function arguments.
