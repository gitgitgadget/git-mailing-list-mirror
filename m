From: Tobias Getzner <tobias.getzner@gmx.de>
Subject: [BUG] Mojibake in git gui and gitk for certain unicode chars
Date: Thu, 22 Jan 2015 12:43:21 +0100
Message-ID: <1421927001.11296.27.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 22 12:43:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEGAa-0006vc-Gr
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 12:43:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbbAVLnZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jan 2015 06:43:25 -0500
Received: from mout.gmx.net ([212.227.17.21]:58997 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751595AbbAVLnX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jan 2015 06:43:23 -0500
Received: from glenalbyn.linguistics.ruhr-uni-bochum.de ([134.147.14.84]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MZ7bs-1Xzu9003cC-00KxcD
 for <git@vger.kernel.org>; Thu, 22 Jan 2015 12:43:22 +0100
X-Mailer: Evolution 3.12.10 
X-Provags-ID: V03:K0:v1iXu+ZpJXk48XNIbVKQQZithtjkRilr3r82WPVddQmJMjMJY6h
 QfeTzfL5Dlo8sWMxZeYI72D2k5j8JAERLx+3u1WPr37UyvrVBJ5NWosUvHfLZ+2LEqN6zzE
 /ZuxQQkwF9qFZevbj0UG2jQKBgzLpbKGy15sIxKiaEDBK2ZsaC5qL9fou2pxw+eraznPrXI
 m/cLFk4GbHkVP96iLe0Ig==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262818>

Hello,

I=E2=80=99ve noticed git gui and gitk seem to have problems decoding ce=
rtain
unicode characters. E.g., when a commit contains the character =C2=AB=F0=
=9F=91=8D=C2=BB
(thumbs up sign; U+1F44D) in UTF-8 encoding, this character will show
as =C2=AB=C3=B0=C2=9F=C2=91=C2=8D=C2=BB in gitk. git gui also displays =
it using the same sequence.
When trying to stage lines within the context of such characters, the
program will error out (corrupt patch).

The character sequence appears to be mojibake introduced by decoding
UTF-8 as ISO-8859-1. However, my locale is set to =C2=ABen_US.utf8=C2=BB=
=2E git gui
is also set to assume UTF-8 encoding for files, and in the list menu
where this encoding is selected, it lists the UTF-8 option under
=C2=ABsystem encoding=C2=BB, which suggests that my locale is correctly=
 picked
up.

Is there perchance any heuristics in place which tries decoding files
as unicode, with a fall-back to latin1? If so, then potentially the bug
could be due to U+1F44D tripping up the decoder, triggering a
fall-back, and rendering the characters as mojibake.

I=E2=80=99ve noticed a perhaps related glitch when the options in git g=
ui is
shown. My committer name contains the character =C2=AB=C3=9F=C2=BB (lat=
in small letter
sharp s; U+00DF). The text field in the options dialog displays this as
=C2=AB=C3=83=C2=9F=C2=BB, which also seems to be UTF-8 to latin1 mojiba=
ke. Curiously, the
same character displays just fine when staging parts of files via git
gui, so the issue is not quite the same as the one described above.

Best regards,
Tobias
