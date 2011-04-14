From: Junio C Hamano <gitster@pobox.com>
Subject: Re: textconv not invoked when viewing merge commit
Date: Thu, 14 Apr 2011 14:05:07 -0700
Message-ID: <7vwriwfssc.fsf@alter.siamese.dyndns.org>
References: <201104111912.47547.kumbayo84@arcor.de>
 <4DA415AB.9020008@drmicha.warpmail.net>
 <20110414190901.GA1184@sigill.intra.peff.net>
 <7vipughbxh.fsf@alter.siamese.dyndns.org>
 <7vd3kohb5n.fsf@alter.siamese.dyndns.org>
 <7v8vvcha2s.fsf@alter.siamese.dyndns.org>
 <20110414202356.GB6525@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Peter Oberndorfer <kumbayo84@arcor.de>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 23:05:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QATjV-00062z-Kv
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 23:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292Ab1DNVF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 17:05:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47666 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab1DNVF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 17:05:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DD89F53D4;
	Thu, 14 Apr 2011 17:07:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aiO3zV5WzIetEv+By2z1YTcRbrI=; b=o/4pE4
	nJkVvteLOcYCyeT2GZLma95boSCbdSwdse/Iy4OzAfcojgXNNDNUJ9s6GX0ZAMLR
	isrTo0Z0aA4J4/K57Q4De8jIUI862bDSAt/9bwFRWtvyIRRXYMAPx3QpmRKAkRQF
	jdZckAphfijdVI/zBE/LiiEa14viAyTfxCmgk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RYkL4rJfFIPoNbzsL9EU2mMtgk1N5OFR
	sc3vzaASDwTTPTEgP/dTSFPb/a/02yUSaBXfXj7Lrw3pBe9scLKX/ydPxPw2v9SY
	/RF3KhEzkD1TLbj3LAwdFwQJ33rytwDp2PeR0lAiTIXVxHKTMxPU3BW/pMFFCYVH
	o9eqQ84dXH4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9D7DB53D2;
	Thu, 14 Apr 2011 17:07:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0793153B5; Thu, 14 Apr 2011
 17:07:07 -0400 (EDT)
In-Reply-To: <20110414202356.GB6525@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 14 Apr 2011 16:23:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2C2531EA-66DB-11E0-A893-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171551>

Jeff King <peff@peff.net> writes:

> On Thu, Apr 14, 2011 at 01:06:19PM -0700, Junio C Hamano wrote:
>
>> Instead, I think we should just use "Binary blob $SHA-1\n" as if that is
>> the textconv of a binary file without textconv filter.  That would
>> certainly make the code much simpler, and more importantly, the output
>> would become more pleasant. We would show something like:
>> 
>>     - Binary blob bc3c57058faba66f6a7a947e1e9642f47053b5bb
>>      -Binary blob 536e55524db72bd2acf175208aef4f3dfc148d42
>>     ++Binary blob 67cfeb2016b24df1cb406c18145efd399f6a1792
>> 
>> if we did so.
>
> Yeah, I think that is pretty readable. But it gives me a funny feeling
> to encode magic strings inside actual diff output. That is, the output
> is indistinguishable from a file which contained the "Binary blob..."
> strings.
>
> I can't think of a case where it matters, though, so maybe it is just
> paranoia.
>
> We do something similar for textconv, of course, but we always knew that
> was a human-only thing, and it isn't enabled for plumbing commands. This
> would be.

Yeah, that may be a sensible concern.

If we really cared, I would say that plumbing should keep the current
behaviour (line-by-line even for binaries, and not using textconv unless
it is asked).  If the command line asked for --textconv, we can use that
"Binary blob $SHA-1" string as a fallback textconv result for binary blobs
that do not have any textconv filter configured.  So the additional logic
to convert the final image and parent images (two places to patch) would
become more like:

	if (if we are a Porcelain or --textconv option given) {
		if (path has textconv)
                	use textconv;
		else if (path is binary)
                	use "Binary blob $SHA-1";
	}

Having said all that, I don't think we made -c/--cc available to plumbing
on purpose; rather they happen to be available because we thought people
with common sense wouldn't run things like "diff-tree --c" that are meant
for human consumption and expect the result to be parsable by their
scripts. In other words, making the parser barf only for plumbing was not
worth doing.
