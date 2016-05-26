From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH 1/2] fetch: better alignment in ref summary
Date: Thu, 26 May 2016 18:13:40 -0400
Message-ID: <57477514.9020800@xiplink.com>
References: <20160522112019.26516-1-pclouds@gmail.com>
 <20160522112019.26516-2-pclouds@gmail.com>
 <xmqqfut9bnff.fsf@gitster.mtv.corp.google.com>
 <CACsJy8BS2n8T1smxEJMPNiXBvMYHWnQ9BQGk_OKqJd1GFcuk7w@mail.gmail.com>
 <574706A1.8040606@xiplink.com> <20160526162940.GB18210@sigill.intra.peff.net>
 <xmqq8tywwwab.fsf@gitster.mtv.corp.google.com> <57473CDA.5000408@xiplink.com>
 <xmqqk2igvcoj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 00:13:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b63XH-0003KB-RV
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 00:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755286AbcEZWNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 18:13:43 -0400
Received: from smtp90.ord1c.emailsrvr.com ([108.166.43.90]:56573 "EHLO
	smtp90.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754849AbcEZWNm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2016 18:13:42 -0400
Received: from smtp12.relay.ord1c.emailsrvr.com (localhost.localdomain [127.0.0.1])
	by smtp12.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id AE6483801F8;
	Thu, 26 May 2016 18:13:41 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp12.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id C87CE38014E;
	Thu, 26 May 2016 18:13:40 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.5.4);
	Thu, 26 May 2016 18:13:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <xmqqk2igvcoj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295699>

On 2016-05-26 03:31 PM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
>
>> The fact that something is buried in some odd part of the ref tree is
>> less relevant, IMO.  If I'm using custom fetch refspecs or other
>> oddities, I'll have that in the back of my head.  But what I really
>> care about is what ref I can use with commands like log and checkout.
>>
>> So, regarding Peff's examples:
>>
>>> $ git fetch origin refs/pull/*/head:refs/remotes/pr/*
>>
>> Just show me the "pr/foo" refs.  I know where things are coming
>> from. Even if I configured that fetch refspec a long time ago, I don't
>> need to see the exact mapping every time I fetch.
>
> That is only because you are used to seeing them.  You cannot claim
> "I'll remember forever without seeing them" without actually
> experiencing not seeing them for a long time.

I don't expect (or even want) to forever remember the mapping.  It's a 
matter of context.

When fetching, I'm interested in shiny new refs and I want to work with 
them.

When configuring a remote repository, I'm interested in how to bring 
that repo's refs into my own repository.

These are two distinct modes of thought, and I don't think fetch's 
output always needs to display the latter.  Perhaps the --verbose switch 
could turn on showing how the remote refs get mapped.  I can see how 
that would occasionally be useful for debugging fetch refspecs.

>> I think the output should show the plain SHA values, since those are
>> the only things the user can use to work with those refs.
>
> When they tell others how to reproduce what they did (or record what
> they did so that they can reproduce it later), they need what it is
> called at the remote end.

Which is why I included the refnames in my proposal to Peff's second 
example.  Really, the SHA and the remote's name for the SHA are the only 
meaningful things in this case.

> I would hesitate to go in the approach based on discarding
> information, as if it is the only way to shorten and clarify the
> output.  Let's not do so before thinking things through to achieve
> the same while keeping the information we give to the users.

I agree, this is not something to undertake lightly.  But I've yet to be 
convinced of the utility of always showing the ref mapping during a fetch.

I actually found fetch's output quite confusing when I first started 
using git.  It's really not obvious that the thing on the left of the 
"->" is the remote's local name, especially since to see what was 
fetched one has to use the thing on the right-hand side -- which is 
obviously in a remote-specific namespace.  (Admittedly, this was before 
checkout learned to search refs/remotes/ for things to check out.)

		M.
