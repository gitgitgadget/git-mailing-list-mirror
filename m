From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/3] t6301: new tests of for-each-ref error handling
Date: Tue, 02 Jun 2015 17:46:41 +0200
Message-ID: <556DCFE1.8070303@alum.mit.edu>
References: <1433174031-5471-1-git-send-email-mhagger@alum.mit.edu> <1433174031-5471-2-git-send-email-mhagger@alum.mit.edu> <20150601160834.GA15148@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Anders Kaseorg <andersk@mit.edu>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 02 17:47:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzoP9-000506-8h
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 17:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759411AbbFBPq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 11:46:59 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:54260 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759071AbbFBPq5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2015 11:46:57 -0400
X-AuditID: 12074411-f796c6d000000bc9-6a-556dcfe32731
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 6E.48.03017.3EFCD655; Tue,  2 Jun 2015 11:46:43 -0400 (EDT)
Received: from [192.168.69.130] (p4FC966E3.dip0.t-ipconnect.de [79.201.102.227])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t52FkfTs010429
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 2 Jun 2015 11:46:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <20150601160834.GA15148@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsUixO6iqPv4fG6owcs3mhZn+sItuq50M1k0
	9F5htvjR0sNssXlzO4sDq8eCTaUeTWeOMns8693D6HHxkrLH501yAaxR3DZJiSVlwZnpefp2
	CdwZl99/Yi7Yylcx/dFptgbG89xdjBwcEgImEv+mB3UxcgKZYhIX7q1n62Lk4hASuMwocfH1
	E3YI5zyTxPT1p1lBqngFtCX2fLzGDmKzCKhKXHo6nwXEZhPQlVjU08wEMlRUIEji9ctciHJB
	iZMzn4CViAjISnw/vJERZCazQBejxKSna8ESwgIeEn9uHmWEWDaXUWLV3+1MIAlOAT2JnmMv
	wZYxC6hL/Jl3iRnClpfY/nYO8wRGgVlIlsxCUjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJ
	eXmpRbqmermZJXqpKaWbGCEBLriDccZJuUOMAhyMSjy8jJ9yQoVYE8uKK3MPMUpyMCmJ8t44
	nhsqxJeUn1KZkVicEV9UmpNafIhRgoNZSYRXcANQjjclsbIqtSgfJiXNwaIkzsu3RN1PSCA9
	sSQ1OzW1ILUIJivDwaEkwRtzDqhRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhSr
	8cXAaAVJ8QDtDQRp5y0uSMwFikK0nmLU5fhxqXExkxBLXn5eqpQ4bwZIkQBIUUZpHtwKWDp7
	xSgO9LEwbztIFQ8wFcJNegW0hAloSbtADsiSkkSElFQDo90UnSKh5zrJwuq72erOip5nteN7
	c5z7zafD7KvvHJ14I/PaGUHT659cPLJVHxyacvxHTsk/Rk7/umIDA4ki/aXfz8ef 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270555>

On 06/01/2015 06:08 PM, Jeff King wrote:
> On Mon, Jun 01, 2015 at 05:53:49PM +0200, Michael Haggerty wrote:
> 
>> Add tests that for-each-ref correctly reports broken loose reference
>> files and references that point at missing objects. In fact, two of
>> these tests fail, because (1) NULL_SHA1 is not recognized as an
>> invalid reference value, and (2) for-each-ref doesn't respect
>> REF_ISBROKEN. Fixes to come.
> 
> This whole series looks straightforward and correct to me. Thanks for a
> pleasant read. I have two minor comments on the tests:
> 
>> --- /dev/null
>> +++ b/t/t6301-for-each-ref-errors.sh
>> @@ -0,0 +1,45 @@
>> +#!/bin/sh
>> +
>> +test_description='for-each-ref errors for broken refs'
>> +
>> +. ./test-lib.sh
>> +
>> +ZEROS=0000000000000000000000000000000000000000
>> +MISSING=abababababababababababababababababababab
> 
> The test suite provides $_z40, so you can skip $ZEROS. I don't think
> it's a big deal, though, and it may be nicer to have it explicitly next
> to $MISSING here.

Dang, I knew about that variable but just forgot it. I'll make this change.

>> +test_expect_success 'Missing objects are reported correctly' '
>> +	r=refs/heads/missing &&
>> +	echo $MISSING >.git/$r &&
>> +	test_when_finished "rm -f .git/$r" &&
>> +	echo "fatal: missing object $MISSING for $r" >missing-err &&
>> +	test_must_fail git for-each-ref 2>err &&
>> +	test_cmp missing-err err
>> +'
> 
> Due to b7dd2d2 (that you mentioned in the message for patch 2), we only
> sometimes notice the missing objects. Is it worth testing that:
> 
>   git for-each-ref --format='%(refname)'
> 
> does _not_ barf here?

It makes sense. I will add it, with --format='%(objectname) %(refname)'
for added fun.

Thanks for the review!
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
