From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] t3404: preserve test_tick state across short SHA-1 collision test
Date: Sun, 25 Aug 2013 22:29:40 -0700
Message-ID: <xmqqwqn9j9yz.fsf@gitster.dls.corp.google.com>
References: <1377112378-45511-1-git-send-email-sunshine@sunshineco.com>
	<1377112378-45511-2-git-send-email-sunshine@sunshineco.com>
	<20130825055550.GN2882@elie.Belkin>
	<CAPig+cSns+_mOMRVRv2Kqb3vHNQGoE4NGZ3ELu7y3pQ57VqPXw@mail.gmail.com>
	<20130825085318.GV2882@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 07:29:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDpN7-0002w5-7D
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 07:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755923Ab3HZF3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 01:29:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36798 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755500Ab3HZF3o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 01:29:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 252E237DAC;
	Mon, 26 Aug 2013 05:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5Hwipl0VzSYSUJwSHyqjuFqAGmM=; b=IUdT+w
	VLueTnqmv5Pf1KWH8qvQInsotdAK8nagJ+iVBbbIrDnWlBj9CeK/eevSYW86SAvl
	aPMJaFi8rxW9YUrYjM/T/GGnISnCuVuZsddMB1gIB6X7q2unWwLH/RVN/oDXs5fo
	NZrpVZmKRuzD0eSP6utmMqU4jITewjOhwbGXI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z4jbEJt3caUGuxkLflwhmBV+/8mhA5Ny
	eWu5VukMQ+igFpviDLR4aF+4wvpPtWFtH09XC3SST6p7BSfuV/Hp1Gr1ssdf6lCH
	/MYbkmXAAlX3g35deKyKBSxYdlPGpfQovJAaK/we0cxeTZ/KSUF14CHoo4pX0yMe
	azbAwrpga74=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1020837DAB;
	Mon, 26 Aug 2013 05:29:43 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6DB3F37DA3;
	Mon, 26 Aug 2013 05:29:42 +0000 (UTC)
In-Reply-To: <20130825085318.GV2882@elie.Belkin> (Jonathan Nieder's message of
	"Sun, 25 Aug 2013 01:53:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8298FAAA-0E10-11E3-BA9E-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232973>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Eric Sunshine wrote:
>> On Sun, Aug 25, 2013 at 1:55 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
>>> Would be clearer if the code in a subshell were indented:
>>>
>>>         (
>>>                 unset test_tick &&
>>>                 test_commit ...
>>>         )
>>
>> I considered it, but decided against it for a couple reasons:
>>
>> * In this script, there already is a mix between the two styles:
>> indented vs. unindented.
>>
>> * In this particular patch, the test_commit line creating commit3
>> wrapped beyond 80 columns when indented.
>
> I'm just one person, but I find the indented form way more readable.
> Long lines or lines with \ continuation are not a big deal.
>
> [...]
>>                                      Should this be worth a re-roll?
>
> Since the file already has a mixture of styles, if there's no other
> reason to reroll, I'd suggest leaving it alone.
>
> The next time it bugs me or someone else, that person can write a
> patch that cleans up the whole file on top. :)

Yeah, I think we saw "style modernization" patches to some test
scripts during the last cycle. This one and the rest may want to go
through a similar modernization, but it can be done after a real
change like the proposed one matures.

Thanks.
