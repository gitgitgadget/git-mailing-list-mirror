From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] Make local branches behave like remote branches when
 --tracked
Date: Fri, 27 Mar 2009 17:52:16 +0100
Message-ID: <49CD0440.6010304@drmicha.warpmail.net>
References: <alpine.LNX.1.00.0903201358440.19665@iabervon.org> <1238100805-19619-1-git-send-email-git@drmicha.warpmail.net> <1238100805-19619-2-git-send-email-git@drmicha.warpmail.net> <1238100805-19619-3-git-send-email-git@drmicha.warpmail.net> <7vprg3fkw8.fsf@gitster.siamese.dyndns.org> <49CC9285.407@drmicha.warpmail.net> <7v1vsjey3s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 17:54:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnFJx-00027Z-1N
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 17:54:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758643AbZC0Qw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 12:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757500AbZC0Qw0
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 12:52:26 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35791 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755797AbZC0QwZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Mar 2009 12:52:25 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 31A762FF92A;
	Fri, 27 Mar 2009 12:52:23 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 27 Mar 2009 12:52:23 -0400
X-Sasl-enc: REuEv12W/zgfTiExEVWevxiF7DpLAzHdkcJ+h4D0sE71 1238172742
Received: from localhost.localdomain (p4FC63422.dip0.t-ipconnect.de [79.198.52.34])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 07814AAF5;
	Fri, 27 Mar 2009 12:52:21 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090326 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <7v1vsjey3s.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114911>

Junio C Hamano venit, vidit, dixit 27.03.2009 17:20:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Junio C Hamano venit, vidit, dixit 27.03.2009 09:08:
>> ...
>>> After calling r-f-t, because this new code assumes that for the "." remote
>>> (aka "local repository"), r-f-t lies and does not give back what it
>>> expects, fixes what it got back from r-f-t.  Shouldn't we be fixing this
>>> inside r-f-t?
>>
>> The technical reason is that there is no local remote, i.e. no remote
>> struct for '.', and I don't think we want it, because it would show up
>> in all places where the list of remotes is searched/displayed/...
>>
>> With ret being the branch we talk about, r-f-t is passed ret->remote and
>> ret->merge[i] only. In the local case, r-f-t cannot use the remote
>> struct for '.' (there is none) to find what it needs, and it has no easy
>> access to ret->merge_names[i] which is that info.
>>
>> branch_get(), on the other hand, has all needed info in place.
> 
> Thanks for a detailed explanation.  Would it deserve to be in the commit
> log justification in a summarized form?

You tell me :)
I'm still unsure at times how detailed commit messages should be, but I
take it I should put a shortened version of the above in there.

> 
>> ..., even worse: if foo is
>> ambiguous because refs/heads/foo and refs/remotes/foo exist then
>> refs/heads/foo would win, i.e. we used to output the *wrong* ref. The
>> above disambiguates. But I'll see if I can simplify the output based on
>> the necessity of disambiguation.
> 
> Thanks.

I thought about doing the following:
- remove occurences of refs/remotes (like before the patch) and of
refs/heads. That way the output format stays the same, the amiguity
problem is not worsened
- think later/harder about doing this more cleverly. I guess I need to
check the output of dwim_ref, but have to figure out all the input
parameters first...

Michael
