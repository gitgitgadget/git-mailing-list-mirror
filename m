From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v2 7/9] sparse: Fix errors due to missing target-specific
 variables
Date: Thu, 21 Apr 2011 20:06:52 +0100
Message-ID: <4DB0804C.10908@ramsay1.demon.co.uk>
References: <4DADC729.5060705@ramsay1.demon.co.uk> <7vbp025clq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, bebarino@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 21:31:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCzbG-000364-U0
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 21:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542Ab1DUTbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 15:31:33 -0400
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:64897 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752223Ab1DUTbd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2011 15:31:33 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1QCzb9-00050T-hv; Thu, 21 Apr 2011 19:31:32 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7vbp025clq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171913>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> I decided not to mark the $(SP_OBJ) as .PHONY targets; after some
>> testing, it seems that it is not necessary, even if users do
>> something like:
>>     make git.sp 2>git.sp
[...]
>> -help.o: common-cmds.h
>> +help.sp help.o: common-cmds.h
> 
> I am not sure if you even want any dependency listed for any %.sp target
> to begin with. 

without these common-cmds.h dependencies, I get something like:

    $ make clean
        ...
    $ make help.sp
    GIT_VERSION = 1.7.5.rc2.10.g4d94
        * new build flags or prefix
        SP help.c
    help.c:6:10: error: unable to open 'common-cmds.h'
    make: *** [help.sp] Error 1

whereas, with them:

    $ make clean
        ...
    $ make help.sp
    GIT_VERSION = 1.7.5.rc2.10.g937d2
        * new build flags or prefix
        GEN common-cmds.h
        SP help.c

[...]
> So why list any dependency?  If it is sensible to treat "sparse" target
> just like "clean" target, it would make sense not to give it any
> dependencies and mark it as .PHONY, no?

After some experiments, looking through the output of "make -d ...", I think
I have a solution which (hopefully) addresses your concerns ...

Version 3 of the patch coming up ...

ATB,
Ramsay Jones
