From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] repack: add `repack.honorpackkeep` config var
Date: Mon, 24 Feb 2014 11:10:49 -0800
Message-ID: <xmqq1tys9vie.fsf@gitster.dls.corp.google.com>
References: <52E080C1.4030402@fb.com>
	<20140123225238.GB2567@sigill.intra.peff.net>
	<52E1A99D.6010809@fb.com> <52E1AB78.1000504@fb.com>
	<20140124022822.GC4521@sigill.intra.peff.net>
	<52E1D39B.4050103@fb.com>
	<20140128060954.GA26401@sigill.intra.peff.net>
	<xmqq8uu0mpg8.fsf@gitster.dls.corp.google.com>
	<20140224082459.GA32594@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Siddharth Agarwal <sid0@fb.com>, Vicent Marti <tanoku@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 24 20:11:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI0vb-0000L2-CA
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 20:10:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994AbaBXTKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 14:10:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34931 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752965AbaBXTKx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 14:10:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF58A6DCB9;
	Mon, 24 Feb 2014 14:10:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bhCdbK8omzyrhEJwDqfonN0OnMY=; b=yR/5PQ
	CMRgY9zxWdgWez4kRpoV02OBUgDRbTyFV2TkwIfgtaVv2E36ELSzQ+MiV96OD5AO
	uFJT61MXXBswG1QhtdKJ8HyHW2ufkBgg2miDIopjNp55D5Ic9lsR+QWneRERPBnG
	w7OzvP+j7WJwEpL4pOdC1p+jDFa1/7QqZTssc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rnzQUyyYDUf9QIIBpisrTYZJSSbUE4C1
	kyj7vmtEqOGclB3o97wirwPwY4DB1qmsqq7acrQVZvew4gYtuAQ5dRw/6jkaDIk1
	pK9P99NOISetJwuT1yHg0sN1ZrZLmNaAhtyQbi/60M+54v/nEM7sFysFk+6119+z
	VAVQV3H5xo0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C83286DCB8;
	Mon, 24 Feb 2014 14:10:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E14866DCB2;
	Mon, 24 Feb 2014 14:10:51 -0500 (EST)
In-Reply-To: <20140224082459.GA32594@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 24 Feb 2014 03:24:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 60AC85FE-9D87-11E3-A3C6-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242629>

Jeff King <peff@peff.net> writes:

> Sorry, this one slipped through the cracks. Here's a re-roll addressing
> your comments.
> ...
>>  - In the context of "pack-objects", the name "--honor-pack-keep"
>>    makes sense; it is understood that pack-objects will _not_ remove
>>    kept packfile, so "honoring" can only mean "do not attempt to
>>    pick objects out of kept packs to add to the pack being
>>    generated." and there is no room for --no-honor-pack-keep to be
>>    mistaken as "you canremove the ones marked to be kept after
>>    saving the still-used objects in it away."
>> 
>>    But does the same name make sense in the context of "repack"?
>
> I think the distinction you are making is to capture the second second
> from the docs:
>
>   If set to false, include objects in `.keep` files when repacking via
>   `git repack`. Note that we still do not delete `.keep` packs after
>   `pack-objects` finishes.
>
> The best name I could come up with is "--pack-keep-objects", since that
> is literally what it is doing. I'm not wild about the name because it is
> easy to read "keep" as a verb (and "pack" as a noun). I think it's OK,
> but suggestions are welcome.

pack-kept-objects then?
