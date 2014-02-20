From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Fwd: Git Directory Diff for submodule
Date: Thu, 20 Feb 2014 21:03:06 +0000
Message-ID: <53066D8A.6070909@web.de>
References: <CAN-m_UmNudmxJnA95h1nYqi7GGxtzKqqpgFHmJZ+MTnxRoEd6g@mail.gmail.com>	<CAN-m_UnQ7Yzuq7n6mxmsd3XcfLSVxMdnLiGFDiN1Ph3ZiFqwew@mail.gmail.com>	<CAN-m_U=eYSEXfVBcD1Rfx-YvGx5Wu+hB2uAc=6xX_HO7bS0FUg@mail.gmail.com>	<52F54441.6090209@web.de> <CAN-m_UnSqTnLydyVF2TLxOia9vzmQr9e4+xWh8aVNBosfCq5nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>
To: =?ISO-8859-1?Q?G=E1bor_Lipt=E1k?= <gabor.liptak@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 20 22:03:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGam9-0003x6-A2
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 22:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856AbaBTVDN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Feb 2014 16:03:13 -0500
Received: from mout.web.de ([212.227.17.12]:54786 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752635AbaBTVDM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Feb 2014 16:03:12 -0500
Received: from [192.168.1.102] ([90.174.2.70]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0LZvrx-1X03LK4AJB-00loj5 for <git@vger.kernel.org>; Thu,
 20 Feb 2014 22:03:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <CAN-m_UnSqTnLydyVF2TLxOia9vzmQr9e4+xWh8aVNBosfCq5nA@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:yMUsC0zjrVMIZudRr0EmYlC6M9UKGfOEmUd0OIxaruU4IwBoSly
 oBR5atrNBjRJ8+RSAKOGvxsK2E9h1E0P8Q/s1DRAXRRNpxmjuQCqAJdJdQrG07zTRmYYwus
 yUVQvlBIyQ/wXxFfPYKPh2rnq+92jGwzW9GaMuKL/XC/Fvd35HJ4ss2VvQEhCUiSmea3MC5
 BGPcRS1X4gCq5U/Y/djmg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242447>

Sorry for the late reply, but here we go ...

Am 10.02.2014 07:33, schrieb G=E1bor Lipt=E1k:
> Hi Jens,
>=20
> So "git status" says:
>=20
> liptak@liptak-kubuntu:~/Projects/MAIN_MODULE/platform/SUBMODULE
> [master]$ git status
> # On branch master
> # Your branch is up-to-date with 'origin/master'.
> #
> # Changes not staged for commit:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working
> directory)
> #
> #       modified:   xxxxxx.java
> #       modified:   xxxxxxx.java
> # ...
> # ...
> # ...
> # ...
> # ...
> #
> no changes added to commit (use "git add" and/or "git commit -a")
>=20
> git config core.worktree gives back: "../../../../platform/SUBMODULE"

Which looks a bit strange but is perfectly ok for a repository
that uses a gitfile, as the core.worktree setting is relative
to the git directory the gitfile references and not the directory
the gitfile lives in. A quick glance at the find_worktree
subroutine in git-difftool.perl makes me think that difftool is
not aware of that fact. David, does that make sense?

> The submodule was inited simply with "git submodule init" +
> "git.submodule update"
>=20
> MAINMODULE/.gitsubmodules file contains similar entry:
> [submodule "platform/SUBMODULE"]
> path =3D platform/SUBMODULE
> url =3D ssh://git@somehost/foo/bar.git
>=20
> MAINMODULE/.git/config:
> [submodule "platform/SUBMODULE"]
> url =3D ssh://git@somehost/foo/bar.git
>=20
> MAINMODULE/platform/SUBMODULE/.git:
> gitdir: ../../.git/modules/platform/SUBMODULE
>=20
> MAINMODULE/.git/modules/platform/SUBMODULE/config:
> [core]
> repositoryformatversion =3D 0
> filemode =3D true
> bare =3D false
> logallrefupdates =3D true
> worktree =3D ../../../../platform/SUBMODULE
> [remote "origin"]
> url =3D ssh://git@somehost/foo/bar.git
> fetch =3D +refs/heads/*:refs/remotes/origin/*
>=20
> So for me it seems that somehow the relative path inside
> MAINMODULE/.git/modules/platform/SUBMODULE/config gets configuread
> wrong during submodule init+update.
>=20
> I tried to update the
> MAINMODULE/.git/modules/platform/SUBMODULE/config to contain
> ../../platform/SUBMODULE as worktree path, then meld was correctly
> started, but the compare tree was not usable. For file changes it
> displayed always: XXXXX.java: Dangling symlink. So this is still not =
a
> complete solution somehow.
>=20
> Regards,
>=20
> G=E1bor Lipt=E1k
>=20
> 2014-02-07 Jens Lehmann <Jens.Lehmann@web.de>:
>> Am 07.02.2014 10:15, schrieb G=E1bor Lipt=E1k:
>>> I think I have found a bug related to submodules and directory diff=
=2E
>>> See the details at hXXp://stackoverflow.com/q/21623155/337621.
>>
>> Let's inline the recipe one finds after decrypting this link:
>>
>> ~/Projects/MAINMODULE/platform/SUBMODULE [master]$ git difftool -too=
l=3Dmeld --dir-diff --cached
>>   fatal: Could not switch to '../../../../platform/': No such file o=
r directory
>>   diff --raw --no-abbrev -z --cached: command returned error: 128
>> ~/Projects/MAINMODULE/platform/SUBMODULE [master]$ cd ..
>> ~/Projects/MAINMODULE/platform [master]$ cd ..
>> ~/Projects/MAINMODULE [master]$ git difftool -tool=3Dmeld --dir-diff=
 --cached
>>   // NO PROBLEM, works.
>> ~/Projects/MAINMODULE [master]$ git version
>>   git version 1.8.4
>>
>>
>>> If you need any further details, just ask.
>>
>> - Does this only happen when you use difftool? E.g. what does
>>   "git status" inside the submodule say?
>>
>> - What does "git config core.worktree" print when run in the
>>   submodule?
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
