Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F2881FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 21:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbcFWVil (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 17:38:41 -0400
Received: from mout.web.de ([212.227.15.14]:61000 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751947AbcFWVik (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 17:38:40 -0400
Received: from [192.168.178.36] ([79.213.122.85]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MLy84-1bHHiq0mtA-007okd; Thu, 23 Jun 2016 23:38:28
 +0200
Subject: Re: [PATCH 2/2] archive-tar: write extended headers for far-future
 mtime
To:	Jeff King <peff@peff.net>
References: <20160616043523.GA13615@sigill.intra.peff.net>
 <20160616043758.GB18323@sigill.intra.peff.net> <57687417.4020009@web.de>
 <576A2631.2000608@web.de> <20160623192251.GB32745@sigill.intra.peff.net>
Cc:	git@vger.kernel.org
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <576C56CB.1040701@web.de>
Date:	Thu, 23 Jun 2016 23:38:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20160623192251.GB32745@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:gwMQXYAVuBWjqZnUiThJMjutE0U53pFzeQlJhHLwh0xurkAtuAV
 iHCFcOAmcBeTDYnmsi6Q2JBK46TPsqvw0P0nFSLq0VDku5jmKHIX1peZrZFxy05tGSCqAEJ
 tIwCzZ7DLhV/cEuiSZi8b7KzpXORALmmL98XpaOR7j6lLDFAcGjqH5BfoFVxQB05ynjVKmR
 UsVFxrBINcjO5CkDDr+zw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:j/0kMk6LUGk=:4gys6Bk6aA0BYJ7kYcgDo/
 QPl2rH1EPFp0MYAIF5sEnb5pqOxSzUQ5hiHzUejKQHOHg4moQI6DDWd3HI/LyKTnnaJ17jXkW
 IqgeFrYw55Mfr+77DPxm1B4ZUUlPUpv0mTb0ZV+Pccikyg854ILa98AkCYlApSHnW/9KpAMdJ
 ebBKtfH5QsMeAdwFNzaOy3JBCP7knzxv1qTHkUkwoFSeIwZT2NYXs4MxU2+x7hxIwuKLfrc9b
 dft8dTqm7GCZ1sdSSkJyZbFDq1/3dPVlDRiGQ2nLjkGKdCQmd9t+e1MiBdQmPc6Cm719xrKHS
 A37uhUAg+02dSxWOy3UoX9bQrLi0jzaGF0IPFZfB3CH5BVYuZKmrdf09tYOgtNyhHXAr4oxm0
 +RKbiWPYTDggbAsOk7nHrt49S4RioPJg+ee9e1ZbRJtWYNZakqzqvtsebDrxv9TLAyZw0vDBU
 CUnvNvMfLgDsGU/mSSHTNNiGVrl4BH2GhPKMXYl/0xjuwSBLAIfYdsRu3r2amrKIRRoAM86Mb
 v2401ovqKvT+U8uR8tIwZiCDmY+nJ83JSLxMv6nHI6ssPOPpevWSNhKRLhFJxLAO2BErCk1aA
 Z40ftL+ELFk4yzLddJP8SEL3O5sncsZLuwF7TvaT/qn3w4L1oanJcPo2rzIuG4iEITMKnHCfu
 VfTGNgVnNx4aiGQ0KYRpgWO54oNKSi3DqtMsq8XeptcTN0ZYFM6ANFaRpKnNwt43VkoVXmH4R
 5TMvdilbkw11cu6MOquGRlNF4NSPQc5t2ra6QRq6SOebidvEbBCfdg65eT4u1TbQTxWD+E9Pz
 Icob2QS
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 23.06.2016 um 21:22 schrieb Jeff King:
> On Wed, Jun 22, 2016 at 07:46:25AM +0200, René Scharfe wrote:
>
>> Am 21.06.2016 um 00:54 schrieb René Scharfe:
>>> Am 16.06.2016 um 06:37 schrieb Jeff King:
>>>>     2. System tars that cannot handle pax headers.
>>>
>>> In t5000 there is a simple interpreter for path headers for systems
>>> whose tar doesn't handle them.  Adding one for mtime headers may be
>>> feasible.
>>>
>>> It's just a bit complicated to link a pax header file to the file it
>>> applies to when it doesn't also contain a path header.  But we know that
>>> the mtime of all entries in tar files created by git archive are is the
>>> same, so we could simply read one header and then adjust the mtime of
>>> all files accordingly.
>>
>> This brings me to the idea of using a single global pax header for mtime
>> instead of one per entry.  It reduces the size of the archive and allows for
>> slightly easier testing -- it just fits better since we know that all our
>> mtimes are the same.
>
> Yeah, I had a similar thought while writing it, but wasn't quite sure
> how that was supposed to be formatted. I modeled my output after what
> GNU tar writes, but of course they are expecting a different mtime for
> each file.
>
> I'll look into how global pax headers should look.

Moving the strbuf_append_ext_header() call into 
write_global_extended_header() should be enough.  The changes to the 
test script are a bit more interesting, though.  Perhaps I can come up 
with something over the weekend.

René
