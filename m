From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 2/6] path: Make the 'get_st_mode_bits' symbol a file static
Date: Mon, 29 Apr 2013 22:57:40 +0100
Message-ID: <517EECD4.800@ramsay1.demon.co.uk>
References: <517C1BF9.2050604@ramsay1.demon.co.uk> <517CBB6E.205@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Apr 30 01:33:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWxZI-0000Ck-0x
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 01:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568Ab3D2XdH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Apr 2013 19:33:07 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:51159 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932554Ab3D2XdE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 19:33:04 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 51CBC384083;
	Tue, 30 Apr 2013 00:33:03 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 86D7F384081;
	Tue, 30 Apr 2013 00:33:02 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Tue, 30 Apr 2013 00:33:01 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <517CBB6E.205@web.de>
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222882>

Torsten B=F6gershausen wrote:
> On 2013-04-27 20.42, Ramsay Jones wrote:
>>
>> On MinGW, sparse issues an "'get_st_mode_bits' not declared. Should
>> it be static?" warning. The MinGW and MSVC builds do not see the
>> declaration of this function, within git-compat-util.h, due to it's
>> placement within an preprocessor conditional. (So, one solution woul=
d
>> be to simply move the declaration to the top level of the header.)
>>
>> In order to suppress the warning, since this symbol does not need
>> more than file visibility, we simply remove the declaration from
>> the header and add the static modifier to the function definition.
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>> ---
>>  git-compat-util.h | 1 -
>>  path.c            | 2 +-
>>  2 files changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index e955bb5..3a990b3 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -163,7 +163,6 @@
>>  typedef long intptr_t;
>>  typedef unsigned long uintptr_t;
>>  #endif
>> -int get_st_mode_bits(const char *path, int *mode);
>>  #if defined(__CYGWIN__)
>>  #undef _XOPEN_SOURCE
>>  #include <grp.h>
>> diff --git a/path.c b/path.c
>> index 04ff148..cc2e9ac 100644
>> --- a/path.c
>> +++ b/path.c
>> @@ -11,7 +11,7 @@
>>   * may return wrong permission bits. Most of the time we do not car=
e,
>>   * but the callsites of this wrapper do care.
>>   */
>> -int get_st_mode_bits(const char *path, int *mode)
>> +static int get_st_mode_bits(const char *path, int *mode)
>>  {
>>  	struct stat st;
>>  	if (lstat(path, &st) < 0)
>>
> Sorry for breaking the MiNGW/MSVC builds.
> It seams that the get_st_mode_bits is badly placed.

You didn't break the build; simply provoked a warning.

As I said in the commit message, an alternative is to
simply move the declaration to the top level of the
header (out of the preprocessor conditional).

ATB,
Ramsay Jones
