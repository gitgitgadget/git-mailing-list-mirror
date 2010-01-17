From: Michael Poole <mdpoole@troilus.org>
Subject: Re: Integration-Manager Workflow
Date: Sat, 16 Jan 2010 21:53:44 -0500
Message-ID: <87my0dwifb.fsf@troilus.org>
References: <201001161849.32211.aribao@gmail.com> <87r5ppx42f.fsf@troilus.org>
	<201001162047.38010.aribao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Adri=C3=A1n?= Ribao =?utf-8?Q?Mart=C3=ADnez?= 
	<aribao@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 17 03:53:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWLGy-00022c-EN
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 03:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326Ab0AQCxs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Jan 2010 21:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753250Ab0AQCxs
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 21:53:48 -0500
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:53421 "HELO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753199Ab0AQCxr convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 21:53:47 -0500
Received: from source ([209.85.221.180]) by na3sys009aob112.postini.com ([74.125.148.12]) with SMTP
	ID DSNKS1J7uppa9pRL8lnYBstjUe0S7l0vh5Ia@postini.com; Sat, 16 Jan 2010 18:53:47 PST
Received: by qyk10 with SMTP id 10so1138945qyk.12
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 18:53:46 -0800 (PST)
Received: by 10.229.50.12 with SMTP id x12mr3039239qcf.76.1263696826342;
        Sat, 16 Jan 2010 18:53:46 -0800 (PST)
Received: from graviton.troilus.org (pool-72-83-66-147.washdc.east.verizon.net [72.83.66.147])
        by mx.google.com with ESMTPS id 20sm3438580qyk.5.2010.01.16.18.53.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 Jan 2010 18:53:45 -0800 (PST)
In-Reply-To: <201001162047.38010.aribao@gmail.com> (=?utf-8?Q?=22Adri?=
 =?utf-8?Q?=C3=A1n?= Ribao =?utf-8?Q?Mart=C3=ADnez=22's?=
	message of "Sat, 16 Jan 2010 20:47:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137272>

Adri=C3=A1n Ribao Mart=C3=ADnez writes:

>> Adri=C3=A1n Ribao Mart=C3=ADnez writes:
>>=20
>> > What happens if they accidentally work in the develop branch inste=
ad of creating a new one? What should we do?
>> > I think I should never fetch from teamx.myserver.net to avoid this=
 problem and instead track the branch like in step 2. Is this correct?
>>=20
>> It is simpler than that.
>>=20
>> If you just use "git remote add teamx teamx.myserver.net:/...." (rat=
her
>> than cloning your integration repository from one of those
>> repositories), it will leave all your local branches alone -- any
>> changes to teamx.myserver.net's "develop" branch will only show up i=
n
>> the teamx/develop tracking branch.
>
> I think this is a stupid question but, how do I bring the feature1 br=
anch from teamx to my local repository?

In brief, "git fetch teamx" -- it will copy that repository's branches
into "tracking" branches.  In your repository, they will be named like
teamx/develop, teamx/test, teamx/feature, and so on.

When you run the "git remote add teamx ${location}" command, it creates
a section in .git/config that looks like this:

[remote "teamx"]
        url =3D ssh://teamx.myserver.net/home/teamx/product.git
        fetch =3D +refs/heads/*:refs/remotes/teamx/*

This tells git to copy the remote branches to tracking branches; it wil=
l
not overwrite any of your own branches.  You can later add "push"
entries to this section to change the default behavior for "git push
teamx".  For example, adding:

         push =3D refs/head/develop
         push =3D refs/head/test:refs/head/test
         push =3D +refs/head/master

These all tell git to push your local branch (develop, test or master)
to the same branch name in the teamx repository.  The + in the last lin=
e
says to push even when it is not a fast-forward.  (The "<refspec>"
section of the git-push man pages has more discussion of the syntax.
Using these push entries makes sure that you don't accidentally modify =
a
feature branch on the team's repository.)

>>=20
>> The reason is that a fetch or pull only merges into your develop bra=
nch
>> if your branch.develop.merge git-config entry specifies an upstream
>> branch -- more detail can be found in the git-config man page under
>> branch.<name>.remote and branch.<name>.merge.
>>=20
>> Those entries are set up when you clone from a repository, and throu=
gh
>> some other commands, but if teamx clones from the integration server=
,
>> they can only mess up their own develop branch.  If/when you push in=
to
>> teamx's repository from yours, you can forcibly overwrite any of tho=
se
>> accidental changes.  (Normally, though, the push would only do a
>> fast-forward merge -- so if teamx made such a mistake, the merge wil=
l
>> fail until you address the mismatch.)
>
> I'm not sure if I understand.

The process you listed looks workable, although I would swap 2 and 3 to
save commands when the change is good (with no extra commands if the
change is bad).  In addition, merging first will find merge conflicts
before you do any verification.

> 1. I bring the feature1 to my local repository.

git fetch teamx

> 2. Check if everything is ok

git checkout teamx/feature1
make clean test (or whatever is appropriate)

> 3. Merge or rebase the branch into develop

git checkout develop
git merge teamx/feature1

If I were to swap the two steps above, I would make sure I was on the
develop branch, and then run:
  git merge teamx/feature1
  make clean test
If the check-out fails, "git reset --hard HEAD^" will back up to the
first parent commit -- in this case, the previous tip commit for
"develop".  If the check passes, the rest of the process is the same.

> 4. Push the develop changes into the in central repository

git push central develop

> 5. Push and force the develop changes into the teamx server

git push teamx develop

> 6. The developers pull their local repositories from teamx server

git pull teamx

Hopefully this helps explain things.

Michael Poole
