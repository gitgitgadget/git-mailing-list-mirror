From: "George Spelvin" <linux@horizon.com>
Subject: Re: Git workflow: how to achieve?
Date: 28 Apr 2009 10:02:48 -0400
Message-ID: <20090428140248.31237.qmail@science.horizon.com>
References: <49F6AF12.70906@op5.se>
Cc: git@vger.kernel.org
To: ae@op5.se, linux@horizon.com
X-From: git-owner@vger.kernel.org Tue Apr 28 16:03:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyntr-0000k6-9f
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 16:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498AbZD1OCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 10:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbZD1OCv
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 10:02:51 -0400
Received: from science.horizon.com ([192.35.100.1]:53746 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754323AbZD1OCu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 10:02:50 -0400
Received: (qmail 31238 invoked by uid 1000); 28 Apr 2009 10:02:48 -0400
In-Reply-To: <49F6AF12.70906@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117774>

>From exon@op5.com Tue Apr 28 07:24:19 2009
Sender: Andreas Ericsson <exon@op5.com>
Date: Tue, 28 Apr 2009 09:24:02 +0200
From: Andreas Ericsson <ae@op5.se>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To: George Spelvin <linux@horizon.com>
CC: git@vger.kernel.org
Subject: Re: Git workflow: how to achieve?
References: <20090427225900.29793.qmail@science.horizon.com>
In-Reply-To: <20090427225900.29793.qmail@science.horizon.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Andreas Ericsson <ae@op5.se> wrote:
> George Spelvin wrote:
>> Andreas Ericsson <ae@op5.se> wrote:
>>>>  I want to be able to switch feature branches easily.
>>> Well, git makes that absolutely trivial. No other vcs has as cheap
>>> branching as git does.
>> 
>> Yes, I'm quite aware, but I mean while keeping the same merged result.
>> That is, I'm compiling and testing base+feature_a+feature_b+feature_c,
>> but I want to be able to change which feature I'm committing to.
>> 
>> This comes up if I arrange some merges so that the "current branch" is
>> one below the top merge:
>> 
>> o--o--o--o--o--o--o <-- HEAD
>>            /  /  /
>>     ...c--c  /  /
>>       ...b--b  /
>>         ...a--a
>> 
>> And then want to switch to branch c.

> Sorry, I still don't see a problem here. If you want to commit to C,
> just checkout C and commit. What am I missing?

If a or b touched one of the files that I edited (even in very different
places), the checkout will fail.  And even if it succeeds, I have to
re-do the merges.

I expect it would be easier to commit on top of the pile, test, and
then rebase the last few patches to push the new changes under the
merges.

I know some kernel-lieutenants use a magic branch-prefix to mark which
branches to merge and compile-test, and then use a homegrown script
to actually merge all those branches.

>>>> But when I want to be testing something highly volatile like linux-next,
>>>> and ensuring that my work continues to merge with it cleanly, as well
>>>> as helping others with their branches, it becomes a daily pain.
>>> Why? Just merge it to make sure it merges, and then throw away the result.
>>> There's a post made by Linus somewhere on how he would like people to do
>>> merges (ie, which to keep and which to throw away).
>> 
>> I don't want to just merge it, I want to *compile it* and *run it*.
>> Because the whole point of using linux-next is to test it.
>> And when it breaks, I want access to the relevant source code.
> 
> Ok. Sounds like you'd need some CI tool with special smarts to try merging
> all relevant branches and bailing out on conflicts or something, unless you
> intend to compile it locally and run it from there.

> Because they already have a reference to where they started. It's called
> the merge-base and it differs depending on which branch you want to merge
> it into. If you have 'maint', 'next' and 'master', the "point of origin"
> for "next" is "maint" from the point of view of "maint", but it's "master"
> from the point of view of "master". Marking it as "master" would mean you
> couldn't use that mark when merging it into maint, so you'd have to either
> mark it as a sub-branch of all previous branches, or do what's done today.
> 
> IOW, the mark would help one corner-case but would make all other cases
> more complicated. A bad idea indeed.

Er... obviously, merges have to work the way they do.  This is all for
rebases (cherry-picks).  And if the merge base is more recent than
the branch base, that should take precendence.

Basically, "git-rebase upstream branch" current cherry-picks the commits
in upstream..branch, a.k.a branch ^upstream.  I'd like it to be
branch ^branch.base ^upstream.

>> We may have a language problem.  "very little detail" means almost no detail,
>> an absence of details.  Did you mean "every little detail"?
> 
> No, I mean with very little detail. Usually when trying to answer a
> question and I can't make sense of the question itself it's because
> the person asking has already started down some road and entered into
> a frame of mind which I cannot share. That mindset may not be correct
> to solve the problem, so removing detail usually helps.

Ah, sorry, you wanted more abstract, not more concrete.

> "I'd like to automatically merge a bunch of branches and compile-test them
> on every commit. How do I go about doing that?" is a much more open question
> that invites to giving a lot more correct answers. Since you haven't asked
> such a high-level question yet, I'm not sure what your need is, and therefore
> I cannot help you find a suitable solution.

Okay, "I'd like to commit to somewhere further back in the history rather
than HEAD, and have the HEAD automagically rebased".  How do I do that?

>> It actually came to mind recently during $DAY_JOB work, but let me give a
>> concrete example based on the Linux kernel:
>> 
>> I am running a customized Linux kernel.  On top of Linus's base,
>> I have local patches to enable 64-bit DMA on the SB600 SATA controller,
>> some local patches to make the RAID (md) code print out the locations
>> of mismatches when verifying, the EDAC quilt series, a merge of the
>> LinuxPPS code, a number of local patches to the LinuxPPS code (that
>> I'm discussing with Rodolfo Giometti), and some revisions to the serial
>> interrupt handler (that I'm discussing with Alan Cox).
>> 
>> There's also the beginning of an ethernet driver that I'm trying to
>> write, but it's going slow.
>> 
>> Every week or two, I rebase all that on top of Linus's latest.  Plain
>> rebase doesn't like the LinuxPPS merge, so I've been doing it manually
>> in two parts.  Although rebase -p is apprently working much better than
>> I remember.
> 
> This step is rather unnecessary unless there are changes to API's you
> depend on. Doing a single rebase once you're done with the patch-series
> would be far better and would, I expect, remove quite a lot of the
> complexity you're experiencing.

*Frustration*  I'm somehow having trouble communicating.

I need to rebase it so I have a merged source tree that I can compile
and test.  How else can I test Linus's latest plus my local changes?
What alternative are you suggesting?

I want, AT ALL TIMES, to be running the kernel consisting of
Linus's latest plus my various local hacks.  I want to be able to
freely update any of the components that make up the result,
and have the sum automatically recomputed for me.

>> Currently, some patches get deeply buried in the stack and I have to
>> do a lot of deep rebasing.
> 
> I'm not sure what you mean by "deep rebasing" or "stack", unless you've
> started using topgit already (which, I believe, does patch-stacks).
> 
> No patch should ever get "deeply buried" unless you do really, really
> weird things with your topic-branches though. They *should* remain the
> same each and every time.

I mean that the patch I want to edit is 20 or more patches back
in history (I'm running 2.6.30-rc3-00063-gd3de9aa at the moment),
so amending it involves a considerable amount of rebasing.

(Because I'm currently organized as a linear list of local
patches on top of upstream.  I'd prefer separate feature
branches plus merges, but that's what I'm asking how to make
work efficiently.)
