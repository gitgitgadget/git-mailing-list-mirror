From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2] mergetools: add winmerge as a builtin tool
Date: Thu, 14 May 2015 23:48:30 +0200
Message-ID: <1431640110-8484-1-git-send-email-szeder@ira.uka.de>
References: <5553B61D.7050204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	David Aguilar <davvid@gmail.com>,
	Phil Susi <phillsusi@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 23:48:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt0zM-0006C0-Ci
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 23:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161153AbbENVsQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2015 17:48:16 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:36184 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161106AbbENVsP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2015 17:48:15 -0400
Received: from x590c510f.dyn.telefonica.de ([89.12.81.15] helo=localhost)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1Yt0zD-0007RV-6Y; Thu, 14 May 2015 23:48:12 +0200
X-Mailer: git-send-email 1.9.5.msysgit.0
In-Reply-To: <5553B61D.7050204@gmail.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1431640092.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269104>

> for directory in "$(env | grep -E '^PROGRAM(FILES(\(X86\))?|W6432)=3D=
' | cut -d '=3D' -f 2 | sort -u)"
> do
>      test -n "$directory" &&
>      test -x "$directory/$winmerge_exe" &&
>      echo "$directory/$winmerge_exe" &&
>      break
> done

This ain't gonna work, because the output of the pipe won't be split
because of the quotes around the command substitution, so $directory wi=
ll
hold everything.  Simply loosing those quotes is not good either, becau=
se
the output will be split on the spaces as well, leading to 'C:\Program'=
,
'Files' and '(x86)', unless the space is already removed from IFS.  IIR=
C
Windows doesn't allow newlines in pathnames, so IFS=3D$'\n' and removin=
g the
quotes around the command substitution should do the trick.

Pathnames can contain '=3D' characters, so, while I think it's outrageo=
us,
the paths in those variables can also contain an '=3D' or two.  Well,
theoretically, at least, and in that case the 'cut -d=3D -f2' will cut =
off
the end of the pathname.  I don't know whether this is something to be
worth worrying about, but in that case it should be 'cut -d=3D -f2-'.


G=E1bor
