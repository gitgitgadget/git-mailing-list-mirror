From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH] worktree: replace "checkout --to" with "worktree new"
Date: Tue, 30 Jun 2015 18:02:38 -0400
Message-ID: <CAPig+cT7X=LOtgYjXWx=EBJpMrytntQHgdSzdN=prqaysanaCw@mail.gmail.com>
References: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com>
	<CACsJy8BYeYq-fQX=M1h2r4daQSsemXQT4Y+ww2Z3Y54brUS3QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 00:02:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZA3c4-0005Au-Go
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 00:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbbF3WCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 18:02:40 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33411 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbbF3WCj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 18:02:39 -0400
Received: by ykdv136 with SMTP id v136so22462341ykd.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 15:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=otofVBciWCoCkYBUyEXuoSaxnrB8xLq0qpp10NzOxsc=;
        b=poLBzPbm0w7rEvP7cQlxDhmjno5oxV3wxE+6Dy3v3RlCfZy4br4jhdUQTeQ3EQvyOh
         krIYcu1S5TKKbuq9NTaDaF9mq4MOfAMwH6WwupOP58RqTJ3bfAbQOjhsoNhM/o1CzRvl
         neFLHqxeEgQp3Q/UxRVOLMfrCkS83CxO4YRHwRwKFTnLHNrkD/DXYjUzZypyY7igD9wp
         uZX26c7huBVps8dAe/o2EYFMSB8k2croxKyUDa9ZrUQy9aDvTNM4ZfQgqD7MVcHHOwnx
         6BeFTl5B+TJwokBB5rdFA5C7HcX/lVM7ueHkyGa3wqX0FhRk9nD3wJP8DIzJFqDh//wM
         xUNg==
X-Received: by 10.129.50.207 with SMTP id y198mr28118062ywy.39.1435701758429;
 Tue, 30 Jun 2015 15:02:38 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Tue, 30 Jun 2015 15:02:38 -0700 (PDT)
In-Reply-To: <CACsJy8BYeYq-fQX=M1h2r4daQSsemXQT4Y+ww2Z3Y54brUS3QQ@mail.gmail.com>
X-Google-Sender-Auth: FhOUN-XPDjx8H-TV-MsxNyZFl0Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273106>

On Tue, Jun 30, 2015 at 5:23 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Jun 30, 2015 at 11:56 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> The command "git checkout --to <path>" is something of an anachronism,
>> encompassing functionality somewhere between "checkout" and "clone".
>> The introduction of the git-worktree command, however, provides a proper
>> and intuitive place to house such functionality. Consequently,
>> re-implement "git checkout --to" as "git worktree new".
>
> I think this is like "git checkout -b" vs "git branch". We pack so
> many things in 'checkout' that it's a source of both convenience and
> confusion. I never use "git branch" to create a new branch [...]
>  "--to" is another "-b" in this sense.

I too always use "git checkout -b", but, like Junio, I don't think
this is an apt analogy. "git checkout -b" is shorthand for two
commands "git branch" and "git checkout", whereas "git checkout --to"
is not.

> "git worktree new" definitely makes sense (maybe stick with verbs like
> "create", I'm not sure if we have some convention in existing
> commands), but should we remove "git checkout --to"? I could do "git
> co -b foo --to bar" for example.

You can still do that with "git worktree new bar -b foo", which is
effectively the same as "git checkout --to bar -b foo" (with
s/checkout/worktree/ and s/--to/new/ applied), though perhaps you
don't find it as obvious or natural.

> If we are not sure about "--to" (I'm not), I think we just remove it
> now because we can always add it back later.

I'm not excited about keeping "git checkout --to" as an alias for "git
worktree new", however, removing it now should not harm us since, as
you say, it can be added back later if needed.

>>  SYNOPSIS
>>  --------
>> +'git worktree new' [-f] <path> [<checkout-options>] <branch>
>
> Should we follow clone syntax and put the <path> (as destination)
> after <branch> ("source")? Maybe not, because in the clone case,
> explicit destination is optional, not like this.. Or.. maybe <branch>
> could be optional in this case. 'git worktree new' without a branch
> will create a new branch, named closely after the destination.
> Existing branch can be specified via an option..

I'm not wedded to this particular argument order, though it does have
the advantage that it's clear which options belong to "worktree new"
and which to "checkout".

As for making <branch> optional and auto-vivifying a new branch named
after <path>, that's something we can consider later (I think).
