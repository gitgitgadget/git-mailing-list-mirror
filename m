From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/10] support pager.* for aliases
Date: Thu, 18 Aug 2011 22:43:57 -0700
Message-ID: <7vaab6552a.fsf@alter.siamese.dyndns.org>
References: <20110818215820.GA7767@sigill.intra.peff.net>
 <20110818215909.GA7799@sigill.intra.peff.net>
 <7v8vqq72kp.fsf@alter.siamese.dyndns.org>
 <20110819033733.GB2993@sigill.intra.peff.net>
 <7vliuq5906.fsf@alter.siamese.dyndns.org>
 <20110819044013.GA2163@sigill.intra.peff.net>
 <7vei0i560a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 19 07:44:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuHsE-00028F-Bk
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 07:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828Ab1HSFoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 01:44:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37357 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751293Ab1HSFoA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 01:44:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2B324B1F;
	Fri, 19 Aug 2011 01:43:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ySSSmFBz1NwU7xIWUZEB+7LFnKY=; b=L/VSWy
	f0/R6JUjyqjdS5OCGjML3YDokGqo3SbzyMxNblguE9hthb2Fy8uLOhzNhn1h0lAF
	uHGfgf2SDfPl/r2z025xiwLIFoY91tMRULcMwAgQBi+UWpX2XCHd7T6y+qWG3Igc
	tl+SW0XjO+xLD4gzALBoHNK5v1qm9/p8FYiRM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QNcDOt0pvGCPlTleoAp/vP7NjndWh6hd
	9RbctC4YP631x2qGfR4jk2pOFzgyzpdm9XdrQc8ZmPoOI45POtUgYqLUcFzaDd9o
	OIO3i6s8yhNA9Kb9XUiNEBacq6IfN5b/CFN/moKQZrv0OSTdemiz4cCK54zxhEYR
	ynNR1b3mLxo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B841E4B1E;
	Fri, 19 Aug 2011 01:43:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 210EA4B1D; Fri, 19 Aug 2011
 01:43:59 -0400 (EDT)
In-Reply-To: <7vei0i560a.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 18 Aug 2011 22:23:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3C5DCBAE-CA26-11E0-933E-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179678>

Junio C Hamano <gitster@pobox.com> writes:

>> If the user thinks of the alias as just another form of "log", then we
>> do the right thing: we use log's pager config by default, and respect
>> pager.log. They never set pager.foo, because that is nonsensical in
>> their mental model.
>>
>> If the user thinks of the alias as its own command, then they would
>> expect pager.foo to work. And it does what they expect.
>>
>> But like I said, I don't personally plan on using this. It was just the
>> only semantics that really made sense to me,...
>
> I can see that argument, but once you start paying attention to "*.foo",
> you have to keep supporting that forever, and also more importantly, you
> need to worry about interactions between "*.foo" vs "*.log". Which one
> should win? Should they combine if both are defined? My "looks confusing"
> includes that can of worms.

Actually there is another thing that I think is much worse. If the user is
trained to think of the alias as its own command by seeing pager.foo to
work as you described, you cannot blame them if they would also expect
these to work, in the sense that only "foo.*" and "bar.*" respectively
would take effect, and they would override "log.*":

	[alias]
        	foo = log
		bar = !sh -c 'log "$@"' -
	[log]
		date = default
	[foo]
        	date = iso
	[bar]
		date = relative

I do not think we want to go there.
