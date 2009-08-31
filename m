From: Andreas Ericsson <ae@op5.se>
Subject: Re: A note from the maintainer: Follow-up questions (MaintNotes)
Date: Mon, 31 Aug 2009 10:05:51 +0200
Message-ID: <4A9B845F.3030302@op5.se>
References: <ac3d41850908301519s2cf8a45auf11fb4c9285c0cb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Chanters <david.chanters@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 10:06:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mi1tx-0006Yf-In
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 10:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbZHaIF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 04:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbZHaIF6
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 04:05:58 -0400
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:44067 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750886AbZHaIF5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Aug 2009 04:05:57 -0400
Received: from source ([209.85.219.217]) by na3sys009aob109.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSpuEZGQ2CvcqzdZag5wyqwp3xVPX1qpx@postini.com; Mon, 31 Aug 2009 01:05:59 PDT
Received: by ewy17 with SMTP id 17so2973665ewy.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2009 01:05:56 -0700 (PDT)
Received: by 10.210.9.7 with SMTP id 7mr4978708ebi.5.1251705955955;
        Mon, 31 Aug 2009 01:05:55 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 23sm192751eya.46.2009.08.31.01.05.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 31 Aug 2009 01:05:54 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <ac3d41850908301519s2cf8a45auf11fb4c9285c0cb5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127469>

David Chanters wrote:
> Hi,
> 
> [Please retain a Cc back to me as I am not currently subscribed to the
> mailing list.]
> 
> I've recently been intrigued with workflows, and have read quite a bit
> about them, including various references on git-scm.com,
> gitworkflows(7), and the email "A note from the maintainer" which I
> have some questions on.  I'll paste random quotes from that and just
> ask my question, I think, so apologies up front of it reads a little
> disjointed.
> 
> I'd often wondered when I have read various posts of the git mailing
> list on gmane, just how it is I am supposed to track:
> 
> dc/some-topic-feature
> 
> ... Junio, are these topic branches ones you actively have somewhere
> in your own private checkout?  Yes, I appreciate that when I read a
> given post to the mailing list, you or other people will sometimes
> make reference to these topic branches, but what do I do if I am
> interested in finding out about one of them?  Indeed, perhaps even
> before getting to that question, how do you go about creating and
> maintaining these topic branches -- are you making heavy use of "git
> am"?
> 
> I ask because of the following snippet from "MaintNotes":
> 
>     The two branches "master" and "maint" are never rewound, and
>     "next" usually will not be either (this automatically means the
>     topics that have been merged into "next" are usually not
>     rebased, and you can find the tip of topic branches you are
>     interested in from the output of "git log next"). You should be
>     able to safely track them.
> 
> I am not sure if there's any real use-case for this, but I will ask
> anyway:  is the above saying that I am able to *checkout* one of these
> topic-branches just from their presence in "next" alone?

Yes. "git log --grep=dc/some-topic-feature next" would point you to
the merge commit where it gets merged to 'next'. Then you can simply
do "git checkout -b dc/some-topic-feature (the-located-commit)^2" to
create the branch "dc/some-topic-feature" as it was when Junio merged
it. This relies on Junio not tampering with the commit messages git
creates when merging, but since there's no real need for that anyway,
it's a fairly safe practice.

> 
> To continue:
> 
>     The "pu" (proposed updates) branch bundles all the remainder of
>     topic branches.  The "pu" branch, and topic branches that are
>     only in "pu", are subject to rebasing in general.  By the above
>     definition of how "next" works, you can tell that this branch
>     will contain quite experimental and obviously broken stuff.
> 
> I'm obviously missing something here -- but why is rebasing these
> existing topic branches (I assume on top of "pu") more useful than
> just merging them into "pu" -- like you do with "next"?
> 

Because topics in 'pu' can be dropped on the floor, and are worked
on quite a lot more than the ones in next. Undoing a merge is quite
a lot of work as opposed to just rebuilding the history without that
merge. It's also a lot nicer to have a cleaner history in 'next',
since that makes it easier to merge things to 'master' in such a way
that bisection works nicely.

>     When a topic that was in "pu" proves to be in testable shape, it
>     graduates to "next".  I do this with:
> 
>             git checkout next
>             git merge that-topic-branch
> 
>     Sometimes, an idea that looked promising turns out to be not so
>     good and the topic can be dropped from "pu" in such a case.
> 
> Ah -- so if I have this straight in my head -- you continually form
> the local topic-branch on its own branch, and then just merge it into
> "next" only when you know that topic branch is satisfactory?

I *think* the topic branches live until they're merged to master, or
until they're dropped (although I could well imagine them staying
behind quite some time after being dropped). I haven't heard Junio
talk about this afair, but that's how I would do it anyways.

>  That
> being the case -- again, I assume the use of "git am" for the topic
> branch?

I should think so, although once a patch is applied in its final
form it'll no longer be necessary to use "git am". It'll be easier
to just use rebase on the topic branch(es), or cherry-pick individual
commits from them in order to get only certain benefits of them.
This isn't *very* usual, but it does happen from time to time that
topic branches refactor something first and then adds a feature on
top of that.

>  If regular readers of the git mailing list wish to track this
> topic branch, can they do so from you only until it's merged into
> "next"?
> 

Topics that make it to master can be tracked indefinitely. 'next'
is never merged directly to master, since the topics brewing on
next get different amounts of testing and feedback. Junio just
merges the topics to master as they go through all the review and
testing they're thought to need. Try

  git log --grep="Merge branch '" master

and you'll see what I mean, or have a look using gitk.

> And a related question:  If you decide a given topic in pu is declared
> to "be dropped", is this done by rebasing (as you mentioned earlier)
> so as to remove any trace of the topic branch ever having been in
> "pu", or am I reading too much into "dropping" here?  :)
> 

AFAIU, 'pu' is dropped in its entirety and re-built from the top of 'next'
by the rather simple expedient of "git reset --hard next" and then merging,
one by one, all branches that aren't already merged to maint, master or
next. Git can list such branches so it's no great chore. Naturally, Junio
knows his way fairly well around git and has scripts to do much of this
work for him.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
