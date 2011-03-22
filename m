From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: How to remove a git subtree and its history?
Date: Tue, 22 Mar 2011 13:44:53 -0700
Message-ID: <AANLkTiktAUeOkX0MZh+JbQb1z-JiN=Qet6_AuWavsNk=@mail.gmail.com>
References: <4D88A1CB.2000500@jku.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Robert Pollak <robert.pollak@jku.at>
X-From: git-owner@vger.kernel.org Tue Mar 22 21:45:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q28S8-00026n-MA
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 21:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169Ab1CVUpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 16:45:15 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:42726 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110Ab1CVUpN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 16:45:13 -0400
Received: by vxi39 with SMTP id 39so5894713vxi.19
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 13:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=ZeuB5BHN35/RVCEpfIOCEXMe+M0tG3HWDC9NrNbDIo0=;
        b=vHTxKqUuqn1xUQpiFgkz8HEuflUreEhuElHYRAbdMIziAmLWq+lcJc9lOKhiDOFTkx
         0SwZC2Htba0xNYVpKnUMRWmLw/SisPRd24cUrrjOg6ffCOPT+6Q0RYAivld6WM6G7clR
         SHs6E+MMKOtgxvbriA3Qs76HzkkEB5cIOrW6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Psf/jzGnbMof1hF/WJhKKAwYM8hFgQSMEkNZ7xMsl0nGa/l0Z8W/YTCNFunmkNOtqk
         qXyf3XUcQag4D7AqVsX1gSe4oM8lS4ZoSJ7/17BK8fxdLjGn3AoxXeBShBYF6wuezi+7
         zduhtShFo2rUFfNVnIMyyQNAZhXozBlHvab+k=
Received: by 10.52.179.69 with SMTP id de5mr5527030vdc.304.1300826713150; Tue,
 22 Mar 2011 13:45:13 -0700 (PDT)
Received: by 10.52.155.74 with HTTP; Tue, 22 Mar 2011 13:44:53 -0700 (PDT)
In-Reply-To: <4D88A1CB.2000500@jku.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169774>

On Tue, Mar 22, 2011 at 6:19 AM, Robert Pollak <robert.pollak@jku.at> wrote:
> in the git repository of my project I have successfully replaced a git
> submodule by a subtree, essentially by using
>
> $git subtree add --prefix=mySubtree mySubmodule/master
>
> with your git-subtree.sh .
>
> Before accepting my change, my project partners want to be sure that
> removing this new subtree and its history at some later point in time
> stays possible. How can I achieve this? I have unsuccessfully tried "git
> filter-branch" as described by pgs and fmarc in
> http://stackoverflow.com/questions/955793#955793 .

Well, you can certainly remove anything you want with git
filter-branch.  Are you concerned about shrinking the size of your
repo, or just getting files out of the way in your tree, or removing
stuff from the git history?

If you want to avoid cluttering the git history, you should use git
subtree with the --squash option.  That makes it quite painless.

If you want to just get the files out of your tree someday in the
future (for example, to switch back to submodules), then simply 'git
rm -r' the directory.  Rewriting history is massive overkill for this.

If you want to be able to shrink your repository size later, well,
then you need git filter-branch.  I've never tried to do this since
the history rewrite you'd be doing in this case would completely
invalidate all your old history: by removing the subtree in all past
revisions, you make all those past revisions unbuildable, which seems
like missing the point of version control.  Nevertheless, I'm sure you
could make it happen if you wanted; you can do pretty much anything
you want by filtering git history.

> (Be free to CC git@vger.kernel.org if you reply, if you think that's
> appropriate for archiving the info.)

I don't understand why you didn't cc: the git list yourself then.  But okay :)

Have fun,

Avery
