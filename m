From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Do not use SHELL_PATH from build system in prepare_shell_cmd
 on Windows
Date: Wed, 18 Apr 2012 07:39:43 +0200
Message-ID: <4F8E539F.7030902@viscovery.net>
References: <7vvclmoit6.fsf@alter.siamese.dyndns.org> <1333157601-6458-1-git-send-email-bwalton@artsci.utoronto.ca> <4F8D15B9.70803@viscovery.net> <20120417221449.GC10797@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, jrnieder@gmail.com,
	gitster@pobox.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 07:40:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKNcZ-0000N7-8Z
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 07:40:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272Ab2DRFj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 01:39:56 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:50876 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750769Ab2DRFj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 01:39:56 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SKNcG-0000LN-Q6; Wed, 18 Apr 2012 07:39:44 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 69BB51660F;
	Wed, 18 Apr 2012 07:39:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <20120417221449.GC10797@sigill.intra.peff.net>
X-Enigmail-Version: 1.4
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195838>

Am 4/18/2012 0:14, schrieb Jeff King:
> On Tue, Apr 17, 2012 at 09:03:21AM +0200, Johannes Sixt wrote:
> 
>> diff --git a/run-command.c b/run-command.c
>> index 2af3e0f..e4edede 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -94,7 +94,11 @@ static const char **prepare_shell_cmd(const char **argv)
>>  		die("BUG: shell command is empty");
>>  
>>  	if (strcspn(argv[0], "|&;<>()$`\\\"' \t\n*?[#~=%") != strlen(argv[0])) {
>> +#ifndef WIN32
>>  		nargv[nargc++] = SHELL_PATH;
>> +#else
>> +		nargv[nargc++] = "sh";
>> +#endif
>>  		nargv[nargc++] = "-c";
>>  
>>  		if (argc < 2)
> 
> It sounds like the real problem is not the use of a configurable shell,
> but rather the use of an absolute path. Should you maybe try to pass the
> basename of SHELL_PATH? Or maybe that is not even worth worrying about,
> as somebody on Windows is not going to ever set SHELL_PATH, since it is
> not like they are working around a non-POSIX "sh" included with the
> operating system (which is why people on Solaris typically set
> SHELL_PATH).

I thought about offering a customization point, but decided that it is not
worth the hassle: Most people download an installer, then the installer
can set up the PATH so that "sh" is not broken or something entirely
unrelated. And those who build git themselves know sufficiently well what
they are doing.

-- Hannes
