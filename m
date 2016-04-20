From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCHv3 3/3] http.c: implements the GIT_TRACE_CURL environment
 variable
Date: Wed, 20 Apr 2016 20:56:28 +0100
Message-ID: <5717DEEC.4000903@ramsayjones.plus.com>
References: <20160420162825.62380-1-gitter.spiros@gmail.com>
 <20160420162825.62380-4-gitter.spiros@gmail.com>
 <xmqqzisoun5n.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, tboegi@web.de, sunshine@sunshineco.com,
	peff@peff.net
To: Junio C Hamano <gitster@pobox.com>,
	Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 21:56:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asyEp-0001Bm-2C
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 21:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbcDTT4f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 15:56:35 -0400
Received: from avasout07.plus.net ([84.93.230.235]:42898 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbcDTT4e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 15:56:34 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout07 with smtp
	id kjwX1s0032D2Veb01jwYeB; Wed, 20 Apr 2016 20:56:32 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=pGLkceISAAAA:8 a=EBOSESyhAAAA:8 a=ybZZDoGAAAAA:8 a=BCjA09oAAAAA:8
 a=PKzvZo6CAAAA:8 a=3Q2Y9p4gJdUVHI5vUAEA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <xmqqzisoun5n.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292068>



On 20/04/16 19:53, Junio C Hamano wrote:
> Elia Pinto <gitter.spiros@gmail.com> writes:
>=20
>> Implements the GIT_TRACE_CURL environment variable to allow a
>=20
> s/Implements/Implement/; speak as if you are giving an order to the
> codebase to "be like so".
>=20
>> greater degree of detail of GIT_CURL_VERBOSE, in particular
>> the complete transport header and all the data payload exchanged.
>> It might be useful if a particular situation could require a more
>> thorough debugging analysis.
>>
>> Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
>> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Helped-by: Jeff King <peff@peff.net>
>> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
>> ---
>>  http.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++-
>>  http.h |   6 ++++
>>  2 files changed, 106 insertions(+), 1 deletion(-)
>>
>> diff --git a/http.c b/http.c
>> index 4304b80..507c386 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -11,6 +11,7 @@
>>  #include "gettext.h"
>>  #include "transport.h"
>> =20
>> +static struct trace_key trace_curl =3D TRACE_KEY_INIT(CURL);
>>  #if LIBCURL_VERSION_NUM >=3D 0x070a08
>>  long int git_curl_ipresolve =3D CURL_IPRESOLVE_WHATEVER;
>>  #else
>> @@ -464,6 +465,100 @@ static void set_curl_keepalive(CURL *c)
>>  }
>>  #endif
>> =20
>> +
>=20
> No need for this extra blank line.
>=20
>> +void curl_dump(const char *text, unsigned char *ptr, size_t size, c=
har nohex)
>> +{
>> +	size_t i;
>> +	size_t w;

As I said in a previous email, curl_dump() should be marked
static here (and remove the declaration from http.h). Unless,
of course, there are plans for future use/calls being added?

ATB,
Ramsay Jones
