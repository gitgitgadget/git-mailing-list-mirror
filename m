From: Ivan Todoroski <grnch_lists@gmx.net>
Subject: Re: Clone fails on a repo with too many heads/tags
Date: Sun, 25 Mar 2012 19:54:19 +0200
Message-ID: <4F6F5BCB.9050406@gmx.net>
References: <20120318190659.GA24829@sigill.intra.peff.net> <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com> <20120319024436.GB10426@sigill.intra.peff.net> <4F69B5F0.2060605@gmx.net> <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com> <20120321171423.GA13140@sigill.intra.peff.net> <4F6A33C5.2080909@gmx.net> <20120321201722.GA15021@sigill.intra.peff.net> <4F6E3373.7090500@gmx.net> <20120325010609.GB27651@sigill.intra.peff.net> <20120325023215.GA13958@sigill.intra.peff.net> <4F6F56D5.3000309@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 25 19:54:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBrdi-0001zm-Be
	for gcvg-git-2@plane.gmane.org; Sun, 25 Mar 2012 19:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756692Ab2CYRx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Mar 2012 13:53:57 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:38318 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756601Ab2CYRx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2012 13:53:57 -0400
Received: (qmail invoked by alias); 25 Mar 2012 17:53:55 -0000
Received: from unknown (EHLO [127.0.0.1]) [77.28.173.43]
  by mail.gmx.net (mp027) with SMTP; 25 Mar 2012 19:53:55 +0200
X-Authenticated: #14478976
X-Provags-ID: V01U2FsdGVkX19+4st8bnF+3hwL1OK9fRW3UMlimVS6TDAqsydoZf
	4ewgWvJIfgC/iS
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <4F6F56D5.3000309@gmx.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193878>

On 25.03.2012 19:33, Ivan Todoroski wrote:
> On 25.03.2012 04:32, Jeff King wrote:
>> On Sat, Mar 24, 2012 at 09:06:09PM -0400, Jeff King wrote:
>>
>>> That's weird. 405 is "Method Not Allowed". Clone shouldn't be doing
>>> anything more exotic than GET and POST. And the prior tests pass, so it
>>> means that it's working in general. The only thing different about this
>>> test is that apache is configured to use mod_rewrite to issue a
>>> redirect.
>>>
>>> Does your machine have mod_rewrite installed and enabled? I would think
>>> apache would complain at startup if it wasn't.  I wonder if there's
>>> something non-portable in the minimal apache config we ship.
>>>
>>> Does httpd/error.log in the trash directory say anything interesting?
>>
>> Also, does it work any better with this patch?
>>
>> diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
>> index 3c12b05..714760d 100644
>> --- a/t/lib-httpd/apache.conf
>> +++ b/t/lib-httpd/apache.conf
>> @@ -61,9 +61,8 @@ ScriptAlias /smart_noexport/ 
>> ${GIT_EXEC_PATH}/git-http-backend/
>>      Options ExecCGI
>>  </Files>
>>  
>> -RewriteEngine on
>> -RewriteRule ^/smart-redir-perm/(.*)$ /smart/$1 [R=301]
>> -RewriteRule ^/smart-redir-temp/(.*)$ /smart/$1 [R=302]
>> +RedirectMatch 301 ^/smart-redir-perm/(.*)$ /smart/$1
>> +RedirectMatch 302 ^/smart-redir-temp/(.*)$ /smart/$1
>>  
>>  <IfDefine SSL>
>>  LoadModule ssl_module modules/mod_ssl.so
> 
> 
> Yes! That patch did it, t5551-http-fetch.sh now passes fully. Thank you.

Ah, no... I spoke too soon.

I didn't look closely enough, I wasn't logged in at the right machine, 
sorry. :)

It's still failing on CentOS 5.8 with Apache 2.2.3. I will just find 
another machine where the test suite works.

If you'd still like to debug the problem on CentOS 5.8 I can run any 
commands or test any patches for you.
