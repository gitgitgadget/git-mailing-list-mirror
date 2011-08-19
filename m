From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/10] support pager.* for aliases
Date: Thu, 18 Aug 2011 22:23:33 -0700
Message-ID: <7vei0i560a.fsf@alter.siamese.dyndns.org>
References: <20110818215820.GA7767@sigill.intra.peff.net>
 <20110818215909.GA7799@sigill.intra.peff.net>
 <7v8vqq72kp.fsf@alter.siamese.dyndns.org>
 <20110819033733.GB2993@sigill.intra.peff.net>
 <7vliuq5906.fsf@alter.siamese.dyndns.org>
 <20110819044013.GA2163@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 19 07:23:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuHYT-0004Bz-Oo
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 07:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327Ab1HSFXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 01:23:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63920 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751828Ab1HSFXg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 01:23:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DE95493B;
	Fri, 19 Aug 2011 01:23:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qddxk0uWy5wyIrlayiNeU8dOb9c=; b=TY5y1E
	orySKBUAZhDoRellZNyDvtekJ0TjAuSZotJyQvMkOfEuXLS9AsMIiSYDg6tWO5Ch
	1+8d613ZnWERXFtLl0WU/0XVaKGL+fD0naxBlbd6acqiR2MzAAvwkbm4LH0Uvc70
	GI7JX5Mp27Q9Mx13xdkZQsVZHoRLmXhgtjLIc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IvlYarssxgIvSxwkzyldIs7pMTlIhyFw
	5rw+A3VxV0VULJO2v4251UVrpCeGAwTtuo18noMp3TUSr+6XnIYuKp/KYJpvFLOB
	DLGma9vF5/BHsB8iPNcKMlYDwcEXM1DE9vPlnrEtsOPrvcoWH19BTlAD3+/fS+xd
	H2meFLhd8f8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6ED7E493A;
	Fri, 19 Aug 2011 01:23:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF0974936; Fri, 19 Aug 2011
 01:23:34 -0400 (EDT)
In-Reply-To: <20110819044013.GA2163@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 18 Aug 2011 21:40:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 62AC7E0C-CA23-11E0-9677-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179677>

Jeff King <peff@peff.net> writes:

> On Thu, Aug 18, 2011 at 09:18:49PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> >> > Until this patch, doing something like:
>> >> >
>> >> >   git config alias.foo log
>> >> >   git config pager.foo /some/specific/pager
>> >> >
>> >> > would not respect pager.foo at all.
>> >> 
>> >> Is it a good thing? Looks too confusing and I am having a hard time to
>> >> decide if this is "just because we could" or "because we need to be able
>> >> to do this for such and such reasons".
>> >
>> > I don't have a particular use for it myself. However, I don't see what's
>> > confusing about it. Would would you expect the above commands to do with
>> > respect to paging?
>> 
>> The reason I found it confusing was that I expected the "log" command that
>> is run as the expansion of the alias to be oblivious to the fact that the
>> end user called it "foo", and ignore anything specific to "foo", including
>> "pager.foo".
>
> I think of it this way:
>
> If the user thinks of the alias as just another form of "log", then we
> do the right thing: we use log's pager config by default, and respect
> pager.log. They never set pager.foo, because that is nonsensical in
> their mental model.
>
> If the user thinks of the alias as its own command, then they would
> expect pager.foo to work. And it does what they expect.
>
> But like I said, I don't personally plan on using this. It was just the
> only semantics that really made sense to me,...

I can see that argument, but once you start paying attention to "*.foo",
you have to keep supporting that forever, and also more importantly, you
need to worry about interactions between "*.foo" vs "*.log". Which one
should win? Should they combine if both are defined? My "looks confusing"
includes that can of worms.
