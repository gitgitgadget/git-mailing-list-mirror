From: Junio C Hamano <gitster@pobox.com>
Subject: Re: POSIX woes in t7810.87: dash bash or bash dash?
Date: Mon, 20 Jun 2011 16:31:32 -0700
Message-ID: <7vwrgg9j1n.fsf@alter.siamese.dyndns.org>
References: <4DFF19C4.5070003@drmicha.warpmail.net>
 <7voc1sb2hr.fsf@alter.siamese.dyndns.org>
 <20110620232425.GA617@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 21 01:31:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYnwS-0002qB-GQ
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 01:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756165Ab1FTXbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 19:31:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40108 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755981Ab1FTXbe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 19:31:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7FEE56F13;
	Mon, 20 Jun 2011 19:33:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YzGWcRxwtfG2nacr2XhpElKK1y8=; b=LWV0/A
	HGrgaV1v0U8+3NV+X0e/EkIOz8WjMQskkBj6u7d5RKZHE7Pt4CY3sbdD0H3e7Jtk
	Ych9y8O0TU6FKuxXGg+s3wNoFgyQX+liyuD+ZIO6ZNYMLT+An8Un+bIWtKdG7VZV
	rHvw53R6YbrK2whCgoYbgFoH2cTTNWr+Whurs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gb8s2zCshhcALBEm9Htcqhbg0QR4/iNX
	BYX/Av/ccwR5cbNEINPnvlzTwTQTihim8b+MCAfYQ1PnNL1VHiF7tCmg0joFEuer
	2rU29b2tGg5ND+kra4Xyn8SrTuQhOhSzCXzG7By2dpdKUBOW323I7T8GMkeQ5gw/
	iimTI8hQYrw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 781626F12;
	Mon, 20 Jun 2011 19:33:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C16D16F11; Mon, 20 Jun 2011
 19:33:45 -0400 (EDT)
In-Reply-To: <20110620232425.GA617@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 20 Jun 2011 19:24:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BDCF076C-9B95-11E0-A192-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176111>

Jeff King <peff@peff.net> writes:

> On Mon, Jun 20, 2011 at 02:46:08PM -0700, Junio C Hamano wrote:
>
>> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
>> index 69bd576..6379ad6 100755
>> --- a/t/t7810-grep.sh
>> +++ b/t/t7810-grep.sh
>> @@ -658,9 +658,9 @@ test_expect_success LIBPCRE 'grep -P -v pattern' '
>>  '
>>  
>>  test_expect_success LIBPCRE 'grep -P -i pattern' '
>> -	{
>> -		echo "hello.c:	printf(\"Hello world.\n\");"
>> -	} >expected &&
>> +	cat >expected <<-EOF &&
>> +	hello.c:	printf("Hello world.\n");
>> +	EOF
>
> Do you need to quote EOF to suppress expansion in the here document?
> Both bash and dash seem to pass unknown backslash-escapes like "\n"
> through unharmed, but I don't know if that is portable (they do both
> munge known escapes like "\\", of course).

I do not think that is strictly necessary, as we are not in the corner of
non-portable echo behaviour anymore, but I guess it wouldn't hurt.
