From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 00/14] numparse module: systematically tighten up integer
 parsing
Date: Tue, 24 Mar 2015 16:05:56 +0100
Message-ID: <55117D54.103@alum.mit.edu>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu> <20150319052620.GA30645@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 24 16:06:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaQPE-0005NU-8L
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 16:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400AbbCXPGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 11:06:08 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:48019 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752335AbbCXPGG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2015 11:06:06 -0400
X-AuditID: 1207440d-f79976d000005643-49-55117d562d63
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 8E.CA.22083.65D71155; Tue, 24 Mar 2015 11:05:58 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9745A.dip0.t-ipconnect.de [79.201.116.90])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2OF5uDg008252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 24 Mar 2015 11:05:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <20150319052620.GA30645@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqBtWKxhqMPe0mUXXlW4mi4beK8wW
	P1p6mC0e35rA5MDi8ax3D6PH3PuWHhcvKXt83iQXwBLFbZOUWFIWnJmep2+XwJ3xcc4UloK9
	RhV/pu9haWCcptHFyMkhIWAiceroLkYIW0ziwr31bF2MXBxCApcZJSY0XWOCcM4zSRzcs4Ud
	pIpXQF3i2qltbCA2i4CqxLld91hBbDYBXYlFPc1MILaoQJDEy1t/GSHqBSVOznzCAmKLCMhK
	fD+8ESzOLBAvMWPec7B6YYFwiaX3ZoPZQgKpEp3vJoDt4hTQk1h94SEbRL26xJ95l5ghbHmJ
	5q2zmScwCsxCsmIWkrJZSMoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI10svNLNFLTSnd
	xAgJZ94djP/XyRxiFOBgVOLhDVgiECrEmlhWXJl7iFGSg0lJlHe6k2CoEF9SfkplRmJxRnxR
	aU5q8SFGCQ5mJRFe1yqgHG9KYmVValE+TEqag0VJnFdtibqfkEB6YklqdmpqQWoRTFaGg0NJ
	gpe/BqhRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhSr8cXAaAVJ8QDtfVYNsre4
	IDEXKArReopRUUqc9z9IQgAkkVGaBzcWlqReMYoDfSnMaw6ynQeY4OC6XwENZgIafC6fD2Rw
	SSJCSqqBMdUtZPIazvvFpWENu9aJveQ9VXpEUHvjnCd7vU03JpxVajd4eGXJlgS9STKuRjX3
	utVPxJ7QyFgQ8mBLoXKo063rn1LOpUp3uzQrf7FyuhRpcDow9n1d7Z0+PdVHjvxK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266189>

On 03/19/2015 06:26 AM, Jeff King wrote:
> On Tue, Mar 17, 2015 at 05:00:02PM +0100, Michael Haggerty wrote:
> 
>> My main questions:
>>
>> * Do people like the API? My main goal was to make these functions as
>>   painless as possible to use correctly, because there are so many
>>   call sites.
>>
>> * Is it too gimmicky to encode the base together with other options in
>>   `flags`? (I think it is worth it to avoid the need for another
>>   parameter, which callers could easily put in the wrong order.)
> 
> I definitely like the overall direction of this. My first thought was
> that it does seem like there are a lot of possible options to the
> functions (and OR-ing the flags with the base does seem weird, though I
> can't think of a plausible case where it would actually cause errors).
> Many of those options don't seem used in the example conversions (I'm
> not clear who would want NUM_SATURATE, for example).

There are a lot of options, but so far only few of them have been used.
As the call sites are rewritten we will see which of these features are
useful, and which can be dispensed with. If groups of options tend to be
used together, we can define constants for them like I've done with
NUM_SLOPPY and NUM_SIGN.

Regarding NUM_SATURATE: I'm not sure who would want it either, but I
thought there might be places where the user wants to specify
(effectively) "infinity", and it might be convenient to let him specify
something easy to type like "--max=999999999999" rather than
"--max=2147483647".

