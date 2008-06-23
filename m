From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 14:23:58 -0700
Message-ID: <7vprq7hmkx.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0806231312130.6440@racer>
 <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org>
 <20080623164917.GA25474@sigill.intra.peff.net>
 <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org>
 <20080623171505.GB27265@sigill.intra.peff.net>
 <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org>
 <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org>
 <20080623183358.GA28941@sigill.intra.peff.net>
 <alpine.LFD.1.10.0806231137070.2926@woody.linux-foundation.org>
 <alpine.LFD.1.10.0806231158340.2926@woody.linux-foundation.org>
 <20080623210935.GC13395@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Jun 23 23:25:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAtXF-0001mO-Iv
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 23:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217AbYFWVYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 17:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752559AbYFWVYR
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 17:24:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58980 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217AbYFWVYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 17:24:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 214BD5915;
	Mon, 23 Jun 2008 17:24:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 262175912; Mon, 23 Jun 2008 17:24:06 -0400 (EDT)
In-Reply-To: <20080623210935.GC13395@artemis.madism.org> (Pierre Habouzit's
 message of "Mon, 23 Jun 2008 23:09:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BB08DA86-416A-11DD-8223-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85933>

Pierre Habouzit <madcoder@debian.org> writes:

>   With that, you write parsers this way:
>
> {
>     struct parse_opt_ctx_t ctx;
>
>     parse_options_start(&ctx, argc, argv, 0);
>
>     for (;;) {
>         const char *arg;
>
>         switch (parse_options_step(&ctx, options, usagestr)) {
>         case PARSE_OPT_HELP:
>             /* dump your help here, the one for options/usagestr is already dumped */
>             exit(129);
>         case PARSE_OPT_DONE:
>             goto done;
>         }
>
>         arg = *ctx->argv++;
>         ctx->argc--;
>
>         if (strcmp(arg, "-")) {
>             /* you're on baby ! */
>         } else if ....
>         } else {
>             error("unknown option %s", arg);
>             parse_options_usage(options, usagestr);
>             /* dump your help here */
>             exit(129);
>         }
>     }
>
> done:
>     argc = parse_options_end(&ctx);
> }

Nice.  I have started doing the same (insignificant details are different;
e.g. I used "positive is unknown" convention instead ) and then the
solution is sitting in my mbox ;-)
