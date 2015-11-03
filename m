From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [BUG] Wrong worktree path when using multiple worktree
Date: Tue, 3 Nov 2015 17:27:31 -0500
Message-ID: <CANoM8SVOPpOvnykGxfw+dn1Twwe8S=WKfePogx+GRQeAjn6D7g@mail.gmail.com>
References: <5638E79E.10407@morey-chaisemartin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 23:27:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ztk3Z-0003ns-M5
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 23:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbbKCW1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 17:27:52 -0500
Received: from mail-oi0-f43.google.com ([209.85.218.43]:34587 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494AbbKCW1w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 17:27:52 -0500
Received: by oies66 with SMTP id s66so17824268oie.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 14:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1XJNi/dX0UouG5TMzn7StfOwCYwsocdni7VdhoB8Uno=;
        b=imaRUd5aeP26hjjSnVKIeZd79Dmpn5ZT4vFyuKK4ufccURRmdLn9AvON9xw8av71Io
         eY47ltt+iMPRJpUm/PTjEFOO2dohI4YcyPm3ng8UlIIHruSVETRPkilYlJpWHL00A/6a
         UueTxVsKZlCnjvy4mDX4w3kWwiAW5sE1AQ/enZPfxiL+g8XV/G7VxtzpsB+XsUnWkjJ0
         vJPAiy22uS92oS7G1GBIJ73fcfG3NuVKpDXpZvMu2+8qxBw1K9Uiup6KsdJSokmNrxLX
         ljeTSJ8p4ycLziql+7EmuRsed5L2qjB9GvC8TfW1vE9Msq6Y4xpTkRrPemrcsPMNkttQ
         wpQQ==
X-Received: by 10.202.208.10 with SMTP id h10mr19699690oig.124.1446589671364;
 Tue, 03 Nov 2015 14:27:51 -0800 (PST)
Received: by 10.202.79.76 with HTTP; Tue, 3 Nov 2015 14:27:31 -0800 (PST)
In-Reply-To: <5638E79E.10407@morey-chaisemartin.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280828>

On Tue, Nov 3, 2015 at 11:58 AM, Nicolas Morey-Chaisemartin
<nicolas@morey-chaisemartin.com> wrote:
> Hi,
>
> There seem to be an issue with the path computed for a worktree when multiple worktree were created (using git worktree)
> In my Setup, I have 3 repos:
> A/repo (main One)
> A/repo-patches (worktree, using branch dev)
> B/repo (worktree, using branch next)
>
> I'm working in A/repo-patches an run:
> $ git checkout next
> fatal: 'next' is already checked out at 'A/repo-patches'
>
> Which is partially true but not completely.
> I looked a bit in the code and found that the issue comes from here (get_linked_worktree):
>     if (!strbuf_strip_suffix(&worktree_path, "/.git")) {
>         strbuf_reset(&worktree_path);
>         strbuf_addstr(&worktree_path, absolute_path("."));
>         strbuf_strip_suffix(&worktree_path, "/.");
>     }
> Because it wrongfully assumes that I am in the linked worktree.
> I checked in the .git/worktree files and couldn't see anything that actually points to where the repo are setup.
>
> Nicolas

This is code that I worked on, but I am unable to reproduce it locally
just yet.  Before I dig too deep, could you report the contents of
"A/repo/.git/worktrees/repo-patches/gitdir" (or similar)?  There is
another issue reported[1] where the contents of the gitdir for a
linked worktree are overwritten in some cases.  A fix for this is
being worked on (see discussion).

In the mean time, I will continue to try and reproduce.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/280307
