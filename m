From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: use default diff format even with patch
 options
Date: Sun, 24 Aug 2008 21:57:55 -0700
Message-ID: <7vr68ditd8.fsf@gitster.siamese.dyndns.org>
References: <g8jbvd$18k$1@ger.gmane.org>
 <20080821200255.GB27705@coredump.intra.peff.net> <48AE786C.20201@fastmail.fm>
 <20080822165047.GA3339@sigill.intra.peff.net>
 <7vzln492pc.fsf@gitster.siamese.dyndns.org>
 <20080825013837.GA17201@coredump.intra.peff.net>
 <20080825021029.GA28355@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 07:07:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXUHO-0003xN-IO
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 07:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbYHYE6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 00:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbYHYE6D
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 00:58:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44389 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbYHYE6D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 00:58:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DD9616EF61;
	Mon, 25 Aug 2008 00:58:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 114916EF60; Mon, 25 Aug 2008 00:57:57 -0400 (EDT)
In-Reply-To: <20080825021029.GA28355@coredump.intra.peff.net> (Jeff King's
 message of "Sun, 24 Aug 2008 22:10:29 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 64778F0E-7262-11DD-8692-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93594>

Jeff King <peff@peff.net> writes:

> I am a little uncomfortable hurting anyone who thought that
> "format-patch -p" was a good idea. OTOH:
>
>   1. I have to question why they were using format-patch in the first
>      place. Probably git-log --pretty=email would be a better fit.
>
>   2. Their mails were already broken, since the presence of the diffstat
>      is what triggers the "---" divider.
>
>  builtin-log.c           |    3 ++-
>  t/t4014-format-patch.sh |   25 +++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 1 deletions(-)
>
> diff --git a/builtin-log.c b/builtin-log.c
> index 9204ffd..1d3c5cb 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -932,7 +932,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  	if (argc > 1)
>  		die ("unrecognized argument: %s", argv[1]);
>  
> -	if (!rev.diffopt.output_format)
> +	if (!rev.diffopt.output_format
> +		|| rev.diffopt.output_format == DIFF_FORMAT_PATCH)
>  		rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SUMMARY | DIFF_FORMAT_PATCH;
>  
>  	if (!DIFF_OPT_TST(&rev.diffopt, TEXT) && !no_binary_diff)

I think this is the right thing to do.  The only unusual option somebody
might want to use would be "format-patch --stat $range" to send out commit
log e-mails with diffstat summary but without the actual patch, but your
change does not break that use case either.
