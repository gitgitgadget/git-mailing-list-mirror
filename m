From: Torben Hohn <torbenh@linutronix.de>
Subject: corner case with rename tracking and reverts
Date: Mon, 2 Jul 2012 14:47:54 +0200
Message-ID: <20120702124754.GA25882@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 02 14:48:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Slg37-0004VQ-OU
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jul 2012 14:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869Ab2GBMsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 08:48:11 -0400
Received: from www.linutronix.de ([62.245.132.108]:45519 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793Ab2GBMsK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 08:48:10 -0400
Received: from torbenh by Galois.linutronix.de with local (Exim 4.72)
	(envelope-from <torbenh@linutronix.de>)
	id 1Slg2z-000180-UG
	for git@vger.kernel.org; Mon, 02 Jul 2012 14:48:09 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200853>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


Hi...

i just came over some issue, where the rename tracking got confused.

I wanted to revert a commit to a moved file. But because it touched an
empty file, this seems to have confused the rename tracking.
(there were a few empty files there)

Attached is a shell script, that reproduces the issue.

The Problem is, that bla2 shows up in omg3, when "bla2 empty" is
reverted.

This was produced with git 1.7.10 from debian.


-- 
Mit freundlichen Grüßen
Torben Hohn

Linutronix GmbH

Standort: Bremen

Phone: +49 421 166 73 41 ; Fax.: +49 7556 919 886
mailto: torbenh@linutronix.de
Firmensitz / Registered Office: D-88690 Uhldingen, Auf dem Berg 3
Registergericht / Local District Court: Freiburg i. Br., HRB Nr. / Trade
register no.: 700 806;

Geschäftsführer / Managing Directors: Heinz Egger, Thomas Gleixner

--3V7upXqbjpZ4EhLz
Content-Type: application/x-sh
Content-Disposition: attachment; filename="revert-mv.sh"
Content-Transfer-Encoding: quoted-printable

=0Amkdir gitrepo=0Acd gitrepo=0A=0Agit init=0A=0Aecho bla1 > bla1=0Aecho bl=
a2 > bla2=0Aecho bla3 > bla3=0A=0A# Add some files and commit em.=0Agit add=
 bla1=0Agit commit -m "bla1"=0A=0Agit add bla2=0Agit commit -m "bla2"=0A=0A=
git add bla3=0Agit commit -m "bla3"=0A=0A=0A# Now make them empty.=0Arm bla=
1; touch bla1=0Arm bla2; touch bla2=0Arm bla3; touch bla3=0A=0A# Commit tha=
t.=0Agit add bla1=0Agit commit -m "bla1 empty"=0A=0Agit add bla2=0Agit comm=
it -m "bla2 empty"=0A=0Agit add bla3=0Agit commit -m "bla3 empty"=0A=0A# Mo=
ve files=0Agit mv bla1 omg1=0Agit mv bla2 omg2=0Agit mv bla3 omg3=0A=0A=0Ag=
it commit -m "move em"=0A=0Agit revert --no-edit HEAD~3=0Agit revert --no-e=
dit HEAD~3=0Agit revert --no-edit HEAD~3=0A=0A=0Acat omg*=0A
--3V7upXqbjpZ4EhLz--
