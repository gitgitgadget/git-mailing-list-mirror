From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-tag: fix fallouts from recent parsopt restriction.
Date: Mon, 17 Dec 2007 12:42:51 -0800
Message-ID: <7vhcih6oj8.fsf@gitster.siamese.dyndns.org>
References: <20071213091055.GA5674@coredump.intra.peff.net>
	<20071213093536.GC12398@artemis.madism.org>
	<20071213102636.GD12398@artemis.madism.org>
	<7vd4t5eq52.fsf@gitster.siamese.dyndns.org>
	<20071217090749.GC7453@artemis.madism.org>
	<7vir2xa8z7.fsf@gitster.siamese.dyndns.org>
	<20071217105834.GG7453@artemis.madism.org>
	<7v1w9la7o8.fsf@gitster.siamese.dyndns.org>
	<20071217123307.GK7453@artemis.madism.org>
	<7vy7bt6qv6.fsf@gitster.siamese.dyndns.org>
	<20071217203143.GA2105@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 17 21:43:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4MoH-0008QZ-Uv
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 21:43:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760634AbXLQUnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 15:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760558AbXLQUnI
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 15:43:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55728 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759857AbXLQUnH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 15:43:07 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D74BC46D4;
	Mon, 17 Dec 2007 15:43:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4514646D3;
	Mon, 17 Dec 2007 15:42:58 -0500 (EST)
In-Reply-To: <20071217203143.GA2105@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 17 Dec 2007 15:31:43 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68616>

Jeff King <peff@peff.net> writes:

> On Mon, Dec 17, 2007 at 11:52:29AM -0800, Junio C Hamano wrote:
>
>> So in short, for an option that takes optional option-argument:
>
> I agree with everything you said, except...
>
>>    - if it is given as "--long-name", and there is a next word, see if
>>      that is plausible as its argument.  Get it and signal the caller
>>      you consumed it, if it is.  Ignore it and signal the caller you
>>      didn't, if it isn't.
>
> This "plausible" makes me a little nervous, and I wonder why we want to
> support this at all. Is it
>
>   1. We have traditionally supported "--abbrev 10"? I don't think this
>      is the case.
>   2. Consistency with "--non-optional-arg foo"? Do we have any such
>      non-optional long arguments? I didn't see any; I think we stick
>      with --non-optional-arg=foo everywhere.
>   3. More convenience to the user? I don't see how " " is easier than
>      "=".

You forgot one case.

    4. Everybody who does _not_ know that we traditionally did not
       support the form would expect "--abbrev 10" and "-n 4" to work.
