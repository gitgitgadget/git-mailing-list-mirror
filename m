From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git checkout -b: unparent the new branch with -o
Date: Sun, 14 Mar 2010 19:56:26 -0700
Message-ID: <7vmxyajns5.fsf@alter.siamese.dyndns.org>
References: <1268173713-5224-1-git-send-email-erick.mattos@gmail.com>
 <7vr5nqrpyg.fsf@alter.siamese.dyndns.org>
 <55bacdd31003120845kc980d16s1e6006d56d6f923a@mail.gmail.com>
 <7v8w9whd3g.fsf@alter.siamese.dyndns.org>
 <7v4okkegdy.fsf@alter.siamese.dyndns.org>
 <55bacdd31003141457t7d2cebe3u9854d3c0a55b7da0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 03:56:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr0Tx-0001pz-A2
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 03:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935219Ab0COC4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Mar 2010 22:56:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46225 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934401Ab0COC4e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 22:56:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 86302A1AA9;
	Sun, 14 Mar 2010 22:56:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=41EoWUs3Lj2ambj9HwZQa0u5tKw=; b=wvS3lL
	SC127OdIWrffNIbwQ5BqZANViIfic7VZ3niqWdHN91RkiXPRIBbUKJPgX6rhnQv9
	7z10czywnvdbuEp9GMiFS87ucN6PIj0YqhTTOhB1rAxldJJwMcc/ChCh1Q2IP6KO
	8k9hYFXIGphrjrKmv5XRSmEMgCXBnq2tNbfjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YVqtRhsoN/XKbOLf6cuighjgSqW+CStK
	ozbDcky+mfEUd8zYcbr7Gra2xG+0zKeZk4/pE7e71c4otTpTDF+qyGma+BWw7+se
	PWLNWK/0SPcOH/6FBR76LPjRvk5ca8pZ3xaysrIfN1HmaJCGsG1bJ8pXh/nEAFCq
	wqEtDzGTOtA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E959A1AA8;
	Sun, 14 Mar 2010 22:56:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C80FA1AA6; Sun, 14 Mar
 2010 22:56:27 -0400 (EDT)
In-Reply-To: <55bacdd31003141457t7d2cebe3u9854d3c0a55b7da0@mail.gmail.com>
 (Erick Mattos's message of "Sun\, 14 Mar 2010 18\:57\:22 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5B310B6A-2FDE-11DF-9EDC-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142166>

Erick Mattos <erick.mattos@gmail.com> writes:

> As I see you have found a very good example under your common work
> flow.  Nice. :-)

And realize that it does not help that you nuke the index while leaving
the working tree files.

I do not think you got my point at all, so let's try a different phrasing.
I've already spent too much time on this thread, so this will be the last
message from me on this topic for now.  Hopefully you will understand this
time.

I saw two potential workflows that could be useful:

 (1) "mostly common paths" workflow;
 (2) "no common paths" workflow;

Suppose you are on master branch and creating an orphan branch.  The first
command is this for either case:

    $ git checkout -b orphan --orphan master

The next action the user needs to make before starting to work on
preparing for the first commit on that unborn branch is different
depending on how "checkout --orphan" behaves.  Let's take two extreme:

 - If it kept both the index and the working tree, the user does not need
   to do anything for "mostly common paths", while the user only needs
   "git rm -rf ." for "no common paths".

 - If it nuked both the index and the working tree, the user does not need
   to do anything else for "no common paths", while the user only needs
   "git checkout master ." for "mostly common paths".

Notice that in either of these two implementations, one camp does not need
to do anything other than the checkout itself and can immediately start
working to prepare for the first commit.  The other camp needs to do an
extra thing, but that is limited to one single, simple Porcelain command.
There is no "did you have untracked files? then do this" complications.

If you nuked the index but didn't touch the working tree, which is what
you did, everybody is forced to do extra things, and recovery is not as
simple as the above two extremes.

For people who wanted "mostly common paths", "git add ." would add paths
that were originally shown in the untracked list, so it cannot be used;
they need to either choose the necessary paths and run a series of random
"git add WHATEVER", or "git add ." and untrack unwanted paths with a
series of random "git rm --cached WHATEVER" after that.

For people who wanted "no common paths", "git rm" wouldn't work (as the
index is nuked), and "git clean" will lose originally untracked files;
again they need to give a series of random "git clean WHATEVER".

Either way, everbody suffers, and recovery won't be a single simple
command anymore.

The conclusion to draw is that, among four possible implementations ("keep
both", "remove both", "remove index but keep working tree", "keep index
but remove working tree"), the last two are clearly inferior compared to
the first two.

Between the first two, there are a few pros-and-cons.

 - Obviously, if most people want "mostly common paths", then "keep both"
   would be more helpful, and vice-versa.

 - "keep both" would not need much safety, but "remove both" needs a
   safety-valve implementation (you don't want to lose added changes in
   the index, nor changes in the working tree yet to be added).

So I am inclined to say, unless "no common paths" is the majority of the
use case, "keep both" would be the design to pick.

I didn't see in your long mail any "third" workflow that would be helped
by your "remove index but keep working tree".  All of them were either "no
common paths" or "mostly common paths".  If you demonstrated that a
"third" workflow is the majority of the case, and that "remove index but
keep working tree" would be the most helpful for that "third" workflow,
then you might have made a case that "remove index but keep working tree"
is the right design to use.  But I didn't see any workflow that wants a
working tree full of files that are nothing but untracked cruft.
