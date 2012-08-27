From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8] http: prompt for credentials on failed POST
Date: Mon, 27 Aug 2012 16:29:19 -0700
Message-ID: <7voblvq5gw.fsf@alter.siamese.dyndns.org>
References: <20120827132145.GA17265@sigill.intra.peff.net>
 <20120827132714.GH17375@sigill.intra.peff.net>
 <7v3938rztf.fsf@alter.siamese.dyndns.org>
 <20120827214930.GA18287@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Iain Paton <ipaton0@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 28 01:29:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T68kX-0008Nf-4y
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 01:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820Ab2H0X3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 19:29:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55143 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754153Ab2H0X3V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 19:29:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46BF19561;
	Mon, 27 Aug 2012 19:29:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0l/3SbLzNywId8GjzBDashyO8dw=; b=t4hMpi
	hvQ9vcoqLgqFszWoOyghd7DzBTokXS3UJTxhBu7lmLEFQFPZXyDndBIK/5WGYLHG
	CRTCTrsPud+y1rYSIPMZ+EqASZTQNtbxYYXHCkSWRMFcsIPJduTVVsAGxbN00UtM
	M9mCtEZFYezvVbhG8Sm1/7YOezw2Cpp/7OLGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l6ESyaefoHLh63ueplME/9XS5HzhSbEJ
	2uGIkc1cj74qUilWLoSoHzftEQ01Qqk+BE0VPjWg29WD3KBzrhtOKd8eyZv/gw97
	mSpORnlTW668ivc2ReP7IHKHPJXBz9WFH3P+0M9jQHdCrlP/PDTnMJ/Be8PVZ7XF
	IhjNci00E/8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 307889560;
	Mon, 27 Aug 2012 19:29:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 880F2955F; Mon, 27 Aug 2012
 19:29:20 -0400 (EDT)
In-Reply-To: <20120827214930.GA18287@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 27 Aug 2012 17:49:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 06FEC9D6-F09F-11E1-8FB7-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204393>

Jeff King <peff@peff.net> writes:

>> A silly question.  Does the initial GET request when we push look
>> any different from the initial GET request when we fetch?  Can we
>> make them look different in an updated client, so that the server
>> side can say "this GET is about pushing into us, and we require
>> authentication"?
>
> Yes, they are already different. A fetch asks for
> ...
> But doing it this way has been advertised in our manpage for so long, I
> assume some people are using it. And given that it used to work for
> older clients (prior to v1.7.8), and that the person who upgraded their
> client is not always in charge of telling the person running the server
> to fix their server, I think it's worth un-breaking it.

Oh, I wasn't saying the fix is unnecessary.  I was trying to see if
there is something people who _care_ about wasted effort on the
client side can do to fix their configuration properly (otherwise
while we are patching the client, make sure we give them a way).

> But that would still suffer from (1) and (2) above, so I don't see it as
> a real advantage. You _could_ fix both cases by buffering the input data
> and restarting the request. I just didn't think it was worth doing,
> since they are unlikely configurations and the code complexity is much
> higher.

OK.
