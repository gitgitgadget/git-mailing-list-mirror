From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: Re: Handling tags/branches after git-svn fetch during SVN to Git 
	conversion
Date: Thu, 8 Jul 2010 22:33:40 -0400
Message-ID: <AANLkTinSdinuL_ZiDsQ9b3wBaJGXRGn5BveS7dRbLZfW@mail.gmail.com>
References: <AANLkTim56UOYQJfX3M5Jpt0vXD8iTnkLuG68IjQG39Xn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 09 04:33:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX3PS-0000gW-UT
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 04:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039Ab0GICdo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jul 2010 22:33:44 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42612 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753876Ab0GICdn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jul 2010 22:33:43 -0400
Received: by qwh6 with SMTP id 6so371735qwh.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 19:33:40 -0700 (PDT)
Received: by 10.224.11.12 with SMTP id r12mr5106151qar.0.1278642820496; Thu, 
	08 Jul 2010 19:33:40 -0700 (PDT)
Received: by 10.229.38.133 with HTTP; Thu, 8 Jul 2010 19:33:40 -0700 (PDT)
In-Reply-To: <AANLkTim56UOYQJfX3M5Jpt0vXD8iTnkLuG68IjQG39Xn@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150629>

I posted this question to StackOverflow and got back that I should use
the svn2git tool. Surely there has to be a native way to convert these
branches into local branches using git-svn.

http://stackoverflow.com/questions/3206383/what-is-the-correct-way-to-c=
onvert-svn-remote-branches-and-tags-into-local-git-br

On Wed, Jul 7, 2010 at 9:36 AM, Bradley Wagner
<bradley.wagner@hannonhill.com> wrote:
>
> I had a fairly complicated config for my SVN to Git migration with
> multiple branch and tag locations. Therefore, I had to break up the
> "git svn clone" because I didn't know how to pass multiple branch
> locations to "git svn clone":
>
> 1. git svn init
> 2. Update .git/config with branch/tag locations
> [svn-remote "svn"]
> =A0 =A0 =A0 =A0url =3D file:///Users/Developers/git_transition/svn_re=
po
> =A0 =A0 =A0 =A0fetch =3D project/trunk:refs/remotes/svn/trunk
> =A0 =A0 =A0 =A0branches =3D
> project/branches/{feature1-branch,feature2-branch}:refs/remotes/svn/*
> =A0 =A0 =A0 =A0branches =3D
> project/branches/{6.x,5.x,4.x,3.x,archive}/*:refs/remotes/svn/*
> =A0 =A0 =A0 =A0tags =3D project/tags/{3.7.x,4.x,5.x,6.x,old-releases}=
/*:refs/remotes/svn/tags/*
> 3. git svn -A/path/to/mappings fetch
>
> Do I need to convert these remote tags/branches into local Git
> tags/branches before pushing them to my remote Git repo or is there a
> way to push remote branches directly to my remote Git repo?
>
> The command that someone else told me was "git checkout -b
> <local_branch_name> <remote_branch_name>". Though, I've seen other
> places mention different strategies for converting the branches.
>
> The script I devised to convert the tags does this for each tags
> folder to maintain the original commit date, author, and commit
> message:
>
> git for-each-ref --format=3D"%(refname)" refs/remotes/svn/tags/6.x |
> grep -v @ | while read tag; do GIT_COMMITTER_DATE=3D"$(git log -1
> --pretty=3Dformat:"%ad" "$tag")" GIT_COMMITTER_EMAIL=3D"$(git log -1
> --pretty=3Dformat:"%ce" "$tag")" GIT_COMMITTER_NAME=3D"$(git log -1
> --pretty=3Dformat:"%cn" "$tag")" git tag -m "$(git log -1
> --pretty=3Dformat:"%s%n%b" "$tag")" ${tag#refs/remotes/svn/tags/6.x/}
> "$tag"; done
>
> Please let me know if this is correct.
>
> Thanks!



--
Hannon Hill - Put Us to the Test
bradley.wagner@hannonhill.com | http://www.hannonhill.com
