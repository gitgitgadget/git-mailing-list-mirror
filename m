From: Junio C Hamano <gitster@pobox.com>
Subject: Re: sparse checkout file with windows line endings doesn't work
Date: Fri, 20 Sep 2013 11:06:24 -0700
Message-ID: <xmqqa9j7qsf3.fsf@gitster.dls.corp.google.com>
References: <CACsJy8BeT7ZP+ZQah7FR6ogqRNiiDZYP5SEs8J6J=+gEHU5MUg@mail.gmail.com>
	<SDZYTDk4NyMxKC4hPVQvMjM1MDUxNjg3@IBMLT4>
	<20130920031705.GA15101@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Gregory <marting@adelaideinterim.com.au>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 20 20:06:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VN568-0006bc-4Z
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 20:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385Ab3ITSG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Sep 2013 14:06:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57190 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753373Ab3ITSG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Sep 2013 14:06:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 258BD43EC6;
	Fri, 20 Sep 2013 18:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=08pvLVWcIpNB7aD3JzIFk3BTOTs=; b=J6j7ji
	njHLhzgZLFA/STB5NQwsLPiqdk5r7kByrwOBiOWBRzQxHYq1kuQ1UYrbc6KoVhWY
	2mnYEia5Z8R2uQ6W22pYZas2HWbr7zKcnZlR6nb1mE1mjWla6Po3+yZMLyY0VnMd
	UZ5DLv6aOM8Sc8i4VF4GcLqgBi57uEYeqGZrk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lkg48Zjru1JS022xxTUWazOYzBvwQtrH
	z6w2zUPgtCmTZNiQi8b/2fpapyxme4mwmukhi0mssEF46U6aeUmgNen3AK72wEHb
	p8GxQAflpyP7f/3FDq+X/0fnwgzW7v1ONNDDI5FbwxeTtbmw5fGbJUR5QYLqDRCW
	7at5oaTiL2g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16FCD43EC5;
	Fri, 20 Sep 2013 18:06:27 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 70B7E43EC3;
	Fri, 20 Sep 2013 18:06:26 +0000 (UTC)
In-Reply-To: <20130920031705.GA15101@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 19 Sep 2013 23:17:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5DD3AECC-221F-11E3-A255-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235072>

Jeff King <peff@peff.net> writes:

> On Fri, Sep 20, 2013 at 11:22:01AM +0930, Martin Gregory wrote:
>
>> When something goes wrong, there appears to be no way to understand what
>> git thinks it's reading.   I'm not sure if such a way, if it existed, would help with
>> trailing spaces, but if you could say
>> 
>> git read-tree -muv HEAD
>> 
>> and it would say
>> 
>> reading '.git\info\sparse-checkout'...
>> rule '/CONFIGURATION ' - no matches
>
> I don't think you can do that in the general case of read-tree. You may
> have sparse paths that exist in some commits, but not others. As you
> move around in history, a sparse entry that does not match might do so
> because it is poorly written, or it might do so because you just don't
> happen to have any matching paths in the commit you are moving to. The
> former is a problem, but warning on the latter would be useless noise.

While that is very true, if

 (1) there is a good criterion to tell that a path pattern in sparse
     file is very likely to be a mistake; and

 (2) we can guess uniquely what likely-to-be-intended path pattern
     the above is a typo for

it may be reasonable to allow people to do:

    GIT_PATH_PATTERN_DEBUG=yes git read-tree -m -u HEAD

and get a diagnostic message

	A rule '/CONFIGURATION ' does not match, but would have
	matched a path if it were spelled '/CONFIGURATION'

or something like that.  The same applies for exclude and possibly
attribute.

Not my itch, though.  Both of these preconditions are *hard*;
limiting only to trailing whitespaces would be an easy start, but
that limitation would make things pretty much useless on sane
platforms.
