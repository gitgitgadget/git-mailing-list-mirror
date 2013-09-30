From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Local tag killer
Date: Mon, 30 Sep 2013 17:14:48 -0400
Message-ID: <5249E9C8.1070700@xiplink.com>
References: <52327E62.2040301@alum.mit.edu> <CAPc5daXvCf90WYoUWC+DxRyZEQhXGL7Bd_ZJKwfoqxeKt8TADQ@mail.gmail.com> <xmqqd2o3p0nk.fsf@gitster.dls.corp.google.com> <523D3FD2.4090002@alum.mit.edu> <20130924075119.GD7257@sigill.intra.peff.net> <alpine.LFD.2.03.1309251834210.312@syhkavp.arg> <5246C975.1050504@alum.mit.edu> <CALKQrgeJn1J4ntE_2Lr7Et+Oao=vB1FE6nLfaFJOvLHJLzG9tA@mail.gmail.com> <5247ACB9.40208@alum.mit.edu> <52499797.9030100@xiplink.com> <alpine.LFD.2.03.1309301138200.6331@syhkavp.arg> <5249CDF7.4050904@xiplink.com> <alpine.LFD.2.03.1309301527270.6331@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	=?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Sep 30 23:14:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQknt-0007dg-Cw
	for gcvg-git-2@plane.gmane.org; Mon, 30 Sep 2013 23:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755763Ab3I3VOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Sep 2013 17:14:49 -0400
Received: from smtp122.ord1c.emailsrvr.com ([108.166.43.122]:47028 "EHLO
	smtp122.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755507Ab3I3VOs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Sep 2013 17:14:48 -0400
X-Greylist: delayed 7120 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Sep 2013 17:14:48 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp8.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 081191A0077;
	Mon, 30 Sep 2013 17:14:48 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp8.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 8706C1A0141;
	Mon, 30 Sep 2013 17:14:47 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <alpine.LFD.2.03.1309301527270.6331@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235627>

On 13-09-30 04:08 PM, Nicolas Pitre wrote:
> On Mon, 30 Sep 2013, Marc Branchaud wrote:
> 
>> On 13-09-30 11:52 AM, Nicolas Pitre wrote:
>>> Consider that I have in my Linux kernel tree:
>>>
>>> - a remote branch corresponding to Linus' master tree
>>>
>>> - multiple remote branches corresponding to Linux stable branches
>>>
>>> - a remote for linux-next which is a repo constantly being rebased
>>>
>>> Now all those repositories share the mainline tags from Linus' repo and 
>>> they add some more of they own which are not shared.  So if they all 
>>> have a v3.11 tag that resolve to the same SHA1, then there is 
>>> effectively no ambiguity at all and git should not warn at all.
>>
>> Thanks, this example helps very much.
>>
>>> *However* if one of those v3.11 tags does not agree with the others 
>>> _then_ I want to be warned about it.
>>
>> Hmmm.  What behaviour would you like if you also had some non-Linux remote,
>> say for some driver code or something, that also had a v3.11 tag?
> 
> I want git to complain and bail out, maybe suggesting that I should use 
> "driver_something/tag/v3.11" to disambiguate the tag.
> 
>> I presume
>> you want commands like
>> 	git checkout -b my-topic v3.11
>> to do the Right Thing, but what's the right thing for you here?
> 
> git itself can't know it.  So the best git could do is to list 
> conflicting tags with the shortest path that makes them unambiguous and 
> suggest that I try again with one of them.
> 
>>> So having multiple matching tags that do resolve to the same SHA1 across 
>>> different remote repositories _is_ the norm and should work 
>>> transparently.
>>
>> My suggestion for your example is that if some remote's tags are so
>> important/useful then you're better off importing them into your local tag
>> namespace (e.g. "git fetch Linus refs/tags/*:refs/tags/*").  By making the
>> remote's tags local, you're expressly telling git that they should be
>> considered for DWIMery, git-describe, etc.
> 
> Sure, it is probably a good thing semantically to give priority to local 
> tags when they exist. However...
> 
>> I feel this approach lets us avoid having to somehow teach git which remote's
>> "v3.11" tags are important enough to merit an ambiguity warning and which
>> aren't.  Plus you get what I think you want, which is the current behaviour.
> 
> But I disagree here.  Most people simply won't care about local tags 
> since the remote tags are sufficient for what they need.

Good point -- I see where my suggestion was wrong.  I think it's worthwhile
to make sure that bare tag names "just work" after a simple clone.  Git's
DWIM code already does this for branch names, and it makes sense to extend
that to other ref types in remote namespaces.

> And if they 
> have multiple remotes in their repository then it is most likely to be 
> different forks of the same project sharing mostly the same tags, and 
> where those tags diverge then they're most likely to have different tag 
> names as well.

I disagree about the "most likely" part, but it's only a niggle.  I agree
with the overall point that disambiguation through SHA1 comparison makes sense.

> So in the large majority of the cases, this v3.11 tag 
> will come from one or more remotes and they will refer to the same SHA1, 
> so it ought to just work without any special fetch.  Also, if I refer to 
> v3.11.1 which is a tag that only exists in one of the remote branches 
> and not in Linus' remote then it ought to just work as well.  That is 
> more inline with the current _usage_ behavior even if the flat namespace 
> is otherwise a nightmare to sort out when managing remotes.

Agreed.

> Furthermore, git already has some code to detect refname ambiguities:
> 
> $ git init && echo "foo" > foo.txt && git add foo.txt
> $ git commit -m "foo" && git tag foo && git branch foo && git log foo
> warning: refname 'foo' is ambiguous.
> 
> So adding the extra step to lookup all possible tags and make sure they 
> resolve to the same SHA1 should be a logical extension to what's already 
> there.
> 
> Again, in the cases where there is actually a SHA1 conflict between all 
> possible tags that match a tag short-end then listing them and asking the 
> user to be more explicit is the right thing to do.  But that should be a 
> very rare case in practice, and designing for making this case easy is 
> the wrong approach.
> 
> Instead, the common case of multiple remotes with duplicated tag names 
> referring to the same thing _and/or_ multiple remotes with distinct tags 
> names is what should be made easy to use with no extra steps.

Again, I don't think that's the common case.  I think it's just as likely for
there to be multiple remotes with duplicate tag names that refer to different
objects.  However, SHA1-disambiguation covers all these cases.

		M.
