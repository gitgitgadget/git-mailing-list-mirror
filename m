X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eran Tromer <git2eran@tromer.org>
Subject: Re: Feature request: git-pull -e/--edit
Date: Mon, 20 Nov 2006 21:10:33 +0200
Message-ID: <4561FDA9.6060807@tromer.org>
References: <git2eran@tromer.org> <200611201709.kAKH9or1012062@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-8
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 20 Nov 2006 19:13:00 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061107 Fedora/1.5.0.8-1.fc5 Thunderbird/1.5.0.8 Mnenhy/0.7.4.0
In-Reply-To: <200611201709.kAKH9or1012062@laptop13.inf.utfsm.cl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31927>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmEZa-0007nD-SY for gcvg-git@gmane.org; Mon, 20 Nov
 2006 20:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966444AbWKTTMK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 14:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966448AbWKTTMJ
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 14:12:09 -0500
Received: from line108-16.adsl.actcom.co.il ([192.117.108.16]:5772 "EHLO
 lucian.tromer.org") by vger.kernel.org with ESMTP id S966444AbWKTTMI (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 14:12:08 -0500
Received: from [192.168.4.6] ([192.168.4.6]) by lucian.tromer.org
 (8.13.8/8.12.11) with ESMTP id kAKJBQtH030552; Mon, 20 Nov 2006 21:11:28
 +0200
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org

On 2006-11-20 19:09, Horst H. von Brand wrote:
>>
>>   A------------F master
>>    \          /
>>     B--C--D--E
>>
>> Yes, E and F have identical trees. But it's actually *very useful*, if
>> the commit message at F says "merged branch foo containing experimental
>> bar from quux". And it shows up nicely when looking at gitk.
> 
> I don't see the usefulness of this. 

Just look up this thread for the most recent example: recording the text
of "pull foo to get" and "[00/05] Fix quux" message.


> And if quux merges back, she gets the same plus a new merge node, and...
> Linus told everybody (quite forcefully, I might add) that this is not
> acceptable for distributed development.

I've address this. Sure, it breaks down completely if done by default
when nothing new happens; but not when done judiciously. For real
problems to show up you'd need two people who both insist on always
using --force-commit when pulling each other. Inevitably, before long
they will realize the folly of their ways and stop doing that; problem
solved.

I expect common usage to be that --force-commit is only used by
maintainers, when pulling/applying non-trivial branches from downstream.
But this is a social convention that can be decided per project, and can
be ignored by anyone who decides to fork off. And if Linus doesn't like
it he can just avoid using it in his projects.


>> There are the obvious bad consequences if you make this the default,
>> but how about adding a --force-commit option to merge and pull?
> 
> Fast forward is fast forward. Merge is when /independent/ changes are
> integrated into one.

I was under the impression that git-merge is what (indirectly)
determines if joining multiple commits is a fast-forward or a real
merge. If it's in some other piece of git, please substitute that.


>> You'd need to educate users on how to use this responsibly
> 
> Looks like you've never met real users ;-)

No, it's really easy in this case: if someone asks you to pull a rotten
branch with too many forced merges, just refuse until he stops abusing
that option. It's not the default, right? There are plenty of much worse
non-default ways to damage history.


>> And to answer Linus: yes, it's expected that only non-leaf developers
>> will use --force-commit on regular basis, but that's not because
>> maintainers are technically special in any way. It's just because
>> maintainers have something useful to say ("someone's private topic
>> branch, starting at A and ending at E, has just been accepted into my
>> all-important public repo and here's why"). Anyone else can do the same
>> if he feels likewise.
> 
> But the individual changes will presumably reflect said someone's
> authorship. If they are interleaved with stuff by others or not doesn't
> make much (development) sense. Yes, it might be interesting for a software
> historian, but that's not git's main audience in the first place.

If the only thing you care about is the tree of the top commit, then
sure, those redundant commits are worthless. But then, why do you bother
with (for example) commit messages, or tag objects? Oh, you want to know
more about what happened and why? Then great, those "pull foo to get"
and "[00/05]" messages are probably the best place to start, if we only
had where to save them.

We are all "software historians" when we look at some project's public
branches and try to grok what's going on recently, who's doing what and
along what workflow, and why it got there. This is useful information,
that is not easily tracked by any other means; there's a reason this
comes up repeatedly in various guises, you know. I can't see why some
people are so eager to discard this information and tell others to use a
munged-up shortlogs, instead of looking for ways to record as much
possible with the least negative impact.

Now, --force-commit with appropriate usage conventions seems like a
reasonable tradeoff.

BTW, in principle another (better?) way to do it is by leaving the
commit DAG alone, and annotating it with tag objects where extra
information such as "[00/05]" is available. The problem is that git
doesn't have any scalable mechanism for adding such annotations. It's a
hard problem; nothing in the commit DAG points to to tag objects, so you
have to scan some external store and that gets more expensive as the
repo grows. It also gets nasty in fetches.

  Eran
