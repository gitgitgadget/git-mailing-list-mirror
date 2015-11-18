From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: [BUG] gitk --all and git bisect visualize crash in non-english locale
Date: Wed, 18 Nov 2015 19:31:15 +0100
Message-ID: <vpqa8qbrwgc.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Nov 18 19:31:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zz7W1-0002n6-Kz
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 19:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755226AbbKRSb3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Nov 2015 13:31:29 -0500
Received: from mx2.imag.fr ([129.88.30.17]:47267 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754713AbbKRSb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2015 13:31:29 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id tAIIVDTi021033
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 18 Nov 2015 19:31:13 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id tAIIVFAN003895;
	Wed, 18 Nov 2015 19:31:15 +0100
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 18 Nov 2015 19:31:13 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: tAIIVDTi021033
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1448476273.97972@8D6dlCBtC48ahAqgDFPINA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281455>

Hi,

I'm getting the following crash on recent gitk:

  $ LANG=3Dfr_FR gitk --all
  Error in startup script: bad menu entry index "=C9diter la vue..."
      while executing
  ".bar.view entryconf [mca "Edit view..."] -state normal"
      invoked from within
  "if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne=
 {}} {
      # create a view for the files/dirs specified on the command line
      se..."
      (file "/home/moy/local/usr-jessie/bin/gitk" line 12442)

It's linked to the locale:

  $ LANG=3DC gitk --all
  # Just works

but does not seem to be related to French in particular nor to the
accent:

  $ LANG=3Des_ES gitk --all
  Error in startup script: bad menu entry index "Modificar vista..."
      while executing
  ".bar.view entryconf [mca "Edit view..."] -state normal"
      invoked from within
  "if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne=
 {}} {
      # create a view for the files/dirs specified on the command line
      se..."
      (file "/home/moy/local/usr-jessie/bin/gitk" line 12442)

It also works fine without --all.

It bisects down to:

commit d99b4b0de27a2bd654a40353b65883e368da6d06
Author: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Date:   Wed Sep 9 15:20:53 2015 +0200

    gitk: Accelerators for the main menu
   =20
    This allows fast, keyboard-only usage of the menu (e.g. Alt+V, N to=
 open a
    new view).
   =20
    Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

I'm not fluent enough in Tcl to fix this myself, sorry ;-).

Thanks,

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
