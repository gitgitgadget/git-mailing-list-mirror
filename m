X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-fetching from a big repository is slow
Date: Thu, 14 Dec 2006 16:06:05 +0100
Message-ID: <4581685D.1070407@op5.se>
References: <200612141340.43925.andyparkins@gmail.com> <4581573E.40803@op5.se> <Pine.LNX.4.63.0612141513130.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 15:06:39 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <Pine.LNX.4.63.0612141513130.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34344>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GusAL-0001iZ-G0 for gcvg-git@gmane.org; Thu, 14 Dec
 2006 16:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932786AbWLNPGI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 10:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932785AbWLNPGI
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 10:06:08 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:35118 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S932774AbWLNPGH (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 10:06:07 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 6EC006BCBC; Thu, 14 Dec 2006 16:06:05 +0100 (CET)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 14 Dec 2006, Andreas Ericsson wrote:
> 
>> Andy Parkins wrote:
>>> Hello,
>>>
>>> I've got a big repository.  I've got two computers.  One has the repository
>>> up-to-date (164M after repack); one is behind (30M ish).
>>>
>>> I used git-fetch to try and update; and the sync took HOURS.  I zipped the
>>> .git directory and transferred that and it took about 15 minutes to
>>> transfer.
>>>
>>> Am I doing something wrong?  The git-fetch was done with a git+ssh:// URL.
>>> The zip transfer with scp (so ssh shouldn't be a factor).
>>>
>> This seems to happen if your repository consists of many large binary files,
>> especially many large binary files of several versions that do not deltify
>> well against each other. Perhaps it's worth adding gzip compression detecion
>> to git? I imagine more people than me are tracking gzipped/bzip2'ed content
>> that pretty much never deltifies well against anything else.
> 
> Or we add something like the heuristics we discovered in another thread, 
> where rename detection (which is related to delta candidate searching) is 
> not started if the sizes differ drastically.
> 

It wouldn't work for this particular case though. In our distribution 
repository we have ~300 bzip2 compressed tarballs with an average size 
of 3MiB. 240 of those are between 2.5 and 4 MiB, so they don't 
drastically differ, but neither do they delta well.

One option would be to add some sort of config option to skip attempting 
deltas of files with a certain suffix. That way we could just tell it to 
ignore *.gz,*.tgz,*.bz2 and everything would work just as it does today, 
but a lot faster.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
