From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH v3 09/10] abspath: convert absolute_path() to strbuf
Date: Tue, 29 Jul 2014 00:34:41 +0200
Message-ID: <53D6D001.8050304@web.de>
References: <53D694A2.8030007@web.de> <53D69793.3010307@web.de> <20140728191500.GD11265@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 29 00:35:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBtVR-0006yw-6t
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 00:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbaG1Wex convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2014 18:34:53 -0400
Received: from mout.web.de ([212.227.15.3]:55372 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425AbaG1Wew (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 18:34:52 -0400
Received: from [192.168.178.27] ([79.253.140.83]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0M7blv-1WF6kn0Xgd-00xNMn; Tue, 29 Jul 2014 00:34:42
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <20140728191500.GD11265@peff.net>
X-Provags-ID: V03:K0:5IKYQDhOQ/8NLS7bsiayuDk0VAGuatFEOkOE6HyKnzVOPrHE4Zq
 PJbA3yZZ5YE/m6yO3FqfY8Pmxy9AeV+ZTUwcNrzCDJeBxyhNXBYb0OnTUSDvKXITpPPnW6Y
 38oFQmHYe8vHABZqnCap5Z+2MRISCwasL52BmkXSvqFhsYoM3Z3uGTqTwZNCm5xgQIKkR1i
 z8jexwoAKAaYrSisUGNeA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254360>

Am 28.07.2014 um 21:15 schrieb Jeff King:
> On Mon, Jul 28, 2014 at 08:33:55PM +0200, Ren=C3=A9 Scharfe wrote:
>
>>   const char *absolute_path(const char *path)
>>   {
>> -	static char buf[PATH_MAX + 1];
>> -
>> -	if (!*path) {
>> -		die("The empty string is not a valid path");
>> -	} else if (is_absolute_path(path)) {
>> -		if (strlcpy(buf, path, PATH_MAX) >=3D PATH_MAX)
>> -			die("Too long path: %.*s", 60, path);
>> -	} else {
>> -		size_t len;
>> -		const char *fmt;
>> -		const char *cwd =3D get_pwd_cwd();
>> -		if (!cwd)
>> -			die_errno("Cannot determine the current working directory");
>> -		len =3D strlen(cwd);
>> -		fmt =3D (len > 0 && is_dir_sep(cwd[len - 1])) ? "%s%s" : "%s/%s";
>> -		if (snprintf(buf, PATH_MAX, fmt, cwd, path) >=3D PATH_MAX)
>> -			die("Too long path: %.*s", 60, path);
>> -	}
>> -	return buf;
>> +	static struct strbuf sb;
>> +	strbuf_init(&sb, 0);
>> +	strbuf_add_absolute_path(&sb, path);
>> +	return sb.buf;
>>   }
>
> Is it right to strbuf_init here? That means that we are throwing away
> the old buffer for each call. I would think you want instead:
>
>    static struct strbuf sb =3D STRBUF_INIT;
>    strbuf_reset(&sb);
>    ...

I changed it from _reset to _init, but I can't remember why. :(  Perhap=
s=20
it's the summer heat.  Your version makes more sense to me now.

Ren=C3=A9
