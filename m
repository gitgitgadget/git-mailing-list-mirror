From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/16] t5304: use helper to report failure of "test foo = bar"
Date: Tue, 07 Oct 2014 14:16:56 -0700
Message-ID: <xmqq61fveg1j.fsf@gitster.dls.corp.google.com>
References: <20141003202045.GA15205@peff.net>
	<20141003202743.GH16293@peff.net> <5433E8CB.1050005@alum.mit.edu>
	<xmqqsiiziy94.fsf@gitster.dls.corp.google.com>
	<20141007201805.GA22703@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 07 23:17:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xbc82-0006Jk-Cj
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 23:17:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691AbaJGVRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 17:17:00 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51847 "EHLO sasl.smtp.pobox.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752139AbaJGVQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 17:16:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C944614474;
	Tue,  7 Oct 2014 17:16:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=95ASE0HW8gkchBCnW772/xU94+o=; b=S6+d/2
	zoa11Z2mdSKhRbgXD9GX6fEIE7E+HrPChOz8sCaUp63IiI3mJqiDr3D1HzoRuWgg
	/bPtkvtZG9jD7ZV2OZ0uUybmz1xF6/iAqPjQZhlRDgjbdBB1BNozzM3IzHb+Vi39
	8Vng0CinqYIfO+XHOEls+Yoo+8dOMgQSvksDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s2FoS3BP2etNIzMNv+vkfBch6O5cnBC/
	o8YXaMMN3uLOrASkSNlUErLXAc9D2nIVLBW56u5W3lSnAoXcB41esAdAel71qenp
	hlwxdpm56CbW0kirOwdogwoOpaqAKSxNiDIlltIVz4j3/vRmzghJ71tRgJjALzpZ
	Z3v09n8+/xU=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BF5E014473;
	Tue,  7 Oct 2014 17:16:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3A4C214472;
	Tue,  7 Oct 2014 17:16:58 -0400 (EDT)
In-Reply-To: <20141007201805.GA22703@peff.net> (Jeff King's message of "Tue, 7
	Oct 2014 16:18:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 457EA924-4E67-11E4-A3F0-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257961>

Jeff King <peff@peff.net> writes:

> Based on your responses, I'm leaning towards:
>
>   test_cmp_str() {
> 	test "$@" && return 0
> 	echo >&2 "command failed: test $*"
> 	return 1
>   }
>
> since the point is really just to print _something_ when the test fails
> (any quoting or whitespace may be wrong, of course, but that's OK; it's
> for human consumption, and is just a hint).

If we really cared, we could do

	echo >&2 "command failed: test $(git rev-parse --sq-quote "$@")"

perhaps?
