From: Nicolas Noble <pixel.nobis@gmail.com>
Subject: Re: [BUG] git-svn returning "Incomplete data: Delta source ended unexpectedly"
Date: Wed, 25 Aug 2010 11:31:07 -0700
Message-ID: <AANLkTi=QUiwUOAZtq_-c=D3S+AuFdZb9PEohVmYW+suW@mail.gmail.com>
References: <AANLkTiljzOuaEToKscBxlc4qGilyNRiUtjoBxW1lJZlp@mail.gmail.com>
	<20100714210940.GA7803@dcvr.yhbt.net>
	<AANLkTil-QOQHNYIRvqDzfwicjo9SLXJPwgby-Z0b9rlT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 20:31:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoKkl-00060M-Sf
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 20:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007Ab0HYSbL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 14:31:11 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:41560 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787Ab0HYSbJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Aug 2010 14:31:09 -0400
Received: by ewy23 with SMTP id 23so524774ewy.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 11:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Or66zc0bKj4EZ/ge1q8KzRdk+jemKvOWvnQdJjaNtlk=;
        b=Qc9rzltS1C7clGkntqlIL4CunurhiheNOhII4FacoBQ9sMB1hO8dY7fnY/SqGPXfkw
         tedBI4hlCX5OYm1NZzObhLnNaSloWtN7paeroGkTp5zVUnp4m7JJGeJTZNCFarZx/9lf
         3HHkfr73uunQ2LQI7dpJdpCsJc1sJEHlS1DAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pH8zJHFDFK+mo1+uqRyYfGJGoxoJkJL0OSsKqNc9JtBO+RkJxzxgFdY0G1ZWdNIIfi
         k/RQm4A5G4IgT0YJFrseA+lnBCrTzKNzeuugfp3MPjEihHIZkSbXxnNt/emlX+whzgId
         wEEQ04AuweOYeIeeP63SJzKFyxzP1FQjTrstM=
Received: by 10.216.7.78 with SMTP id 56mr1128567weo.96.1282761067823; Wed, 25
 Aug 2010 11:31:07 -0700 (PDT)
Received: by 10.216.4.67 with HTTP; Wed, 25 Aug 2010 11:31:07 -0700 (PDT)
In-Reply-To: <AANLkTil-QOQHNYIRvqDzfwicjo9SLXJPwgby-Z0b9rlT@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154458>

Hello,

  I'm bumping this thread, as our git-svn mirror at work broke down
with the same exact problem. Now, rebuilding it wasn't exactly an
option, and I rather went the "restore backup" way, but my management
feels a bit nervous about git now since this issue hit us, and I
wasn't able to fix it in any way.

  Basically, at our company, we're having subversion to track our
software codebase, but I'm trying hard to make people move to git. My
biggest (quite successful) attempt so far is to have a git-svn
"gateway" machine that people can clone in order to work on their own.
They don't have the right to push back, as it would obviously break
with the way git-svn works, but I take care of rebasing their commits
if they need to, in order to push them back onto the subversion. So we
have two sets of developers: one working with git, and one still with
svn. I'm having a crontab job that's using git-svn fetch every 2
minutes in order to get the gateway in sync at all times; the git-svn
rebase part doesn't really apply, as the point is to create local
branches from the subversion snapshots.

  Now, yesterday, that exact issue described below hit us. But unlike
what's described below, both the git and svn history match perfectly.

  Unfortunately, I can't upload the git repository anywhere, but as
far as I could see, there's indeed some blobs that don't match. But
for the life of me, I have absolutely no idea how to fix this without
going the backup way. I've tried to roll-back the remote branch to the
commit before, by hand-editing .git/refs/remotes/trunk,
=2Egit/packed-refs, .git/info/refs and .git/svn/.metadata, running git
gc --prune in order to make sure I get rid of the corrupted blobs, and
re-running git svn fetch, but that didn't help. Probably because the
corruption happened even before, but then, I have no idea how to find
and fix this. I tried going back several days before, but no luck. And
the worst part is that I tried to skip over that commit, just to see,
using git-svn fetch --revision=3Dxxxx and pointing at some revisions
after that, but ALL of the revisions I tried did the same thing, which
would tend to indicate that... everything is corrupted ? There's
something fundamentally wrong here, where I'm actually trusting
git-svn fetch to do the job properly and work at all time, yet it's
not.

  Again, I can still restore backups, but my management would feel
much better if this issue was fixable instead. And the bad part is
that by backup, I mean I was running another git-svn mirror in
parallel on another machine, but for some reason, they diverged in
history. There's one commit message long time ago that didn't get
fetch from the subversion repository the same way, and from it, the
two history diverged. The delta of that commit itself is fine, but the
commit message got truncated. Which is of course going to have me
breaking any branches people created, and I'll have a very fun time
rebasing everything now :-)

  I don't know exactly what kind of information I could provide in
order to troubleshoot, without disclosing our sourcecode, but if you'd
like to investigate this, I'd be happy to help and provide as much as
I can, as long as you describe what you'd need me to do.

  Thanks!

  -- Nicolas Noble

On Wed, Jul 14, 2010 at 3:16 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Wed, Jul 14, 2010 at 21:09, Eric Wong <normalperson@yhbt.net> wrot=
e:
>
>> Something went wrong with your mirror script (the way you're doing
>> externals is probably screwing it up, badly).
>>
>> Compare the "git svn log" output of your in-progress repository
>> with the "svn log http://josm.openstreetmap.de/svn/trunk"
>>
>> The revision numbers/commit messages don't sync up at all.
>
> Sorry for the false alarm, I didn't check that. Thanks for looking at
> it, and sorry for wasting your time.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
