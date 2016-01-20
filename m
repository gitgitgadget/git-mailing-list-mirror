From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: resolve $commit^{tree} in no-index case
Date: Tue, 19 Jan 2016 17:51:58 -0800
Message-ID: <xmqqbn8h6mrl.fsf@gitster.mtv.corp.google.com>
References: <AF975DD2-988F-47A8-BFC3-3BBC27419305@wolfram.com>
	<xmqqbn8h9squ.fsf@gitster.mtv.corp.google.com>
	<xmqq7fj59rs2.fsf@gitster.mtv.corp.google.com>
	<20160119213705.GA28656@sigill.intra.peff.net>
	<xmqq37tt9r9g.fsf@gitster.mtv.corp.google.com>
	<20160119215100.GB28656@sigill.intra.peff.net>
	<20160119215928.GA6556@sigill.intra.peff.net>
	<20160119222802.GC6556@sigill.intra.peff.net>
	<20160120012253.GD16090@google.com>
	<20160120013436.GA24541@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	John Fultz <jfultz@wolfram.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 02:52:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLhwk-0004bJ-OA
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 02:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934806AbcATBwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 20:52:19 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55918 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933798AbcATBwA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 20:52:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B52873D5B5;
	Tue, 19 Jan 2016 20:51:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BwJ4W49ptkG9kUsGiT0yFv+NrRo=; b=Xjxjqi
	h4T9hsrf3SZKWEW8UNjGzVrmtGijxi3fzbb3JuMjql/wjaPapPuHbCdr2U1HJb/F
	whf7/Y8V2Fa7PDO+uQapuT2BzBtzsgoZQyOmDD8CWlQS+ehSSGVonDyc49bdtWVi
	pf9TKAEfKKTRIUXkRB4TGQTpv7mqMBUPP8umk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XNEKecEct0hvIpC5YXMrakwtEf7qYwEO
	czLWahMiZV7r+Q7q0Ae0hJvbt/RMduFSP3Y4yWmryM2zRIneGqQatLeSQXoKEbEl
	1x/cQvWBKM6pVWIk9tGR3nL5BGJeOSGmqi7+v+ow6FRxFRiQaq/Gh1SovM2+qFqM
	SNtN5a4g9a8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AC26D3D5B4;
	Tue, 19 Jan 2016 20:51:59 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 28D083D5B3;
	Tue, 19 Jan 2016 20:51:59 -0500 (EST)
In-Reply-To: <20160120013436.GA24541@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 19 Jan 2016 20:34:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 648E4F4A-BF18-11E5-AD6C-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284410>

Jeff King <peff@peff.net> writes:

>> Mph.  We could get the best of both worlds by introducing a "git
>> rev-parse --compare <a> <b>" that compares object ids.  Actually...
>> 
>> How about something like this?
>
> Thanks. I had in my head that we could do something like that, but
> hadn't quite worked it out. I think what you wrote works.

But wouldn't "diff-tree --quiet" essentially be that command?

> If you want to wrap it up into a patch, I'd be OK with it, but note that
> it still falls afoul of changing $tree in a user-visible way (so you
> should note that in the commit message).

Yes, I think we should take your conservative variant for that exact
reason.
