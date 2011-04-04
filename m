From: Lasse Makholm <lasse.makholm@gmail.com>
Subject: Re: [RFC/PATCH] Make "git notes add" more user-friendly when there
 are existing notes
Date: Mon, 4 Apr 2011 13:35:38 +0200
Message-ID: <BANLkTi=PHq=VVuh24S5-QZDXkdW4XVWWQA@mail.gmail.com>
References: <09668994f10284cfa5243789a627dce8c2325bc6.1301388217.git.git@drmicha.warpmail.net>
	<201103300202.55973.johan@herland.net>
	<4D92D399.4090404@drmicha.warpmail.net>
	<201103301159.55573.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Apr 04 13:35:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6i4T-0004Bk-2U
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 13:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806Ab1DDLfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 07:35:40 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:65128 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294Ab1DDLfj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 07:35:39 -0400
Received: by pxi2 with SMTP id 2so1897999pxi.10
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 04:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=tZA0p2bBsD3hdxL3qzlE8SoipGgHXZDinvx5oZb1ius=;
        b=EAEEKc+y6O7WeGSHM78NvemdeC14/uhWECjSiSHmvDBvqHzO2CC23/1/L76dt009ac
         azpzHTEFIvoLNOC1o9GrIFm8YmFoa32dLwKq3Z7Xcsm9006jtTW1czWZzaIXYty3+MSB
         Rs+IhlZKs0CSk8qLCDdfSW3xWMJcVtIpSh0Jg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=rLEssSQGS1Hlq0KxkhtAqWTnDz+Krn7ABGf00BBSIqbw2JJJqljucm1ApKXrjUVKdt
         5kFj7Yhu9xChcXcb/Tyxt3V8/5eWkC1RdohsIbPdV6qYKSu/JXBOh6WnRnyUOQJjTkET
         6fqLx2Ij4xNWPcDrOLu/hf37Ro52V/KPicWdc=
Received: by 10.142.144.20 with SMTP id r20mr6358988wfd.76.1301916938737; Mon,
 04 Apr 2011 04:35:38 -0700 (PDT)
Received: by 10.68.46.39 with HTTP; Mon, 4 Apr 2011 04:35:38 -0700 (PDT)
In-Reply-To: <201103301159.55573.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170803>

On 30 March 2011 11:59, Johan Herland <johan@herland.net> wrote:
>> * options vs. arguments:
>>
>> "tag", "branch" etc. use options for subcommands, e.g. "tag -d", "branch
>> -d" etc. "remote", "stash" use arguments, e.g. "remote add", "stash
>> list". I don't see us unifying that, but we should decide about a
>> direction to go for "new" commands and stick to that. I feel that
>> options are the way to go. What I really feel strongly about is that we
>> should decide once and then stick to that for future commands (and may
>> be gradually revamping).
>
> This is a big discussion, and I don't really have a strong opinion either
> way (or on whether unification of options vs. arguments is really necessary
> at all). In general, I like separating the "verb" of the command (_what_ to
> do) from the "adverbs" (_how_ to do it). For some git commands, the verb is
> right there in the name (e.g. "checkout", "add", "rm", etc.), so the options
> are usually all "adverbs". Other commands, however, refer to one of git's
> "subsystems" (for some very vague definition of "subsystem") as a "noun"
> (e.g. "stash", "remote", "notes"), and the verb needs to be specified
> (either as a subcommand, or as an option). In those cases, I personally
> prefer the subcommand approach ("git noun verb --adverb") better than the
> option approach ("git noun --verb --adverb"), so as to separate the verb
> from the adverbs.
>
> However, some commands (e.g. "branch", "tag") are _both_ "verbs" ("I want to
> tag something") and "nouns" ("I want to add a tag"). By now, I'm thoroughly
> used to "branch -d" and "tag -d", so e.g. "branch rm" and "tag rm" look a
> bit foreign to me, although they probably follow the above principle more
> closely...

Think of it less as the (only) verb and more of it as a domain. In the
domain of a git remote, (add|rm|rename|...) is the action (verb) and
that's why it is and should be a sub-command.

git remote and git stash do it right in my opinion. The default action
differs (list vs. create) but that's OK because so does the most
common use case.

The canonical way to create a stash is to say "git stash create" but
we allow you to simply say "git stash" because that's probably what
you want. It seems then, that the canonical way to create a commit
would be by saying "git commit create" (again, allowing the "git
commit" shortcut).

We could even expand on the heresy and argue that git log should be an
alias for "git commit list"... :-)

My fingers type git branch -d foo by habit as well, but were it to
change, I'd get over it and form new habits. We shouldn't let the
force of mere habits prevent us from doing The Right Thing.

You could argue that git branch -d is broken because -d is, in fact,
not an option at all. If it was, you would be able to say git branch
-d junk feature master to delete junk and branch out feature from
master. But you can't because -d really is a sub-command in disguise.

> Then you have weird cases that further complicate things: "rebase" is
> usually a verb, but in "rebase --continue" or "rebase --abort" another verb
> takes the focus, and I would probably prefer them as subcommands ("rebase
> continue" and "rebase abort").

Absolutely, yes. I don't see this as a weird case at all. In my view,
this is clearly broken just as git branch -d is. Again, in the domain
of a rebase, abort and continue are clearly commands and should loose
the dashes.

> What can I say? Habits are hard to break, and this might be a case where
> breaking them is more harmful than a somewhat messy command-line interface.

As someone, standing on the edge of a 1000+ developer deployment of
git, the option-vs-sub-command issue is one of the many things
currently keeping me up at night. I would take a break in habits any
day to avoid a lifetime of pain teaching people to remember and accept
these inconsistencies...

/Lasse
