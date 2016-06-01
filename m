From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4014: shell portability fix
Date: Tue, 31 May 2016 23:49:10 -0700
Message-ID: <xmqqshwx1k0p.fsf@gitster.mtv.corp.google.com>
References: <xmqqbn3l3kmc.fsf@gitster.mtv.corp.google.com>
	<20160531225628.GA4585@sigill.intra.peff.net>
	<CAPig+cR989yU4+JNTFREaeXqY61nusUOhufeBGGVCi29tR1P5w@mail.gmail.com>
	<20160601023159.GA5411@sigill.intra.peff.net>
	<20160601033139.GB5411@sigill.intra.peff.net>
	<20160601034413.GC5411@sigill.intra.peff.net>
	<20160601053325.GA20797@sigill.intra.peff.net>
	<20160601054048.GB20797@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 01 08:49:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7zxx-0006o6-UY
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 08:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757499AbcFAGtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 02:49:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52375 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757460AbcFAGtO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 02:49:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BF6A81AE92;
	Wed,  1 Jun 2016 02:49:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yQqGLzVsG+ukl8Z6dvrsB7cEKqU=; b=k57gJA
	NgaEQC2p5A9fX7Q0nNn5U94TZ52Qc94u2hPlFReGK/d27RLSs+G1AHnMIOkavg9+
	ZlA3dcPEbKU0b3oSeIOPf6qYiBjSwHnAotOiK/gcRHq9KPvHMSnFIB/q4eLm67+0
	6RY1XTTjlfLFlVH+kCQMUKdx0nfUtxtbpJJus=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OJENwLE6MuWaoI1RM4V/iR6d+VxNyOva
	rl18TRkJcMJeZkJv2T99/N9ZcA/081pDK3ayd3aH2x4BQV/KHJeKG8splJVLPi7r
	hNAdslP+qSeGU3leFqsHYn8kjyf/cWg+Dkqe1Wh5+Pvlhft+XkoMLrt9UdutMxba
	1BKopd1WnoQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B7C591AE91;
	Wed,  1 Jun 2016 02:49:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 40ED31AE8F;
	Wed,  1 Jun 2016 02:49:12 -0400 (EDT)
In-Reply-To: <20160601054048.GB20797@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 1 Jun 2016 01:40:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F2D8F8D0-27C4-11E6-9CB8-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296056>

Jeff King <peff@peff.net> writes:

> OK, last email tonight, I promise.
>
> Here's the subshell version. I'm a little embarrassed not to have
> thought of it sooner (though the other one was a fun exercise).
>
> 	test_env () {
> 		(
> 			while test $# -gt 0
> 			do
> 				case "$1" in
> 				*=*)
> 					eval "${1%%=*}=\${1#*=}"

Is this an elaborate way to say 'eval "$1"', or is there anything
more subtle going on?

> 					eval "export ${1%%=*}"
> 					shift
> 					;;
> 				*)
> 					"$@"
> 					exit

... or 'exec "$@"'

> 					;;
> 				esac
> 			done
> 		)
> 	}

You can dedent the whole thing and remove the outermost {} pair.

Other than that, looks good to me.

>
> -Peff
