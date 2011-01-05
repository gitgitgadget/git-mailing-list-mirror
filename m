From: Levend Sayar <levendsayar@gmail.com>
Subject: Re: git repo corruption
Date: Wed, 5 Jan 2011 20:58:44 +0200
Message-ID: <AANLkTikxW-kEhCFKBb-rGPM2xZtk7WyomYnFwz_DYV43@mail.gmail.com>
References: <AANLkTi=TSy1WQZARNQgGfPiV93hQ-xmCTip75JAixgDB@mail.gmail.com> <4D24B969.50007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 05 19:59:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaYZl-0003tY-15
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 19:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529Ab1AES7H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Jan 2011 13:59:07 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37903 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab1AES7F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Jan 2011 13:59:05 -0500
Received: by qwa26 with SMTP id 26so15973118qwa.19
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 10:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ijtww9rrgKkAqQecjQ4mUm4V0fH4Um076kFQ+c/9Y3Q=;
        b=XMDEO9ZGHUM0J8Y/IQkEs+WmpqZYMzQRz7mK15BWuVrNzK23mlJfZfsvzltR2PNy6O
         fL9Cg4LVJGjCP2HuuztnPs7l+RHeA6GplPju5Ig3fQfe+Ygmyj2GVOisHx9wNTEaPHWC
         UmNRXhd2z+yPtHfdZjtR0QSh3CyWBnX4a4Y7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=AxNO0BfwVm8hxR0TolkUXp82ySLUkAGxrokvwTeUWENEDSvFhw8Vjlw9a5U0jgxGRs
         xm/2PvCJTV7iAx6hqm4zsrgDXwnQK1vik6A8q1o6FmkDVAyp9W0jEAxOzdjsLfmHoVBc
         OBGhBaAk7GEsBZAi5A/Ce+eP+NgMy58Rnx7lg=
Received: by 10.229.241.9 with SMTP id lc9mr20496198qcb.88.1294253944854; Wed,
 05 Jan 2011 10:59:04 -0800 (PST)
Received: by 10.229.219.147 with HTTP; Wed, 5 Jan 2011 10:58:44 -0800 (PST)
In-Reply-To: <4D24B969.50007@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164583>

In fact, let me summarize what I did.

After sysadmin changed permissions, git status gave

Changed but not updated:

modified: bla bla
modified: bla bla
modified: ....

That modifed files are all the files that tracked in fact. So many
files. And git diff gave

diff bla bla
old mode 644
new mode 750

for all files. So only permissions are changed. To revert back I did on=
ly

git ls-files -m | xargs git checkout --

And everything is fine.


_lvnd_
(^_^)



On Wed, Jan 5, 2011 at 8:33 PM, Neal Kreitzinger <nkreitzinger@gmail.co=
m> wrote:
> On 1/4/2011 3:10 AM, Levend Sayar wrote:
>>
>> Hi, all.
>>
>> We have a repo on a corporate server. The sysadmin changed access
>> rights of files on our repo by accedant.
>> Some directories have 2750 acces rights before, but he changed as
>>
>> chmod -R 2770 *
>>
>> Now when you make git status, every file that is tracked by git is s=
aid as
>>
>> changed but not updated
>>
>> So is there a way to get this back to normal ?
>>
>> TIA
>>
>> _lvnd_
>> (^_^)
>
> If you want to reset the permissions back to exactly what git would d=
o, here
> is the way I did it after hours one night to fix the repo at our shop
> (modify the permissions value to what you want):
>
> Here is the technique I devised to change permissions on a git repo. =
=A0I
> needed to lock down a repo so only the integration manager has write =
access.
> This method ensures that git sets the permissions according to gits r=
ules.
> Please let me know if you know of an easier/better way to do this.
>
> Change Permissions on an Existing Git Repo:
>
> Check System for Users who may be using the Repo:
> # w =A0(see who's logged in)
> # ps -A |grep git-menu-scriptname =A0(where scriptname is some unique=
 string
