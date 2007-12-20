From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] Re-re-re-fix common tail optimization
Date: Thu, 20 Dec 2007 09:23:15 +0000
Message-ID: <20071220092315.GA31337@hashpling.org>
References: <20071215200202.GA3334@sigill.intra.peff.net> <20071216070614.GA5072@sigill.intra.peff.net> <7v8x3ul927.fsf@gitster.siamese.dyndns.org> <7v7ijejq6j.fsf@gitster.siamese.dyndns.org> <20071216212104.GA32307@coredump.intra.peff.net> <7v3au2joo2.fsf_-_@gitster.siamese.dyndns.org> <20071219141845.GA2146@hashpling.org> <20071219142715.GB14187@coredump.intra.peff.net> <20071219143712.GA3483@hashpling.org> <7vy7bqrzat.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>, Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 10:24:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5Hdb-0006FL-Qw
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 10:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755897AbXLTJX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 04:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753767AbXLTJX5
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 04:23:57 -0500
Received: from pih-relay05.plus.net ([212.159.14.132]:35423 "EHLO
	pih-relay05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754209AbXLTJX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 04:23:56 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay05.plus.net with esmtp (Exim) id 1J5Hcg-0006Pj-KL; Thu, 20 Dec 2007 09:23:22 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id lBK9NI5K031676;
	Thu, 20 Dec 2007 09:23:18 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id lBK9NFRQ031675;
	Thu, 20 Dec 2007 09:23:15 GMT
Content-Disposition: inline
In-Reply-To: <7vy7bqrzat.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68983>

On Wed, Dec 19, 2007 at 04:21:30PM -0800, Junio C Hamano wrote:
> 
> By the way, how does this rewrite look?
> 

It looks good and the test works on my fedora and Mac OS X boxes.
(Just for reference I'm on 10.4.3, not 'Leopard'.)

I've snipped everything except zc that I wanted to comment on.

The only two really minor nits I have is that zc does bizarre things
without warning for more than 9999 "z" ( e.g. 17000 = 9000 + 8000 =
98000 (!) ) and that, from a function responsibility point of view,
the /^index/d looks rather out of place.

Perhaps a comment saying tha zc is designed for <= 9999 z's?  Given
this, a lot of the /g are redundant.

But hey, it's a test script and it works and I don't have any better
suggestions. :)

Charles.

> +zc () {
> +	sed -e "/^index/d" \
> +		-e "s/$z1000/Q/g" \
> +		-e "s/QQQQQQQQQ/Z9000/g" \
> +		-e "s/QQQQQQQQ/Z8000/g" \
> +		-e "s/QQQQQQQ/Z7000/g" \
> +		-e "s/QQQQQQ/Z6000/g" \
> +		-e "s/QQQQQ/Z5000/g" \
> +		-e "s/QQQQ/Z4000/g" \
> +		-e "s/QQQ/Z3000/g" \
> +		-e "s/QQ/Z2000/g" \
> +		-e "s/Q/Z1000/g" \
> +		-e "s/$z100/Q/g" \
> +		-e "s/QQQQQQQQQ/Z900/g" \
> +		-e "s/QQQQQQQQ/Z800/g" \
> +		-e "s/QQQQQQQ/Z700/g" \
> +		-e "s/QQQQQQ/Z600/g" \
> +		-e "s/QQQQQ/Z500/g" \
> +		-e "s/QQQQ/Z400/g" \
> +		-e "s/QQQ/Z300/g" \
> +		-e "s/QQ/Z200/g" \
> +		-e "s/Q/Z100/g" \
> +		-e "s/000Z//g" \
> +		-e "s/$z10/Q/g" \
> +		-e "s/QQQQQQQQQ/Z90/g" \
> +		-e "s/QQQQQQQQ/Z80/g" \
> +		-e "s/QQQQQQQ/Z70/g" \
> +		-e "s/QQQQQQ/Z60/g" \
> +		-e "s/QQQQQ/Z50/g" \
> +		-e "s/QQQQ/Z40/g" \
> +		-e "s/QQQ/Z30/g" \
> +		-e "s/QQ/Z20/g" \
> +		-e "s/Q/Z10/g" \
> +		-e "s/00Z//g" \
> +		-e "s/z/Q/g" \
> +		-e "s/QQQQQQQQQ/Z9/g" \
> +		-e "s/QQQQQQQQ/Z8/g" \
> +		-e "s/QQQQQQQ/Z7/g" \
> +		-e "s/QQQQQQ/Z6/g" \
> +		-e "s/QQQQQ/Z5/g" \
> +		-e "s/QQQQ/Z4/g" \
> +		-e "s/QQQ/Z3/g" \
> +		-e "s/QQ/Z2/g" \
> +		-e "s/Q/Z1/g" \
> +		-e "s/0Z//g" \
> +	;
> +}
