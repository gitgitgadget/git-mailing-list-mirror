From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Easy Non-Fast-Forward Pushes
Date: Fri, 27 Feb 2015 11:08:35 -0800
Message-ID: <xmqq8ufjjhos.fsf@gitster.dls.corp.google.com>
References: <loom.20150227T170215-199@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Lasse Kliemann <lasse@lassekliemann.de>
X-From: git-owner@vger.kernel.org Fri Feb 27 20:08:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRQHM-00055v-Ih
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 20:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787AbbB0TIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2015 14:08:40 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63340 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754752AbbB0TIj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2015 14:08:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 32E0B3AC66;
	Fri, 27 Feb 2015 14:08:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qwuSz+M6/09lIyCGYqOOBY4wH7c=; b=ceCwS9
	V3xfuDNo9zGuEQkc38uXNqj/UsDUeV2FqUegptmNJ/atb9/+Zb6hR/1Gjqpegyab
	LAE6wcpYFXny2A8yrihGq5rb/K6ys0rqFF11tZ2c2fmmZPWcESjmOwz1XnmGJDf7
	Fws5cXGvjZNNfonJvDFItY9rS4LmFOwMvBDCw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LjWw/jcSqLZkpBXTwMPhfMMZb3YKTki+
	DL96cu5WB8cHCm+Q2UT10a/RCY7itUgUCb0+ezYtlOHrt1/ekrtiX0W4EJx9FAvJ
	wnpcAn19NxYG8URzCkFbYWWU5ic+cOQDOVD/YuwRTFLVn5yTCcTfqET2HawHW9wO
	yuAwyHewZR8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A0BC3AC61;
	Fri, 27 Feb 2015 14:08:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1E1A93AC5C;
	Fri, 27 Feb 2015 14:08:37 -0500 (EST)
In-Reply-To: <loom.20150227T170215-199@post.gmane.org> (Lasse Kliemann's
	message of "Fri, 27 Feb 2015 16:20:19 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0858D6BA-BEB4-11E4-AFFF-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264505>

Lasse Kliemann <lasse@lassekliemann.de> writes:

> As far as I understand, a push will always modify (or add) a ref in the
> remote repository. When pushing to branch B, then the ref pointing to the
> last commit in this branch will be moved, provided that this can be done in
> a fast-forward way. Otherwise the push will fail.
>
> The following options exist:
>
> (1) force the push
> (2) fetch, merge, then push
> (3) push to a different branch
>
> I don't want (1), for obvious reasons.
>
> Option (2) implies that a particular person has to do the merge, namely the
> person for whom the push is failing, or in other words: the person
> unfortunate enough not being the first to push. (This reminds me of
> Subversion: whoever tries to commit after someone else has committed will
> have the burden of an update and possible merge.)
>
> Option (3) allows others to recognize the situation, and anyone with
> repository access can do a merge. This is a good thing. However, I am
> confused as to what branch name should be used for this. In Mercurial, we
> would say that a new "head" is created, and anyone can recognize this by
> using "hg heads" and do a merge if he feels competent enough. (A "head" in
> Mercurial is a revision without children.) Can something similar be done in
> Git? I'd like to provide my co-workers with a command which they can always
> use to push their changes to a central repository in order that I can see
> what has happened and do merges accordingly. In Mercurial, such a command
> would simply be "hg commit && hg push -f". Then I can use "hg heads" to see
> if any new heads have grown, and if so, do merges. Upon their next pull,
> these merges would manifest themselves in the repositories of my co-workers,
> and everything will be fine for them. So, im looking for the equivalent of
> that workflow in Git. Thanks a lot!

I do not think I agree with the premise of the above in the first
place.

The person whose push is failing is not a "victim".  Everybody who
pushes is working together with others to advance what is hosted in
the repository he or she is pushing into.

If your work you failed to push is independent from others, then
"fetch-merge-push" will be conflict-less and that is no basis to
complain that you had to do extra work to get your change to the
commons.

If your work does conflict, what does it mean?  It means that other
people did some work in the same area as you just have worked on.
Who are the best equipped to resolve such a conflict?

True, you are not the only one who can understand the conflict.
Those whose work in the same area that caused the conflict may know
the nature of their own changes just as well as you know your
changes, so they are equally qualified as you are.  But you are
among the people a lot better qualified to understand and resolve
this conflict correctly than a random joe who was not involved in
changes that happened during the time your work was done offline
while the shared commons were advancing.

Unlike your view to see conflict resolution is a "burden", implying
"after I push my changes out, it is other people's problem to
correctly integrate their changes, and it will not be my problem if
they break the change I did before they did with the merges", the
workflow Git suggests when it rejects a non-fast-forward push
encourages more effective collaboration by making sure that the
opportunity to integrate _your_ own changes correctly to the shared
common is given to _you_.

Having said all that.

There may be cases where you are far less qualified to resolve the
conflict than other people who were involed in it.  After

    $ git push
    ... results in no-ff
    $ git pull 
    ... results in conflict

the changes that overlap with your work can be found in this:

    $ git log ..MERGE_HEAD

And those who worked on them may know the area you and they both
worked on a lot better than you.  And I fully understand and agree
with you that you and they need a way to communicate and makes it
easy for you to ask them for help.

I however do not think an anonymous "split head" (i.e. 'master' that
is split 47 ways because different people punted on their conflict
resolution and left their work based on older state not usable by
the collective commons) is the best way to do so.  Your option (3)
encourages a workflow where it is OK to punt after saying "I gave
random others to resolve if/when they feel like it", while making
it more difficult for you to communicate those others that are more
qualified to help you---you have to say which one of 47 split heads
you want them to take a look to help you.

Your message to ask somebody for help would say what your changes
were for, what changes from them conflicted with that, and because
you do not understand some of their changes you do not know how best
to adjust your changes on top of theirs (yes, adjusting your changes
to the updated shared commons is what a merge resolution is about).
As a part of that communication, pushing your work, that is based on
an older shared common from their point of view, to a branch whose
name is taken after the topic you were working on, i.e. what your
changes were for, would help (or a non-branch ref, such as
refs/helpme/lasse-<topic>) a lot better than "Hey, here is a random
unexplained half-done work based on an older version of 'master'.
Feel free to grab it and integrate.  I don't bother understanding
and resolving the conflicts with more recent state of the project",
which is how Option (3) seems to be aiming at.
