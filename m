From: =?windows-1252?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: zip files created with git archive flags text files as binaries
Date: Mon, 23 Feb 2015 20:30:44 +0100
Message-ID: <54EB7FE4.7070804@web.de>
References: <12g5ss8uqwflv.dlg@nililand.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: luatex@nililand.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 20:31:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPyit-0006A5-0r
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 20:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165AbbBWTbO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Feb 2015 14:31:14 -0500
Received: from mout.web.de ([212.227.15.4]:60011 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135AbbBWTbO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 14:31:14 -0500
Received: from [192.168.178.27] ([79.250.163.41]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MJlGW-1YR4eJ1VAa-001BDZ; Mon, 23 Feb 2015 20:31:11
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <12g5ss8uqwflv.dlg@nililand.de>
X-Provags-ID: V03:K0:/FBEuzlbr9TfqdlST4O6C3nwNMn/FvM4WsSiClPkrr9O5/B9UdW
 C3zfc7UEeKeaB6O5KjQ2BNEWPIeJ/AmyO/CQFDRui6pt24Skva2rBdUOvdPWPzddUwTtHA2
 6J15eCJ2NDSoDtfcRjnsi/QEh21vil6SQn54Y5xHJj34Zl9OMq6zKDAKtEYVpUGkkzE/wKk
 4f7sNfd86yHNTYM1FLvFQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264289>

Am 23.02.2015 um 14:58 schrieb Ulrike Fischer:
> I'm using git on windows 7.
>
> $ git --version
> git version 1.9.4.msysgit.0

Git's code for ZIP file creation hasn't changed since then.

> Some days ago I uploaded a latex package to CTAN (www.ctan.org).
> I created the zip-file with
>
> git archive --format=3Dzip --prefix=3Dciteall/
> --output=3Dzip/citeall_2015-02-20.zip HEAD
>
> The zip contained four text files and a pdf.
>
> The CTAN maintainers informed me that all files in the zip are
> flagged as binaries and this makes it difficult for them to process
> them further (they want to correct line feeds of the text files:
> http://mirror.ctan.org/tex-archive/help/ctan/CTAN-upload-addendum.htm=
l#crlf)

I wouldn't have expected that this ZIP file attribute is actually used=20
in the wild.

> unzip -Z reports for my zip:
>
> $ unzip -Z citeall_2015_02_20.zip
> Archive:  citeall_2015_02_20.zip
> Zip file size: 105509 bytes, number of entries: 6
> drwx---     0.0 fat        0 bx stor 15-Feb-20 17:07 citeall/
> -rw----     0.0 fat      458 bx defN 15-Feb-20 17:07 citeall/README
> -rw----     0.0 fat   102244 bx defN 15-Feb-20 17:07
> citeall/citeall.pdf
> -rw----     0.0 fat     3431 bx defN 15-Feb-20 17:07
> citeall/citeall.sty
> -rw----     0.0 fat     3971 bx defN 15-Feb-20 17:07
> citeall/citeall.tex
> -rw----     0.0 fat      557 bx defN 15-Feb-20 17:07
> citeall/examples-citeall.bib
> 6 files, 110661 bytes uncompressed, 104669 bytes compressed:  5.4%
>
> The problem are all the "bx" entries.

The "x" is due to the extra mtime header and unrelated to your issue.

"b" (binary) is set unconditionally to ensure that line endings are kep=
t=20
intact by unpackers on all platforms.

"fat" is used as lowest common denominator for regular files and=20
directories; "unx" is used for symbolic links.

> When I zip all the files with the standard windows zip-tool I get
> this:
>
> $ unzip -Z citeall-win.zip
> Archive:  citeall-win.zip
> Zip file size: 105275 bytes, number of entries: 5
> -rw----     2.0 fat   102244 b- defN 15-Feb-20 17:07
> citeall/citeall.pdf
> -rw----     2.0 fat     3431 t- defN 15-Feb-20 17:07
> citeall/citeall.sty
> -rw----     2.0 fat     3971 t- defN 15-Feb-20 17:07
> citeall/citeall.tex
> -rw----     2.0 fat      557 t- defN 15-Feb-20 17:07
> citeall/examples-citeall.bib
> -rw----     2.0 fat      458 t- defN 15-Feb-20 17:07 citeall/README
> 5 files, 110661 bytes uncompressed, 104675 bytes compressed:  5.4%
>
> Here the text files have a correct t flag.
>
> I don't know if it the problem exists also with zips created with
> git archive on non-windows OS.

Yes, git archive creates the same ZIP files everywhere.

> Would it be possible to correct the zip-backend so that it flags
> text files correctly? Or alternativly could one configure git
> archive to use another zip programm?

We would have to detect the line ending format (DOS, Unix, Macintosh,=20
etc.) of each file, then set the attribute "t" (text) and the host=20
system.  The detection would slow down archive creation a bit and the=20
resulting files would be different, of course, so this feature should=20
only be enabled by a new command line option.  I'll take a look.

Ren=E9
