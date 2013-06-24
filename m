From: Yann Droneaud <ydroneaud@opteya.com>
Subject: Re: Another core.safecrlf behavor with git diff/git status
Date: Mon, 24 Jun 2013 19:02:11 +0200
Organization: OPTEYA
Message-ID: <400f1e3599efcbdcad82c2da89a3875c@meuh.org>
References: <866f886ef5e48ba22eec0f67203666bb@meuh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 19:02:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrA9h-00018o-Gr
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 19:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829Ab3FXRCN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 13:02:13 -0400
Received: from mx-out.ocsa-data.net ([194.36.166.37]:60150 "EHLO
	mx-out.ocsa-data.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964Ab3FXRCM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 13:02:12 -0400
Received: from [192.168.111.12] (helo=rc.ouvaton.coop)
	by mx-out.ocsa-data.net with esmtpa (Exim - FreeBSD Rulez)
	id 1UrA9c-000KzQ-79
	for <git@vger.kernel.org>; Mon, 24 Jun 2013 19:02:12 +0200
In-Reply-To: <866f886ef5e48ba22eec0f67203666bb@meuh.org>
X-Sender: ydroneaud@opteya.com
User-Agent: Roundcube Webmail/0.9.2
X-abuse-contact: abuse@ocsa-data.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228875>

Le 24.06.2013 18:37, Yann Droneaud a =C3=A9crit=C2=A0:

> I'm still trying to use .gitattributes "text" flag with CRLF line=20
> ending files
> under Linux.
>=20
> I'm surprised about the interaction between the index and the working=
=20
> directory,
> more specificaly about the interaction between git diff and git statu=
s:

[...]

> - Why git diff does not always report the CRLF/LF mismatch ?
>=20
> - Why git status does not report about the CRLF/LF mismatch before
> updating the index:
>   it silently hide the CRLF/LF warning.
>   git add, git commit report the warning. git status should probably
> do the same.
>=20

One last try for today, still under Linux, with git 1.8.1.4:

   $ git init
   Initialized empty Git repository in=20
/home/ydroneaud/src/tmp/onemore/work1/.git/
   $ git commit --allow-empty -m "root"
   [master (root-commit) 89c2ff9] root

   $ CRLF=3D"\r\n"
   $ printf "Hello World 1${CRLF}Hello World 2${CRLF}Hello World=20
3${CRLF}Hello World 4" > test
   $ git add test
   $ git commit -m "test"
   [master 36d4628] test
    1 file changed, 4 insertions(+)
    create mode 100644 test

   $ echo "test text" > .gitattributes
   $ git add .gitattributes
   $ git commit -m ".gitattributes"
   [master 3b9f3cc] .gitattributes
    1 file changed, 1 insertion(+)
    create mode 100644 .gitattributes

   $ git diff                      # print nothing
   $ git status
   # On branch master
   nothing to commit, working directory clean
   $ touch test
   $ git diff
   warning: CRLF will be replaced by LF in test.
   The file will have its original line endings in your working=20
directory.
   diff --git a/test b/test
   index b043836..63ba10f 100644
   --- a/test
   +++ b/test
   @@ -1,4 +1,4 @@
   -Hello World 1
   -Hello World 2
   -Hello World 3
   +Hello World 1
   +Hello World 2
   +Hello World 3
    Hello World 4
   \ No newline at end of file


- commiting .gitattributes should have trigger a warning about CRLF=20
conversion
- doing git diff after commiting .gitattributes should have reported th=
e=20
warning about CRLF/LF.

I dislike complaining all the time about such unusual corner cases, I=20
apologize not having patches
to provides to Git to try to "fix"/improve this.

Regards.

--=20
Yann Droneaud
OPTEYA
