From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] repack: add `repack.honorpackkeep` config var
Date: Mon, 03 Mar 2014 10:13:47 -0800
Message-ID: <xmqqeh2jrvz8.fsf@gitster.dls.corp.google.com>
References: <20140128060954.GA26401@sigill.intra.peff.net>
	<xmqq8uu0mpg8.fsf@gitster.dls.corp.google.com>
	<20140224082459.GA32594@sigill.intra.peff.net>
	<xmqq1tys9vie.fsf@gitster.dls.corp.google.com>
	<20140226101353.GA25711@sigill.intra.peff.net>
	<xmqqr46p39cj.fsf@gitster.dls.corp.google.com>
	<20140227112734.GC29668@sigill.intra.peff.net>
	<xmqqy50wzb2b.fsf@gitster.dls.corp.google.com>
	<20140228085546.GA11709@sigill.intra.peff.net>
	<xmqqob1ruld8.fsf@gitster.dls.corp.google.com>
	<20140301054350.GA20397@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Siddharth Agarwal <sid0@fb.com>, Vicent Marti <tanoku@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 03 19:13:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKXNE-00071x-4h
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 19:13:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959AbaCCSNv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 13:13:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40107 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753942AbaCCSNt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 13:13:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67D60709F9;
	Mon,  3 Mar 2014 13:13:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=cg84pZEf2zM6oZhX8us0MTBmTak=; b=TvMyhH
	p3OB1zVj2OB7HelLPud1MLyWO1nVM9e/tfgt3LFFTcab4GBrfr43lFWxWcSZZSi4
	I5noYi+MgHtKJeB4vDs5Dep+nTqAqZHFRbRlf8PszzDvXeUcuQtz92k7HQ91czpi
	DPe8wgwHWVlhrWUYCjyPvvGHkHRP1lfaO0T0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D/HaJHWoZ7hD/4ueMhD9i8H7r5lXfWrd
	njLLH/ZlNtioY1teQWibNS0j67wyx0mSfXy3tnwg4Njg4U2TMdgidhhvC9AbrJH4
	9iGS2j3ubZqGZsdyyOymTAsMvY2caIZ2rDfqPTorlMnTXGCrHIwGc1tbMmBdZn4Y
	1STrc+mIqrw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 526FC709F8;
	Mon,  3 Mar 2014 13:13:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 964E2709F7;
	Mon,  3 Mar 2014 13:13:48 -0500 (EST)
In-Reply-To: <20140301054350.GA20397@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 1 Mar 2014 00:43:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 911E082A-A2FF-11E3-B57D-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243242>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 28, 2014 at 10:45:39AM -0800, Junio C Hamano wrote:
>
>> > Exactly. The two features (bitmaps and .keep) are not compatible with
>> > each other, so you have to prioritize one. If you are using static .keep
>> > files, you might want them to continue being respected at the expense of
>> > using bitmaps for that repo. So I think you want a separate option from
>> > --write-bitmap-index to allow the appropriate flexibility.
>> 
>> What is "the appropriate flexibility", though?  If the user wants to
>> use bitmap, we would need to drop .keep, no?
>
> Or the flip side: if the user wants to use .keep, we should drop
> bitmaps. My point is that we do not know which way the user wants to
> go, so we should not tie the options together.

Hmph.  I think the short of your later explanation is "global config
may tell us to use bitmap, in which case we would need a way to
defeat that and have existing .keep honored, and it makes it easier
to do so if these two are kept separate, because you do not want to
run around and selectively disable bitmaps in these repositories.
We can instead do so with repack.packKeptObjects in the global
configuration." and I tend to agree with the reasoning.

Thanks.
