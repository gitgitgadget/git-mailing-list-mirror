From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git grep -O -i: if the pager is 'less', pass the '-i' option
Date: Wed, 14 May 2014 20:15:19 +0200
Message-ID: <vpqha4sfcqw.fsf@anie.imag.fr>
References: <20140514155010.GA4592@camelia.ucw.cz>
	<xmqq7g5okztp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stepan Kasal <kasal@ucw.cz>,
	GIT Mailing-list <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 14 20:15:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkdiO-00023r-88
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 20:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbaENSPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 14:15:36 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60194 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741AbaENSPg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 14:15:36 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s4EIFGoc012206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 14 May 2014 20:15:16 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s4EIFJJk010133;
	Wed, 14 May 2014 20:15:19 +0200
In-Reply-To: <xmqq7g5okztp.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 14 May 2014 10:57:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 14 May 2014 20:15:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s4EIFGoc012206
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1400696121.55756@iN8EvCeXeYScMyz9Zx5/Nw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248931>

Junio C Hamano <gitster@pobox.com> writes:

> Stepan Kasal <kasal@ucw.cz> writes:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Date: Tue, 8 Feb 2011 00:17:24 -0600
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
>> ---
>> Hi,
>> this patch has been in msysgit for 3 1/4 years.
>>   Stepan
>>
>>  builtin/grep.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/builtin/grep.c b/builtin/grep.c
>> index 8073fbe..6c82a29 100644
>> --- a/builtin/grep.c
>> +++ b/builtin/grep.c
>> @@ -897,6 +897,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>>  		if (len > 4 && is_dir_sep(pager[len - 5]))
>>  			pager += len - 4;
>>  
>> +		if (opt.ignore_case && !strcmp("less", pager))
>> +			string_list_append(&path_list, "-i");
>
> I have a feeling that this goes against the recent trend of not
> mucking with the expectation of the users on their pagers, if I
> recall correctly the arguments for dropping S from the default given
> to an unconfigured LESS environment variable.

I had the same feeling about "we're doing magic in corner-cases, makes
it hard for the user to understand what's going on". But the patch
actually makes a lot of sense. Without the patch, I get

  $ git grep -O -i no_openssl
  Pattern not found  (press RETURN)

with the patch, I do get a file opened and NO_OPENSSL selected.

The lines right below the ones of the patch are aleady (documented)
less+vi magic, which actually require the patch to behave well in the
presence of -i.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
