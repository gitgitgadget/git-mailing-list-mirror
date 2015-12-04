From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/5] Split .git/config in multiple worktree setup
Date: Fri, 4 Dec 2015 16:57:14 +0100
Message-ID: <CACsJy8B6hZGn_KW5PeB33bjU6Y5n3Zbuh1YO0McZZg5DRemB0g@mail.gmail.com>
References: <1449083626-20075-1-git-send-email-pclouds@gmail.com>
 <20151203061505.GA4314@wheezy.local> <CACsJy8AOeFEKhhmH-TCK6gWZQAJX0kbTS0-=iyCji9eXwBr9QA@mail.gmail.com>
 <20151203205318.GA10006@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Max Kirillov <max@max630.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 16:57:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4sk2-00018R-E3
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 16:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbbLDP5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 10:57:46 -0500
Received: from mail-lf0-f44.google.com ([209.85.215.44]:33727 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374AbbLDP5p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 10:57:45 -0500
Received: by lfaz4 with SMTP id z4so115033792lfa.0
        for <git@vger.kernel.org>; Fri, 04 Dec 2015 07:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7iSimqc6iAqg+/0yPuQLwVVlGQlfvkImrgsG4RjWdYU=;
        b=ubFeM/ZopSpr0kn8bz8NSAtUM3ujIbIUGDdF5DCti7fpErc01xLxjR1bKvgyu6eqGq
         xF8Ccnf7/rKwuOWvYP7NVRo/R5g74gbnNWL6I0o9RPeoEK6EvwXMxK5BqqH2BgOmA9z0
         /F6qnTBpTUezzTc5TcQayX8T7U10LYYS/aoCmS+5nKU5ZgyHTO1HaV8pKFYfNTiBoPNC
         SF7xN3gjkm4m14R399AibabiIIl+rTGj0gVUVmPs2vZqWV6yPYbI42rW2ZZI4/OJ+Tv5
         AfWyeCynmvUtotr7x5d0xSnBBucebsYoL2bd2UK5DhtgIQG/xIDv2i6OwJzWIS5EU5L4
         CU0w==
X-Received: by 10.25.165.202 with SMTP id o193mr8191341lfe.83.1449244664302;
 Fri, 04 Dec 2015 07:57:44 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Fri, 4 Dec 2015 07:57:14 -0800 (PST)
In-Reply-To: <20151203205318.GA10006@wheezy.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281986>

On Thu, Dec 3, 2015 at 9:53 PM, Max Kirillov <max@max630.net> wrote:
> On Thu, Dec 03, 2015 at 09:07:07AM +0100, Duy Nguyen wrote:
>> On Thu, Dec 3, 2015 at 7:15 AM, Max Kirillov <max@max630.net> wrote:
>>> Using builtin defaults might be confusing for users -
>>> editing the info/config.worktree they must keep in mind the
>>> list of defaults (which they seem to don't know).
>>
>> All per-worktree variables are marked so in config.txt
>
> If I were user I would like the list to be more explicit.

I wouldn't. I mean, I have more than a dozen of git repos lying
around, some I don't even remember where. Should I check git release
notes at every upgrade then fix up _all_ of my repos? That's something
I rather not do.

>>> Also, if
>>> anybody wants to extend the default list (like myself, for
>>> submodules), should they edit the info/config.worktree in
>>> provided template of extend the builtin list? What was wrong
>>> with the default in template?
>>
>> Suppose you introduce a new
>> per-worktree variable in the new git version. If it's in the builtin
>> list, we don't have to update every repo's info/config,worktree.
>
> But how do you see it? Let's, for example, git-N consider
> some variable as per-repository, and user does have it their
> .git/config. Then git-N+1 considers it as per-worktree. How
> does it find the variable while opening some existing
> worktree? Then, if user sets the variable in some worktree
> using git-N+1, git-N will no longer be able to see the
> correct variable value. Does this mean that any change in
> builtin list should cause repository incompatibility?

Behavior differences between git versions have been alway will always
be the problem. Yes providing some forward compatibility (by storing
some logic outside the binary in this case) helps, but I don't think
it eliminates it. If incompatibilities may lead to a big problem, then
we can always make the new behavior an "repo extension" to stop older
binaries from accessing the touched repos.

Most of the time there's only one git version being used. So it should
not be a big problem. But yes, if a repo is shared over network, then
multiple git versions accessing the same repo can happen.

On Thu, Dec 3, 2015 at 8:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I agree with your reasoning to have built-in set of files that are
> per-worktree. I actually prefer *not* to have any configurability
> to avoid confusion between users.

There are a set of variables where whether they are shared or
per-worktree is pretty much preference. For example, core.ignoreCase.
What if I put one worktree on that case-insensitive file system? This
gives the user some flexibility in managing those variables. _But_
they can also manage another way with include.path (or a new variant
that is worktree-aware), with a bit of work.

So killing info/core.worktree is not a bad idea. Even better, we can
avoid pulling exclude machinery in. But yeah, need to sort out the
upgrade issue Max mentioned first.
-- 
Duy
