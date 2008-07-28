From: =?windows-1250?Q?Jurko_Gospodneti=E6?= <jurko.gospodnetic@docte.hr>
Subject: [StGIT] Not working on Windows with msysgit.
Date: Mon, 28 Jul 2008 19:29:49 +0200
Message-ID: <g6kvmc$sqr$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1250;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 19:31:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNWYv-0004kj-EF
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 19:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754980AbYG1RaI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2008 13:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755065AbYG1RaI
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 13:30:08 -0400
Received: from main.gmane.org ([80.91.229.2]:44149 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754914AbYG1RaG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 13:30:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KNWXo-0006mV-Td
	for git@vger.kernel.org; Mon, 28 Jul 2008 17:30:01 +0000
Received: from 87.252.133.29 ([87.252.133.29])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 17:30:00 +0000
Received: from jurko.gospodnetic by 87.252.133.29 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 17:30:00 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 87.252.133.29
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90476>

   Hi.

   I believe StGIT fails to work on Windows with msysgit installed=20
because of the way it runs its external executables. It assumes that th=
e=20
executable is available on the path and is named exactly 'git'.

   This however is not the case on Windows with msysgit installed. Ther=
e=20
the 'git executable' is a batch script named git.cmd and stgit fails to=
=20
find it causing all git calls to return an error code.

   Popen() calls in StGIT's run.py module seem to run their executables=
=20
(git & gitk only as far as I saw from the sources) directly instead of=20
running them through the shell in order to have the shell try all the=20
default extensions (configured on Windows using the PATHEXT environment=
=20
variable).

   One 'fix' that corrects this in all the use cases on Windows that I=20
tried is to add the shell=3DTrue parameter to all Popen() calls in StGI=
T's=20
run.py module (one in __run_io() and one in __run_noio()). This would=20
however require more testing as I do not know how this would affect=20
other OSs or whether there might be some problems with how Windows's=20
default cmd shell handles quoting in the executed command lines. I do=20
recall Python having some serious problems with these quoting in=20
executed commands... something about external quotes getting stripped i=
n=20
some cases... I might be able to dig up a workaround from somewhere if=20
needed...

   I'm using Windows XP SP3 and my git/StGIT/Python version information=
 is:
> Stacked GIT 0.14.3
> git version 1.5.6.1.1071.g76fb
> Python version 2.5.2 (r252:60911, Feb 21 2008, 13:11:45) [MSC v.1310 =
32 bit (Intel)]

   Anyone using StGIT on Windows with sysgit?

   The place where I originally detected this problem is that StGIT=20
fails to read the stgit.editor configuration option with=20
Windows/msysgit. I think it got so far though only because I also had=20
cygwin git a bit later on the path.

   Best regards,
     Jurko Gospodneti=E6