> I wondered if we could do away with the radix entirely. Wouldn't we be
> asking for base 10 most of the time? Of course, your first few patches
> show octal parsing, but I wonder if we should actually have a separate
> parse_mode() for that, since that seems to be the general reason for
> doing octal parsing. 100000644 does not overflow an int, but it is
> hardly a reasonable mode.

Again, as a first pass I wanted to just have a really flexible API so
that call sites can be rewritten without a lot of extra thought. If
somebody wants to add a parse_mode() function, it will be easy to build
on top of convert_ui(). But that change can be done after this one.

> I also wondered if we could get rid of NUM_SIGN in favor of just having
> the type imply it (e.g., convert_l would always allow negative numbers,
> whereas convert_ul would not). But I suppose there are times when we end
> up using an "int" to store an unsigned value for a good reason (e.g.,
> "-1" is a sentinel value, but we expect only positive values from the
> user). So that might be a bad idea.

Yes, as I was rewriting call sites, I found many that used the unsigned
variants of the parsing functions but stored the result in an int.
Probably some of these use -1 to denote "unset"; it might be that there
are other cases where the variable could actually be declared to be
"unsigned int".

Prohibiting signs when parsing signed quantities isn't really elegant
from an API purity point of view, but it sure is handy!

> I notice that you go up to "unsigned long" here for sizes. If we want to
> use this everywhere, we'll need something larger for parsing off_t
> values on 32-bit machines (though I would not at all be surprised with
> the current code if 32-bit machines have a hard time configuring a
> pack.packSizeLimit above 4G).

Yes, probably. I haven't run into such call sites yet.

> I wonder how much of the boilerplate in the parse_* functions could be
> factored out to use a uintmax_t, with the caller just providing the
> range. That would make it easier to add new types like off_t, and
> possibly even constrained types (e.g., an integer from 0 to 100). On the
> other hand, you mentioned to me elsewhere that there may be some bugs in
> the range-checks of config.c's integer parsing. I suspect they are
> related to exactly this kind of refactoring, so perhaps writing things
> out is best.

It's not a lot of code yet. If we find out we need variants for size_t
and off_t and uintmax_t and intmax_t then such a refactoring would
definitely be worth considering.

>> * Am I making callers too strict? In many cases where a positive
>>   integer is expected (e.g., "--abbrev=<num>"), I have been replacing
>>   code like
>> [...]
> 
> IMHO most of the tightening happening here is a good thing, and means we
> are more likely to notice mistakes rather than silently doing something
> stupid.
> 
> For sites that currently allow it, I could imagine people using hex
> notation for some values, though, depending on the context. It looks
> there aren't many of them ((it is just when the radix is "0", right?).
> Some of them look to be accidental (does anybody really ask for
> --threads=0x10?), but others might not be (the pack index-version
> contains an offset field that might be quite big).

Yes, we can even debate whether we want to implement a general policy
that user-entered integers can be specified in any radix. Probably
nobody will ever specify "--threads=0x10", but is there harm in allowing it?

Against the gain in flexibility, I see the following potential
disadvantages:

* Added cognitive burden for rarely-used flexibility.
* Other Git clients might feel obliged to be just as flexible, causing
their implementers extra work.
* Users might see commands written in unfamiliar ways (e.g. in scripts
or stackoverflow) and get confused.
* Octal is ambiguous with decimal. What to make of "--count=010"? People
who expect octal numbers to be allowed will think it means 8, whereas
people who don't expect octal numbers to be allowed (or don't even know
what an octal number is!) will think that it means 10. Such uses might
even already exist and have their meaning changed if we start allowing
octal.

All in all, I thought it is less error-prone to default to allowing only
decimal, except in selected situations where hex and octal are
traditionally used (e.g., file modes, memory limits).

Most of the call sites so far have explicitly specified decimal parsing,
and I have left them unchanged.

> Feel free to ignore any or all of that. It is not so much criticism as
> a dump of thoughts I had while reading the patches. Perhaps you can pick
> something useful out of that, and perhaps not. :)

Thanks very much for the feedback!

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
