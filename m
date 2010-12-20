From: david@lang.hm
Subject: Re: [PATCH] convert filter: supply path to external driver
Date: Sun, 19 Dec 2010 21:52:09 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1012192151090.20181@asgard.lang.hm>
References: <20101218223822.GA18902@arf.padd.com> <20101219212925.GA7393@arf.padd.com> <7vzks1e84p.fsf@alter.siamese.dyndns.org> <20101220022409.GA4625@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>, Pete Wyckoff <pw@padd.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 20 06:52:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUYfe-0003yB-AW
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 06:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838Ab0LTFwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 00:52:25 -0500
Received: from mail.lang.hm ([64.81.33.126]:51481 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750783Ab0LTFwY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 00:52:24 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id oBK5q9DR014462;
	Sun, 19 Dec 2010 21:52:09 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20101220022409.GA4625@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163984>

On Sun, 19 Dec 2010, Jeff King wrote:

> On Sun, Dec 19, 2010 at 01:59:50PM -0800, Junio C Hamano wrote:
>
>> Modulo one worry.  Don't we have, or don't we at least plant to allow us
>> to have, a facility to cache expensive blob conversion result, similar to
>> the textconv caching?  How would this change interact with two blobs that
>> live in different paths?
>
> Yeah, it has been talked about, but I don't think anyone is working on
> it (I don't personally use clean/smudge at all, so it is not something I
> have thought _that_ much about).
>
> This does definitely complicate matters, as the filtering is no longer a
> pure mapping of sha1->sha1. However, I think in practice we could do
> just fine by using a multi-level lookup. I.e., mapping a sha1 to be
> filtered into a tree. Each tree entry would represent the remaining
> cache parameters. In this case, the only other parameter we have is the
> path given to the filter (but it could easily be extended to include
> other parameters, if they existed, in this or other caching cases).
>
> We only get a high-performance lookup for the first part of the
> multi-level (i.e., the sha1), but that's OK if we assume the number of
> second-level items is going to be small. Which I think is the case here
> (a sha1 will tend to be found only under one or a few names).
>
> An alternative would be to combine all parts of the filter under a
> single lookup key. E.g., calculate and store under sha1(sha1(blob) +
> filename)). But that means the notes keys are not actual object sha1s,
> which throws off pruning.
>
> Anyway, that's just my quick thinking on the subject. I don't see any
> reason to restrict a feature just because we might want to cache it in
> the future. At the very worst, we could always cache filters which do
> not use %s, and make only %s users pay the penalty.

or you could cache the stats of the filtered file, including any changes 
that are made.

David Lang
