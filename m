From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4212: handle systems with post-apocalyptic gmtime
Date: Tue, 01 Apr 2014 12:07:22 -0700
Message-ID: <xmqqbnwk27it.fsf@gitster.dls.corp.google.com>
References: <20140326193359.GA14105@sigill.intra.peff.net>
	<20140326212227.GC6991@hashpling.org>
	<20140326215741.GA17716@sigill.intra.peff.net>
	<20140326224616.GA9454@hashpling.org>
	<20140327224837.GB32434@sigill.intra.peff.net>
	<xmqqd2h6cm26.fsf@gitster.dls.corp.google.com>
	<20140328184710.GA29987@sigill.intra.peff.net>
	<xmqqppl69meh.fsf@gitster.dls.corp.google.com>
	<20140328190548.GB30739@sigill.intra.peff.net>
	<xmqq8uru9l51.fsf@gitster.dls.corp.google.com>
	<20140401073848.GA22023@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Charles Bailey <cbailey32@bloomberg.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 01 21:07:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV41y-00029H-6e
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 21:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbaDATH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 15:07:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54391 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254AbaDATHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 15:07:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DBA37852A;
	Tue,  1 Apr 2014 15:07:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v7TpjuatWalV5cKSG9f/eV8Ou/w=; b=oc/wJV
	k6BKw+4/TdkxiWet/phLWcCFYIyaNdl1GHav34zWPaSiBHtJGx60rljhJehxh97D
	wyjXZ83p1dfmVw7j9R0OOkP/Qc1Yb94ALiYmbq8v/rYMpWqbmW/NkfJYhrHqiNBI
	YCWyU0Jh39t0dTsZR1m67XoZROMS1S0AU2RO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hlgkK0YyIAdZBvm3l9v2+iqDq3JWlB77
	Y+PNQYG/6C3Xh7lOXvllMlPUG1rQU2NdGJ8e8QiFkp2syTPsADo5hi0LgSZbeHf6
	tzLhqONdnYyfOewtZGI21LFn0XWMZPdM/a/yxyahlQiBq3YLPV3or0qKc8MFQ+xc
	FVfVczNgCQI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F138978529;
	Tue,  1 Apr 2014 15:07:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50DD378527;
	Tue,  1 Apr 2014 15:07:24 -0400 (EDT)
In-Reply-To: <20140401073848.GA22023@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 1 Apr 2014 03:38:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DBCFD8B6-B9D0-11E3-862A-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245621>

Jeff King <peff@peff.net> writes:

> On Fri, Mar 28, 2014 at 12:30:02PM -0700, Junio C Hamano wrote:
>
>> Let's just deal with a simple known cases (like FreeBSD) in the real
>> code that everybody exercises at runtime, and have the new test only
>> check we do not segfault on a value we used to segfault upon seeing.
>
> OK. Here it is, with the other option as an "alt" patch for reference.
>
>   [1/2]: date: recognize bogus FreeBSD gmtime output
>   [2/2]: t4212: loosen far-in-future test for AIX
>   [2alt/2]: work around unreliable gmtime errors on AIX
>
> -Peff

Thanks.  2alt does not look too bad, but on the other hand, we are
replacing a value that can produce the right result on correctly
implemented gmtime with a completely bogus value only because we
know there exists one broken implementation---which does not sound a
very good trade-off, given that we would get a result that does not
correspond to the input anyway with or without the change on the
broken implementation.
