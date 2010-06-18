From: Joshua Shrader <jshrader83@gmail.com>
Subject: Re: Fixing branches from a (really messed up) subversion repository
Date: Fri, 18 Jun 2010 17:40:58 -0400
Message-ID: <AANLkTin0zwH8KLr9Cem-piRZ0mn9Q9ZScmFJF2r_DTi4@mail.gmail.com>
References: <AANLkTinmU3tOkv9usjGogHn5cXm07FMde8ryDKuWNKD_@mail.gmail.com>
	<AANLkTink-Rm44xnzBHVo6W_29YCPrjScnolqx_9B8A5G@mail.gmail.com>
	<AANLkTim6pBqc1qQhvGrzmf5FDbVkfw1GmNP00BM_99n4@mail.gmail.com>
	<AANLkTin268tbt5E2flbzwq8Rik0D21Uf4t2z-5fgb4BZ@mail.gmail.com>
	<AANLkTingIuZQ8BB9NW0UpGt7a9uccnBX0_R7YZwJpVsd@mail.gmail.com>
	<AANLkTimxivcSShukg0kFPF_7ignIv3d3TUl8KELKUksF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 18 23:41:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPjJE-0000lS-Ao
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 23:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930Ab0FRVlB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jun 2010 17:41:01 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42983 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126Ab0FRVlA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jun 2010 17:41:00 -0400
Received: by gxk26 with SMTP id 26so186695gxk.19
        for <git@vger.kernel.org>; Fri, 18 Jun 2010 14:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EjKSd/IJcC4Yb5RmXt0yd1uncgwVXLPnkmu233gB2h8=;
        b=ZHq/J6NYClxRGSOovCqBNBtG6jIwtN+2MpZksGmnGUAvCLP0Tfa9TKtUnG5EXY56J0
         EGLSGUJWszKVSz5liso/hQkcwd0KKpyzD5erF3x28+8TGLiESulaHtACdzwG13MsfLGA
         pwsiGuoLvL7jbzITkCwrKCIKJjdxdsNefb+GE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fBqMmqT/7aNruDZoGOHQGXQSDKTK2QlTlcTJlvbG9uVXnkLkt2CGYIOQeE1PPpxhs8
         eTV92INRldISoky6uqRIAv82RpLaHhT8pKYzhQcsSpYuKsk/htE5k7bYSPJ2DD7zihO0
         lc9OYTcOf7E+/9aRFOS2py89AbjF5TODxmJh0=
Received: by 10.220.80.75 with SMTP id s11mr708349vck.58.1276897258922; Fri, 
	18 Jun 2010 14:40:58 -0700 (PDT)
Received: by 10.220.106.167 with HTTP; Fri, 18 Jun 2010 14:40:58 -0700 (PDT)
In-Reply-To: <AANLkTimxivcSShukg0kFPF_7ignIv3d3TUl8KELKUksF@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149366>

I started with svnadmin dump /path/to/repo > svn.dump.  Then I had to
manually edit svn.dump (I'm sure someone smarter then me could roll
this into the Perl script I used in the next step) to create a "trunk"
and "branches" directory in the first commit.  I found the commits
that added "trunk" and "branches" when we re-organized our repo to
follow this convention, and deleted them.  Then I had to locate where
all of the branches were created - looked like

Node-path: branchname
Node-kind: dir
Node-action: add
Node-copyfrom-rev: 23
Node-copyfrom-path:

and change that blank "Node-copyfrom-path: " to "Node-copyfrom-path:
trunk".  The blank path is what really caused issues because everytime
a branch was created, it would contain copies of branches which
contained copies of branches, etc...  So branch2 had a subfolder
branch1, and branch3 contained branch2 and branch 1, where branch 2
contained branch 1...

Then, I removed all of the contents of the commits (not the commits
themselves) where we re-organized the repo.  i.e.

Node-path: trunk/src
Node-action: add
Node-copyfrom-ref: 23
Node-copyfrom-path: src

and the ones where we deleted nested branches and moved the individual
branches into a "branches" directory.

I made these edits and saved them.  Then I ran that file through a
perl filter, tried to svnadmin load newrepo < filteredDumpFile, and if
I got errors, I iterated - changed the pre-filtered file, blow away
the svn repo that gave me an error during load, re-create it, and
re-load.  I iterated this over several days, as I discovered more and
more inconsistencies with my edited dump file.  I think I have all of
the steps above, but I may be missing one or two, and if I am, I
apologize.  I'd imagine everyone's situation would be a bit different,
so adjust accordingly.

Now, I'm quite the Perl hack so I doubt you want to look at the
script.  It essentially did the following:

Read each line of the dump file.
If the line doesn't start with "Node-path:" or "Node-copyfrom-path:",
then just print it un-altered.
If it does,
  does what follows the ':' start with "trunk", "branches", or "tags"?
 If so, then just print un-altered.
Otherwise,
  for each $branchname(@branchnames) if what follows the ':' begins
with $branchname, replace it with "branches/$branchname", and print.
If none of the branch names match,
  prepend "trunk" to the beginning of the path, and print.

This essentially re-writes all of the paths so that everything not in
a branch, or already under "branches", "tags", or "trunk", is put
under trunk.  It also moves all of the /branchenames to
/branches/branchnames.

After this, we did
svnadmin hotcopy repo repo-backup
rm -rf repo
svnadmin create repo
svnadmin load repo <filteredDumpFile

Changed the ownership to match the ownership of the original
repository, copied over the contents of the repo-backup/hooks
directory into the new repo/hooks, and we were all set.

git svn clone --stdlayout... then worked fine.  Now I just need to
work on a workflow for my co-workers how want to also use git (i.e.
create a bare git repo, and keep that in sync with the git-svn repo).
Ideally, all of us git users can clone the bare repo and push to it,
then every once in a while, I can pull from the bare into the git-svn
repo, and do a dcommit, but I've ran into a couple yet-unresolved
problems.  If you have an references or ideas, I'd appreciate them,
but I suppose that's another thread.



On Fri, Jun 18, 2010 at 5:01 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Fri, Jun 18, 2010 at 20:59, Joshua Shrader <jshrader83@gmail.com> =
wrote:
>> Thanks. =A0It took a couple days to get everything straightened out,=
 but
>> this seems to have worked very well.
>
> Mind sharing the details or code for what you did?
>
> I've only proved to myself that this approach will work, I haven't
> actually done it.
>
