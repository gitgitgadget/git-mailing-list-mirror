From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: [PATCH RFC] gitk: display submodule diffs with appropriate encoding
Date: Tue,  5 Jan 2010 15:44:54 +0300
Message-ID: <1262695494-27975-1-git-send-email-kirr@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Jan 05 14:11:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS9C8-0007eJ-Ic
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 14:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741Ab0AENJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 08:09:46 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179Ab0AENJq
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 08:09:46 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:52132 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734Ab0AENJp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 08:09:45 -0500
X-Greylist: delayed 1773 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Jan 2010 08:09:44 EST
Received: by landau.phys.spbu.ru (Postfix, from userid 509)
	id EEFDA17B66C; Tue,  5 Jan 2010 15:40:07 +0300 (MSK)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.71)
	(envelope-from <kirr@roro3.zxlink>)
	id 1NS8mc-0007IA-1H; Tue, 05 Jan 2010 15:45:10 +0300
X-Mailer: git-send-email 1.6.6.78.gbd757c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136189>

Previsously, when submodule commits headings contained non-latin-1
characters, they were displayed incorrectly in gitk, because $line was
not properly decoded, i.e.

----------------------------- Documentation/Dokko ---------------------=
--------
Submodule Documentation/Dokko 2ca20c7..0ea204d:
  > =C3=90=C2=9F=C3=91=C2=80=C3=90=C2=BE=C3=91=C2=82=C3=90=C2=BE=C3=90=C2=
=BA=C3=90=C2=BE=C3=90=C2=BB=C3=91=C2=8B =C3=91=C2=81=C3=90=C2=BE=C3=90=C2=
=BF=C3=91=C2=80=C3=91=C2=8F=C3=90=C2=B6=C3=90=C2=B5=C3=90=C2=BD=C3=90=C2=
=B8=C3=91=C2=8F =C3=90=C2=98=C3=90=C2=9C=C3=90=C2=A1 "=C3=90=C2=9C=C3=90=
=C2=BE=C3=91=C2=81=C3=91=C2=82=C3=90=C2=B8=C3=90=C2=BA-21631"  (=C3=90=C2=
=9B=C3=90=C2=982 =C3=90=C2=B8 =C3=90=C2=A1=C3=90=C2=B0=C3=90=C2=BD=C3=90=
=C2=B4=C3=90=C2=B0=C3=90=C2=BB)
  > hardware: =C3=90=C2=B4=C3=90=C2=BE=C3=90=C2=BA=C3=91=C2=83=C3=90=C2=
=BC=C3=90=C2=B5=C3=90=C2=BD=C3=91=C2=82=C3=90=C2=B0=C3=91=C2=86=C3=90=C2=
=B8=C3=91=C2=8F =C3=90=C2=BD=C3=90=C2=B0 InnoDisk SATA 10000
  > hardware: =C3=90=C2=B4=C3=90=C2=BE=C3=90=C2=BA=C3=91=C2=83=C3=90=C2=
=BC=C3=90=C2=B5=C3=90=C2=BD=C3=91=C2=82=C3=90=C2=B0=C3=91=C2=86=C3=90=C2=
=B8=C3=91=C2=8F =C3=90=C2=BD=C3=90=C2=B0 IEI PCISA-6770E2 v3.0
  > hardware: =C3=90=C2=B4=C3=90=C2=BE=C3=90=C2=BA=C3=91=C2=83=C3=90=C2=
=BC=C3=90=C2=B5=C3=90=C2=BD=C3=91=C2=82=C3=90=C2=B0=C3=91=C2=86=C3=90=C2=
=B8=C3=91=C2=8F =C3=90=C2=BD=C3=90=C2=B0 Fastwel NIB941
  > hardware: =C3=90=C2=B4=C3=90=C2=BE=C3=90=C2=BA=C3=91=C2=83=C3=90=C2=
=BC=C3=90=C2=B5=C3=90=C2=BD=C3=91=C2=82=C3=90=C2=B0=C3=91=C2=86=C3=90=C2=
=B8=C3=91=C2=8F =C3=90=C2=BD=C3=90=C2=B0 IEI IPX-9S
  > hardware: =C3=90=C2=B4=C3=90=C2=BE=C3=90=C2=BA=C3=91=C2=83=C3=90=C2=
=BC=C3=90=C2=B5=C3=90=C2=BD=C3=91=C2=82=C3=90=C2=B0=C3=91=C2=86=C3=90=C2=
=B8=C3=91=C2=8F =C3=90=C2=BD=C3=90=C2=B0 Hirschmann 5TX-EEC


instead of

----------------------------- Documentation/Dokko ---------------------=
--------
Submodule Documentation/Dokko 2ca20c7..0ea204d:
  > =D0=9F=D1=80=D0=BE=D1=82=D0=BE=D0=BA=D0=BE=D0=BB=D1=8B =D1=81=D0=BE=
=D0=BF=D1=80=D1=8F=D0=B6=D0=B5=D0=BD=D0=B8=D1=8F =D0=98=D0=9C=D0=A1 "=D0=
=9C=D0=BE=D1=81=D1=82=D0=B8=D0=BA-21631"  (=D0=9B=D0=982 =D0=B8 =D0=A1=D0=
=B0=D0=BD=D0=B4=D0=B0=D0=BB)
  > hardware: =D0=B4=D0=BE=D0=BA=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=
=86=D0=B8=D1=8F =D0=BD=D0=B0 InnoDisk SATA 10000
  > hardware: =D0=B4=D0=BE=D0=BA=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=
=86=D0=B8=D1=8F =D0=BD=D0=B0 IEI PCISA-6770E2 v3.0
  > hardware: =D0=B4=D0=BE=D0=BA=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=
=86=D0=B8=D1=8F =D0=BD=D0=B0 Fastwel NIB941
  > hardware: =D0=B4=D0=BE=D0=BA=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=
=86=D0=B8=D1=8F =D0=BD=D0=B0 IEI IPX-9S
  > hardware: =D0=B4=D0=BE=D0=BA=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=
=86=D0=B8=D1=8F =D0=BD=D0=B0 Hirschmann 5TX-EEC


This fixes it.

Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
---
 gitk |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 86dff0f..0edef8f 100755
--- a/gitk
+++ b/gitk
@@ -7689,8 +7689,10 @@ proc getblobdiffline {bdf ids} {
 	    makediffhdr $fname $ids
 	    $ctext insert end "\n$line\n" filesep
 	} elseif {![string compare -length 3 "  >" $line]} {
+	    set line [encoding convertfrom $diffencoding $line]
 	    $ctext insert end "$line\n" dresult
 	} elseif {![string compare -length 3 "  <" $line]} {
+	    set line [encoding convertfrom $diffencoding $line]
 	    $ctext insert end "$line\n" d0
 	} elseif {$diffinhdr} {
 	    if {![string compare -length 12 "rename from " $line]} {
--=20
1.6.6.78.gbd757c.dirty
