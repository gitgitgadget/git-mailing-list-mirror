From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 04/19] fsck: Offer a function to demote fsck errors
 to warnings
Date: Mon, 22 Jun 2015 17:24:35 +0200
Organization: gmx
Message-ID: <d58343ff03fbc41b8d1346419ce2c389@www.dscho.org>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
 <44acafb2cf0a98e5ad75e3da24ba0e7453e6118f.1434720655.git.johannes.schindelin@gmx.de>
 <xmqqzj3v7b58.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 17:24:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z73aZ-00065o-Bv
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 17:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbbFVPYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 11:24:43 -0400
Received: from mout.gmx.net ([212.227.15.15]:58315 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753411AbbFVPYm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 11:24:42 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LaGJa-1YgD0t2Xc6-00m3rH; Mon, 22 Jun 2015 17:24:37
 +0200
In-Reply-To: <xmqqzj3v7b58.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:kOnj3PovRZSemya0UBybwDn9KBx+DBKhu3VT29m+8n7EoXRYcz5
 vetdAXEtwBtzGxk0OBr3qxknH10INPJAg+x8x7NI27RUziNX87UimfgAc0UUorYuz6oSaDY
 +rKMaeX2c4ub0ysWEQLa+qU369/1C0PVuPVy835GwzBL44W34js2yIqxULQtGhuUnqczR2b
 MCCS0+Zz8JWYOwGm6940Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:P+CVhRWAv5Q=:SUpwiRNVYR5uH5nOf8GSMH
 xVlCMglPKyXJxZUPjMYS1R5LkuCY+l6c7OZpvTLMqOjB7Q7n/nIn/mxSGAMncXKD4IzvhcAI2
 aHxfts/XhlN4HQbggkY90fBH5aSmF7rc5LhNXhq0O1WQ9r6uL5A+PnIejKSsEwSvWBG95NePG
 qOt/7kEI9Ay/nHdlTWwGbZryVlh0vuJ2o4WjAqwYY0R48BeqBe8ciJ4tAdljerRUBMbuBxYpu
 FOdbeeW98RRdwFTB4TdWgxCIrn7ftkRwVsAPoz1pE6ZkvYJ7885dUxCfjR09w3YccCVZm4u14
 EkriFpAWAlGFgGpbXi56E624vXLgfOieEaLZQ3S5JizlFji23T5UluPacDAOBlgArZFABzP00
 OgUMtVlN5dhuRFi378YIV9eJBiIFavfFA5RepyGLa3o0D98heQcxhmmuJe5HTaoO0tCAshn/I
 kfcC4jFMafR4lgWIMbbFLeEqfPg/gk/Od+OGPrQv34tMr6IsZ4XFghZC1mClBQ7CQBQGFyMuu
 ZsCh5bH+J/DqkhnYSB0fhzjzxHaq4Dx+bbfEuC9R2th2iYTkU3pDnb3ycJYJd8ksEoulnpmzG
 SaxLCypTaz63l7vuoQC8MMPmxfGU2fqXCU42uPq4P+54LYkk7nDSHgy7aVl4GEax7HJHFNip/
 Kcmtg0QEVN/GMq3GjFyu+7Kusv4EfDSjlMzWJc5vbySTk2yoNvJmh8VXzQhQO4rc3vXk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272370>

Hi Junio,

On 2015-06-19 21:26, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> +static inline int substrcmp(const char *string, int len, const char *match)
>> +{
>> +	int match_len = strlen(match);
>> +	if (match_len != len)
>> +		return -1;
>> +	return memcmp(string, match, len);
>> +}
> 
> What this does looks suspiciously like starts_with(), but its name
> "substrcmp()" does not give any hint that this is about the beginnig
> part of "string"; if anything, it gives a wrong hint that it may be
> any substring.  prefixcmp() might be a better name but that was the
> old name for !starts_with() so we cannot use it here.  It is a
> mouthful, but starts_with_counted() may be.
> 
> But the whole thing may be moot.
> 
> If we take the "why not upcase the end-user string upfront"
> suggestion from the previous review, fsck_set_msg_types() would have
> an upcased copy of the end-user string that it can muck with; it can
> turn "badfoo=error,poorbar=..." into "BADFOO=error,POORBAR=..."
> that is stored in its own writable memory (possibly a strbuf), and
> at that point it can afford to NUL-terminate BADFOO=error after
> finding where one specification ends with strcspn() before calling
> fsck_set_msg_type(), which in turn calls parse_msg_type().
> 
> So all parse_msg_type() needs to do is just !strcmp().

Turns out that the diffstat says it saves 10 lines. So I changed it according to your suggestion. Part of v7.

Ciao,
Dscho
