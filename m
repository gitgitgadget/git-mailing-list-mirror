From: Magnus =?iso-8859-1?Q?B=E4ck?= <baeck@swipnet.se>
Subject: Re: Implementing stat() with FindFirstFile()
Date: Tue, 24 Mar 2009 22:54:16 +0100
Message-ID: <20090324215416.GB27249@jeeves.jpl.local>
References: <20090321154738.GA27249@jeeves.jpl.local> <200903212055.15026.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 23:16:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmEuv-0003lG-ED
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 23:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbZCXWOq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 18:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752030AbZCXWOq
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 18:14:46 -0400
Received: from proxy1.bredband.net ([195.54.101.71]:43875 "EHLO
	proxy1.bredband.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbZCXWOp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 18:14:45 -0400
X-Greylist: delayed 1222 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Mar 2009 18:14:45 EDT
Received: from ironport2.bredband.com (195.54.101.122) by proxy1.bredband.net (7.3.139)
        id 49C91729000142FA for git@vger.kernel.org; Tue, 24 Mar 2009 22:54:20 +0100
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AikzACPzyElT4/BMPGdsb2JhbACBUJQOAQEBAR4XC70Mg3YG
X-IronPort-AV: E=Sophos;i="4.38,415,1233529200"; 
   d="scan'208";a="466271091"
Received: from ua-83-227-240-76.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.240.76])
  by ironport2.bredband.com with ESMTP; 24 Mar 2009 22:54:20 +0100
Received: from jeeves.jpl.local (jeeves.jpl.local [192.168.7.3])
	by elwood.jpl.local (Postfix) with ESMTP id 5A0324229F
	for <git@vger.kernel.org>; Tue, 24 Mar 2009 22:54:19 +0100 (CET)
Received: by jeeves.jpl.local (Postfix, from userid 100)
	id D40E33C2D; Tue, 24 Mar 2009 22:54:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200903212055.15026.j6t@kdbg.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114500>

On Saturday, March 21, 2009 at 20:55 CET,
     Johannes Sixt <j6t@kdbg.org> wrote:

> On Samstag, 21. M=E4rz 2009, Magnus B=E4ck wrote:
>
> > Is there any reason why compat/win32.h uses GetFileAttributesEx()
> > instead of FindFirstFile() to implement the stat() call on Windows?
> > The current implementation requires each queried file to be opened
> > and closed while FindFirstFile() only reads the directory.
>=20
> There is: File times are extremely important for git. Unfortunately,
> MS's implementation of stat and utime are broken, and they do use
> FindFirstFile(). Read up on the topic here:
>=20
> http://search.cpan.org/~shay/Win32-UTCFileTime-1.50/lib/Win32/UTCFile=
Time.pm

Quite interesting, thanks. As it often is, "obvious" changes that
haven't been made aren't that obvious after all.

=46rom what I gather the problematic conversion takes place in the Win3=
2
layer, in which case we might be able to call the ZwQueryDirectoryFile(=
)
kernel routine directly via ntdll.dll to obtain the file times straight
from the file system. Has anyone explored that path, and would it be
acceptable to make such a change?

[...]

--=20
Magnus B=E4ck
baeck@swipnet.se
