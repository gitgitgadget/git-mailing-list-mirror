From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git checkout -b: unparent the new branch with -o
Date: Fri, 12 Mar 2010 23:53:23 -0800
Message-ID: <7v8w9whd3g.fsf@alter.siamese.dyndns.org>
References: <1268173713-5224-1-git-send-email-erick.mattos@gmail.com>
 <7vr5nqrpyg.fsf@alter.siamese.dyndns.org>
 <55bacdd31003120845kc980d16s1e6006d56d6f923a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 13 08:53:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqMAJ-0002tk-Sj
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 08:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756697Ab0CMHxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 02:53:35 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61733 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599Ab0CMHxd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 02:53:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 26CF3A1049;
	Sat, 13 Mar 2010 02:53:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Sglp/IpmzalB52V+RxuUqEqS33Q=; b=F0Lgc5
	YPyQKvvQnrH5+fLR8hEZkl7vF9y9sfxQ3TeQL6QEXE9gg4Esvhk/FotakQ4hAcvf
	xzbkwhHD2vVqOxIiebUhTjK5zlP5jWZ23sraNeojNbpe4MpdsrahmQpXMjpYaWlV
	PT51rJKNIPlxgPLR8As+O7XDy/pXPPx7Ttm2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dAHLEpZqPyFkjH3FKrbJbp8t1k3+8ZQF
	plrgkzphtldEzW53AaQyNnKPUmReWVfQWlHvrzAAiQRgYMIkhFkUkEgkpsskOBrm
	EUUAt8eUtxb93zcRB7D3MhdCb7VM68cJBRswOEO/GivElpl360/7Vm1HfuvJIcbt
	06Owy/suij0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 019AFA1048;
	Sat, 13 Mar 2010 02:53:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C6C16A1047; Sat, 13 Mar
 2010 02:53:24 -0500 (EST)
