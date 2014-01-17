From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: file permissions in Git repo
Date: Fri, 17 Jan 2014 20:55:51 +0100
Message-ID: <52D98AC7.9030101@web.de>
References: <1389916737.92225.YahooMailNeo@web124906.mail.ne1.yahoo.com> <20140117022623.GC12444@sigill.intra.peff.net> <52D971A7.1040104@web.de> <1389986459.3994.YahooMailNeo@web124902.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: SH <saajey@yahoo.com>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 17 20:56:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4FWM-0006vc-EN
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 20:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752984AbaAQTz7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jan 2014 14:55:59 -0500
Received: from mout.web.de ([212.227.15.4]:56579 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752823AbaAQTz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 14:55:57 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MQvxm-1Vuzq93TP4-00UN2H for <git@vger.kernel.org>;
 Fri, 17 Jan 2014 20:55:56 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <1389986459.3994.YahooMailNeo@web124902.mail.ne1.yahoo.com>
X-Provags-ID: V03:K0:mQJ2uea1VuHELoRL170YH/SCTFwjdgRAxJlwP2/Mp4po/9JKfve
 L2qXxVVdnSKixKU0NKWL8Wr5W0Al0lIBEOur/BxRcta88ibdSk7E6Wxk/+jdPSUB379YQlP
 nmvJmdq5lbaa4cJyCHl3EjuvmsBPDLeyM03/UiwzTsCGrfq7LXWpMccZemEitdKbtCg8DI5
 ockC9EksGAz1R3O/LZ02A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240618>

(Please no top posting next time)
On 2014-01-17 20.20, SH wrote:
> On Friday, January 17, 2014 10:08 AM, Torsten B=F6gershausen <tboegi@=
web.de> wrote:
> On 01/17/2014 03:26 AM, Jeff King wrote:
>=20
>> On Thu, Jan 16, 2014 at 03:58:57PM -0800, SH wrote:
>>
>>> We have a repository which holds lots of shell and perl scripts. We=
 add the
>>> files to repository (from windows client) with executable permissio=
ns (using
>>> cygwin) but when we pull that repository on another machine (window=
s or linux),
>>> files dont have executable permission. Can you please provide a sol=
utions for
>>> this?
>>
>> Git does not preserve file permissions _except_ for the executable b=
it.
>> So this should be working.
>>
>> However, I suspect that `core.fileMode` is set to `false` in your
>> repository, which causes git to ignore the executable bit. When a
>> repository is initialized, we check whether the filesystem simply
>> creates everything with the executable bit. If so, we turn off
>> core.fileMode for the repository (since otherwise every file would h=
ave
>> it set).
>>
>> -Peff
> Cygwin has been a little bit special (and mingw still is).
> Until this commit:
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Wed Jul 24 19:22:49 2013 -0700
>=20
>     Merge branch 'ml/cygwin-updates'
>=20
>     The tip one does _not_ revert c869753e (Force core.filemode to
>     false on Cygwin., 2006-12-30) on purpose, so that people can
>     still retain the old behaviour if they wanted to.
>=20
>     * ml/cygwin-updates:
>       cygwin: stop forcing core.filemode=3Dfalse
>       Cygwin 1.7 supports mmap
>       Cygwin 1.7 has thread-safe pread
>       Cygwin 1.7 needs compat/regex
> the repositories created by cygwin had always core.filemode=3Dfalse.
>=20
> You can easily check your configuration by running
> git config -l
> on the cygwin machine, as Peff suggested.
>=20
> The next step is to check how the files had been recored in git, usin=
g
> git ls-files -s | less
> on any machine.
>=20
> If I do this on git.git, we find lines like this, where
> 100755 means an executable file,
> 100644 means non-executable file.
>=20
> 100755 9c3f4131b8586408acd81d1e60912b51688575ed 0=20
> Documentation/technical/api-index.sh
> 100644 dd894043ae8b04269b3aa2108f96cb935217181d 0=20
> Documentation/technical/api-lockfile.txt
>=20
>=20
> The 3rd step is to check how file are shown in cygwin, run
> ls -l
> (Do they have the executable bit set ?)
>=20
> Side note:
> And I think the way the auto-probing of the file system works is
> like this:
> When a git repo is initialized, the .git/config file is created.
> After that, we try to toggle the executable bit, and if lstat reports
> it as toggled, we set core.filemode=3Dtrue.
> (See builtin/init-db.c, search for core.filemode)
>=20
> I tested to create a repo on a network share exported by SAMBA.
> The Server was configured so that all new created files had the
> executable bit set by default.
> Git detected that the executable bit could be switched off,
> and configured core.filemode=3Dtrue
> Nice.
>=20
> /Torsten
> Thanks guys.  Sorry but one more question, like I mentioned we have h=
osted repositories so how do I make some configuration changes are serv=
er based so whether the client have those changes or not, it wouldn't m=
atter. Also I have one client on linux and another one on windows (for =
my testing purpose) and I see that .git/config on both machines are lit=
tle different. Is that normal?
>=20
> Thanks Again.
That a config file has small differences could be normal:
the server has typically core.bare true.

About other differences, please don't heasitate to consult
http://git-htmldocs.googlecode.com/git/git-config.html

And if there are still questions, they are there to be answered here.
/Torsten
