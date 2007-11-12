From: Andreas Ericsson <ae@op5.se>
Subject: Re: git diff woes
Date: Mon, 12 Nov 2007 12:19:08 +0100
Message-ID: <473836AC.6090802@op5.se>
References: <4738208D.1080003@op5.se> <Pine.LNX.4.64.0711120958500.4362@racer.site> <47382C84.50408@op5.se> <Pine.LNX.4.64.0711121047590.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 12:19:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrXKB-0001F6-Kf
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 12:19:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757068AbXKLLTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 06:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757374AbXKLLTM
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 06:19:12 -0500
Received: from mail.op5.se ([193.201.96.20]:53528 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757068AbXKLLTL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 06:19:11 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 262C21F0875A;
	Mon, 12 Nov 2007 12:19:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ExXKnnZh3Gid; Mon, 12 Nov 2007 12:19:09 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 1E6DE1F08751;
	Mon, 12 Nov 2007 12:19:09 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <Pine.LNX.4.64.0711121047590.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64602>

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 12 Nov 2007, Andreas Ericsson wrote:
> 
>> Johannes Schindelin wrote:
>>
>>>  And sure you can trust the hunk header.  Like most of the things, the 
>>> relate to the _original_ version, since the diff is meant to be 
>>> applied as a forward patch.
>>>
>>> So for all practical matters, the diff shows the correct thing: "in 
>>> this hunk, which (still) belongs to that function, change this and 
>>> this."
>>>
>>> Of course, that is only the case if you accept that the diff should be 
>>> applied _in total_, not piecewise.  IOW if you are a fan of GNU patch 
>>> which happily clobbers your file until it fails with the last hunk, 
>>> you will not be happy.
>>>
>> You're right. GNU patch will apply one hunk and then happily churn on 
>> even if it fails. git-apply will apply all hunks or none, so all hunks 
>> can assume that all previous hunks were successfully applied. So what 
>> was your point again?
> 
> My point was that this diff is not to be read as if the previous hunks had 
> been applied.  Just look at the context: it is also the original file.
> 

The context is ambiguous, as it must be present in both the new and the
old file for it to actually *be* context. Otherwise it would be part of
the +- diff text.

> It seems I am singularly unable to explain plain concepts as this: a diff 
> assumes that the file is yet unchanged.
> 

Sure, but the useraid with writing the apparent function declaration in
the hunk header *will* be confusing if the function declaration changes
in the same patch as other things in the function.

> So I'll stop.
> 

Give me something valuable instead, such as your opinion on whether it
would be better to not print the function declaration at all if it will
be changed by applying the same patch, or if one should pick one of the
declarations from old or new and, if so, which one to pick.

I simply refuse to believe that you wouldn't immediately think the hunk
below holds an obvious bug. I thought so because of the helpful function
context git diff prints (which is a helper for human reviewers, and not
something git-apply or GNU patch needs to work), and now I want to do
something about it so others won't have to suffer the same confusion.

@@ -583,75 +346,100 @@ double jitter_request(const char *host, int *status){
       if(verbose) printf("%d candiate peers available\n", num_candidates);
       if(verbose && syncsource_found) printf("synchronization source found\n")
       if(! syncsource_found){
-               *status = STATE_UNKNOWN;
+               status = STATE_WARNING;
               if(verbose) printf("warning: no synchronization source found\n")
       }

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
