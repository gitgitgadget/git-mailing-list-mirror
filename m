From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: confused about preserved permissions
Date: Tue, 21 Aug 2007 20:01:01 +0200
Message-ID: <46CB285D.3010909@lsrfire.ath.cx>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net> <20070820174142.GA7943@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Aug 21 20:01:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INY2a-0006Qz-Gc
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 20:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761300AbXHUSBQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 21 Aug 2007 14:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760513AbXHUSBQ
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 14:01:16 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:46395
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760150AbXHUSBQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Aug 2007 14:01:16 -0400
Received: from [10.0.1.201] (p508EBE32.dip.t-dialin.net [80.142.190.50])
	by neapel230.server4you.de (Postfix) with ESMTP id 617458B008;
	Tue, 21 Aug 2007 20:01:14 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20070820174142.GA7943@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56319>

Mike Hommey schrieb:
> On Mon, Aug 20, 2007 at 06:44:11PM +0200, martin f krafft <madduck@ma=
dduck.net> wrote:
>> Why does git bother saving a mode when later it never seems to use
>> it again?
>=20
> Same applies to git-archive, which generates files with mode 666 and
> directories with 777, while it could follow the modes in the
> repository... or at least, that's what the manpage claims, but facts
> seem to be quite different...
>=20
> mh@namakemono:~/git/git$ git-archive --format=3Dtar HEAD | tar -tvf -
> -rw-rw-r-- root/root      2365 2007-08-19 20:45 .gitignore
> -rw-rw-r-- root/root      1973 2007-08-19 20:45 .mailmap
> -rw-rw-r-- root/root     18787 2007-08-19 20:45 COPYING
> drwxrwxr-x root/root         0 2007-08-19 20:45 Documentation/

> mh@namakemono:~/git/git$ umask
> 0022
>=20
> And no value is set for umask in git config...

In that case the default value for tar.umask applies, which is 002.  Th=
e
manpage needs an update..  Thanks for spotting this.

You can set it to 022 explicitly or to "user" to restrict permissions:

   $ git config tar.umask 022		# -rw-r--r--
   $ git config tar.umask user		# your Unix umask applies

Originally file permissions were simply copied into the archive, but
this was inconvenient for users that needed more permission bits set,
e.g. to share an extracted archive with with others by default.

Also please note that tar applies your umask when extracting files
(exception: GNU tar doesn't do that by default if run as root), so the
permissions of extracted files may look different from the output of
"tar -t".

Ren=E9
