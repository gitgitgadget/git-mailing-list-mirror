From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] Handle more file writes correctly in shared repos
Date: Mon, 11 Jan 2016 07:57:03 -0800
Message-ID: <xmqqio30yur4.fsf@gitster.mtv.corp.google.com>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de>
	<cover.1452085713.git.johannes.schindelin@gmx.de>
	<c03e5a9d367b76d8a249680c752b4c4d935e9b91.1452085713.git.johannes.schindelin@gmx.de>
	<xmqq1t9t3vn8.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1601081704280.2964@virtualbox>
	<xmqqbn8w2brm.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1601111018550.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Yaroslav Halchenko <yoh@onerussian.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 11 16:57:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIeqR-0003KV-UL
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 16:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760669AbcAKP5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 10:57:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61214 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759403AbcAKP5M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 10:57:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 010C1375B0;
	Mon, 11 Jan 2016 10:57:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UTMC+GlIXTqDRnVdbkjdS439Lwo=; b=gwUIJ5
	yskm1CqnL9fxh6oxGcawUEC97JcjHRQ9FmKzElq1LsYYCFDPsGD0kS4S7KxZRGQX
	lzWKK6EE254gf4FvFJZrNuCByxdfvXmIuNXkcckesHL4xq6sOvA7Dan82LMSOAo1
	lNwul+zv/WKXGmwdx66I3XxIPcl1I2C+D5gLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vfhBk/KFzncm3uSe8h+aOMitRylb6/tp
	U4TzgmIFAhGNLlFSXbYwXoCA+U3/PItNWFwhe1AGmhkF2T74Q8EitGTah8fM8/tv
	LIY2XRn0JnnXCGoTjvGolTnQH5swxwDqU/btLz4CZ+Ppf+C1eJBS3XqpajcgxBKw
	QQu1Snff2oc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EC5BE375AC;
	Mon, 11 Jan 2016 10:57:05 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6FE0D375A9;
	Mon, 11 Jan 2016 10:57:05 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1601111018550.2964@virtualbox> (Johannes
	Schindelin's message of "Mon, 11 Jan 2016 10:28:28 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F6248B2A-B87B-11E5-B81E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283661>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 8 Jan 2016, Junio C Hamano wrote:
>
>> I think it is correct not to touch this codepath in this patch,
>> because of the above two reasons, but more simply and generally, it
>> is correct not to touch this codepath because core.sharedRepository
>> is not about working tree files, and .rej is a file you use in your
>> working tree.
>
> I am happy to adjust the log message, but I am pretty certain that the
> `core.sharedRepository` setting actually also affects the working tree. At
> least in my hands, calling
>
> 	git clone -c core.sharedRepository=group . test-shared
>
> results in all of the working tree files being group-writable.

Interesting.  I have a suspicion that "clone" does not honor the
configuration given that way, though.

 $ umask 077
 $ git clone -c core.sharedRepository=group ~/w/git.git sharedtest
 $ cd sharedtest
 $ ls -l COPYING .git/index
 -rw------- 1 jch eng 18765 Jan 11 07:43 COPYING
 -rw------- 1 jch eng 272037 Jan 11 07:43 .git/index

Notice that the permission bits in the working tree is correct, but
in the resulting .git/ they are bogus, so from this we cannot
clearly see the reason why COPYING is not group-readable is because
the checkout codepath (write_entry(), I think) is correctly omitting
the call to adjust_perm(), or simply the configuration is ignored
during the clone.

With a workaround to ensure that checkout happens definitely after
the configuration gets in effect by doing config and pull/checkout
as two separate steps:

 $ rm -fr sharedtest
 $ umask 077
 $ git init sharedtest && cd sharedtest
 $ git config core.sharedRepository group
 $ git pull ~/w/git.git/ master
 $ ls -l COPYING .git/index
 -rw------- 1 jch eng 18765 Jan 11 07:48 COPYING
 -rw-rw---- 1 jch eng 272037 Jan 11 07:48 .git/index

we can see that the configuration affects only the $GIT_DIR/ files
and not working tree.

So you found a bug in clone, I think ;-)
