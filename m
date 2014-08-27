From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Improving the git remote command
Date: Wed, 27 Aug 2014 13:35:44 -0700
Message-ID: <xmqqegw1d61r.fsf@gitster.dls.corp.google.com>
References: <53FC537C.4080206@gmail.com> <20140826124027.GE29180@peff.net>
	<CAGK7Mr7BPvV6oO_t4x_1m9sDtWBgPWUqDq+3kZx6rVYAhY+wqA@mail.gmail.com>
	<20140826163741.GA14983@peff.net>
	<xmqq7g1vjh9o.fsf@gitster.dls.corp.google.com>
	<20140826173312.GB16394@peff.net> <20140827163617.GA66615@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	=?utf-8?Q?R=C3=A9my?= Hubscher <hubscher.remy@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 22:36:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMjwq-0003JU-3v
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 22:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755580AbaH0Uf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 16:35:59 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61034 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929AbaH0Uf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 16:35:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0727A348F9;
	Wed, 27 Aug 2014 16:35:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YHEnphy1lTMsJV+oDSRWkD+k36I=; b=VUtYKX
	XONYQUqjDEOHuu1FFBpLebX4JqsZPve0lOSTI/nhdTGspJ6pIOwQHQKtqNA3wJ3Y
	IM4y2KHOPlLbbzwVrQQLX4dI7MV8v32TaCRMXc3+mLPSMNC15q6stdoK6nU+yOes
	I5lCMLluUDwqCodAX5/ytZIRt80DgG4A5Gu6k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rCIrx/iCtpZkavBV7Q4ExjXCrRupFQ3l
	tOtiIlOfM2R6tf7CfBztKGt6neZpdLltRrduAPME4/dUbLpLj5mGxvProOtHVp6A
	pxgcw35QWAxJEMomtN1KaHic8iAWfDVW3UmWMQTZsioTuDEl/lR6+8DTJdMJ/GYo
	ZV18b98h+SI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EFDD5348F8;
	Wed, 27 Aug 2014 16:35:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A7105348EB;
	Wed, 27 Aug 2014 16:35:46 -0400 (EDT)
In-Reply-To: <20140827163617.GA66615@gmail.com> (David Aguilar's message of
	"Wed, 27 Aug 2014 09:36:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B966200A-2E29-11E4-A71D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256039>

David Aguilar <davvid@gmail.com> writes:

> We have some internal scripts at Disney Animation that rely on "git remote"
> output so I would vote for #3 personally as well.

I take it that you mean you would vote _against_ #3 which will break
the expectation.

> I know that "git config" is porcelain, and I can get remote.(.*).url,
> but that's not obvious and I highly doubt that anyone does that.

Perhaps that is something worth fixing.

> What if we said that "git remote list --porcelain" == "git remote"
> and then just leave "git remote" output as-is so that we don't have to
> have a flag day when we break people's scripts?

I suspect that it is not likely a workable solution.  The commands
being Porcelain by definition means that people aimed to make their
output consumable by humans, and the current "git remote", which may
be what your script happens to use, is not by design the best
representation of the information for all the script writers to
want to call _good_.

If we were to do "git remote list", I'd imagine it would be far more
useful to have --format="<format specifiers>" option so that you can
do something like

	git remote list --format="%(name) %(url) (%(direction))"

Then scripts can explicitly ask for what they want and have less
chance of getting broken (I say "less" because what %(specifier)
stands for could be changed either to fix mistakes or by mistake).

>> > Having said that, my preference is 
>> > 
>> >     0. Do nothing, but document the "default to listing" better if
>> >        needed.
>> > 
>> > and then 2. above, and then 1.
>> 
>> Yeah, I'd agree with that.
>
> Ditto.
