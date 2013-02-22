From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] archive: let remote clients get reachable commits
Date: Fri, 22 Feb 2013 11:15:34 -0800
Message-ID: <7v38wodusp.fsf@alter.siamese.dyndns.org>
References: <1361456643-51851-1-git-send-email-gurugray@yandex.ru>
 <20130221155208.GA19943@sigill.intra.peff.net>
 <995301361532360@web22h.yandex.ru> <7vehg8s295.fsf@alter.siamese.dyndns.org>
 <20130222172710.GB17475@sigill.intra.peff.net>
 <7vfw0odxz3.fsf@alter.siamese.dyndns.org>
 <20130222182654.GA18934@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergey Sergeev <gurugray@yandex.ru>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 22 20:16:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8y6E-0004K6-C8
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 20:16:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757040Ab3BVTPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 14:15:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52679 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756892Ab3BVTPg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 14:15:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 488CDA9E4;
	Fri, 22 Feb 2013 14:15:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q1cV9E1gpSK9XbzhcKTS1v/RQaA=; b=t5bB50
	x6o9O5spMJeGsXgvkpl5IZ8kKPXZxi6k4FbtpaYJoq6NLsDX94Um8vCzO/IPUmiP
	uYDPv8bu6BqIW8kcYReam2TaM45Vr0DD651YfITKpbkYG/+q8BmaqeCl01vKRmUH
	aoQA9IYWCE3hXJTwMZU/tho1PekHgFj6+xesM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n55bCr5zG4ZcwooKg6aD/ryByX4AuzZN
	HEu/4PeRoWhXxqnwoqSpsbT7OjtuyaDL0j5Usjv2knC552Zt7VDjVpnooU82TTc0
	2o2l/dQOX1LCdJztwGvbyp3X8GXibg7hn+SfUO+IPa9RZ6CE/RQ+H3P0537YyyVI
	DDBIRnPgyUI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D170A9E3;
	Fri, 22 Feb 2013 14:15:36 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D795A9E1; Fri, 22 Feb 2013
 14:15:35 -0500 (EST)
In-Reply-To: <20130222182654.GA18934@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 22 Feb 2013 13:26:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3C2ECB62-7D24-11E2-9279-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216854>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 22, 2013 at 10:06:56AM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > How are you proposing to verify master~12 in that example? Because
>> > during parsing, it starts with "master", and we remember that?
>> 
>> By not cheating (i.e. using get_sha1()), but making sure you can
>> parse "master" and the adornment on it "~12" is something sane.
>
> So, like these patches:
>
>   http://article.gmane.org/gmane.comp.version-control.git/188386
>
>   http://article.gmane.org/gmane.comp.version-control.git/188387
>
> ? They do not allow arbitrary sha1s that happen to point to branch tips,
> but I am not sure whether that is something people care about or not.
>
>> That is why I said "this is harder than one would naively think, but
>> limiting will make it significantly easier".  I didn't say that it
>> would become "trivial", did I?
>
> I'm not implying it would be trivial. It was an honest question, since
> you did not seem to want to do the pass-more-information-out-of-get-sha1
> approach last time this came up.

That does not match my recollection ($gmane/188427).  In fact, I had
those two patches you quoted earlier in mind when I wrote the "limit
it and it will become easier" response.

> Even though those patches above are from me, I've come to the conclusion
> that the best thing to do is to harmonize with upload-pack. Then you
> never have the "well, but I could fetch it, so why won't upload-archive
> let me get it" argument.

That sounds like a sensible yardstick.

>   1. split name at first colon (like we already do)
>
>   2. make sure the left-hand side is reachable according to the same
>      rules that upload-pack uses.

Well, "upload-pack" under the hood operates on a bare 40-hex.  If
you mean to do "split name at first colon, run get_sha1() on the
LHS" in step 1., I would agree this is a good direction to go.

>      Right we just say "is it a ref". It should be:

With s/should/could optionally/, I would agree.

> That leaves the only inaccessible thing as direct-sha1s of trees and
> blobs that are reachable from commits.

Yes (with s/are reachable/are only reachable/).
