From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] Let git-add--interactive read colors from configuration
Date: Thu, 22 Nov 2007 13:28:34 -0800
Message-ID: <7v63zu3r7h.fsf@gitster.siamese.dyndns.org>
References: <20071017015152.GN13801@spearce.org>
	<20071022164048.71a3dceb@danzwell.com>
	<20071023042702.GB28312@coredump.intra.peff.net>
	<20071023035221.66ea537f@danzwell.com>
	<20071102224100.71665182@paradox.zwell.net>
	<20071104045735.GA12359@segfault.peff.net>
	<7v640ivagv.fsf@gitster.siamese.dyndns.org>
	<20071104054305.GA13929@sigill.intra.peff.net>
	<20071110180109.34febc3f@paradox.zwell.net>
	<20071122045606.0232fc2d@paradox.zwell.net>
	<20071122121836.GG12913@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Zwell <dzwell@zwell.net>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 22 22:29:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvJbe-00010p-4s
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 22:29:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320AbXKVV2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 16:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752135AbXKVV2s
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 16:28:48 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:41323 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317AbXKVV2r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 16:28:47 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id A21F52EF;
	Thu, 22 Nov 2007 16:29:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id EFC6B98A1A;
	Thu, 22 Nov 2007 16:28:57 -0500 (EST)
In-Reply-To: <20071122121836.GG12913@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 22 Nov 2007 07:18:36 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65848>

Jeff King <peff@peff.net> writes:

> On Thu, Nov 22, 2007 at 04:56:06AM -0600, Dan Zwell wrote:
>
>> +			# Grab the 3 main colors in git color string format, with sane
>> +			# (visible) defaults:
>> +			$prompt_color = Git::color_to_ansi_code(
>> +				scalar $repo->config_default('color.interactive.prompt',
>> +					'bold blue'));
>
> And by the same token as the last message, given that config_* take only
> two arguments, is there a reason not to extend them so that
>
>   $repo->config_bool('my.key', 0);
>
> handles the default. Then I think you could simplify this to just:
>
>   $repo->config_color('color.interactive.prompt', 'bold blue');
>
> and hide the color_to_ansi_code messiness from the script altogether.

I like the config_color() method.

I think the "config_bool with default" also makes sense but it
needs to be coded a bit carefully.  Issues to consider:

 (1) Non default form "$r->config_bool('key')" should keep the
     original semantics; missing key in the configuration is the
     same as false (i.e. "undef" in scalar, () in list context).

 (2) What should be the second parameter in the form to default
     to true?  '1'?  'true'?  Any kind of "true" value in Perl
     should be accepted?

 (3) Same question as (2) but for defaulting to false.  Any kind
     of "false"?
