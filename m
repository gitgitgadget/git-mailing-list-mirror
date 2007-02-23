From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH] Add git-bundle: move objects and references by archive
Date: Thu, 22 Feb 2007 21:32:57 -0500
Message-ID: <45DE5259.6090502@verizon.net>
References: <Pine.LNX.4.63.0702220157130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xeqllxk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 23 03:33:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKQFF-0002aj-AD
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 03:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbXBWCdK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 21:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbXBWCdJ
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 21:33:09 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:58674 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbXBWCdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 21:33:09 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDW00BLS9QTNN09@vms044.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 22 Feb 2007 20:32:55 -0600 (CST)
In-reply-to: <7v8xeqllxk.fsf@assigned-by-dhcp.cox.net>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40410>

Junio C Hamano wrote:
>> diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
>> index a2d6268..f61c77a 100755
>> --- a/Documentation/cmd-list.perl
>> +++ b/Documentation/cmd-list.perl
>> @@ -70,6 +70,7 @@ git-archive                             mainporcelain
>>  git-bisect                              mainporcelain
>>  git-blame                               ancillaryinterrogators
>>  git-branch                              mainporcelain
>> +git-bundle                              mainporcelain
>>  git-cat-file                            plumbinginterrogators
>>  git-checkout-index                      plumbingmanipulators
>>  git-checkout                            mainporcelain
>>     
>
> Is this really a mainporcelain?
> I would say ancillarymanipulators (or perhaps synchelpers).
>
>   
git bundle has four commands: create, verify, list-heads, and unbundle. 
The last two are pure helper functions, basically plumbing. Verify is 
questionable as to where it lies. But, create is the only way to create 
a bundle, is logically equivalent to git push as a user command to move 
data,  so I called it mainporcelain because that is how git push is 
classified.


>> +	/* write prerequisites */
>> +	memcpy(argv_boundary + 2, argv + 1, argc * sizeof(const char *));
>> +	argv_boundary[0] = "rev-list";
>> +	argv_boundary[1] = "--boundary";
>> +	argv_boundary[argc + 1] = NULL;
>> +	out = -1;
>> +	pid = fork_with_pipe(argv_boundary, NULL, &out);
>> +	if (pid < 0)
>> +		return -1;
>> +	while ((i = read_string(out, buffer, sizeof(buffer))) > 0)
>> +		if (buffer[0] == '-')
>> +			write(bundle_fd, buffer, i);
>>     
>
> It would be helpful for the recipient if you can append output
> from git-describe (or name-rev) when the buffer lacks "name".
>   
I found the actual commit summary message (i.e., git-rev-list 
--pretty=one --max-count=1 sha1) the most useful of the various 
summaries available.



Mark
