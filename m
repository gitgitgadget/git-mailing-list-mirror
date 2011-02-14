From: Rafael Kitover <rkitover@io.com>
Subject: Re: [PATCH] fixes for ActiveState Perl
Date: Mon, 14 Feb 2011 14:39:09 -0500
Organization: CPAN
Message-ID: <4D5984DD.1030004@io.com>
References: <4D5914C1.9050008@io.com> <AANLkTimCXEbzZnR1k32u942hjB37nThN_RDBL5N7owHa@mail.gmail.com>
Reply-To: rkitover@io.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 14 20:39:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp4Gh-0000ih-So
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 20:39:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153Ab1BNTj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 14:39:27 -0500
Received: from smtp.prismnet.com ([209.198.128.91]:65520 "EHLO
	smtp.prismnet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934Ab1BNTj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 14:39:26 -0500
Received: from [127.0.0.1] (c-76-98-235-160.hsd1.pa.comcast.net [76.98.235.160])
	(authenticated bits=0)
	by smtp.prismnet.com (8.14.4/8.14.4) with ESMTP id p1EJdO2J039178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Mon, 14 Feb 2011 13:39:24 -0600 (CST)
	(envelope-from rkitover@io.com)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <AANLkTimCXEbzZnR1k32u942hjB37nThN_RDBL5N7owHa@mail.gmail.com>
X-Spam-Status: No, score=0.0 required=10.0 tests=RDNS_DYNAMIC
	autolearn=disabled version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on smtp.prismnet.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166752>

On 2/14/2011 7:49 AM, Erik Faye-Lund wrote:
...
>> diff --git a/perl/Makefile b/perl/Makefile
>> index a2ffb64..1fa99cd 100644
>> --- a/perl/Makefile
>> +++ b/perl/Makefile
>> @@ -3,18 +3,28 @@
>>  #
>>  makfile:=perl.mak
>>
>> +# support PERL_PATH=C:\\Perl\\bin\\perl
>> +PERL_PATH := $(subst \,\\,$(PERL_PATH))
>> +
>>  PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
>> +PERL_MAKE := MAKEFLAGS="" $(subst \,\\,$(shell $(subst \,\\,$(PERL_PATH)) -MConfig -le "print ((\%Config)->{make})"))
>> +
>> +ifneq (,$(findstring nmake,$(PERL_MAKE)))
>> +       PERL_MAKE := $(PERL_MAKE) -nologo
>> +endif
>> +
>>  prefix_SQ = $(subst ','\'',$(prefix))
>>
>>  ifndef V
>>        QUIET = @
>>  endif
>>
>> +
> 
> Why?

Windows perl (activestate, strawberry) uses nmake or dmake. The
makefiles for these makes are incompatible with GNU make. This code
retrieves the make Perl would use from its Config, and uses that on
invoking perl.mak .

This should also allow for using EU::MM for the MSVC+ActiveState build.
