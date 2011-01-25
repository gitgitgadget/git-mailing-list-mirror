From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Can't find the revelant commit with git-log
Date: Tue, 25 Jan 2011 17:12:00 +0100
Message-ID: <4D3EF650.20407@lsrfire.ath.cx>
References: <m2ipxd2w78.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 25 17:12:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhlVP-00034D-Sf
	for gcvg-git-2@lo.gmane.org; Tue, 25 Jan 2011 17:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837Ab1AYQMY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Jan 2011 11:12:24 -0500
Received: from india601.server4you.de ([85.25.151.105]:35523 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab1AYQMX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jan 2011 11:12:23 -0500
Received: from [192.168.2.104] (p4FFD963E.dip.t-dialin.net [79.253.150.62])
	by india601.server4you.de (Postfix) with ESMTPSA id 601F12F8091
	for <git@vger.kernel.org>; Tue, 25 Jan 2011 17:12:21 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <m2ipxd2w78.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165480>

Am 25.01.2011 10:01, schrieb Francis Moreau:
> Hello,
>=20
> I'm trying to find out a commit which removed a function inside a fil=
e.
>=20
> The project is the Linux kernel, and I'm trying to look for changes
> which happened between v2.6.27 and v2.6.28. The changes happened in t=
he
> following file: drivers/pci/intel-iommu.c where a function has been
> removed:
>=20
>    $ git --version
>    git version 1.7.4.rc3
>=20
>    $ cd ~/linux-2.6/drivers/pci/
>    $ git grep blacklist v2.6.27 -- drivers/pci/intel-iommu.c
>    $
>=20
> No ouput... hmm, I know it's in... oh maybe the path is incorrect
>=20
>    $ git git grep blacklist v2.6.27 -- intel-iommu.c
>    v2.6.27:intel-iommu.c:static int blacklist_iommu(const struct dmi_=
system_id *id)
>    v2.6.27:intel-iommu.c:          .callback =3D blacklist_iommu,
>=20
> ah, so Git failed previously without any comments on the wrong
> path... maybe it should ?

Good idea.

> So at that point I know that in the revision v2.6.27, there's a funct=
ion
> called "blacklist_iommu" in drivers/pci/intel-iommu.c
>=20
> Now take a look if it's still there in v2.6.28:
>=20
>    $ git git grep blacklist v2.6.28 -- intel-iommu.c
>    $
>=20
> This time nothing is printed but I know that the command is correct.
>=20
> So now I'm interested in looking for the commit which removed this
> function. Fo this I'm trying to use git-log(1):
>=20
>    $ git log --full-history --follow -S'static int blacklist_iommu(co=
nst struct dmi_system_id *id)' v2.6.27..v2.6.28 -- intel-iommu.c
>    $ echo $?
>    0
>=20
> I tried different options but it fails.
>=20
> Also I found that passing the exact string to '-S' is annoying, are
> there any way to just pass a part of the string such as
> "-Sblacklist_iommu" ?

This (-Sblacklist_iommu) works for me.

> Sorry if I miss the revelant git-log's option, but there're so many..=
=2E

Try -m (show full diff for merge commits), as the change you're looking
for seems to have been introduced by a merge, not a regular commit.

	$ opts=3D"--stat -Sblacklist_iommu -m --oneline"
	$ revs=3D"v2.6.27..v2.6.28"

	$ git log $opts $revs -- drivers/pci/intel-iommu.c

This returns nothing.  Hmm.  Let's try this instead:

	$ git log $opts $revs -- drivers/pci/
	057316c (from 3e2dab9) Merge branch 'linus' into test
	 drivers/pci/intel-iommu.c |  307 ++++++++++++++++++++----------------=
--------
	 1 files changed, 140 insertions(+), 167 deletions(-)
	6b2ada8 (from 3b7ecb5) Merge branches 'core/softlockup', 'core/softirq=
', 'core/resources', 'core/printk' and 'core/misc' into core-v28-for-li=
nus
	 drivers/pci/intel-iommu.c |  187 ++++++------------------------------=
--------
	 1 files changed, 26 insertions(+), 161 deletions(-)
	d847059 (from 725c258) Merge branch 'x86/apic' into x86-v28-for-linus-=
phase4-B
	 drivers/pci/intel-iommu.c |  185 ++++++------------------------------=
---------
	 1 files changed, 25 insertions(+), 160 deletions(-)
	725c258 (from 129d6ab) Merge branches 'core/iommu', 'x86/amd-iommu' an=
d 'x86/iommu' into x86-v28-for-linus-phase3-B
	 drivers/pci/intel-iommu.c |   25 ++++++++++++++++++++++++-
	 1 files changed, 24 insertions(+), 1 deletions(-)
	6e03f99 (from 9821626) Merge branch 'linus' into x86/iommu
	 drivers/pci/intel-iommu.c |   23 +++++++++++++++++++++++
	 1 files changed, 23 insertions(+), 0 deletions(-)

Strange, why did we need to remove the last path component to get these
results which say that exactly the file we previously specified was cha=
nged?

Also interesting, and matching the above results in that we see the nee=
d for
the -m flag confirmed:

	$ for merge in 057316c 6b2ada8 d847059 725c258 6e03f99
	do
		a=3D$(git show $merge | grep -c blacklist_iommu)
		b=3D$(git show -m $merge | grep -c blacklist_iommu)
		echo $merge $a $b
	done
	057316c 0 2
	6b2ada8 0 2
	d847059 0 2
	725c258 0 2
	6e03f99 0 2

IAW: the combined diff for the five found merges doesn't show any chang=
es to
a line containing the string "blacklist_iommu", but the full diffs do.

Let's check for the presence of the string in the merge results and the=
ir
parents:

	$ for merge in 057316c 6b2ada8 d847059 725c258 6e03f99
	  do
		for rev in $(git show $merge | grep ^Merge:)
		do
			t=3Dparent
			case $rev in
			Merge:)
				echo
				rev=3D$merge
				t=3Dmerge
				;;
			esac
			if git grep -q blacklist_iommu $rev -- drivers/pci/
			then
				echo "$t $rev: found"
			else
				echo "$t $rev: not found"
			fi
		done
	done

	merge 057316c: not found
	parent 3e2dab9: found
	parent 2515ddc: not found
=09
	merge 6b2ada8: not found
	parent 278429c: not found
	parent 3b7ecb5: found
	parent 77af7e3: not found
	parent 1516071: not found
	parent 1fa63a8: not found
	parent 8546232: not found
=09
	merge d847059: not found
	parent 725c258: found
	parent 11494547: not found
=09
	merge 725c258: found
	parent 3dd392a: found
	parent 72d3105: found
	parent 129d6ab: not found
	parent 1e19b16: found
=09
	merge 6e03f99: found
	parent 9821626: not found
	parent 6bfb09a: found

Hmm, seems like the function is gone since d847059.  Does all of this h=
elp
you in any way?

Ren=E9
