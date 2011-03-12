From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] rebase: be cleverer with rebased upstream branches
Date: Sat, 12 Mar 2011 16:15:22 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1103120930250.15442@debian>
References: <1297691481-3308-1-git-send-email-martin.von.zweigbergk@gmail.com> <7vzkpxm45e.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1102152040370.14950@debian> <AANLkTinmxbYLB-K+VzY50NtOAPwd-q3WwAosAHqKRq_0@mail.gmail.com> <alpine.DEB.2.00.1102161122350.14950@debian>
 <AANLkTik-JGZFCE+m7g__mwfQhRReOM=Qe_EO3otw50XC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>
To: =?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Sat Mar 12 22:15:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyWA8-0001z7-Hd
	for gcvg-git-2@lo.gmane.org; Sat, 12 Mar 2011 22:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755661Ab1CLVPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2011 16:15:34 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48431 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346Ab1CLVPc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2011 16:15:32 -0500
Received: by vws1 with SMTP id 1so1535622vws.19
        for <git@vger.kernel.org>; Sat, 12 Mar 2011 13:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=Z/n7O5WBdTLeOZ+y1RhfJX3emXpVDI/+GhwodFGamJw=;
        b=nNPPLBR6vPC6mOCcYE2QL7rEp/XomJVd2+/XC+PTZj6UsY9YWjc0TqBLUkQK/xsElU
         6sXho8QIVUzeFHPPsI8dILv4qHYAqAO0KhRA5YVsOJeatTvdS3uuI4KbBvb03f7R2Vbe
         NlKGBZ7JTbhOJUPUufXMeCvmN6WBZvE2Rz5qc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=obaqzB24rO9+OvuVpylLn3rd/oEFmwvDL93bSzBR1JUUAi7e2YtlcnIK3sndR91y1d
         zeuDm9Hb0W5VRNnuaIqhwA66MiPZFXF/ROfYKxjuSqjQphWLXQUAMwHVy8j6qLAuZ2TL
         Kg0oCjCsmKOXuIyTHIS+EGQhWB2/LJthpBFsA=
Received: by 10.52.166.195 with SMTP id zi3mr928478vdb.193.1299964531785;
        Sat, 12 Mar 2011 13:15:31 -0800 (PST)
Received: from [192.168.1.101] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id a11sm1321900vdu.1.2011.03.12.13.15.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 12 Mar 2011 13:15:29 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <AANLkTik-JGZFCE+m7g__mwfQhRReOM=Qe_EO3otw50XC@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168950>

On Thu, 17 Feb 2011, Santi B?jar wrote:

> On Wed, Feb 16, 2011 at 5:45 PM, Martin von Zweigbergk
> <martin.von.zweigbergk@gmail.com> wrote:
> > On Wed, 16 Feb 2011, Santi B?jar wrote:
> >
> >> On Wed, Feb 16, 2011 at 3:03 AM, Martin von Zweigbergk
> >> <martin.von.zweigbergk@gmail.com> wrote:
> >> >
> >> >        .-u@{0}
> >> >       /
> >> >      .---u@{1}
> >> >     /
> >> > x---y-----u@{2}
> >> >     \
> >> >      .---u@{3}---b
> >> >       \
> >> >        .-u@{4}
> >> >
> >> >
> >> > I have an idea inspired by bisection, Thomas's exponential stride, and
> >> > what someone (you?) mentioned the other day about virtual merge
> >> > commits. I haven't tried it out, but let me know what you think. I'll
> >> > try to explain it using an example only:
> >> >
> >> > Exponential stride phase:
> >> > 1. candidates={ u@{0} }
> >> >   merge-base b $candidates -> y, _not_ in $candidates
> >> > 2. candidates={ u@{1} u@{2} }
> >> >   merge-base b $candidates -> y, _not_ in $candidates
> >> > 3. candidates={ u@{3} u@{4} u@{5} u@{6} }
> >> >   merge-base b $candidates -> u@{3}, in $candidates
> >>
> >> Doesn't it indicate that u@{3} is the commit we are looking for? I
> >> haven't found a counterexample...
> >
> > Yes, of course. Stupid me ;-). Forget about the other half. (I think
> > that's what I did manually to match the sha1 back to the ref name, but
> > that is of course complete non-sense to do in the script.)
> >
> >> If this is true the following patch can implement it for git-pull.sh and
> >> git-rebase.sh (sorry if it is space damaged):
> >
> > Thanks! Will have a closer look at it later today. If I understand
> > correctly, you simply call merge-base with the _entire_ reflog. I
> 
> Yes, that is the idea (plus the old remote hash in case of git-pull)
> 
> > would have thought that would be slow, but it's great if that is fast
> > enough.
> 
> Yes, I think it is fast enough in the normal case. Even feeding the
> entire git.git's master, ~25000 revisions, it takes around 2-4 seconds
> only:
> 
> $ git rev-list origin/master | wc -l
> 24380
> $ time git merge-base $(git rev-list origin/master)
> 9971d6d52c5afeb8ba60ae6ddcffb34af23eeadd
> 
> real	0m4.014s
> user	0m1.520s
> sys	0m2.284s
> 
> (2.5GHz CPU)


