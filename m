From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: submodules workflow aches
Date: Mon, 19 May 2008 19:55:00 +0100
Message-ID: <320075ff0805191155rd55e36h61924d25c03a65cc@mail.gmail.com>
References: <320075ff0805190756x3adf1684i3980aac15e2ddb88@mail.gmail.com>
	 <20080519181134.GA7928@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "Chris Shoemaker" <c.shoemaker@cox.net>
X-From: git-owner@vger.kernel.org Mon May 19 20:56:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyAWh-0006d3-LJ
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 20:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754942AbYESSzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 14:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755024AbYESSzF
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 14:55:05 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:4858 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754942AbYESSzB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 14:55:01 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1756803fgg.17
        for <git@vger.kernel.org>; Mon, 19 May 2008 11:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=nUTORhgLSbY4IX9aVOz1/UKNVlRh1jxyaeGOtoN35UQ=;
        b=oijxn1Pgtcuo5qBe6xdK5ZT8MGF5olPgjMCKR6MeVkdLdV6G7I/O6afGHMqTH4BoDCNR1FtlUHZLUJQAEUz7T3HR9LHVstrxRXtn3ar/eP9/a2QuHQz50KWyvIIa4/WzojyuZFe0PXHPRRpd0YaJLkltO16EE7xHB6TQipwDbCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NJ+pknq6IR+uhJCrkTGza5Pi7UA3yjA9MJG9zXAiZwJDKA/yXuyYhKzKQufmWQwj88/2xpK5BHynrg7BYbvvWeRHF9uJI0FTjkiF+zTaFJM6O+ko0ViPbcnGfAgmJjyE7E/hg2742G85pmMmyumfijdWLUt0pcA3b/1Ou1yScHI=
Received: by 10.82.107.15 with SMTP id f15mr1044534buc.30.1211223300267;
        Mon, 19 May 2008 11:55:00 -0700 (PDT)
Received: by 10.82.168.20 with HTTP; Mon, 19 May 2008 11:55:00 -0700 (PDT)
In-Reply-To: <20080519181134.GA7928@pe.Belkin>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82440>

>> We've been using submodule support for a few months (and I've been
>> checking out the list to see what other people are doing); it works
>> well, but there's a couple of ache points (in the sense that if I'm to
>> convince SVN users to migrate, they're liable to point and laugh).
>>
>> The first nuisance is the 'get me up to date' stanza of 'git pull &&
>> git submodule update' always leaving you on (no branch), even if you
>> were on [master] before, and the head commit now is also equal to
>> [master]. Having to remember to go into several submodules and do 'git
>> checkout master' to get you back to ready-to-do-work mode isn't nice
>> (and is worse if you're on autopilot, and someone has committed a
>> submodule on a different branch
>
> It might help if you describe more completely how you expect it to behave
> under a wide variety of conditions.  I suspect that the current behavior
> is the simplest behavior that remains correct under all conditions.
>

Oh, I agree. git is actually much more powerful, but it (currently)
requires a lot more faffing for common usecases (unless of course I've
missed some new features, which is entirely possible).

Coming from the svn world, with a project containing many
svn:externals, a 'bring everything up to date, ready to continue work'
is just a case of 'svn up'. In the git equivalent, it seems to be
git pull && git submodule update
(for-each-submodule-that-changed) cd submodule && git checkout master

If module A was on branch [x] before submodule update, and after
update sha1(HEAD)==sha1([x]), couldn't it return the module to being
on branch [x] ?

>> The second nuisance is around conflicts in submodules. If I make a
>> (non-conflicting) change to a submodule, merge with the head and
>> commit, then when I do a 'git pull' in the superproject readiness to
>> do a push, I get a conflict. This is presumably because it doesn't
>> know that the submodule change is a fast-forward. It'd be nice if it
>> could figure that out, and not conflict?
>
> If I follow the scenario correctly, you're essentially pulling into a
> dirty working tree.  I guess you're saying that if the submodule
> wasn't touched by the merge, you'd like it to leave your working tree
> dirty?
>
I find this kinda stuff hard to describe :-)

Superproject SP, Modules M1 and M2

origin:
SP = sha1-x
 m1 = sha1-y
 m2 = sha1-z

User1 and User2 both have SP checked out@sha1-x.

User1 makes a change in M1, commits and updates origin (push) M1 and then SP.

origin:
SP = sha1-xx
 m1 = sha1-yy
 m2 = sha1=z

User2 makes a change in M1 that doesn't conflict with U1. commits and
updates origin M1 (needs to pull then push to automatically merge),
producing sha1-yyy.
When trying to commit SP, push fails. pull then produces a conflict -
SP[sha1-xx] says m1=sha1-yy, and local WC m1=sha1-yyy.
But - sha1-yyy is a fast-forward from sha1-yy, so it should be
automatically mergeable. Maybe. Either way it's a pain - most people
seem to just ignore it and 'git add' each submodule and force the
commit anyway. But it basically happens virtually every commit (unless
you were the last person to do the SP commit and so it's not a merge),
which is annoying especially since I'm asking svn users to replace a
'svn up && svn ci' with an equivalent in the module /and/ the
superproject /and/ to merge a (to the user irrelevant) conflict.


>> Are people writing their own wrapper scripts for this? I find I have a
>> hard time explaining why it's all necessary to svn users who just (by
>> and large) do 'svn up' and 'svn ci' on projects..
>
> I'll throw out one nuisance that I hit, perhaps related to your second
> one: in the super-module, rebasing a series containing a submodule
> update.  I start the rebase with a clean working tree, but since the
> rebase doesn't update the submodule, (which I wouldn't really want it
> to do anyway) the rebase aborts in the middle with:
>
> $ git rebase --continue
> plugin/submodule: needs update
> Working tree is dirty
>
> forcing me to "git submodule update" in order to continue.
>
> Then, when the rebase finishes, my working tree is dirty again because
> the submodule is out-of-date, so I have to "submodule update" AGAIN.
>
> Am I just missing the much better way to do this?
>
> -chris
>
