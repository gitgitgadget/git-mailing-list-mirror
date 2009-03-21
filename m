From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Implementing stat() with FindFirstFile()
Date: Sat, 21 Mar 2009 20:55:14 +0100
Message-ID: <200903212055.15026.j6t@kdbg.org>
References: <20090321154738.GA27249@jeeves.jpl.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Magnus =?iso-8859-1?q?B=E4ck?= <baeck@swipnet.se>
X-From: git-owner@vger.kernel.org Sat Mar 21 20:57:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll7JQ-0003nU-G7
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 20:56:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754406AbZCUTzV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Mar 2009 15:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753570AbZCUTzV
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 15:55:21 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:59060 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753750AbZCUTzU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 15:55:20 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1C54ACDF82;
	Sat, 21 Mar 2009 20:55:15 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id A08C11D235;
	Sat, 21 Mar 2009 20:55:15 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20090321154738.GA27249@jeeves.jpl.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114054>

On Samstag, 21. M=E4rz 2009, Magnus B=E4ck wrote:
> Is there any reason why compat/win32.h uses GetFileAttributesEx()
> instead of FindFirstFile() to implement the stat() call on Windows?
> The current implementation requires each queried file to be opened
> and closed while FindFirstFile() only reads the directory.

There is: File times are extremely important for git. Unfortunately, MS=
's=20
implementation of stat and utime are broken, and they do use FindFirstF=
ile().=20
Read up on the topic here:

http://search.cpan.org/~shay/Win32-UTCFileTime-1.50/lib/Win32/UTCFileTi=
me.pm

To quote the important sentence:

"The problem with Microsoft's stat(2) and utime(2) [...] is basically t=
his:=20
file times reported by stat(2) or stored by utime(2) may change by an h=
our as=20
we move into or out of daylight saving time (DST) if the computer is se=
t=20
to "Automatically adjust clock for daylight saving changes" [...]."

Be sure to read section "Background Reference".

Besides that, our stat() implementation is already ca. twice as fast as=
=20
MSVCRT's stat(). (Thank you, Marius!)

-- Hannes
