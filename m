X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nix <nix@esperi.org.uk>
Subject: Re: What's the meaning of `parenthood' in git commits?
Date: Wed, 08 Nov 2006 01:36:15 +0000
Message-ID: <87zmb2afe8.fsf@hades.wkstn.nix>
References: <878ximbwm3.fsf@hades.wkstn.nix>
	<7vy7qmyc46.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 8 Nov 2006 01:37:21 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Emacs: impress your (remaining) friends and neighbors.
In-Reply-To: <7vy7qmyc46.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Tue, 07 Nov 2006 17:13:13 -0800")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31110>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhcMm-0004L7-0V for gcvg-git@gmane.org; Wed, 08 Nov
 2006 02:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753827AbWKHBgY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 20:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753831AbWKHBgX
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 20:36:23 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:64777 "EHLO
 mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1753827AbWKHBgW (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 20:36:22 -0500
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18]) by
 mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id kA81aFB3014068;
 Wed, 8 Nov 2006 01:36:16 GMT
Received: (from nix@localhost) by esperi.org.uk
 (8.12.11.20060614/8.12.11/Submit) id kA81aFih030120; Wed, 8 Nov 2006 01:36:15
 GMT
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 8 Nov 2006, Junio C. Hamano spake thusly:
> Nix <nix@esperi.org.uk> writes:
>
>> The idea being that if you have a tree like this:
>>
>>      B
>> ------------- ref trunks/latest
>>      \
>>       ------ ref heads/some-change-foo
>>
>>  ... -------- ref trunks/old-and-grotty
>>
>>
>> then this merge strategy, when asked to merge heads/some-change-foo into
>> trunks/old-and-grotty would spot that point B was the most recent
>> merge point into anything in trunks/, generate a diff between point B
>> and heads/some-change-foo, and patch it into trunks/old-and-grotty.
>
> This is a standard "cherry-picking" practice.

Yes, pretty much, except that we do *everything* by cherry-picking, and
we want to track the cherry-picks in the same way that all other changes
are tracked (i.e., a small branch for each (numbered) change, patching
madly in all directions into a variety of trunks and release branches,
with all those patches tracked.)

>    These commits I list as its parents of this new commit, and
>    everything that leads to them, are what I considered when
>    derived this commit.  This new child commit of them suits the
>    purpose of _my_ branch better than any of these parent
>    commits I took into consideration because of such and such
>    reasons that I stated in its commit log message.
>
> If you mark the resulting commit on old-and-grotty to have
> some-change-foo as one of its parents, because some-change-foo
> has almost everything 'latest' has (up to point B), you are also
> saying "I have considered everything that happened between
> old-and-grotty and B when making this commit".

Yeah. This is the merge-base tracking that Linus mentioned, and it's not
quite what I'm looking for :/ it's a sort of step-parent, really...

> What's implied by that statement is this, even though you do not
> explicitly say:
>
>    I reject everything that happened on the development line
>    that led to 'latest' up to point B since old-and-grotty was
>    forked.

(which is not necessarily true: we might want to backport an earlier
change, also on another `small change branch', later on. Stuff on the
trunks themselves will never want to get backported, but if the
merge-base algorithm traverses patch-merge parent links, it might
consider that a `small change branch' has been merged when it actually
hasn't.)

> This is not necessarily a bad thing, by the way.  For somebody
> who is trying to maintain extremely-stable branch by cherry
> picking only changes in a few narrow areas from the mainline
> would _want_ to leave most of the "new good stuff" out from his
> branch.  That's why I emphasized _my_ a few paragraphs above.

That's exactly what we're doing, across-the-board.

> But it is _so_ different from the mindset of usual "every branch
> makes progress _forward_ perhaps with different pace".  In this
> example, this branch is actively choosing to stay behind and
> refusing to take changes from the 'latest'.  So your users need
> to really understand what they are doing.

*hahahaaaaa*... hang on, that *was* a joke, right? ;)

> So I think as long as you and your users understand what is
> going on, I do not see a problem at either the mechanical level
> or the philosophical level.  But I am sure it would confuse a
> lot of people, so please do not come back complaining that you
> ended up getting your users heads explode ;-).

OK, I think I need to find a way to notate in the patch-merged commit
that one or more parents should be disregarded when searching for merge
bases (and *only* when searching for merge bases). I think that will
do what's wanted in all areas: i.e., it'll act like a cherry-pick
that shows up in the logs/revlist and so on, but doesn't affect the
semantics of later merges of stuff from anywhere except for the
same limited branch.

(obviously trying to patch-merge B to A twice is always going to
fail, whether or not merge-base traversal jumps into B: I don't
think there's any real need to protect against that.)

-- 
Rich industrial heritage: lifeless wasteland. `The land
