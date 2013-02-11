From: Ethan Reesor <firelizzard@gmail.com>
Subject: Re: Pushing a git repository to a new server
Date: Mon, 11 Feb 2013 02:57:51 -0500
Message-ID: <CAE_TNin6-weutRDToZ7-BBGJTCcf0dwJn0ChUbFcACRU=SbjzA@mail.gmail.com>
References: <CAE_TNin0Kb_38gnx9W36VZ8CTxYBZ9T1Dkhar1DUFHyQUq7ebg@mail.gmail.com>
 <20130211075040.GJ5210@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Cc: git <git@vger.kernel.org>
To: Konstantin Khomoutov <kostix+git@007spb.ru>
X-From: git-owner@vger.kernel.org Mon Feb 11 08:58:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4oHc-0001wZ-6m
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 08:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817Ab3BKH6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 02:58:13 -0500
Received: from mail-qc0-f169.google.com ([209.85.216.169]:60908 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654Ab3BKH6M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 02:58:12 -0500
Received: by mail-qc0-f169.google.com with SMTP id t2so2144578qcq.0
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 23:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=qgWxfwogHKabQScP69OOu7KemaHH9599d/hjFEi9tkw=;
        b=C5de/6UF7jmFXAOwVSk8JtBQ6LvOqA274QkwLenoGb1ySxaXPOmaTVkyvplwXUtUPK
         5cgm+9UjVouIdPVkq9F+//ycCizINgBfp1+PtV6ihzfSe0k833NDM1eeVVJDMC/H8H+7
         jXhanHH4lqOJt7clqcDUCrCLff4yrm7DZX+ce3fzFuLK8t1e9EB7y6HZqSDuUqbDAE90
         PbFWJXApdpiXhpz/tmgC4p/gXA763nlM0X9xDZYamETOSnPTUwJnO3GLDxBlek9tomq0
         bW7Jguv1r3aL+nagr6NIeQ22AxbtCMucB27RaO7GES4Y/SKvgfB+iMMUzRTEot/d+tLh
         GvMA==
X-Received: by 10.229.178.232 with SMTP id bn40mr1226705qcb.44.1360569491327;
 Sun, 10 Feb 2013 23:58:11 -0800 (PST)
Received: by 10.49.95.225 with HTTP; Sun, 10 Feb 2013 23:57:51 -0800 (PST)
In-Reply-To: <20130211075040.GJ5210@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216021>

On Mon, Feb 11, 2013 at 2:50 AM, Konstantin Khomoutov
<kostix+git@007spb.ru> wrote:
> What's wrong with
> $ ssh myuser@remotehost 'mkdir /path/to/MyRepo.git; cd $_; git init --bare'
> $ git push --all git@remotehost:MyOtherRepo.git
> ?

Nothing, I just wanted to make myself a command to do that for me.

>> The reason I had to use my user is the git user's shell is git-prompt
>
> There's no such thing as git-prompt.  The restricted login shell for
> SSH-only access typically used for such a "virtual" Git user is
> git-shell.

Sorry, git-prompt is something I made for myself. I meant git-shell.

> It's not really clear what do you want to achieve.
> The reason the git-shell shell is *restricted* (read its manual page)
> is to shrink the surface of possible attacks in the case the shell
> account used for accessing Git repos over SSH is compromized (the key or
> password stolen, for instance).  This is achieved by only allowing
> commands like git-upload-pack etc in the shell (no general file
> manipulation commands etc).  So what creating "git command that can
> talk to the server using git-prompt ..." would really buy you?

I want to create a git-command that 1) creates a bare version of the
current repo, 2) and uploads it to the specified path on my server
(using tar, but that's not the point).

My problem is that I have no idea how things like git-push works via a
user with git-shell. Can you only run certain git commands, like
git-upload-pack? Because I tried running 'ssh git@server git status'
and that failed.

> I think the way to go is to start using gitolite [1] or implement by
> hand a subset of what it does (a custom login shell which is allowed to
> do certain things in a special area of the filesystem designated to keep
> Git repositories) or just set up a special account on the server
> ("git-admin", for instance) which would have a regular login shell set
> for it and would be in the same group as the user "git" (or even have
> the same UID) so that they could share the files they create (subject to
> active umasks of processes run as both users though).

I thought about the secondary user idea. I decided that trying to make
my own command would be more fun.


-- 
Ethan Reesor (Gmail)
