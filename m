From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Sun, 13 Feb 2011 14:58:32 -0800
Message-ID: <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
 <20110213193738.GA26868@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 13 23:58:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Poku4-00022T-I1
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 23:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755136Ab1BMW6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 17:58:47 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55271 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753669Ab1BMW6q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 17:58:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 916933C4F;
	Sun, 13 Feb 2011 17:59:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DswBwSR7z4uAnwWmK1Ktyt9LKcU=; b=ZuwQnt
	pBkiVeKd9ZXyQ92/g4PDwIpWQVTnLZ1I05KWIYzUjgFhdp66sbpQoiMacyrvaKJe
	CnyNzDshEkysGfkBbG1eADbUHDKp6VJoipheBVFbhePeGFQGsk0Ed35f+J2o953o
	4yYtKwBsDEjeuGcnKZHYziRQB+hDR8uB/jeEs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RjcprZK6WexP+DKCMxb83uRAs/fH9yBl
	hke/ceFUXQcQgUOljt3l022O8j+Phdr2DTX7p5TisIy46IF+RVIEfFaCSohno1yN
	mVlkZh0MQTY+0VVo9xqU7Emsip23hLlNRdCUzdUR9jScgvKn0BGIxslnlJIRXyH3
	w9kNBCLVgc0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5E4473C4E;
	Sun, 13 Feb 2011 17:59:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A36303C4C; Sun, 13 Feb 2011
 17:59:36 -0500 (EST)
In-Reply-To: <20110213193738.GA26868@elie> (Jonathan Nieder's message of
 "Sun\, 13 Feb 2011 13\:37\:38 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F1F312B6-37C4-11E0-A374-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166679>

Jonathan Nieder <jrnieder@gmail.com> writes:

> If I understand correctly, the intended semantics are:
>
> --index versus --cached
> ~~~~~~~~~~~~~~~~~~~~~~~
> The place where changes for the next commit get registered is called
> the "index file".
>
> Commands that pay attention to the registered content of files rather
> than the copies in the work tree use the option name "--cached".  This
> is mostly for historical reasons --- early on, it was not obvious that
> making the index not match the worktree was going to be useful.
>
> Commands that update the registered content of files in addition to
> the worktree use the option name "--index".

Mostly correct, except the "early on, it was not obvious" part.  It was
very obvious from the early days that unlike "cvs commit" or "svn commit"
it was very useful that you can trust "git commit", after preparing the
index with what is and isn't to be included in the commit, won't pick up
debugging cruft you keep around in the working tree.

"cache" was an old name (and still established name in-use in the code)
for the index.  Some commands make sense to affect both the index and the
working tree (e.g. "apply") and you give --index to mean "both index and
the working tree" while some other operating modes that make sense only to
look at the index, ignoring the potential difference between the working
tree and the index (e.g. again "apply"), iow, taking only the cached
changes into account, are invoked with --cached to mean "look only at what
is recorded in the index".

Some people may find it a good idea to introduce new synonyms --index-only
vs --index-and-working-tree. I personally am not opposed to such a change,
as long as traditional --cached vs --index will keep working for people
who already learned the difference.  These hypothetical new synonyms would
be more descriptive; the necessity to differenciate the two concepts the
two options --cached vs --index try to tell apart is very real, but it was
a hack to use these two particular words --cached vs --index to do so
without trying harder to come up with better words.


> --staged
> ~~~~~~~~
> diff takes --staged, but that is only to support some people's habits.

This one actually needs more historical background to understand why it is
there, as the synonym is not necessary to understand how git works.

Originally, the way to say "what is in the current working tree for this
path is what I want to have in the next commit" was "update-index".  "What
I want to have in the next commit" is "the index", and the operation is
about "updating" that "What I want to have...", so the name of the command
made perfect sense.  "update-index" had a safety valve to prevent careless
invocation of "update-index *" to add all the cruft in the working tree
(there wasn't any .gitignore mechanism in the Porcelain nor in the
plumbing) and by default affected only the paths that are already in the
index.  You needed to say "update-index --add" to include paths that are
not in the index.

A more user friendly Porcelain "git add" was later implemented in terms of
"update-index --add", but originally it was to add new paths; updating the
contents was still done via "update-index" interface.

This changed in v1.5.0, around the beginning of 2007.  Nicolas Pitre among
others realized that git is about tracking contents, not paths, which
meant that "make the content in the working tree at this moment appear in
the next commit" is equivalent to saying "add this _content_ to the set of
contents that make up the next commit".  "git add" learned to accept both
new paths that were not in the index so far and also paths known to the
index that had old contents for them.

Before v1.5.0, we explained the concept as "we update the set of contents
to be in the next commit" (hence "update-index"); since v1.5.0, we explain
the concept as "we add what's in these paths to the set of contents to be
in the next commit" (hence "add").

Notice that there is no need for a new terminology "staged" in the above
description?

The semantics of the index didn't change ever since, modulo small tweaks
like "add -i" (I borrowed it from Darcs) that allows us to say "add parts
of the changed content" instead of the "what's in the file as a whole
right now" were added; these small tweaks didn't introduce any conceptual
change.

The term "stage" comes from "staging area", a term people used to explain
the concept of the index by saying "The index holds set of contents to be
made into the next commit; it is _like_ the staging area".

My feeling is that "to stage" is primarily used, outside "git" circle, as
a logistics term.  If you find it easier to visualize the concept of the
index with "staging area" ("an area where troops and equipment in transit
are assembled before a military operation", you may find it easier to say
"stage this path ('git add path')", instead of "adding to the set of
contents...".

Although I tried to use the word myself in earlier days, I have never felt
that "staging area" is a very widely known term for non-native speakers of
English, and personally have tended to avoid using it.  I find "adding to
the set of contents..." somewhat easier to understand regardless of your
language background, but it may be just me who is not a native speaker.

In short, "stage" is an unessential synonym that came much later, and that
is why we avoid advertising it even in the document of "git diff" too
heavily.  Unlike the hypothetical --index-only synonym for --cached I
mentioned earlier that adds real value by being more descriptive, "staged"
does not add much value over what it tried to replace.
