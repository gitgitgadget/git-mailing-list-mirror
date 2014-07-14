From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] tag: support configuring --sort via .gitconfig
Date: Mon, 14 Jul 2014 10:17:40 -0700
Message-ID: <xmqqfvi3zwp7.fsf@gitster.dls.corp.google.com>
References: <1405119347-3308-1-git-send-email-jacob.e.keller@intel.com>
	<1405119347-3308-3-git-send-email-jacob.e.keller@intel.com>
	<CAPig+cR9VCtNhk-FbqDM1LTCa8VeUTYXU4XEX36Rb5CxPFfLWQ@mail.gmail.com>
	<xmqqfvi518xo.fsf@gitster.dls.corp.google.com>
	<20140713173356.GA8406@sigill.intra.peff.net>
	<20140713183629.GA19293@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 14 19:17:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6jsw-0007dy-MR
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 19:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296AbaGNRRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 13:17:50 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51526 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751148AbaGNRRt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 13:17:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 35A2026252;
	Mon, 14 Jul 2014 13:17:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yk7dqfqLzDUzg4JaKPAweHKFnBU=; b=nc1YUz
	ruAG+GuY4tV2V7tf7hMFYhl94SSqukN9sVbGt9093eGENhG+5N4Mezo6FotIDSeV
	jJHPbple0tTwzciEjQoGa0YgZVNvOH1DyArAKK4XETF0rgRwOdki0HKUe4eVtL1T
	e4BhlTe7qxbus9AnkP8raQRdDXVCTP/mKrIEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e2GhuRcNywYlBL5Q1bFUNI3ud+y7vnkT
	h5JDZi+dEooOsysGk2WjcQPWKZp2RalLVJHp7hhtXJ0EKU+huqNGtUiLmAvKvLAX
	ZeNKbdi9oY7VCn9D5mjhpKv/FxLJrwqxwomsb0uhBJWJSej0tsy7KpqmH33Gn5dI
	aFF/ADi75Mo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2CBE126251;
	Mon, 14 Jul 2014 13:17:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6DAF626242;
	Mon, 14 Jul 2014 13:17:24 -0400 (EDT)
In-Reply-To: <20140713183629.GA19293@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 13 Jul 2014 14:36:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B8F00036-0B7A-11E4-8AC6-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253498>

Jeff King <peff@peff.net> writes:

> On Sun, Jul 13, 2014 at 01:33:56PM -0400, Jeff King wrote:
>
>> I realize that I am reinventing the error-reporting wheel on a sleepy
>> Sunday afternoon without having thought about it much, so there is
>> probably some gotcha or case that makes this ugly, or perhaps it just
>> ends up verbose in practice. But one can dream.
>
> Just for fun...

Yes, that is fun.

I actually think your "In 'version:pefname' and 'wersion:refname',
we want be able to report 'pefname' and 'wersion' are misspelled,
and returning -1 or enum would not cut it" is a good argument.  The
callee wants to have flexibility on _what_ to report, just as the
caller wants to have flexibility on _how_.  In this particular code
path, I think the former far outweighs the latter, and my suggestion
I called "silly" might not be so silly but may have struck the right
balance.  I dunno.

If you absolutely need to have both, you would need something like
your approach, of course, but I am not sure if it is worth it.

I am not sure how well this meshes with i18n (I know the "for fun"
does not even attempt to, but if we tried to, I suspect it may
become even uglier).  We would also need to override both error and
warning routines and have the reporter tag the errors in these two
categories, no?
