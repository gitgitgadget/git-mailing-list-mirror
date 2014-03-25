From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Better control of the tests run by a test suite
Date: Mon, 24 Mar 2014 21:58:18 -0700
Message-ID: <7v4n2mq3h1.fsf@alter.siamese.dyndns.org>
References: <1395650987-5960-1-git-send-email-ilya.bobyr@gmail.com>
	<20140324230304.GC17080@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilya Bobyr <ilya.bobyr@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 25 05:57:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSJQC-0000IP-Se
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 05:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbaCYE5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 00:57:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37877 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876AbaCYE5C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 00:57:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55276677D6;
	Tue, 25 Mar 2014 00:57:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sdbejxMcYavDkUrrKs0pdMevaCQ=; b=ZjR2OC
	nXfO8rivpJctwGuW1qNaC4mnpsNQXmpjGDNoXURCqRTapDxhrLchClTuazaGZkTo
	geHROzA9IMXoD7yVF0+48bb8M1t4uH1tCkXQ1q4iPfs6cDzkDszLhhOqYaQ+lI9y
	5NHx6zaeneig2ZlXCuTquROs0Wc3Ocfv+CF8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SRAFQyeTTkulYTQrZMwAlYUdFp8eIOA0
	TMVck1Jhajq+E5H9+7RApE+Bapoeq45YxiRbknWdNoxGXwNnRhfYVFNsQFbW9D2+
	ktyQ08QmetNURV1+kzlVzZT056vST1wKuLV5l1nwHpwdrYJb9H6afdXqoXP+ezwx
	qUrGDNfdrJ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EDC0677D5;
	Tue, 25 Mar 2014 00:57:02 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 66543677D2;
	Tue, 25 Mar 2014 00:57:01 -0400 (EDT)
In-Reply-To: <20140324230304.GC17080@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 24 Mar 2014 19:03:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: E6E5055C-B3D9-11E3-83A8-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244903>

Jeff King <peff@peff.net> writes:

> On Mon, Mar 24, 2014 at 01:49:44AM -0700, Ilya Bobyr wrote:
>
>> Here are some examples of how functionality added by the patch
>> could be used.  In order to run setup tests and then only a
>> specific test (use case 1) one can do:
>> 
>>     $ ./t0000-init.sh --run='1 2 25'
>> 
>> or:
>> 
>>     $ ./t0000-init.sh --run='<3 25'
>> 
>> ('<=' is also supported, as well as '>' and '>=').
>
> I don't have anything against this in principle, but I suspect it will
> end up being a big pain to figure out which of the early tests are
> required to set up the state, and which are not. Having "<" makes
> specifying it easier, but you still have to read the test script to
> figure out which tests need to be run.

Likewise.

> I wonder if it would make sense to "auto-select" tests that match a
> regex like "set.?up|create"? A while ago, Jonathan made a claim that
> this would cover most tests that are dependencies of other tests. I did
> not believe him, but looking into it, I recall that we did seem to have
> quite a few matching that pattern. If there were a good feature like
> this that gave us a reason to follow that pattern, I think people might
> fix the remainder

This may be worth experimenting with, I would think.
