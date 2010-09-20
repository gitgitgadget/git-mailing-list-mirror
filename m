From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: Reduced privileges install
Date: Mon, 20 Sep 2010 09:53:27 -0500
Message-ID: <BvHZDf7-epsPOl8y5QrLcsmYgobmFUo7HwZanlekCciU8I-jiKPVRw@cipher.nrlssc.navy.mil>
References: <325786BC-5F54-47B5-AEF5-7FDAD9BEA4BA@kellerfarm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 16:53:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxhkM-0002MJ-Dr
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 16:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756315Ab0ITOx3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 10:53:29 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43461 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379Ab0ITOx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 10:53:29 -0400
Received: by mail.nrlssc.navy.mil id o8KErRSY026853; Mon, 20 Sep 2010 09:53:27 -0500
In-Reply-To: <325786BC-5F54-47B5-AEF5-7FDAD9BEA4BA@kellerfarm.com>
X-OriginalArrivalTime: 20 Sep 2010 14:53:27.0663 (UTC) FILETIME=[9550B7F0:01CB58D3]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156629>

On 09/19/2010 06:50 PM, Andrew Keller wrote:
> Hello, all.  Quick question:
>=20
> I'm trying to build and install git 1.7.2.3 from source on a server a=
t school used for my class.
> 'uname -a' is 'SunOS bloch 5.9 Generic_122300-54 sun4u sparc SUNW,Ult=
raAX-i2'.
>=20
> There were a few hiccups at first =96 things like CC not being define=
d, tclsh not existing, the path to python being wrong, etc, but they we=
re all relatively easy to work around.  This last error, however, not s=
o much luck.
>=20
> Because I do not own the server and my account has restricted privile=
ges, I attempted to augment my PATH to include a directory in my home f=
older, and then install git in there by specifying a prefix at the conf=
igure stage.  The configure and the make work, but the make install fai=
ls.  Here's the last section of the log:
>=20
>=20
> $ make install
>=20
> ...
>=20
> make -C templates DESTDIR=3D'' install
> make[1]: Entering directory `/usr/users/students/ak4390/Downloads/git=
-1.7.2.3/templates'
> /usr/ucb/install -d -m 755 '/usr/users/students/ak4390/.local/share/g=
it-core/templates'
> (cd blt && gtar cf - .) | \
>         (cd '/usr/users/students/ak4390/.local/share/git-core/templat=
es' && umask 022 && gtar xof -)
> make[1]: Leaving directory `/usr/users/students/ak4390/Downloads/git-=
1.7.2.3/templates'
> make -C perl prefix=3D'/usr/users/students/ak4390/.local' DESTDIR=3D'=
' install
> make[1]: Entering directory `/usr/users/students/ak4390/Downloads/git=
-1.7.2.3/perl'
> make[2]: Entering directory `/usr/users/students/ak4390/Downloads/git=
-1.7.2.3/perl'
> Warning: You do not have permissions to install into /usr/perl5/site_=
perl/5.6.1/sun4-solaris-64int at /usr/perl5/5.6.1/lib/ExtUtils/Install.=
pm line 85.
> Installing /usr/perl5/site_perl/5.6.1/Error.pm
> Installing /usr/perl5/site_perl/5.6.1/Git.pm
> mkdir /usr/perl5/site_perl/5.6.1/sun4-solaris-64int/auto: Permission =
denied at /usr/perl5/5.6.1/lib/ExtUtils/Install.pm line 165
> make[2]: *** [pure_site_install] Error 255
> make[2]: Leaving directory `/usr/users/students/ak4390/Downloads/git-=
1.7.2.3/perl'
> make[1]: *** [install] Error 2
> make[1]: Leaving directory `/usr/users/students/ak4390/Downloads/git-=
1.7.2.3/perl'
> make: *** [install] Error 2
>=20
>=20
> So anyways, it appears that it is trying to install into a directory =
in which I do not have write permissions.  But why?  I thought that set=
ting the prefix to a folder in my home directory would change that.  Is=
 there another parameter I'm forgetting about at the configure stage?
>=20
> Thanks,
> Andrew Keller
>=20
> PS: not sure if it matters, but just in case...
> path to perl: /bin/perl
> version of perl: 5.6.1

By chance could INSTALL_BASE be set in your environment?

   $ echo $INSTALL_BASE

A patch was recently made to unset that variable so that it
could not influence perl's makemaker.  Though the commit message
indicates that makemaker complains loudly when both INSTALL_BASE
and PREFIX are set, so perhaps this is not the problem.

If INSTALL_BASE is set, then unset it, and try again.

Alternatively, you could avoid makemaker altogether by setting
NO_PERL_MAKEMAKER on the make command line and git will build
its own make file:

   make NO_PERL_MAKEMAKER=3D1 install

-Brandon
