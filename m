From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH] wt-status: use strncmp() for length-limited string
 comparison
Date: Wed, 25 Nov 2015 03:16:49 +0100
Message-ID: <56551A11.9030809@web.de>
References: <563D2DE7.1030005@web.de>
 <20151124213601.GB29185@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 25 03:17:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1Pe2-0002u6-1e
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 03:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755521AbbKYCRP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Nov 2015 21:17:15 -0500
Received: from mout.web.de ([212.227.15.14]:59091 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753828AbbKYCRN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 21:17:13 -0500
Received: from [192.168.178.36] ([79.253.150.73]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MY6lc-1ZoIdk2Ps8-00Uv7l; Wed, 25 Nov 2015 03:16:56
 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <20151124213601.GB29185@sigill.intra.peff.net>
X-Provags-ID: V03:K0:KM/KL6YbYTcAEOotnOXp9IMxN0u/s2sf+wC3+2RGxZGSkAQfVWz
 YbIvalIy+oNC5I2Yarl0VbV9subqzvKiznNXaz9AOiDjmopk/slsHdRyrlvM9EOvY9V+LD8
 PZJ/7+SIst/bEfFitSHau41ck1FAzYDomWmX9ddSw7BEEH1FC5rGjfW+SmnIYRlm129jRBs
 TXrx4BIpbAgbQlnQE/6OQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XK3yOH5vYaU=:hpBsGx0EzhZVmWw6ZFbiCI
 mA09WuzzcPAIQpr3aBhlnBW/uDpyHOtooCL9PmlvxEIn+1H9EVds97Q0uZVEnoureN7+EcgN5
 7O8SzrelVqNxK1r2ORvPVoOTmJOVIG7dlvfPLunvX9OakaZXtOUc58DwnfMPT0/liKkdKOhvT
 /k672OSfwsmGXV/NfsRjUJPo/CLxTG4eq2ZohOEeEYP3gJV1xGAwlx8gfRtNSof6HIOmWrBen
 K2XNWnLqvTYbQ5mVTDUy7TOeLANcTtfyQN+5YUwsfmQccjQAslXiHl5O6hWDqES1pbulIQ7pU
 qyU0ZUJYZ/3TS/3b/nm7WXcCC4ZJBsDJLvELmxjfYYZqzQ0+eaD8BJqSvt/p/8xFi82HjwAVj
 5k8g+3yEK2xhwGzJ5kvqI37HX1qcHzv5+bjbMv23UsH6/QNbPZ3SJtaAintS4+BlGx4BHu2HX
 e8HkkZOfJxzVR1ZdX4pcQYvJwSyoRaZPCjzTT0zp6FijND9GCWzwidM7hhgjC0AQD2+Dzn7rd
 HJcT6JQYHYXUnmnyjIb0aCymyvdYNQeJRvS/hONcf9I/HmBY8l+BsZzb7FJOy0XOc2Kgfk+UU
 z/o7OHiNMj+TRbzU1/A4rZGPr1AkdsAXG+62R2bluZJ7Hki+7hlVjZzokcSuaxmrGu13dxXoh
 zxuBhJFe0eZWx1hpZNQBsK44dbcNL2apCrrBVwTWBaYi+XlyUGU/hthe26nTvoVh/2qBb8Jh9
 kYnt2RjQJ5A1U+Wfg5KimI1qh8UKozQTL+X3iVW+e9xDfs6ajm2b1iUW+D1hm9hbkDwPwuko 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281675>

Am 24.11.2015 um 22:36 schrieb Jeff King:
> On Fri, Nov 06, 2015 at 11:47:03PM +0100, Ren=C3=A9 Scharfe wrote:
>=20
>> When a branch name is longer than four characters, memcmp() can read
>> past the end of the string literal "HEAD".  Use strncmp() instead, w=
hich
>> stops at the end of a string.  This fixes the following test failure=
s
>> with AddressSanitizer:
>=20
> Hmm. I think this is mostly harmless, as a comparison like:
>=20
>    memcmp("HEAD and more", "HEAD", strlen("HEAD"))
>=20
> would yield non-zero when we compare the NUL in the second string to
> whatever is in the first. So I assume what is going on is that memcmp=
 is
> doing larger compares than byte by byte, and is examining 4 or 8 byte=
s
> starting at that NUL.
>=20
> The outcome is equivalent, but we do touch memory that is not ours, s=
o I
> think this is a positive direction in that sense.

Yes, except it should be strlen("HEAD and more") in your example code;
with strlen("HEAD") it would compare just 4 bytes and return 0.

> But...
>=20
>> diff --git a/wt-status.c b/wt-status.c
>> index 435fc28..8dc281b 100644
>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -1319,7 +1319,7 @@ static int grab_1st_switch(unsigned char *osha=
1, unsigned char *nsha1,
>>   	hashcpy(cb->nsha1, nsha1);
>>   	for (end =3D target; *end && *end !=3D '\n'; end++)
>>   		;
>> -	if (!memcmp(target, "HEAD", end - target)) {
>> +	if (!strncmp(target, "HEAD", end - target)) {
>=20
> This will match prefixes like "HEA" in the target, won't it?

Oww, yes. :-/  NB: The existing code does the same.

> I think you want something more like:
>=20
>    if (end - target =3D=3D 4 && !memcmp(target, "HEAD", 4))
>=20
> I tried to think of a way that didn't involve a magic number. The bes=
t I
> came up with is:
>=20
>    if (skip_prefix(target, "HEAD", &v) && v =3D=3D end)
>=20
> but that requires an extra variable, and is arguably more obfuscated.

Using one more variable isn't that bad, as long as it gets a fitting
name.  Or we could reuse "end" (I'm not worrying about scanning "HEAD"
twice very much):

diff --git a/wt-status.c b/wt-status.c
index 435fc28..96a731e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1317,14 +1317,14 @@ static int grab_1st_switch(unsigned char *osha1=
, unsigned char *nsha1,
 	target +=3D strlen(" to ");
 	strbuf_reset(&cb->buf);
 	hashcpy(cb->nsha1, nsha1);
-	for (end =3D target; *end && *end !=3D '\n'; end++)
-		;
-	if (!memcmp(target, "HEAD", end - target)) {
+	if (skip_prefix(target, "HEAD", &end) && (!*end || *end =3D=3D '\n'))=
 {
 		/* HEAD is relative. Resolve it to the right reflog entry. */
 		strbuf_addstr(&cb->buf,
 			      find_unique_abbrev(nsha1, DEFAULT_ABBREV));
 		return 1;
 	}
+	for (end =3D target; *end && *end !=3D '\n'; end++)
+		;
 	strbuf_add(&cb->buf, target, end - target);
 	return 1;
 }
