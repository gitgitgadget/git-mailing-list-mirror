From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Tue, 16 Apr 2013 11:59:31 +0200
Message-ID: <8761zm4wzg.fsf@linux-k42r.v.cablecom.net>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
	<CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
	<7vip3npet0.fsf@alter.siamese.dyndns.org>
	<CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 11:59:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US2fq-0008Rn-UR
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 11:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935218Ab3DPJ7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 05:59:34 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:17695 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935184Ab3DPJ7d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 05:59:33 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 16 Apr
 2013 11:59:28 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 16 Apr 2013 11:59:31 +0200
In-Reply-To: <CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
	(Felipe Contreras's message of "Mon, 15 Apr 2013 18:30:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221405>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Clearly, that's the correct behavior. Why would anybody send a change
> that does something other than the correct behavior?

Along the same lines, why would anyone write broken code?  Nobody does,
right?

If anyone reads that commit message in more than a few weeks, then it's
because some of the code is *broken*.  So the reader is investigating a
situation where there must be a flaw somewhere, and trying to pin down
the source.  Having access to the thinking behind each commit means s/he
can more easily verify whether that thinking was correct and still
applies.

And your commit messages do nothing towards that end.


A cursory look^W^Wreview of the messages in fc/remote-hg:

    remote-hg: fix bad file paths
    
    Mercurial allows absolute file paths, and Git doesn't like that.

Only describes the problem; no reasoning as to what the chosen solution
is or why it is correct.  (I can at least infer the former from the
code, but not the latter.)

    remote-hg: show more proper errors
    
    When cloning or pushing fails, we don't want to show a stack-trace.

So what do we show?

It also seems that you do not actually use the import you add, or do
you?

    remote-hg: force remote push
    
    Ideally we shouldn't do this, as it's not recommended in mercurial
    documentation, but there's no other way to push multiple bookmarks (on
    the same branch), which would be the behavior most similar to git.
    
    At the same time, add a configuration option for the people that don't
    want to risk creating new remote heads.

This one, for a change, says what it does but doesn't say what problem
it fixes.

I'll refrain from commenting on all the one-line messages, and just
point at this one:

    remote-hg: trivial test cleanups

In $DAYJOB the advice is to avoid "trivial" (and similarly "obvious"):
either it *is* trivial, in which case you don't need to point that out,
or you're just trying to handwave over the fact that it's not.  Like
this:

 git_clone () {
-       hg -R $1 bookmark -f -r tip master &&
        git clone -q "hg::$PWD/$1" $2
 }

Not knowing the code I can only conjecture, but surely there was a
reason that the hg call lived in a function called git_clone?  And
surely there must be a good reason why it is no longer needed?


My personal favorite however is this one:

    remote-bzr: improve tag handling
    
    revision_history() is deprecated and doesn't do what we want (revno
    instead of dotted_revno?).

I don't even know how to parse that question mark.  Does it actually ask
a question?  Does it mean to imply, by the intonation suggested by a
question mark, "how could anyone ever have been so silly as to use a
revno instead of a dotted_revno"?


By the way, it's easy to find similarly helpful messages in git.git in
the old days.  One that I remember stumbling across was:

    Add the --color-words option to the diff options family
    
    With this option, the changed words are shown inline. For example,
    if a file containing "This is foo" is changed to "This is bar", the diff
    will now show "This is " in plain text, "foo" in red, and "bar" in green.

How could it not be obvious how it achieves this to anyone who has read
the ~170 lines of code it adds?

Luckily *that* code was correct and feature-complete right from the
start, so nobody ever had to actually read it to figure out what's going
on.

But that was back in 2006.  I should think that git.git has improved
since; when I wrote my first patches in 2008, I was impressed with the
readable history and extensive reviews.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