I finally got around to doing some tests on this myself. I used
git.git as of mid Feb, which at that time had 10010 commits in master,
following only the first parent. I took the first 563 commits from the
todo branch and transplanted onto master~10000 (there were some
conflicts after about 563 commits and I figured that would be enough
anyway). I then rebased the resulting branch (let's call it 'u')
against master~9990, then against master~9980 and so on to get a
reflog with 1001 entries for u. I then created another branch 'b'
based on u@{10}, u@{100} and @{1000}, for different runs of the
tests. I created one additional commit on b in each case. I then
rebased b with master, using the following algorithms to find the base
to rebase from:

 manual: simply calling 'git rebase --onto u b~1'

 linear: same algorithm as in 'git pull', which linearly walks the
 reflog until a commit that b contains is found

 merge-base: the base will be calculated as 'git merge-base b $(git
 ref-list -g u)'

 exponential: like merge-base, but start with only u@{0}, then
 {u@{1},u@{2}} and so on until a commit that b contains is found

These are the results:

                 u@{10}     u@{100}    u@{1000}
manual         0m0.535s    0m1.164s    0m1.415s
linear         0m1.245s   0m37.367s   5m10.068s
merge-base    0m14.490s   0m15.409s   0m15.508s
exponential    0m1.056s    0m6.175s   0m27.221s

(1.8 GHz Athlon 64).

This clearly shows that the linear algorithm from git pull is not good
enough when rebasing older branches (i.e. branches whose upstream has
many reflog entries created after the branch itself was created).

The time it takes the "merge-base" algorithm is quite independent on
how old the branch is, but with this quite long and branchy reflog
(but not too dissimilar from git.git's pu?), it takes quite a while to
calculate it. I think this is also too slow to be acceptable as a
default.

I would personnally be happy if the "exponential" algorithm was used
by git rebase default. I suppose not everyone would agree that the
convenience outweighs the performance cost, though. OTOH, a slower
algorithm has been used in git pull for a long time and it seems like
not many people have really been bothered by that. Also see the
following paragraphs.

I also ran the same tests with an upstream branch that was never
force-updated. For these test cases, I created a reflog such that
u@{$i} = master~$((10 * $i)). Since the upstream branch was know never
to have been force-updated in this case, the "manual" test case was
simply 'git rebase u'. These are the results:

                 u@{10}     u@{100}    u@{1000}
manual         0m0.885s    0m6.126s   0m52.248s
linear         0m1.349s   0m39.688s   5m28.753s
merge-base     0m1.160s    0m1.699s    0m1.901s
exponential    0m0.769s    0m4.342s    0m7.360s

Not surprisingly, the linear algorithm is slow in these cases as well.

What's more interesting here is that the last two algorithms are
actually faster than the plain 'git rebase u'. This is caused by
--ignore-if-in-upstream flag to format-patch. Since the other three
algorithms try to figure out what the base was and pass the range from
the guessed base to the branch (e.g. u@{100}..b) to format-patch, the
--ignore-if-in-upstream to that command effectively becomes a no-op.

Although this makes rebase faster in the case of a non-force-updated
upstream, it may also be a problem in some cases. This was something
that I had not thought about until I started timing the calls. One
reason I can think of when the --ignore-if-in-upstream is useful is
when the upstream branch has been rebased, but this is exactly the
case when guessing the old base is useful and solves the problem in a
better way anyway. However, if a commit on the upstream branch was
cherry-picked from some commit on the current branch above its base
(i.e. in u@{x}..b), then that would not be detected by
--ignore-if-in-upstream and could result in unnecessary merge
conflicts. I don't know how common this case is.

The above also applies to 'git pull', of course, but the ways of
getting identical patches in upstream are probably different (more
likely by 'git am' than 'git cherry-pick' perhaps).

I think this is a useful feature. I'm just not sure how to balance the
performance vs convenience. Worst case, this could probably become a
command line option and configuration. I guess 'git pull' should use
the same algorithm. If we decide to use configation, maybe git-pull's
default would need to be different to be backward compatible.

Any thoughts?

> But, as Junio showed, it has problems when the reflog lenght is too
> large. Maybe git-merge-base can learn the --stdin flag, or we could
> process the reflog in batches of 1000 (?) entries, ... but the nice
> property of using the entire reflog is that the output is what you are
> looking for, if you take the first 1000 entries you have to check if
> the output is one of these entries.

Since I think the exponential algorithm seems the best choice, we
could probably just limit it to a certain number of entries, but maybe
it's better to implement a --stdin flag to merge-base. It could be
useful for others too.


/Martin
