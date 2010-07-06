From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Make author and committer available to pre-commit hook
Date: Tue, 06 Jul 2010 08:47:37 -0700
Message-ID: <7veifg4nom.fsf@alter.siamese.dyndns.org>
References: <AANLkTinpCDRf_Yhuj2-tdZwmvHk8yna1Xjdtbrmx35CB@mail.gmail.com>
 <20100705114619.GA21146@sigill.intra.peff.net>
 <AANLkTinlGBt3nBa7Ge5ytjisTeDu3As4wCkF8M1iz5JV@mail.gmail.com>
 <AANLkTim-TXX4uVyUN9loOI276wnKp22m4F7g5c-js61U@mail.gmail.com>
 <7vocel5n08.fsf@alter.siamese.dyndns.org>
 <20100706072947.GB3567@sigill.intra.peff.net>
 <AANLkTilsdbJLHTY7cx2GeZg9ai_OZhmnEt0KdFjF81Pd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Gisle Aas <gisle@aas.no>
X-From: git-owner@vger.kernel.org Tue Jul 06 17:47:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWANH-0008JW-OC
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 17:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753797Ab0GFPru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 11:47:50 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48869 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176Ab0GFPrt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 11:47:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AE2BC2D0D;
	Tue,  6 Jul 2010 11:47:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hTIgEwjrZF53m1b7C+OTbjmnd34=; b=bT2yZK
	00+h6vG0IkVnAcfOC6L/pOVCyp9Xt034yUJdzJFec1EK47jBPPCOcTmsyI7Lg6BH
	UiuZpvcvyie9Pogif4OzufJPRk33eFxMj5zi3/goJ8iZzYt2Ea2hqdlcPOYSBXGU
	NkWBdKKgbHAhWS2J6xGxmR1kCyzNYYe3ClNQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EPmnF5S0Xsun47e/T+bqt30myfFThi+T
	1a0nTlzLOnFZEc9IWcxeoDhEX8dZvewSakP2+D5luiyTh8cGg1ONV3th5L7r2nTN
	BWwUtU9CkXkVYSdLwbFJIUAuPHaBgm8QhFT1iKtoTl+HNoLM+r9nAs4OeETNlInz
	LsgoY3+cgsk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EFBDCC2D0C;
	Tue,  6 Jul 2010 11:47:43 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14D8BC2D05; Tue,  6 Jul
 2010 11:47:38 -0400 (EDT)
In-Reply-To: <AANLkTilsdbJLHTY7cx2GeZg9ai_OZhmnEt0KdFjF81Pd@mail.gmail.com>
 (Gisle Aas's message of "Tue\, 6 Jul 2010 11\:22\:07 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D1144ADC-8915-11DF-A611-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150365>

Gisle Aas <gisle@aas.no> writes:

> One question that arise is what format the date variables should have.
> Is the raw format (that is "1278400946 +0200") sensible?

I'd say so.  We are doing this for scripts (hooks) and there is not much
point doing machine-readable-to-human conversion they could do if they so
choose.

> I've created a patch for this locally, but it has some side effects in
> messing up the dates stored by 'git commit -C...' which I have not
> figured out yet; and now I need to get some other stuff done.

I imagine that you would be sending the date information just the same way
you send the author information, so if your addition messes up the dates
for "commit -C", wouldn't your original patch mess up the authorship
information the same way?

In any case, this new feature won't be in 'master' nor 'next' while we are
in pre-release freeze, so no need to rush.

Thanks.
