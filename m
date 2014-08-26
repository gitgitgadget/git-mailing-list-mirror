From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Makefile: use `find` to determine static header dependencies
Date: Tue, 26 Aug 2014 12:40:17 -0700
Message-ID: <xmqqegw3hwf2.fsf@gitster.dls.corp.google.com>
References: <20140822042716.GE27992@peff.net>
	<20140822043303.GB18192@peff.net> <20140825194641.GS20185@google.com>
	<20140825200042.GJ30953@peff.net> <20140825204516.GT20185@google.com>
	<xmqqppfol1sx.fsf@gitster.dls.corp.google.com>
	<20140825212705.GU20185@google.com>
	<xmqq4mx0kyrx.fsf@gitster.dls.corp.google.com>
	<20140826123427.GD29180@peff.net>
	<xmqqiolfjio4.fsf@gitster.dls.corp.google.com>
	<20140826172959.GA16394@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jiang Xin <worldhello.net@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 26 21:40:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMMba-00050v-VL
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 21:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327AbaHZTkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 15:40:31 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56985 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752222AbaHZTka (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 15:40:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 845B03275B;
	Tue, 26 Aug 2014 15:40:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4TFsphOvzJb+3WSsjy5ieBDIj7U=; b=oNwJGC
	+2qqahhor69HRtQ1NdQQcBxs+6SSfK0b2cEsZa09fbL6Z2Rg1npycrYQfSfZAM7C
	+aAEjb7mbSfdHm56ifi1LW7GvoI7bG9hUhANW328c4F7r0tuyvuQ2JbFWcRQMs7S
	inMkMdy9MpnYzsDQX5QVRsKa5ZF6V8HpMVae4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bRggCzIvk8SQRumZkgMlvxAgLMTieYs3
	0HF4f5zk3oognzaA8wRKC4DU2f3Nsl2vWfDwraVK3FwzvStC190DU66FCGqAd7O/
	oxleJ6HGplab6hbksHKdHN+UsKgvn05GipuTBvoXW4+FGBDhJbSVbj6Tq7xkM6+e
	iqKShHKetiU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4B4CE32758;
	Tue, 26 Aug 2014 15:40:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DE84332745;
	Tue, 26 Aug 2014 15:40:18 -0400 (EDT)
In-Reply-To: <20140826172959.GA16394@peff.net> (Jeff King's message of "Tue,
	26 Aug 2014 13:29:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CF7A84A2-2D58-11E4-8890-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255938>

Jeff King <peff@peff.net> writes:

> On Tue, Aug 26, 2014 at 09:54:19AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> >> Actually as you are not excluding CVS, RCS, etc., and using ??* as
>> >> the starting point will exclude .git, .hg, etc. at the top, I think
>> >> we can shorten it even further and say
>> >> 
>> >> 	find ??* -name Documentation -prune -o -name \*.h
>> >> 
>> >> or something.
>> >
>> > I had originally considered starting with "find *", but I was worried
>> > about shell globbing overflowing command-line limits here. "echo *" on a
>> > built tree is about 12K.
>> 
>> OK.  What I queued is still your original which is the most
>> conservative among various "fun" alternatives we have seen so far on
>> this thread, so we should be good ;-)
>
> The only thing I think mine does not do that Jonathan suggested is
> dropping .hg, etc. I do not know why anyone would track git in hg, but
> it might make sense to s/.git/.?/ in what I sent.
>
> (I noticed also that you did not queue the third patch to drop
> CHECK_HEADER_DEPENDENCIES; I'm OK if we keep it, but I wanted to make
> sure it was not an oversight).

It started as "I just ran out of time to really think about it" and
transitioned to "Ahh, I forgot that I postponed deciding" ;-)
