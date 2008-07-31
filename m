From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git blame not respecting --find-copies-harder ?
Date: Thu, 31 Jul 2008 01:35:33 -0700
Message-ID: <7v8wvizc16.fsf@gitster.siamese.dyndns.org>
References: <20080730093903.GA14330@cuci.nl>
 <20080730150123.GB9758@atjola.homenet>
 <bd6139dc0807300843l1d42d6fep95f6c99fe6e0ea0@mail.gmail.com>
 <20080731064814.GA32431@sigill.intra.peff.net>
 <7vfxpq3559.fsf@gitster.siamese.dyndns.org>
 <20080731072149.GA2304@sigill.intra.peff.net>
 <7v8wvi33ok.fsf@gitster.siamese.dyndns.org>
 <20080731082553.GA19522@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sverre@rabbelier.nl,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 31 10:36:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOTeY-0008MJ-NC
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 10:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbYGaIfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 04:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbYGaIfs
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 04:35:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63665 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbYGaIfp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 04:35:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1245A40ED4;
	Thu, 31 Jul 2008 04:35:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4432540ED3; Thu, 31 Jul 2008 04:35:38 -0400 (EDT)
In-Reply-To: <20080731082553.GA19522@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 31 Jul 2008 04:25:54 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AA659C08-5EDB-11DD-8819-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90912>

Jeff King <peff@peff.net> writes:

> On Thu, Jul 31, 2008 at 12:36:59AM -0700, Junio C Hamano wrote:
>
>> Alas, shortlog does not take --all.  Yes, I know
>> 
>> 	git log --since=3.day --all | git shortlog | sort | uniq -c
>> 
>> is an obvious workaround, but it is mildly irritating.
>
> Hmm. Could it be as simple as:
>
> diff --git a/revision.c b/revision.c
> index a843c42..eaa5572 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1002,7 +1002,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  	    !strcmp(arg, "--no-walk") || !strcmp(arg, "--do-walk"))
>  	{
>  		unkv[(*unkc)++] = arg;
> -		return 0;
> +		return 1;
>  	}
>  
>  	if (!prefixcmp(arg, "--max-count=")) {
>
> That is, handle_revision_opt says "yes we parsed this, and it should be
> gone" even though it still gets stuck in the "unknown" section to be
> parsed by setup_revisions later.

Hmm, wouldn't that suggest it needs to return 1 when an option candidate
given to diff_opt_parse() turns out not to be a diff option and stuffed
back to unkv[] at the end of this function?
