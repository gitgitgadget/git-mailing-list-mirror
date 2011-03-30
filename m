From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCH] Make "git notes add" more user-friendly when there are
 existing notes
Date: Wed, 30 Mar 2011 11:59:55 +0200
Message-ID: <201103301159.55573.johan@herland.net>
References: <09668994f10284cfa5243789a627dce8c2325bc6.1301388217.git.git@drmicha.warpmail.net>
 <201103300202.55973.johan@herland.net> <4D92D399.4090404@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 12:00:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4sCF-0004hl-BR
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 12:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755714Ab1C3KAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 06:00:07 -0400
Received: from smtp.getmail.no ([84.208.15.66]:49496 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754925Ab1C3KAG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 06:00:06 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LIV00ISX7S2ZT70@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 30 Mar 2011 12:00:02 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id B39641EEEE28_D92FF22B	for <git@vger.kernel.org>; Wed,
 30 Mar 2011 10:00:02 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 5AB851EEEC9B_D92FF21F	for <git@vger.kernel.org>; Wed,
 30 Mar 2011 10:00:01 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LIV00IGT7S0J100@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 30 Mar 2011 12:00:01 +0200 (MEST)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.1; x86_64; ; )
In-reply-to: <4D92D399.4090404@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170374>

On Wednesday 30 March 2011, Michael J Gruber wrote:
> I'm still wondering how large a
> change we're aiming at, given Junio's remarks. Things I would like to
> throw in:
> 
> * options vs. arguments:
> 
> "tag", "branch" etc. use options for subcommands, e.g. "tag -d", "branch
> -d" etc. "remote", "stash" use arguments, e.g. "remote add", "stash
> list". I don't see us unifying that, but we should decide about a
> direction to go for "new" commands and stick to that. I feel that
> options are the way to go. What I really feel strongly about is that we
> should decide once and then stick to that for future commands (and may
> be gradually revamping).

This is a big discussion, and I don't really have a strong opinion either 
way (or on whether unification of options vs. arguments is really necessary 
at all). In general, I like separating the "verb" of the command (_what_ to 
do) from the "adverbs" (_how_ to do it). For some git commands, the verb is 
right there in the name (e.g. "checkout", "add", "rm", etc.), so the options 
are usually all "adverbs". Other commands, however, refer to one of git's 
"subsystems" (for some very vague definition of "subsystem") as a "noun" 
(e.g. "stash", "remote", "notes"), and the verb needs to be specified 
(either as a subcommand, or as an option). In those cases, I personally 
prefer the subcommand approach ("git noun verb --adverb") better than the 
option approach ("git noun --verb --adverb"), so as to separate the verb 
from the adverbs.

However, some commands (e.g. "branch", "tag") are _both_ "verbs" ("I want to 
tag something") and "nouns" ("I want to add a tag"). By now, I'm thoroughly 
used to "branch -d" and "tag -d", so e.g. "branch rm" and "tag rm" look a 
bit foreign to me, although they probably follow the above principle more 
closely...

Then you have weird cases that further complicate things: "rebase" is 
usually a verb, but in "rebase --continue" or "rebase --abort" another verb 
takes the focus, and I would probably prefer them as subcommands ("rebase 
continue" and "rebase abort").

What can I say? Habits are hard to break, and this might be a case where 
breaking them is more harmful than a somewhat messy command-line interface.

> * singular vs. plural:
> 
> All our porcelain commands are singular even when they deal with
> multiple items (tag, branch, remote, submodule, ...). "notes" is the
> only exception, why not have it be "note"? (That would also open up a
> migration strategy, though the usual suspects may not even bother ;))

True, but would you want to use "note" as a verb or a noun?

  Verb:
  $ git note # to add/edit a note
  $ git note -d # to remove a note
  etc.

  Noun:
  $ git note add # to add/edit a note
  $ git note rm # to remove a note
  etc.

> * "notes message":
> 
> The term seems to be used to distinguish between the content of a note
> and the note object (blob content vs. blob object). A regular git user
> may think it is the commit message in the notes log, i.e.:
> 
> git log $(git notes get-ref)
> 
> I'm wondering whether we should actually expose those note commit
> messages. If notes are shared then editing a note may require an
> explanation just like other commits do, especially when they get used
> for other things than "notes" in the proper sense.
> 
> If we do that, then -m,-c,-C etc. would need to be analogous to "git
> commit -m,-c,-C", i.e. about note commit messages, not about the actual
> note. If we completely discard the possibility that users will look at
> the notes log and write note commit messages, we can use the "regular
> commit message <-> notes content" analogy for the options that we
> partially have now (and adjust -c,-C).

Interesting. Originally, I think "notes message" comes from the initial use 
case of notes being an extension of the commit message. The "notes message" 
is therefore what is shown next to the commit message, i.e. the blob 
content. From that POV, the --reuse-message/--reedit-message options also 
make some sense.

But it is apparent by now that simply extending the commit message will 
probably not be the central use case for notes, and I agree that it makes 
sense to revisit the terminology (both in the documentation and the options 
themselves.)

As you say, -m/-c/-C should probably change to affect the commit message of 
the note commit (and not affect the note content). I'm unsure whether -F 
should follow along, or if we should reserve that for supplying note content 
(binary-safely). I think I prefer the former, and would want a different 
option for getting note contents from a file.

Obviously, copying notes from one object to another is covered by "git notes 
copy", but I wonder if it still makes sense to provide a way to get note 
contents from an existing blob SHA1 (i.e. what -c/-C does today).


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
