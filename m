From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: "git commit" fails due to spurious file in index
Date: Tue, 05 Mar 2013 11:40:59 +0100
Message-ID: <5135CBBB.60102@web.de>
References: <2D9BD788B02ABA478C57929170AF952B7622B5@EXCH-MBX-3.epic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Robert Irelan <rirelan@epic.com>
X-From: git-owner@vger.kernel.org Tue Mar 05 11:41:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCpJP-00062V-9t
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 11:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755819Ab3CEKlH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Mar 2013 05:41:07 -0500
Received: from mout.web.de ([212.227.17.12]:59402 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755597Ab3CEKlG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 05:41:06 -0500
Received: from [192.168.2.107] ([79.244.183.61]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0Lwq0e-1UsSaB3wfw-016PJ5; Tue, 05 Mar 2013 11:41:00
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130216 Thunderbird/17.0.3
In-Reply-To: <2D9BD788B02ABA478C57929170AF952B7622B5@EXCH-MBX-3.epic.com>
X-Provags-ID: V02:K0:neTwj2TLZUGPXJqathtzPJHn7oaOu9RE362+fNdrzjo
 EMmvt0pMoEuVm/xFHmIKF0ez4u8Kqeid92kt3/McpdO9rA1u5t
 D2SrvKbReDJ2V+RT4pi9O5Y9mcpd3C4HOYiibdqjE55SKAt0Eh
 ACnS2zk+f+7jXKA+tK08otCy2q2X0/gFZMVo7rWyk8E3v0z+RL
 AiMIYeu3JoPJeqw4qZfqg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217443>

On 04.03.13 19:15, Robert Irelan wrote:
> Hello all:
>=20
> This is my first time posting to this mailing list, but it appears to
> me, through a Google search, that this is where you go to report what
> might be bugs. I'm not sure if this is a bug or not, but it is
> mysterious to me.
>=20
> My git repository has this directory structure (I don't know if the f=
ile
> names are necessary or not; only the leaf directories contain files):
>=20
>     $ tree -ad -I.git
>     .
>     =E2=94=94=E2=94=80=E2=94=80 admin_scripts
>         =E2=94=9C=E2=94=80=E2=94=80 integchk
>         =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 2012
>         =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 2014
>         =E2=94=9C=E2=94=80=E2=94=80 jrnadmin
>         =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 2012
>         =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 2014
>         =E2=94=94=E2=94=80=E2=94=80 logarchiver
>             =E2=94=9C=E2=94=80=E2=94=80 2012
>             =E2=94=94=E2=94=80=E2=94=80 2014
>=20
>     10 directories
>=20
> The last commit in this repo was a rearrangement of the hierarchy
> carried out using `git mv`.  Before, the directory structure went
> `admin_scripts/version/script_name` instead of
> `admin_scripts/script_name/version`.
>=20
> Now I'm attempting to some new files that I've already created into t=
he
> repository, so that the repo now looks like this (`setup/2012`
> contains files, while `setup/2014` is empty):
>=20
>     $ tree -ad -I.git
>     .
>     =E2=94=94=E2=94=80=E2=94=80 admin_scripts
>         =E2=94=9C=E2=94=80=E2=94=80 integchk
>         =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 2012
>         =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 2014
>         =E2=94=9C=E2=94=80=E2=94=80 jrnadmin
>         =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 2012
>         =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 2014
>         =E2=94=9C=E2=94=80=E2=94=80 logarchiver
>         =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 2012
>         =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 2014
>         =E2=94=94=E2=94=80=E2=94=80 setup
>             =E2=94=9C=E2=94=80=E2=94=80 2012
>             =E2=94=94=E2=94=80=E2=94=80 2014
>=20
>     13 directories
>=20
> Now, when I run 'git add admin_script/setup' to add the new directory=
 to
> the repo and then try to commit, I receive the following message:
>=20
>     $ git commit
>     mv: cannot stat `admin_scripts/setup/2012/setup': No such file or=
 directory
>=20
> The error message is correct in that `admin_scripts/setup/2012/setup`
> does not exist, either as a file or as a directory. However, I'm not
> attempting to add this path at all. Using grep, I've confirmed that t=
he
> only place this path appears in any of my files is in `.git/index`.
>=20
> Also, I can commit to other places in the repository without triggeri=
ng
> any error. In addition, I can clone the repository to other locations
> and apply the problematic commit manually. This is how I've worked
> around the problem for now, and I've moved the repository that's
> exhibiting problems to another directory and started work on the clon=
ed
> copy.
>=20
> Why is this spurious path appearing in the index? Is it a bug, or a
> symptom that my repo has been somehow corrupted? Any help would be
> greatly appreciated.
>=20
> Robert Irelan | Server Systems | Epic | (608) 271-9000
You have come to the right group.
It might be difficult to tell (at least for me) if there is a bug or a =
corruption,
May be some tests could help to bring more light into the darkness:

What does "git status" (in the problematic repo) tell you?
What does "git fsck" (in the problematic repo) tell you?
What does "git ls-files" (in both repos) tell you?

/Torsten
