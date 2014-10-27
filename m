From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Makefile: Reorder linker flags in the git executable rule
Date: Mon, 27 Oct 2014 10:42:21 -0700
Message-ID: <xmqq61f5flz6.fsf@gitster.dls.corp.google.com>
References: <87mw8iag72.fsf@gmail.com>
	<CAPig+cRUxXw4b2z1Gu4p6GKjnYrt_70h3kbR+jzbMP_jY24Sjg@mail.gmail.com>
	<20141026183530.GA18144@peff.net>
	<CAEvUa7nMYn1EJhrX+Yo-T53-tqB80p_ym9i+Ua6PMLqZrAFmQw@mail.gmail.com>
	<20141027051705.GC2996@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Michael <fedora.dm0@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 27 18:42:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XioJM-0001OW-Fr
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 18:42:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbaJ0Rm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2014 13:42:27 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53096 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751676AbaJ0RmX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 13:42:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E0A2718DAF;
	Mon, 27 Oct 2014 13:42:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2gE9vzPB/p2mFzk2S0QuiuW1CeI=; b=gSDlfv
	AW/H/b/X3zyKbBxZVbteq1tkr5NS6PKKKjahS3K7fOzLemSTRi5K2rkJ6Lknekhu
	DbpFOQSLSvfRhs9UJQ5GbuqjO8b3kxTCqhVESm3AaEsNemoAfD2AKg8Fqtfgybs+
	svi3iYq1vEpkIvGTdkb1zmXitkFqqu3OfWiwY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cwnw2FQeSLPliDIGoPLwoL9gJhLFIhDN
	xv+FmuKFCJnuRh+rLyqCMOvdzCpnqjJep+DMkgKCOmgBVQlVC5bA+QTvpuTVAVK7
	QifDux2MC7pplqLej+HkMxcriDZhkcUF8rwuCj2LbxQXF+GSxO3Zq0Qr+0NvxvYS
	b9sMjICw3Io=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D7C7118DAD;
	Mon, 27 Oct 2014 13:42:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 63DAF18DAC;
	Mon, 27 Oct 2014 13:42:22 -0400 (EDT)
In-Reply-To: <20141027051705.GC2996@peff.net> (Jeff King's message of "Sun, 26
	Oct 2014 22:17:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9B2A1130-5E00-11E4-91E3-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Oct 26, 2014 at 02:54:56PM -0400, David Michael wrote:
>
>> Yes, the compiler refuses to run by default when a "-L" option occurs
>> after a source/object file.  It tries to interpret it as another file
>> name and fails.
>
> Yeah, I think I have seen similar behavior before, but it has been long
> enough that I no longer remember the compiler in use.
>
>> I believe I can work around the error with an "export _C89_CCMODE=1",
>> but I thought I'd send the patch since this is the only occurrence of
>> the problem, and the argument order is inconsistent with other linker
>> commands in the file.
>
> I don't think working around it makes sense. That would fix your case,
> but nobody else's (though given how long it has been that way without
> complaints, I suspect any other compilers this picky may have died off).

I think you meant s/nobody else's/breaks &/;

With that, I agree with your assessment.  The diff itself is
probably fine as-is (I didn't look at it for more than 10 seconds,
though ;-).  And I agree that it needs to be better explained.


>> Do you want me to resend the patch and reference the IBM documentation
>> in the message?
>
> I don't think you need to. More interesting than documentation is the
> real-world breakage you experienced and the analysis of the situation.
> I'd be fine taking the patch as-is, or if changing anything, mentioning
> the failure mode in the commit message.
>
> -Peff
