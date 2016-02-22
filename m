From: Junio C Hamano <gitster@pobox.com>
Subject: Re: whither merge-tree?
Date: Mon, 22 Feb 2016 14:45:45 -0800
Message-ID: <xmqqsi0k4b52.fsf@gitster.mtv.corp.google.com>
References: <xmqqio1nge5b.fsf@gitster.mtv.corp.google.com>
	<20160222221209.GA18522@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan =?utf-8?Q?Fr=C3=BChwirth?= <stefan.fruehwirth@uni-graz.at>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 22 23:45:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXzEn-0006Ae-FE
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 23:45:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756052AbcBVWpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 17:45:49 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756060AbcBVWps (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 17:45:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 93EF247094;
	Mon, 22 Feb 2016 17:45:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JFwLt9YQSyItSAqaEXAEuLSdVRA=; b=x7HSQa
	L5jSlul4XyRWS7J6thhgc1f7ehikKyPXd4li67Wcj2Zxi3wRcKgQsW6CD1eAIHCI
	53Zie3KqSiBmQBgFZENyygDEdRsR5Ro1TjVEX9z+6mM1VOGWSR47eETw+YUaqaOS
	7tF2wVq1LTnqqz4SZiaOnQrnee3eu+dTloRn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qTRBozPWhlYZbGmXy69Y1QppNafwshCq
	NdkUB4JHKyhGYco9YCk1o/6F8hcyh3oWZWZcVbbdykEXVvOjIB7L7teGkvDZchCh
	K82IQ0Fb3nbs0VUHNF7OwQZrGvSG2dHrzLSoE17t2pIMbEUzmElZPNL+RjakfI5u
	nmUGJwtUUUA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8489647093;
	Mon, 22 Feb 2016 17:45:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F284D47092;
	Mon, 22 Feb 2016 17:45:46 -0500 (EST)
In-Reply-To: <20160222221209.GA18522@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 22 Feb 2016 17:12:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0376F8C0-D9B6-11E5-8CAB-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286993>

Jeff King <peff@peff.net> writes:

>   2. Rip out the weird add/add conflict resolution. This gets rid of the
>      buggy code, makes merge-tree more like the rest of git, and I think
>      lets us even drop the EMIT_COMMON stuff from xdiff).

That is a nice bonus.

git-merge-resolve (rather, git-merge-one-file) attempts the same
"resolve add/add by taking the common" thing, but it implements it
in quite a different way.

>      That lets people keep using merge-tree if they have found it useful
>      over the years.

>   3. Drop merge-tree completely. This deletes even more code, and helps
>      the people in (2) realize that it is utterly unmaintained. :)
>
> I think at this point I am waffling between (2) and (3). I did (1) in a
> hope that I could avoid looking deeper into the code at all, but now
> that I have, I do not think (2) would be so bad. I'm happy to work up a
> patch, but won't bother if we think that (3) is viable.

Yup, between 2 and 3, 2 would certainly be safer, and I agree that
it is not too bad (I have this feeling that add-add conflict is not
the only funny this code has, though).

Let's wait and see how many "please don't"s we hear, perhaps, before
deciding to go 3.?
