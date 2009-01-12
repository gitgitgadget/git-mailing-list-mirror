From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH v2] git-web--browse: don't add start as candidate on Ubuntu
Date: Mon, 12 Jan 2009 21:05:56 +0000
Message-ID: <496BB0B4.7070303@ramsay1.demon.co.uk>
References: <495D3964.6040006@ramsay1.demon.co.uk> <200901040833.25849.chriscool@tuxfamily.org> <7vljtr33sb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@suse.cz>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 22:10:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMU34-0001aX-5e
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 22:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108AbZALVIr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jan 2009 16:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752825AbZALVIr
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 16:08:47 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:64154 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752332AbZALVIq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jan 2009 16:08:46 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1LMU1c-0002XL-Y1; Mon, 12 Jan 2009 21:08:45 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7vljtr33sb.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105380>

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

  Junio C Hamano wrote:
  > Christian Couder <chriscool@tuxfamily.org> writes:
  >> Le jeudi 1 janvier 2009, Ramsay Jones a =C3=A9crit :
  >> ...
  >>> Does anybody else see this issue and can someone test the patch?
  >> Petr, as you added support for using /bin/start on MinGW, could yo=
u test?
  >>
  >> diff --git a/git-web--browse.sh b/git-web--browse.sh
  >> index 78d236b..7ed0fad 100755
  >> --- a/git-web--browse.sh
  >> +++ b/git-web--browse.sh
  >> @@ -115,7 +115,7 @@ if test -z "$browser" ; then
  >>  	browser_candidates=3D"open $browser_candidates"
  >>      fi
  >>      # /bin/start indicates MinGW
  >> -    if test -n /bin/start; then
  >> +    if test -x /bin/start; then
  >>  	browser_candidates=3D"start $browser_candidates"
  >>      fi
  >=20
  > In any case, the original test is simply bogus.  'test -n "$foo"' i=
s to
  > see if $foo is an empty string, and giving a constant /bin/start al=
ways
  > yields true.
  >=20
  > As an old timer, I tend to prefer "test -f" in this context, as any=
body
  > sane can expect that the directory /bin will contain executables an=
d
  > nothing else.  Another reason is purely stylistic.  Historically "-=
f" has
  > been much more portable than "-x" (which came from SVID), even thou=
gh it
  > wouldn't make much difference in practice in the real world these d=
ays.

Sorry for the late reply; if this has already been resolved, then sorry=
 for
the noise.

I was expecting to be castigated for having /sbin in my $PATH. Indeed, =
I was
a bit surprised... So, I checked my initialization files and then the s=
ystem
initialization files and could not find where it was being set...

    $ strings /bin/bash | grep sbin
    /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
    $ strings /bin/sh | grep sbin
    PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

So I don't think it's anything I'm doing...

Anyway, I've changed the patch as you suggested. It would still be good
if someone on MinGW could test it.

ATB,
Ramsay Jones

 git-web--browse.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-web--browse.sh b/git-web--browse.sh
index 78d236b..c5e62a6 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -115,7 +115,7 @@ if test -z "$browser" ; then
 	browser_candidates=3D"open $browser_candidates"
     fi
     # /bin/start indicates MinGW
-    if test -n /bin/start; then
+    if test -f /bin/start; then
 	browser_candidates=3D"start $browser_candidates"
     fi
=20
--=20
1.6.1
