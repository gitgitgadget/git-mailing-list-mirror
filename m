From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: .git/info/exclude w/ CFLF fails in cygwin
Date: Sat, 8 Sep 2007 12:36:03 +0200
Message-ID: <200709081236.04411.robin.rosenberg.lists@dewire.com>
References: <20070908010139.GA5501@falcon.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jing Xue <jingxue@digizenstudio.com>
X-From: git-owner@vger.kernel.org Sat Sep 08 12:34:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITxe0-0007AM-O4
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 12:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbXIHKeY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 8 Sep 2007 06:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbXIHKeX
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 06:34:23 -0400
Received: from [83.140.172.130] ([83.140.172.130]:28860 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750903AbXIHKeX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 06:34:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 5F4D78030C7;
	Sat,  8 Sep 2007 12:26:23 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 09299-05; Sat,  8 Sep 2007 12:26:23 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 03C218030C4;
	Sat,  8 Sep 2007 12:26:22 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <20070908010139.GA5501@falcon.digizenstudio.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58117>

l=F6rdag 08 september 2007 skrev Jing Xue:
> (1.5.3.1 in cygwin, Win XP)
> I have cygwin configured to operate in the DOS/text mode, which means
> cygwin translates LF to CRLF when writing a file, and CRLF to LF when
> reading.  Unfortunately cygwin's fstat() implementation doesn't take =
the
> mode into account when reporting stat.st_size, presumably for the sak=
e
> of performance, while read() does actually do the conversion.

This is not just cygwin and applies to all CRLF environments.

> That causes the function add_excludes_from_file_1() in dir.c to rejec=
t a
> .git/info/exclude file with CRLF ending, because the size actually re=
ad
> is not the same as the size reported by fstat().

> The simplest fix I have found is to explicitly open the exclude file =
in
> binary mode, because the rest of the exclude file parsing code actual=
ly
> deals with CRLF quite fine.
>=20
> I would submit a patch but I am not sure if this is the appropriate f=
ix.
doubt it is worth it..
>=20
> By the way, parsing .git/config with CRLF in the same environment wor=
ks
> fine because the code reads the file by byte and doesn't do any size
> validation.
>=20
> Any thoughts?

I have cygwin in CRLF mode too, but I have binary-mounted the paths' wh=
ere
I use git to avoid the problem. I did a half-hearted attempt to fix git=
 in CRLF mode,
but it failed because in some places plumbing commands communicate via =
files
and in other pipes are used making it hard to get then right translatio=
n mode.

That is not to say it is impossible, but as I understand it the Cygwin =
project have
essentially given up on CRLF mode, so it will probably go away as progr=
ams get
updated and no longer works in translated mode.

Try git in unix mode and, if you need it, use the core.autocrl setting =
to have git
translate explicitly. There are plenty editors that honour line endings=
 in Windows
so LF mode works out quite well nowadays (for me, on my machines).

-- robin
