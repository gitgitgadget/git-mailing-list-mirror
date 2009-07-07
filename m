From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: hooks/post-receive-email bug?
Date: Tue, 07 Jul 2009 15:33:19 +0200
Message-ID: <4A534E9F.3010303@drmicha.warpmail.net>
References: <4A396C6E.2050600@xiplink.com> <4A520EFA.10309@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 15:33:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOAnq-00028Y-GE
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 15:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755416AbZGGNdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 09:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547AbZGGNdj
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 09:33:39 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:57090 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755203AbZGGNdi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jul 2009 09:33:38 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 92BB13AF691;
	Tue,  7 Jul 2009 09:33:37 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 07 Jul 2009 09:33:40 -0400
X-Sasl-enc: N9CQxd6tPduv5mjgqLW77uHnOh9JnA1oxH30aM9HrWnB 1246973617
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id ECD97287E5;
	Tue,  7 Jul 2009 09:33:36 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.1pre) Gecko/20090707 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <4A520EFA.10309@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122845>

Marc Branchaud venit, vidit, dixit 06.07.2009 16:49:
> Ping?
> 

Pong!

Why not read the hook script yourself... but see below.

> 		M.
> 
> 
> Marc Branchaud wrote:
>> Hi all,
>>
>> We currently have two main development branches: master and release. 
>> These branches exist on our shared git server.  I had to make a change
>> in both branches, so I made a topic branch off of their merge-base and
>> did the work:
>>
>>  o--o--A--B--C        <-- origin/master
>>     |\
>>     | X--Y        <-- origin/release
>>      \
>>       1--2--3        <-- topic
>>
>> I then merged topic into both master and release.  The merges were clean:
>>
>>  o--o--A--B--C---D    <-- master
>>     |\           |
>>     | X--Y----Z /    <-- release
>>      \       / /
>>       1--2--3--    <-- topic
>>
>> Then I did
>>     git push origin
>> to push matching refspecs to the origin repo.
>>
>> port-receive-email sent two messages for that push, one for each
>> branch.  Each message showed that commits 1, 2 and 3 were applied to the
>> appropriate branch:
>>
>>     The branch, release has been updated
>>            via  hash for Z (commit)
>>            via  hash for 3 (commit)
>>            via  hash for 2 (commit)
>>            via  hash for 1 (commit)
>>           from  hash for Y (commit)
>>
>> However, the details of the topic commits were missing from both
>> messages.  Instead, both only contained the details of the merge commits
>> D and Z.
>>
>> I was expecting at least one of the messages to have the details of
>> commits 1, 2 and 3.  Was I wrong to expect that?
>>
>> Thanks,
>>
>>         M.

I assume that by "pushing matching heads" you mean you did not create a
topic branch on origin?

The hook tries cleverly to avoid sending multiple commit mails for the
same commit. The heuristics is not completely failsafe. It seems the
hook thinks these commits have been dealt with already, which usually
happens when they can be reached by other refs than the one being updated.

Michael
