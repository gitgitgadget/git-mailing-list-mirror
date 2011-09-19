From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-web--browse: invoke kfmclient directly
Date: Mon, 19 Sep 2011 10:57:37 -0700
Message-ID: <7vvcso9zzi.fsf@alter.siamese.dyndns.org>
References: <20110918032933.GA17977@sigill.intra.peff.net>
 <1316341224-4359-1-git-send-email-judge.packham@gmail.com>
 <20110918183846.GA31176@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org,
	chriscool@tuxfamily.org, jepler@unpythonic.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 19 19:57:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5i6E-0002OJ-0g
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 19:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228Ab1ISR5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 13:57:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52241 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932213Ab1ISR5k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 13:57:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F42640D7;
	Mon, 19 Sep 2011 13:57:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e0/7rTIxjSm2MZtD2pxYOPN3N8Q=; b=lr0Hp3
	p80fZdB+l5+mo7W9Jyj0fLjBmIxy0xpgU+QlecnhytbZM+YcjoVo3/pe+KK5LmKJ
	cG3DFeR8mzVZn3pRCIvti3aLI0jhFyL3zIwsq0BesxS0ZDX/Et5e2P8WR7tK3+R1
	7GQkao1gvtc1WcLmedAi5ZBhsBbG434/N7YDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A4ztEgcgr9jVRMfFbZPL1DRDRDMJRoup
	FtA2KN6ljGNqluZwYMZUvOsaBrDjytwS4g8fOGKLhS2VedM2T+pKzsZUEu6r0+iU
	4JHE6x9VlPBfAugC0ALAAaonkIvj6klePXpxyiygJbHUOLz/aP7VgP/JkPQBaNvn
	Ckglg+z8Iho=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7667840D5;
	Mon, 19 Sep 2011 13:57:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DCA8640D4; Mon, 19 Sep 2011
 13:57:38 -0400 (EDT)
In-Reply-To: <20110918183846.GA31176@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 18 Sep 2011 14:38:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DCFFCE74-E2E8-11E0-B36B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181687>

Jeff King <peff@peff.net> writes:

> Hmm. Actually, the one for custom browser commands might need it,
> because that one is expected to be a shell snippet. I suspect the
> simplest thing is to do something like:
>
>   eval "$browser_cmd \"\$@\""

Yeah, I agree, and the dq around $browser_cmd is kind of important, too,
for that to work and be readable.
> If you want to make a test, I think you would do better with something
> like:
>
>   echo someurl_with_&_in_it >expect &&
>   git config browser.custom.cmd echo &&
>   git web--browse --browser=custom someurl_with_&_in_it >actual &&
>   test_cmp expect actual
>
> That won't test that we are invoking kfmclient correctly, obviously, but
> you can confirm at least that URLs are making it through to the browser
> script intact.

Hmm, isn't '&' somewhat an unusual in URL? ...ah, not really, if it is in
the query parameter part it is quite common.

Thanks.
