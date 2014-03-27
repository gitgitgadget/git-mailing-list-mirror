From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v8 03/12] Move lower case functions into wrapper.c
Date: Thu, 27 Mar 2014 08:47:45 +0100 (CET)
Message-ID: <20140327.084745.2069840957131666658.chriscool@tuxfamily.org>
References: <20140326215858.11352.89243.chriscool@tuxfamily.org>
	<20140326221531.11352.86408.chriscool@tuxfamily.org>
	<xmqqppl8ftjd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, johan@herland.net, josh@joshtriplett.org,
	tr@thomasrast.ch, mhagger@alum.mit.edu, dan.carpenter@oracle.com,
	greg@kroah.com, peff@peff.net, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 27 08:48:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WT52s-0006TH-2j
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 08:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308AbaC0HsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 03:48:09 -0400
Received: from [194.158.98.14] ([194.158.98.14]:49743 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751595AbaC0HsI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 03:48:08 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id F34EB5C;
	Thu, 27 Mar 2014 08:47:45 +0100 (CET)
In-Reply-To: <xmqqppl8ftjd.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245261>

From: Junio C Hamano <gitster@pobox.com>
>
> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>> diff --git a/wrapper.c b/wrapper.c
>> index 0cc5636..c46026a 100644
>> --- a/wrapper.c
>> +++ b/wrapper.c
>> @@ -455,3 +455,17 @@ struct passwd *xgetpwuid_self(void)
>>  		    errno ? strerror(errno) : _("no such user"));
>>  	return pw;
>>  }
>> +
>> +void lowercase(char *p)
>> +{
>> +	for (; *p; p++)
>> +		*p = tolower(*p);
>> +}
>> +
>> +char *xstrdup_tolower(const char *str)
>> +{
>> +	char *dup = xstrdup(str);
>> +	lowercase(dup);
>> +	return dup;
>> +}
>> +
> 
> As a pure code-movement step, this may be OK, but I am not sure if
> both of them want to be public functions in this shape.
> 
> Perhaps
> 
> char *downcase_copy(const char *str)
> {
> 	char *copy = xmalloc(strlen(str) + 1);
>         int i;
>         for (i = 0; str[i]; i++)
>         	copy[i] = tolower(str[i]);
> 	copy[i] = '\0';
>         return copy;
> }
> 
> may avoid having to copy things twice.

Yeah, but it seems a bit wasteful to allocate memory for a new string,
then downcase it, then compare it with strcmp() and then free it,
instead of just using strcasecmp() on the original string.

> Do you need the other
> function exposed?

No, with the change you suggest, I don't.

Thanks,
Christian.
