From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] rev-parse and "--"
Date: Mon, 09 Dec 2013 12:48:08 -0800
Message-ID: <xmqqob4pycmv.fsf@gitster.dls.corp.google.com>
References: <20131206211222.GB20482@sigill.intra.peff.net>
	<20131206211509.GB20536@sigill.intra.peff.net>
	<20131206220520.GA30652@sigill.intra.peff.net>
	<xmqqmwk9zvyy.fsf@gitster.dls.corp.google.com>
	<20131209191224.GR29959@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 21:48:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq7kX-0004FK-12
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 21:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933105Ab3LIUsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 15:48:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53449 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932216Ab3LIUsM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 15:48:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 477C559D8F;
	Mon,  9 Dec 2013 15:48:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wQ82S9OU9ad9O6ZfU03XnzNA32Y=; b=F2SMyY
	oMsPwfscEz9is/N4NuG4w6f50UB6mV20cYjOrUkWXqE3GdN3OmHqDGK33uAH+gef
	USPLGn39N7001ggArt0j20stsgKSDW+j66mKle15/VqAG29M0t8H3/IC8S6cnC2O
	CggHXZCwPWdDEgAej35E7F8kDif8WNPRPjy7k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JgmWaE58PT5GFKNm5cnvlGZnJMO/pMdx
	FY3BdgvE/2Ry2SK7/KoCqRW4rR4uZVAglonXY/I8eajH65qOwCGl7MOsL3vIMOkY
	WZIE1a4i0XdRaqF4wUM1xzN6rCivgjKtbRmp/OP1t6tf8uymmT8bI9P1I1LuKAVK
	8t+ryQ2lBeE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E85759D8E;
	Mon,  9 Dec 2013 15:48:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6821F59D8B;
	Mon,  9 Dec 2013 15:48:10 -0500 (EST)
In-Reply-To: <20131209191224.GR29959@google.com> (Jonathan Nieder's message of
	"Mon, 9 Dec 2013 11:12:24 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 36E2FC54-6113-11E3-B2E4-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239092>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>>>                                      So maybe we are doing a favor by
>>> calling out the problem; if they want a rev, they should be using
>>> "--verify" (or "--").
>>
>> I tend to agree with the reasoning in the last sentence. Let's cook
>> it for a while and see what happens.
>
> Isn't this essentially breaking a contract that would have been relied
> on by any script that used "git rev-parse HEAD~3..HEAD"?  Worse, it's
> breaking that contract in a way that no one would notice until they
> are asked to manipulate a worktree with a file named 'HEAD~3..HEAD'
> --- in other words, the breakage it introduces is painfully subtle.
>
> I agree that "git rev-parse HEAD" is better written as "git rev-parse
> --verify HEAD" and hence not so much worth worrying about,

I do not share the "with --verify is better hence no problem"
reasoning.  My "not so much worth worrying about" comes solely from
a hunch that nobody has "HEAD~3..HEAD" in their working directory,
and if somebody has one, then they must be using "--verify" (or a
clarifying "--"), because their "git log" and whatever they use "git
rev-parse HEAD~3..HEAD" for would behave very differently otherwise.

So it is not merely "--verify is better"---in a situation where the
backward incompatibility matters, I doubt the existing behaves
sensibly in the first place.

But if we cook it for a while, I suspect that we will find more and
more breakages of expectations in the existing scripts in and out of
the tree; in general, I hate _any_ change, and I do not mind
dropping it ;-).
