From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [Bug] git status -unormal -- 'foo[b]/' won't display content
 of 'foo[b]/
Date: Sun, 21 Sep 2014 21:52:54 +0200
Message-ID: <541F2C96.6050101@web.de>
References: <87vbogq293.dlv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?UsOpbWkgVmFuaWNhdA==?= <vanicat@debian.org>,
	git Maling list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 21 21:53:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVnBv-0007Bv-0i
	for gcvg-git-2@plane.gmane.org; Sun, 21 Sep 2014 21:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbaIUTw7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Sep 2014 15:52:59 -0400
Received: from mout.web.de ([212.227.17.12]:58562 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374AbaIUTw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2014 15:52:58 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0Meji8-1XgrxH1EwS-00OH0d; Sun, 21 Sep 2014 21:52:55
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <87vbogq293.dlv@gmail.com>
X-Provags-ID: V03:K0:1cP0ijhc5OGP/iARNuH6j91Yz/EAGkdkYdMyQakKkZ2wiW8cq0u
 Mvx0zDRQAevLbZlKhMAeUNuFty3byVn5wNIfh+7kLXnBBC1y4jRPLHjlAlm/uXM4TygIV3X
 ZDXxE6VtKmcYC6DsMqDXeDy61ao3HUpix7ixl8ij5MaSjt+Zh43bnnTow4Ui3Pl47UoIVp6
 dTV+4JRpKizHKzG6Pi/QA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257355>

On 2014-09-21 20.04, R=C3=A9mi Vanicat wrote:
> Hello,
>=20
> I found what look like a bug in git status:
> `git status -unormal foo[b]/` won't output the content of the directo=
ry
> foo[b] when `git status -unormal foo/` will output the content of the
> directory foo:=20
>=20
>   $ mkdir 'foo[b]'
>   $ touch 'foo[b]/bar'
>   $ git status -unormal 'foo[b]/'
>   On branch master
>   Untracked files:
>     (use "git add <file>..." to include in what will be committed)
>=20
>           foo[b]/
>=20
>   nothing added to commit but untracked files present (use "git add" =
to track)
>   $ mkdir 'foo'
>   $ touch 'foo/bar'
>   $ git status -unormal 'foo/'
>   On branch master
>   Untracked files:
>     (use "git add <file>..." to include in what will be committed)
>=20
>           foo/bar
>=20
>   nothing added to commit but untracked files present (use "git add" =
to track)
>=20
> The documentation of git status contain nothing about treating bracke=
t
> specially. Quoting the brackets do not solve the problem.
>=20
> see https://github.com/magit/magit/issues/1512 for discussion about i=
t
> (in the case of git status --porcelain).
>
git status takes a "pathspec" as a parameter, which is not the same as =
a filename.
A pathspec can contain wildcards like '*' or '?' or things like "*[ch]"=
=2E
This is known as shell glob syntax (or so), and used automatically by a=
ll shells.

Git allows to use "git add *.[ch]" (where the shell expands the glob) o=
r
"git add '*.[ch]'" where Git does the expansion.

You can turn of the glob handling in a pathspec by using this:  =20
=20
GIT_LITERAL_PATHSPECS=3D1 git status -unormal 'foo[b]/'
On branch master

Initial commit

Untracked files:
  (use "git add <file>..." to include in what will be committed)

        foo[b]/bar
-------------------
Side note:
If somebody feels that the documentation can be better: we appreciate p=
atches.
