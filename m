From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] wt-status: use strncmp() for length-limited string comparison
Date: Wed, 25 Nov 2015 11:29:39 +0100
Message-ID: <vpqtwoawewc.fsf@anie.imag.fr>
References: <563D2DE7.1030005@web.de>
	<20151124213601.GB29185@sigill.intra.peff.net>
	<56551A11.9030809@web.de>
	<20151125091503.GA1779@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 25 11:30:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1XL0-0006sB-Bo
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 11:30:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbbKYKaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 05:30:06 -0500
Received: from mx1.imag.fr ([129.88.30.5]:36730 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796AbbKYKaF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 05:30:05 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id tAPATc2h006638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 25 Nov 2015 11:29:38 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id tAPATd7i025326;
	Wed, 25 Nov 2015 11:29:39 +0100
In-Reply-To: <20151125091503.GA1779@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 25 Nov 2015 04:15:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 25 Nov 2015 11:29:39 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: tAPATc2h006638
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1449052183.90227@ng39YTf04OFWEBzopxyppQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281698>

Jeff King <peff@peff.net> writes:

>> diff --git a/wt-status.c b/wt-status.c
>> index 435fc28..96a731e 100644
>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -1317,14 +1317,14 @@ static int grab_1st_switch(unsigned char *osha1, unsigned char *nsha1,
>>  	target += strlen(" to ");
>>  	strbuf_reset(&cb->buf);
>>  	hashcpy(cb->nsha1, nsha1);
>> -	for (end = target; *end && *end != '\n'; end++)
>> -		;
>> -	if (!memcmp(target, "HEAD", end - target)) {
>> +	if (skip_prefix(target, "HEAD", &end) && (!*end || *end == '\n')) {
>>  		/* HEAD is relative. Resolve it to the right reflog entry. */
>>  		strbuf_addstr(&cb->buf,
>>  			      find_unique_abbrev(nsha1, DEFAULT_ABBREV));
>>  		return 1;
>>  	}
>
> Yeah, I think parsing left-to-right like this makes things much more
> obvious.

Agreed.

>> +	for (end = target; *end && *end != '\n'; end++)
>> +		;
>
> This loop (which I know you just moved, not wrote) is basically
> strchrnul, isn't it? That might be more readable.

Agreed too.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
