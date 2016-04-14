From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] fsck_commit_buffer(): do not special case the last validation
Date: Thu, 14 Apr 2016 11:15:39 -0700
Message-ID: <xmqq8u0ggipg.fsf@gitster.mtv.corp.google.com>
References: <20160414180709.28968-1-gitster@pobox.com>
	<20160414181030.GA22068@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 20:15:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqlnw-0001Su-4g
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 20:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530AbcDNSPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 14:15:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62454 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752611AbcDNSPn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 14:15:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1972C134E3;
	Thu, 14 Apr 2016 14:15:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TrfXgd4eGzK0drXjsXLYHf2IyGc=; b=OxjUrS
	CTfQBoVITlKjk3weQJIb9xmfuL3iCLztXTentPtlL1+BBUmcsXgN3uLwYuvIFKYp
	1WVcze33BfVcRfeVE1bRuWB8gOIoaw2IAEc2OQfC6CBq57C/BR6ySMYvL8N/dyjx
	iAqyGYSMREX5xXZUFlFHfMRA+1sX/E+lABPOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bk+021G45rKAyusA/RMBWrZKR9TrwTVo
	dipZyxUHax+wnTvJ9sIXAaL3QpmMPXpEvIXgEqSDVZ2wZpEnlpeZSM6s9djFeWK/
	0CgAa+DJX816bK/GDma/NbGaA0njEgwwGaWHo/hOFqdTSPzNHCIKO4tU/01YlV8w
	9wHO5rtSiZs=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 102A3134E1;
	Thu, 14 Apr 2016 14:15:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 71C8D134E0;
	Thu, 14 Apr 2016 14:15:41 -0400 (EDT)
In-Reply-To: <20160414181030.GA22068@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 14 Apr 2016 14:10:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E5B24A9E-026C-11E6-99A5-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291544>

Jeff King <peff@peff.net> writes:

> On Thu, Apr 14, 2016 at 11:07:08AM -0700, Junio C Hamano wrote:
>
>> The pattern taken by all the validations in this function is:
>> 
>> 	if (notice a violation exists) {
>> 		err = report(... VIOLATION_KIND ...);
>> 		if (err)
>> 			return err;
>> 	}
>> 
>> where report() returns zero if specified kind of violation is set to
>> be ignored, and otherwise shows an error message and returns non-zero.
>> 
>> The last validation in the function immediately after the function

s/after/before/

>> returns 0 to declare "all good" can cheat and directly return the
>> return value from report(), and the current code does so, i.e.
>> 
>> 	if (notice a violation exists)
>> 		return report(... VIOLATION_KIND ...);
>> 	return 0;
>> 
>> But that is a selfish code that declares it is the ultimate and
>> final form of the function, never to be enhanced later.  To allow
>> and invite future enhancements, make the last test follow the same
>> pattern.
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  fsck.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> Patch looks good, and nicely explained.
>
> -Peff
