From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git stash refuses to save after "add -N"
Date: Sun, 30 Aug 2009 22:03:07 -0700
Message-ID: <7vljl0lgms.fsf@alter.siamese.dyndns.org>
References: <54e098c45bffbf870bdfcee26b9ddecc.squirrel@intranet.linagora.com>
 <20090828190531.GB11488@coredump.intra.peff.net>
 <7vmy5ixn96.fsf@alter.siamese.dyndns.org>
 <20090830095509.GB30922@coredump.intra.peff.net>
 <7v63c5f4vs.fsf@alter.siamese.dyndns.org>
 <20090831042724.GA16646@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@linagora.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 31 07:03:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mhz39-0001X2-UY
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 07:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbZHaFDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 01:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbZHaFDS
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 01:03:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45655 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbZHaFDR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 01:03:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6A3D73D59C;
	Mon, 31 Aug 2009 01:03:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R+pmirSvm1iUvbZCEObIoyMDW6E=; b=bjoFcN
	TuzIgHuHs0Lac+oQmXqts7b3w2i5Ig5eGPy+odfaIgszwidGwXqo86m6UOQSeTk7
	ZnuxJpRvud16GjtJZVOlUKbdBifA4icFLqD7/pk0/w72z97p8/NySlvkF2WcpnRi
	mJ09wQe6xQOs8f6L0hlU++sH0JXd46W7SQI0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PXApKH/68lqLMVBF0H1MJswGPJp60DzC
	M8+1I39NPz0e9j3BB/t3qYt+AWsWjInOOj4SPB7GQl4vmaD7VUoUv2ogEOIzpGBR
	ClWdrXM62Erum/Q9FAXCDmPZDFklqLzmPk6a5QZIM9tuVbiGwcRvTsXC6X7TgFYw
	jnDTdJ5qRDQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3EE323D59B;
	Mon, 31 Aug 2009 01:03:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5E57B3D59A; Mon, 31 Aug 2009
 01:03:09 -0400 (EDT)
In-Reply-To: <20090831042724.GA16646@coredump.intra.peff.net> (Jeff King's
 message of "Mon\, 31 Aug 2009 00\:27\:25 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 97126DAA-95EB-11DE-81B8-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127459>

Jeff King <peff@peff.net> writes:

> My concerns are:
>
>   - "-f" is kind of vague. Would people expect it to force aspects of
>     the stash? Should it be "--intent-as-empty"?
>
>   - the error message is still a bit muddled, because you get the "not
>     yet added" files _first_, then some failure cruft from write-tree,
>     and _then_ the trying-to-be-helpful message
>
> I dunno. Honestly I am a bit lukewarm about this whole thing, as it
> seems like something that just wouldn't come up that often, and while
> the current error message is a bit disorganized, I think a user who has
> used "git add -N" can figure out that it is related (the only report we
> have is from Yann, who _did_ figure it out, but wanted to know how to
> make git handle the situation better).

I am not sure if asking for positive confirmation with "-f" is even worth
it.  As you pointed out in your earlier message, which prompted me to
respond with a patch, when this codepath is exercised, the user is in a
rush, and I do not see what else the user would want to do other than
including it in the stash by rerunning with -f.
