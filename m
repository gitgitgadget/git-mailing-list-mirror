X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: Fast access git-rev-list output: some OS knowledge required
Date: Thu, 07 Dec 2006 16:28:12 +0100
Message-ID: <4578330C.9070208@op5.se>
References: <e5bfff550612061124jcd0d94em47793710866776e7@mail.gmail.com> <20061206192800.GC20320@spearce.org> <e5bfff550612061134r3725dcbu2ff2dd6284fcd651@mail.gmail.com> <20061206194258.GD20320@spearce.org> <20061206195142.GE20320@spearce.org> <45781639.1050208@op5.se> <Pine.LNX.4.63.0612071553090.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 15:28:28 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>,
	Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <Pine.LNX.4.63.0612071553090.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33592>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsLAX-0007ME-Eo for gcvg-git@gmane.org; Thu, 07 Dec
 2006 16:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937985AbWLGP2O (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 10:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937986AbWLGP2O
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 10:28:14 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:60598 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S937985AbWLGP2N (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 10:28:13 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 6B92B6BCCC; Thu,  7 Dec 2006 16:28:12 +0100 (CET)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 7 Dec 2006, Andreas Ericsson wrote:
> 
>> Shawn Pearce wrote:
>>> Perhaps there is some fast IPC API supported by Qt that you could use 
>>> to run the revision listing outside of the main UI process, to 
>>> eliminate the bottlenecks you are seeing and remove the problems noted 
>>> above?  One that doesn't involve reading from a pipe I mean...
>>>
>> Why not just fork() + exec() and read from the filedescriptor? You can 
>> up the output buffer of the forked program to something suitable, which 
>> means the OS will cache it for you until you copy it to a buffer in qgit 
>> (i.e., read from the descriptor).
> 
> Could somebody remind me why different processes are needed? I thought 
> that the revision machinery should be used directly, by linking to 
> libgit.a...
> 

You wrote:
--%<--%<--%<--
Because, depending on what you do, the revision machinery is not
reentrable. For example, if you filter by filename, the history is
rewritten in-memory to simulate a history where just that filename was
tracked, and nothing else. These changes are not cleaned up after 
calling the internal revision machinery.
--%<--%<--%<--

When I wrote the above suggestion, I hadn't read the posts following the 
email where I cut this text from (where Linus said "we can add a 'reset' 
thingie to the revision walking machinery" and Marco replied with some 
more questions).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
