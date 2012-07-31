From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] send-email: improve RFC2047 quote parsing
Date: Tue, 31 Jul 2012 10:09:05 +0200
Message-ID: <87lii0gxni.fsf@thomas.inf.ethz.ch>
References: <cb7aa2a8fc08df4f1d12add603ffcbc104f67823.1343676034.git.trast@student.ethz.ch>
	<7vzk6hot8a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>,
	"Christoph Miebach" <christoph.miebach@web.de>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?SsO8cmdlbiBSw7xobGU=?= <j-r@online.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 10:09:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sw7WG-0005Oi-9g
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 10:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755639Ab2GaIJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 04:09:19 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:58687 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753545Ab2GaIJI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 04:09:08 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 31 Jul
 2012 10:09:06 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 31 Jul
 2012 10:09:06 +0200
In-Reply-To: <7vzk6hot8a.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 30 Jul 2012 14:05:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202633>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> This patch fixes the first two by doing a more careful decoding of the
>> =AB outer quoting.  Fixing the fundamental issues is left for a
>> future, more intrusive, patch.
>
> What is this =AB thing?

The two-hex-digits quoting in the style of MIME quoted-printable.  I
called it the "outer quoting" (RFC2047: "encoding") because it serves to
protect the bytes from transport damage; there is another encoding
(RFC2047: "character set") "inside" which is specified by the
=?utf-8?...?= wrapper.

BTW, note that we also only handle the Q outer quoting
(quoted-printable).  There is a B encoding, which your email in fact
used in the Cc: header:

Cc: [...] =?utf-8?B?SsO8cmdlbiBSw7xobGU=?= <j-r@online.de>

B means Base64, as you can probably guess from the looks of it.

>> This is the easy part, fixed as per Junio's comment that it needs to
>> use a .*? match for the contents, and with a test.
>
> What's the hard part?  Do you mean the "fundamentally cannot" part?

Yes, and by "fundamentally" I meant "not without fixing something
outside of this function, which I am too lazy to do at this time". ;-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