In-Reply-To: <55bacdd31003120845kc980d16s1e6006d56d6f923a@mail.gmail.com>
 (Erick Mattos's message of "Fri\, 12 Mar 2010 13\:45\:17 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8316B98C-2E75-11DF-B657-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142090>

Erick Mattos <erick.mattos@gmail.com> writes:

>> The use case in your commit log message wasn't convincing either. If such
>> a new branch will be merged later, especially if the trees of the commits
>> in newly rooted history resemble the trees in the original history (I am
>> guessing that is the intended use case, as you do not seem to be removing
>> anything from the working tree---how is the user expected to use them by
>> the way?), not having a common merge base will make the merge harder, not
>> easier, and later examination of the history (think "bisect") also
>> harder.
>
> Are you talking about the commit log message of the previous version
> patch?

I was referring to this from the latest version:

    Sometimes it is necessary to start up a new development branch of code
    intended to be merged in the near future to existing branches but which
    actually does not relate to them.

Let's give you an example of the depth of thought and clarity of
description of the workflow I am expecting from anybody who claims "this
is a useful feature to help _some_ workflows" by taking an example from
git.git, because it is one project that both of us are familiar with and
there is a readily available example in it.  It has disjoint merges from
gitk, gitweb and git-gui.  The history up to such a merge 5569bf9 (Do a
cross-project merge of Paul Mackerras' gitk visualizer, 2005-06-22) looks
like this:

 A---o---?---o---o---X---* linus
          .             /
           B---o---o---Y gitk

Note that with this merge '*', two histories merged did not share any
paths at commit X and Y.

Did you have this kind of "no common paths" merge in mind when you wrote
the proposed commit log message?  IOW, if we pretend that Paul started his
gitk work and he "intended to be merged to Linus's branch but which does
not relate to it", would that be a good example of what you are trying to
achieve?

    Side note: The other two "disjoint" merges we have are also this kind
    of "no common paths" merge.  Nobody who was involved in the branches
    that resulted in them prepared his branch with --orphan, by the way.
    They started out in independent repositories, because they were by
    definition independent projects and these were "cross project merges",
    as Linus put it.

I'd grant you that we could say that these histories did not start in the
same repository using "checkout --orphan" because it was not available.
But in that case, it would have been nicer if Paul didn't have to remove
files came from Linus's branch, left by your "checkout --orphan", by hand.
"rm -rf" would not have been very useful, especially if he had some
untracked files that he never intended to commit to git project but did
not want to lose (think of "Notes" "memo" "todo" files you would keep in
the source tree).  The most natural way to keep these untracked files
while removing now-unneeded tracked files in the Linus's git when he
switched from using "checkout --orphan" would have been to use something
like "ls-files -z | xargs -0 rm -f".  But you are nuking the index without
removing the tracked files, so that becomes impossible.

On the other hand, Paul could have started his gitk branch from a copy of
git Linus had published.  Even though gitk was developed with an intention
to run with any version of git available that was installed idependently
on the system, it did depend on git and it would have made equal amount of
sense if he shipped with a matching version of git, saying "this version
of gitk was tested with this git".  If that were the case, paths at commit
X and Y would have been overlapping.  In fact, gitk has been a single-file
project for a long time, so most of the paths were the same and Y would
had one file more than X.

Did you have this kind of "mostly common paths" merge in mind when you
wrote the proposed commit log message?  IOW, if "checkout --orphan" were
available to Paul, would you have recommended him to use it, add his gitk
script to the tree, and start his history at commit B which he started
from commit '?' from Linus's history?  But you are again nuking the index
so Paul would have had to add the files back with "git add", while being
careful not to add untracked files, or run "git read-tree ?" to populate
the index back to the original state.

> I am not wiping the tree by default because I am not deciding for
> people if they are going to use anything from it as a template (even
> the directory structure only).
>
> I am not trying to make decisions for the user.  I think he would be
> capable of deciding it himself.  That is my way of thinking so I
> normally prefer to advice, alert, inform not to impose.

You may think that you are supporting both, but in reality, you are
supporting neither by making both cases equally inconvenient.  The only
thing you are gaining is a way to weasel out of issues experienced by the
users by saying "I didn't remove anything from the working tree, so if you
want to add them, you can, it is up to you", while ignoring the issue that
(1) if the user wants "no common paths", cleaning working tree becomes
cumbersome and error prone, and (2) if the user wants "mostly common
paths", adding back to the index becomes cumbersome and error prone.

As I already said, I do not think "mostly common paths" case should be
encouraged to begin with.  As far as I know (and you can guess by now that
I know reasonably well about git), you do not gain anything by not having
the ancestry link between '?' and 'B', except that it would make conflict
resolution at '*' extremely difficult.  There is only downside without any
upside in "mostly common paths" disjoint merge.

That leaves only the "almost no common paths" case.  As we have already
seen in git project, the end result is indeed very useful.  It used to be
that people had to download and use gitk independently before Linus's
cross project merge, but after the merge, the project gives the core git
and gitk comes with it.  So you could argue that "checkout --orphan" would
become useful if you adjusted the code like I suggested in my review
comments (run an equivalent of "git rm" without "-f" from the top-level
and make the HEAD dangling to the new branch, only if the "git rm" step
succeeds), and document clearly that is the intended workflow for the new
feature to support.

But stepping back a bit, you would realize that the usefulness of the end
result of these existing "disjoint merges" does not come from the fact
that the side branch was initially a disjoint history from the main
branch.  The usefulness of the end result comes solely from the fact that
we managed to merge such a side branch.  If Paul started gitk by forking
Linus's git, adding gitk script, _without_ making the history disjoint,
the result of the merge would have been equally useful.

The only reason the early part of gitk's history is independent from git
is because Paul nor Linus did _not_ have any plan to merge these two
histories.  Lack of foresight is not a crime, so it is perfectly fine if
you have to merge histories that started separately, but if you do plan to
merge the future, starting the branch as a disjoint history is a crime--it
does not help anybody.

Up to this point, I:

 - described possible two workflows ("almost no common paths" and "mostly
   common paths") that "checkout --orphan" _could_ support;

 - explained why neither makes sene; and

 - explained why your implementation does not support either one well,
   even if one or both of these workflows made sense.

Now, do not take the above as a personal criticism.  The only thing the
above discussion may be showing could be that your description was not
clear enough to tell me that the workflow you had in mind to support was a
third one, different from the above two, and that your implementation may
support that untold workflow very well.  Take the above as an illustration
of how you present the workflow your new feature intends to support, and
how you choose your design and implementation to support that workflow
well.

So let's hear it.  Until we clear the design issues, there is not much
point in talking about coding styles and implementation.
