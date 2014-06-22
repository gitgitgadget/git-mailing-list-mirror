From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [msysGit] Re: The different EOL behavior between libgit2-based
 software and official Git
Date: Sun, 22 Jun 2014 08:46:57 +0200
Message-ID: <53A67BE1.4060903@web.de>
References: <1403146778624-7613670.post@n2.nabble.com>	<53A285A1.3090804@web.de> <53A3DB01.7090904@web.de>	<CAO_ghTLq-a3dJGXvmspaCYS19RhTJzT0teWO5XSfVSiRUN7rrQ@mail.gmail.com>	<53A40DEC.4050902@web.de> <xmqqmwd7ee2j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yue Lin Ho <yuelinho777@gmail.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Jun 22 08:47:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WybYh-0002av-T5
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jun 2014 08:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbaFVGrE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Jun 2014 02:47:04 -0400
Received: from mout.web.de ([212.227.15.3]:58031 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102AbaFVGrD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2014 02:47:03 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Maamb-1XIbFL3mVV-00KAyR; Sun, 22 Jun 2014 08:46:59
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqmwd7ee2j.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:EShQiKCfa8rfqNg2aXp19eLuvdgJ85aFqkaRa1tcFg04qtK8eug
 9ANCzFufXq7EZtPUmrTjZFKBWtb4+jU3g2gi6DCTu4joJXWvdoqPxN7uA/oxu4v55Ody3/y
 SoS+PHORtU16RQMQonh/P9F2q0UtPZukE5vIAQadQIYS3bYqo1zg4B/Z/UtILg2msX7DD7X
 mTOyj4qGPyBeiFvz9IkXg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252307>

On 2014-06-20 18.33, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
> tb@Linux:~/EOL_Test/TestAutoCrlf$ t=3DLF.txt  &&  rm -f $t &&  git -c=
 core.eol=3DCRLF checkout $t  && od -c  $t
> 0000000   L   i   n   e       1  \n   l   i   n   e       (   2   )  =
\n
> 0000020   l   i   n   e       3   .  \n   t   h   i   s       i   s  =
 =20
> 0000040   l   i   n   e       4  \n   l       i       n       e      =
 N
> 0000060   o   .       5  \n   L   i   n   e       N   u   m   b   e  =
 r
> 0000100       6  \n  \n
>=20
> In Documentation/config.txt, we find:
>=20
>     core.eol::
>             Sets the line ending type to use in the working directory=
 for
>             files that have the `text` property set.  Alternatives ar=
e ...
>=20
> Does that file $t in your practice "have the `text` property set"?
>=20
No, it hadn't, under my Linux box.
(And I had a .gittatributes file on the Mac OS box, which I forgot abou=
t.
I am really sorry for the confusion and saying that Git behaves differe=
nt under Linux and Mac OS).

You are pointing into the right direction:
=46iles with mixed LF CRLF in the repo are not changed by Git, when the=
 checkout out
or checked in, unless the .gitattributes say that the file is text.

And libgit2 should do the same.


However, I was confused by this
https://www.kernel.org/pub/software/scm/git/docs/git-config.html
(My comments inline with ##)
-----------------------
core.autocrlf

    Setting this variable to "true" is almost the same as setting the t=
ext attribute to "auto" on all files except that text files are not gua=
ranteed to be normalized: files that contain CRLF in the repository wil=
l not be touched.=20
## And is this line still valid:
Use this setting if you want to have CRLF line endings in your working =
directory even though the repository does not have normalized line endi=
ngs.=20

## In 2010 the "the new safer autocrlf handling" was introduced,
## and it looks as if commits fd6cce9e and c4805393 are involved here.
## When the file in the repo has only LF, it will have CRLF in the work=
 tree
## When the file in the repo has mixed LF and CRLF, it will not be chan=
ged in the work tree
## and will have mixed line endings in the work tree
## When the file in the repo has only CRLF, it will not be changed in t=
he work tree
## and will have CRLF in the work tree as well as in the repo.

##Should this line simply be dropped in the documentation ?
