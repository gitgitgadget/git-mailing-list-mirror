From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: On MacOS, 1.7.2, git svn clone seems to fail silently
Date: Fri, 30 Jul 2010 20:35:09 -0500
Message-ID: <20100731013509.GG5817@burratino>
References: <AANLkTimxqC3oax=Q0EppAb-Q7AzHshRkV=H=6dJDNhqY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Benson Margulies <bimargulies@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 03:36:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of100-0007MH-Ja
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 03:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754272Ab0GaBgX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jul 2010 21:36:23 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61061 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012Ab0GaBgW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 21:36:22 -0400
Received: by iwn7 with SMTP id 7so1875485iwn.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 18:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=B4NXYmw6bNvmEMvz2GRFhYWzE4dV/07h4evkybpnGgk=;
        b=iIibXcFZD4/vHhusstIgQ2ctjc9/2OvtclPLMxp2Y1eBMUpNuh4/QHycQwmE4Vd7Z4
         D7alul+U4yBSyVEceL908tyLLZHINJYVpnJ2KkE2EnSGDC49w99INgthHZ8EnHmVRXmV
         SiYRyeEko1HZZCeJPDNIZiWDhbGQWsBV423Aw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=K0hEjksE0DZFHSUE6vudCgptDYhm64YxuGt1xqyb28mnK6oMErZKuZgqTgWrOIG7SU
         /075tVdDNdwELZxSBQTJCRYlYjXexQHOVIOrXdD0STUIsMq+h/sYJqdUyQXyoJzveuZu
         hRC/7rQDmMtivskRIFXlr9Vo+97iGJGD1lT9I=
Received: by 10.231.173.144 with SMTP id p16mr2617275ibz.108.1280540180591;
        Fri, 30 Jul 2010 18:36:20 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id 34sm2487358ibi.18.2010.07.30.18.36.19
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Jul 2010 18:36:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimxqC3oax=Q0EppAb-Q7AzHshRkV=H=6dJDNhqY@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152283>

Hi again,

Benson Margulies wrote:

> I don't have $? at hand, but I can tell you that git branch -r says
> nothing, either. Also, running git fetch has the same result. Prints
> the same sort of trace lines if tracing, then does nothing.

Yes, this seems different from the EPIPE bug, alas.

I get a core dump (for some small process, I don=E2=80=99t know what: 1=
048576
bytes.  Died of signal 5 in pthread_mutex_unlock) and git-svn is still
going.

 $ git svn clone -s https://gate.svn.sourceforge.net/svnroot/gate
 Initialized empty Git repository in /tmp/gate/.git/

Sitting there quietly.  ltrace tells me it=E2=80=99s busy copying aroun=
d data.

 memcpy(0x0aa679d8, "Git::SVN::Ra", 12)                                =
 =3D 0x0aa679d8
 pthread_getspecific(0, 0xbfb1855c, 1, 0xb76b83a0, 0xaa679d8)          =
 =3D 0x9df2008
 realloc(0x0aa679d8, 20)                                               =
 =3D 0x0aa679d8
 memmove(0xaa679e4, 0x8160163, 7, 0xab723e8, 0xa5ae200)                =
 =3D 0xaa679e4
 memcpy(0xbfb186dc, "Git::SVN::Ra::SUPER", 19)                         =
 =3D 0xbfb186dc
 memcpy(0xbfb185fc, "Git", 3)                                          =
 =3D 0xbfb185fc
 memcpy(0xbfb185fc, "SVN", 3)                                          =
 =3D 0xbfb185fc
 memcpy(0xbfb185fc, "Ra", 2)                                           =
 =3D 0xbfb185fc
 memcpy(0xbfb185fc, "SUPER", 5)                                        =
 =3D 0xbfb185fc
 memmove(0xa89f878, 0xa88f934, 19, 0x80d171d, 0x9df2008)               =
 =3D 0xa89f878
 memmove(0xa89f88b, 0x8160032, 2, 0x80ecf3a, 0xa89f878)                =
 =3D 0xa89f88b
 memmove(0xa89f88d, 0xa257f7f, 10, 0x80ecf3a, 0xa89f878)               =
 =3D 0xa89f88d
 memcpy(0x0a10cbe0, "\3701%\n\0302%\n82%\nX3%\n", 16)                  =
 =3D 0x0a10cbe0
 strlen("Git::SVN::Ra")                                                =
 =3D 12
 memmove(0xa89f780, 0x9e16d7c, 12, 0x80d5cd1, 0xa10cbe0)               =
 =3D 0xa89f780
 memmove(0xa89f798, 0xa89f780, 12, 0x8083aa6, 0x9df2008)               =
 =3D 0xa89f798
 memmove(0xa89f8a8, 0xa89f878, 31, 0x8083aa6, 0x9df2008)               =
 =3D 0xa89f8a8
 memcmp(0xa59c590, 0xa89f8bc, 2, 0x45505553, 0x93a3a52)                =
 =3D -1
 memcmp(0xa59c590, 0xa89f8bb, 2, 0x45505553, 0x93a3a52)                =
 =3D 0
 memcpy(0x0a4ee938, "\0302%\n82%\nX3%\n", 12)                          =
 =3D 0x0a4ee938
 strcmp("REF", "SVN::Pool")                                            =
 =3D -1
 strlen("SVN::Pool")                                                   =
 =3D 9
 strcmp("SCALAR", "_p_apr_pool_t")                                     =
 =3D -1
 strlen("_p_apr_pool_t")                                               =
 =3D 13
[etc]

(strace tells me it=E2=80=99s in conversation with the server.)
Hints?
