From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] t7005-editor.sh: Don't invoke real vi when it is in
	GIT_EXEC_PATH
Date: Sun, 11 Nov 2007 19:01:08 +0100
Message-ID: <20071111180108.GA27759@atjola.homenet>
References: <9A9986E7-E03D-458A-9A19-A3EF0E7B203D@silverinsanity.com> <1194802691-27610-1-git-send-email-B.Steinbrink@gmx.de> <Pine.LNX.4.64.0711111742010.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benji@silverinsanity.com, aroben@apple.com, dak@gnu.org,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 11 19:01:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrH7k-0004yk-1R
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 19:01:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756399AbXKKSBN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2007 13:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756374AbXKKSBN
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 13:01:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:54550 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756354AbXKKSBM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 13:01:12 -0500
Received: (qmail invoked by alias); 11 Nov 2007 18:01:10 -0000
Received: from i577B84F1.versanet.de (EHLO localhost) [87.123.132.241]
  by mail.gmx.net (mp031) with SMTP; 11 Nov 2007 19:01:10 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19je0p//bZjf3lGUxek2hssPrWJc3jgO7sbQIji47
	gbVqNOmNydeOEn
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711111742010.4362@racer.site>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64489>

On 2007.11.11 17:44:14 +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Sun, 11 Nov 2007, Bj=F6rn Steinbrink wrote:
>=20
> > The git wrapper executable always prepends the GIT_EXEC_PATH build
> > variable to the current PATH, so prepending "." to the PATH is not
> > enough to give precedence to the fake vi executable.
> >=20
> > The --exec-path option allows to prepend a directory to PATH even b=
efore
> > GIT_EXEC_PATH (which is added anyway), so we can use that instead.
>=20
> Hmm.  This will probably stop working when you do not have git instal=
led,=20
> because you now tell git to search for git programs in ".", where the=
y are=20
> not.  Probably git-commit executes your installed write-tree, commit-=
tree=20
> and friends, instead of the compiled ones.

The . is prepended to PATH in _addition_ to the usual paths (as I wrote=
,
see setup_path() in exec_cmd.c). It does not replace anything AFAICT.

$ echo $PATH
/home/doener/bin:/usr/local/bin:/usr/bin:/bin:/usr/games

$ GIT_EXEC_PATH=3D.. GIT_EDITOR=3D"env;" ../git  commit | grep ^PATH=3D
PATH=3D/home/doener/src/git:/home/doener/bin:/home/doener/src/git:/home=
/doener/bin:/usr/local/bin:/usr/bin:/bin:/usr/games

$ GIT_EXEC_PATH=3D.. GIT_EDITOR=3D"env;" ../git --exec-path=3D. commit =
| grep
^PATH=3D
PATH=3D/home/doener/src/git/t:/home/doener/src/git:/home/doener/bin:/ho=
me/doener/src/git:/home/doener/bin:/usr/local/bin:/usr/bin:/bin:/usr/ga=
mes


Looks good to me...

Bj=F6rn
