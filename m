From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] pretty-print: add --pretty=noexpand
Date: Thu, 17 Mar 2016 22:44:20 -0700
Message-ID: <xmqq7fh0s5l7.fsf@gitster.mtv.corp.google.com>
References: <alpine.LFD.2.20.1603160926060.13030@i7>
	<xmqq7fh25mkc.fsf@gitster.mtv.corp.google.com>
	<CA+55aFxV5PWdSn9Gj=zV464TtJo=QvciZrhc5Pwe+Qfyqt8sXw@mail.gmail.com>
	<xmqqwpp243sb.fsf@gitster.mtv.corp.google.com>
	<xmqqoaae4340.fsf@gitster.mtv.corp.google.com>
	<CA+55aFwbNXJnwEYrKE5dDRk_6eZeGT6Z11uSQS8RmCSq43PkdA@mail.gmail.com>
	<xmqqk2l23xzc.fsf@gitster.mtv.corp.google.com>
	<CA+55aFwbev52kTV1wNMTsxR3kWvhXxTkjVy-KQOEO_2jX3RrAQ@mail.gmail.com>
	<xmqq37rozoic.fsf_-_@gitster.mtv.corp.google.com>
	<xmqqoaacy9tm.fsf_-_@gitster.mtv.corp.google.com>
	<20160318050807.GC22327@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 18 06:44:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agnDJ-0001pi-Fm
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 06:44:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753958AbcCRFoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 01:44:34 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60991 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752087AbcCRFoX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 01:44:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 552F143D7A;
	Fri, 18 Mar 2016 01:44:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cefsYgYt61WEm12v3M1YUi2DA/I=; b=JKhI6e
	M5rcKS3JjmnTqAvawFGBbhTm0Fn3yYjq7Ha5jhtlzsQC6tKfybBzA1+R03cJ2RnZ
	PFjggcHckyHd69mrsdTxDxizVVhhINxPDaoM7Km7+iHXaO+8a/jBBoNjB0wdvzPf
	vUmsb1AEh4Q5DV2x2bLslKSs5a/x66JvzNjlo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FlzZmkve47q/RZHcLRABphtn41A8nvVM
	weaGLN5Nu28/5vC5bpbuh6Ahsc0ycuTUDHNeIJ03RtODwuWjb8Ru1p10lkjBEqYs
	YxFQd1NlGND+qJW91sYBSVsMH0PG379v+KJCatrL7SW89JSEmnpe55RWwMAydqwt
	NMb5TIBNOmo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4CB1243D79;
	Fri, 18 Mar 2016 01:44:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C15E943D78;
	Fri, 18 Mar 2016 01:44:21 -0400 (EDT)
In-Reply-To: <20160318050807.GC22327@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 18 Mar 2016 01:08:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 76F6ED18-ECCC-11E5-821F-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289195>

Jeff King <peff@peff.net> writes:

> E.g., start with:
>
>   - only CMIT_FMT_MEDIUM expands tabs (and does so by default)
>
>   - passing --no-expand-tabs suppresses this behavior
>
>   - passing --expand-tabs is an error for now; if people care later,
>     they can add support for other formats (naively this is trivial, but
>     I suspect there are some corner cases around things like
>     --pretty=raw, so unless somebody wants to work on it now, I don't
>     think we need to).

Yup, I like that better, but it is now past my work hours, so I
won't be looking at it right now.