> in the name of the main script your users use to access that repo, if
> applicable)
> # skill -KILL pts/99 =A0(where 99 =3D the pts/# from w command, log t=
he user
> off)
>
> Change Shared=3Dgroup to Shared=3D0644 =A0(change group read+write to=
 group read
> only):
> Create Template for permissions:
> login as fsngit0
> $ cd /path/to/template
> $ cat config
> [core]
> =A0 =A0 =A0 =A0sharedRepository =3D 0644
>
> Clone repo to set permissions via git:
> $ cd /path/to/repo-parent-dir
> $ git clone --bare --template=3D/path/to/template file:///path/to/REP=
O.git
> REPOMOD.git
>
> Compare old and new versions:
> $ diff -r REPO.git REPOMOD.git
> Only in REPO.git: branches =A0(empty, keep the old version)
> diff -r REPO.git/config REPOMOD.git/config =A0(merge the old and new =
together)
> 1a2
>> =A0 =A0 =A0 sharedrepository =3D 0644
> 6,7c7
> < =A0 =A0 =A0 =A0 denyDeletes =3D true
> < =A0 =A0 =A0 =A0 denyNonFastForwards =3D true
> ---
>> =A0 =A0 =A0 denyNonFastforwards =3D true
> Only in REPO.git: description =A0(keep the old version)
> Only in REPO.git: gitk.cache =A0(gitk will recreate this)
> Only in REPO.git: hooks =A0(contains sample scripts only or whatever =
scripts
> your using, keep the old version)
> Only in REPO.git: info =A0(keep the old version: contains attributes,=
 exclude,
> or whatever you've setup)
> Only in REPO.git/objects: aa (keep new version, loose object have bee=
n
> packed)
> Only in REPO.git/objects/pack:
> pack-A5735e9b894dce1498ec1c776dcabc97fd8ceAfc.idx
> diff -r REPO.git/packed-refs REPOMOD.git/packed-refs =A0(keep the new=
 version
> because fresh clone has been optimized)
> 2c2
> < Xa8b7b8c8fd3920b89770f2e8356f4ecb71a58cX refs/heads/master
> ---
>> Ya69744e46276a37932d5f0755a53f76cdf83e0dY refs/heads/master
> Only in REPO.git/refs/heads: master =A0(old version not needed becaus=
e fresh
> clone has been optimized)
>
> Copy over REPO.git files that the clone didn't replicate, but that yo=
u need
> in order to retain all settings:
> $ cp -rv /path/to/REPO.git/info .
> repeat as needed...
>
> change permissions to g-w or whatever your core.sharedRepository new =
value
> is supposed to be:
> $ chmod -R g-w info
> repeat as needed...
>
> Validate your changes:
> $ diff -r REPO.git REPOMOD.git
> diff -r REPO.git/config REPOMOD.git/config
> 1a2
>> =A0 =A0 =A0 sharedrepository =3D 0644
> 7c8
> < =A0 =A0 =A0 =A0 denyNonFastForwards =3D true
> ---
>> =A0 =A0 =A0 denyNonFastforwards =3D true
> Only in REPO.git: gitk.cache
> Only in REPO.git/objects: aa
> Only in REPO.git/objects/pack:
> pack-A5735e9b894dce1498ec1c776dcabc97fd8ceAfc.idx
> diff -r REPO.git/packed-refs REPOMOD.git/packed-refs
> 2c2
> < Xa8b7b8c8fd3920b89770f2e8356f4ecb71a58cX refs/heads/master
> ---
>> Y69744e46276a37932d5f0755a53f76cdf83e0dY refs/heads/master
> Only in REPO.git/refs/heads: master
>
> Backup REPO.git and rename REPOMOD.git to REPO.git:
> $ cp -rvp REPO.git REPO.git-old
> $ diff -r REPO.git REPO.git-old
> $ rm -rf REPO.git
> $ cp -rvp REPOMOD.git REPO.git
> $ diff -r REPO.git REPOMOD.git
> $ diff -r REPO.git REPO.git-old
>
> v/r,
> Neal
>
>
>
