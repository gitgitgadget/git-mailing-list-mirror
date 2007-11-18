From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] send-pack: assign remote errors to each ref
Date: Sat, 17 Nov 2007 20:47:11 -0800
Message-ID: <7vwssgxir4.fsf@gitster.siamese.dyndns.org>
References: <20071117125323.GA23125@sigill.intra.peff.net>
	<20071117125602.GC23186@sigill.intra.peff.net>
	<7vir40z7nm.fsf@gitster.siamese.dyndns.org>
	<20071118023942.GA4560@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 18 05:47:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Itc4M-0004r6-D1
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 05:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566AbXKRErX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 23:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbXKRErX
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 23:47:23 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:55759 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbXKRErW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 23:47:22 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 073C42EF;
	Sat, 17 Nov 2007 23:47:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 73E2697081;
	Sat, 17 Nov 2007 23:47:35 -0500 (EST)
In-Reply-To: <20071118023942.GA4560@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 17 Nov 2007 21:39:43 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65338>

Jeff King <peff@peff.net> writes:

> On Sat, Nov 17, 2007 at 05:03:57PM -0800, Junio C Hamano wrote:
>
>> > +	for (ref = refs; ref; ref = ref->next) {
>> > +		const char *msg;
>> > +		if (prefixcmp(line, ref->name))
>> > +			continue;
>> 
>> It probably would not matter for sane repositories, but with
>> thousands of refs, strlen() and prefixcmp() may start to hurt:
>
> It is actually _just_ prefixcmp. Or do you mean the strlen we call in
> prefixcmp? If so, I think the right solution is to make prefixcmp
> faster.  :)

I was referring to strlen(ref->name) taken for all refs during
the loop.  Micro-optimized one finds the end of refname on the
"ng" line once before entering the loop.

> OK. Since it is already in next, do you want a style fixup patch?

I do not think it is particularly a big deal -- perhaps clean it
before we touch the vicinity of the code next time.  The same
goes for the "} else {" stuff.

>> Before receive_status() is called, can the refs already have the
>> error status and string set?
>
> Nothing else sets the string, so the latter is not possible (perhaps it
> should be "remote_error" for clarity). It is less clear that we are not
> ... if you look at do_send_pack, we
> only actually send the remote refs that are getting REF_STATUS_OK.

Ah, Ok.
