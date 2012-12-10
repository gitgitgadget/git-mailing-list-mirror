From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Feature Request - Hide ignored files before checkout
Date: Mon, 10 Dec 2012 12:46:05 +1100
Message-ID: <CAH5451m-JcgLtvVER1UgvsFzemb=otG3XttR4j2s=eFnPrPyEQ@mail.gmail.com>
References: <000301cdd4dd$f8554090$e8ffc1b0$@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Matthew Ciancio <matthew.ciancio16@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 02:47:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ThsSd-0002sB-EN
	for gcvg-git-2@plane.gmane.org; Mon, 10 Dec 2012 02:47:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870Ab2LJBq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2012 20:46:27 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:44145 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab2LJBq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2012 20:46:27 -0500
Received: by mail-qa0-f53.google.com with SMTP id a19so1045575qad.19
        for <git@vger.kernel.org>; Sun, 09 Dec 2012 17:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yHIgDlKQu3jIodcZNMz3Pf0FIANugjre4gkU6k1ZpBg=;
        b=JEuSdeM4pyVUe3uFph38s9iZBpcmP0E540FUh+zrJLSq2GhUBEL0taFpFobfZEFXK6
         qvJJ0AkWZfiOVkvrcLmQjuvsrIQOBJMzjvc8c8TnhywIoEnfoRUeZ3RIikISslJIDMd9
         0FGK7OvTI30D5WcrLZLeeHOZeZtsuiz27ot+64a59L6vG+hkrBJe7Xtcxmo4Bepk/NP7
         I5y9YckV2sgKy2hCiE77oOdxktbkznzMs1Fqz9v4iv9xutOuYNiW+/19ii8R9EIDjdo6
         KBbaNieAzgikoho1BF8l9uCkek3sBQn6UXbr4AxXNkKVGKEWOMH3nRsvBg7MBfzVZIh8
         6oBQ==
Received: by 10.224.189.65 with SMTP id dd1mr23785867qab.79.1355103985601;
 Sun, 09 Dec 2012 17:46:25 -0800 (PST)
Received: by 10.49.14.3 with HTTP; Sun, 9 Dec 2012 17:46:05 -0800 (PST)
In-Reply-To: <000301cdd4dd$f8554090$e8ffc1b0$@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211246>

Hi Matt,

On 8 December 2012 11:50, Matthew Ciancio <matthew.ciancio16@gmail.com> wrote:
> Problem: ignore.txt does not "disappear" like foo.txt does and is now just
> sitting in branchA (and now any other branch I checkout into).
>
> When I first started using Git, I genuinely thought this was a bug, because
> it seems so logical to me that ignore files should hide/reappear just like
> tracked files do, when switching branches.

Let me address this by asking a few questions; *why* do files
hide/reappear, what is the mechanism behind that and does it really
make sense to apply it to ignored files.

For each commit, git stores a snapshot of your files. When we switch
branches we are telling git to restore the previously saved snapshot
so we can work with those files. This means resetting the working
directory so that it looks like what we had committed; git will delete
files that were part of the current checked out snapshot but not the
new one, and create files that need to be created. As a convenience to
users, files that are not tracked are left 'as-is' when switching
branches.

So we see that in order to hide/reappear a file it has to be tracked
in a snapshot, and so has to be committed *somewhere*. An ignored file
is by definition not included in commits, and furthermore you hope to
keep these files out of your commit history.

> I have been told ways of circumventing this (using commits and un-commits OR
> using stash), but my reason for avoiding commits is: say you have binary/OS
> specific files which really do not belong in the commit logs (even locally)
> and hence should be ignored. What if you want those files in only one branch
> and not all?
> Stashing doesn't seem appropriate either, because it would get messy.

I am not sure how viable a suggestion this is, but perhaps you can
have two separate repositories, one tracking your standard branches,
and another tracking the ignored files. These repositories could be
kept in sync through submodules or some similar mechanism. This could
also allow you to, for example, publish the histories of these
independently, for example releasing the non-ignored repository
publicly.
I haven't heard of anyone doing this, but if you need to keep the
history clean it might be a way of achieving it.
I also don't know what the implications of checking out two
repositories into the same tree might be, or even if git would allow
it in general (maybe if you ignored everything belonging to the other
repository?) In any case, this solution could quickly become messy,
but if carefully controlled might solve your problem. Then again,
maybe you can achieve what you want using more 'traditional' git
workflows.

Regards,

Andrew Ardill
