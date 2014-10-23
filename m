From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Plumbing version of 'git branch --contains' ?
Date: Thu, 23 Oct 2014 11:07:13 -0700
Message-ID: <xmqqd29islri.fsf@gitster.dls.corp.google.com>
References: <B82B660D4887C042850326C2BC65FE035D58B11E@G9W0757.americas.hpqcorp.net>
	<20141023171921.GA25061@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Crabtree\, Andrew" <andrew.crabtree@hp.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 23 20:07:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhMnE-0006fr-Dr
	for gcvg-git-2@plane.gmane.org; Thu, 23 Oct 2014 20:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbaJWSHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2014 14:07:19 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57643 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932129AbaJWSHR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2014 14:07:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 44C6917346;
	Thu, 23 Oct 2014 14:07:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1RF1MiBH66/MyYkPJKooq2gq6oU=; b=kAV8FC
	ChCT6UQRJiL63iZgMEHs1A70tS9NgHKYPGTO1/EH6W/XAAKNzfWShCl/b6dhK/9q
	jRuhK+g0NMC1IOuSoq86F0VbMkvEb5MLR1r3XahhzbezrXkzJl73GR7Z7kwe+Zcz
	6SYxbIZPr5KOAGsZxPPE8QimjhR/5Ld7AJLKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n6TSINk4ElJIASj3SeEkI4pDHhsJT+Hs
	T+pz9RY/JDUttVytnyfLkfjLka6up+rAKGo45nmQnvi/KZWFu9CZUidTSHalGkbN
	TlQMHkj/af7agw+NIGEjGPSrAw44atgGW/pB2w/SWwIzCFVM5yepiBSfgsymR5GS
	/IY5mS9L4H0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 39FE217344;
	Thu, 23 Oct 2014 14:07:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A36D217343;
	Thu, 23 Oct 2014 14:07:14 -0400 (EDT)
In-Reply-To: <20141023171921.GA25061@peff.net> (Jeff King's message of "Thu,
	23 Oct 2014 10:19:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6AF7E84E-5ADF-11E4-AAAD-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Oct 22, 2014 at 08:19:07PM +0000, Crabtree, Andrew wrote:
>
>> I need to get a list of refs that can reach a certain SHA in in a script.
>> 
>> git branch --contains SHA 
>> 
>> would be great (runs in ~2 seconds), but not my preferred option for scripting.
>> 
>> I tried
>>  
>> for br in $(git for-each-ref --format='%(refname:short)' refs/heads/)
>> do
>>     git merge-base --is-ancestor $1 ${br}
>>     if [ $? -eq 0 ]
>>     then
>>             echo "${br}"
>>     fi
>> done
>> 
>> Which gives me perfect output, but takes 82 seconds to run in my environment.
>
> Right. There's some setup work that happens in `git branch --contains`
> that we end up repeating.
>
>> Is there an alternative I'm missing to give me the run time
>> performance of 'git branch --contains' but with stable output suitable
>> for parsing?
>
> Sadly, no, there isn't currently. The right tool would be `git
> for-each-ref --contains`, but it doesn't exist yet. I was working
> towards it, but got stopped on factoring out a `--contains` traversal
> suitable for both `git tag` and `git branch` (they currently are
> different and make performance tradeoffs based on the expected depth of
> the merge bases, which is usually different between tags and
> branches)[1].  That's work I'd love to resume, but I haven't gotten
> around to it yet.
>
> -Peff
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/252472

Thanks for status update.  I was wondering if I should start looking
into it myself.
