From: Eli Barzilay <eli@barzilay.org>
Subject: `*' gitignores and nested ignores
Date: Thu, 24 Mar 2011 06:10:00 -0400
Message-ID: <19851.6264.179471.935771@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 12:13:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2iUI-0008EP-4b
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 12:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933Ab1CXLNx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2011 07:13:53 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:34429 "EHLO
	winooski.ccs.neu.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458Ab1CXLNw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2011 07:13:52 -0400
X-Greylist: delayed 3830 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Mar 2011 07:13:52 EDT
Received: from winooski.ccs.neu.edu (localhost.localdomain [127.0.0.1])
	by winooski.ccs.neu.edu (8.14.4/8.14.4) with ESMTP id p2OAA14B027923
	for <git@vger.kernel.org>; Thu, 24 Mar 2011 06:10:01 -0400
Received: (from eli@localhost)
	by winooski.ccs.neu.edu (8.14.4/8.14.4/Submit) id p2OAA07r027919;
	Thu, 24 Mar 2011 06:10:00 -0400
X-Mailer: VM 8.1.93a under 23.2.1 (x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169913>

According to the man page, a .gitignore file that is deeper has higher
precedence, and a `!' line overrides lower precedence ignores.  I
tried that, and it works in cases like the last "vmlinux*" example.

But it doesn't work if the lower precedence directory has a "*"
pattern.  If the last example from the man page is changed to:

               $ cat .gitignore
               *
               $ ls arch/foo/kernel/vm*
               arch/foo/kernel/vmlinux.lds.S
               $ echo =C2=B4!/vmlinux*=C2=B4 >arch/foo/kernel/.gitignor=
e

then -- IIUC -- the second ignore should work the same, but it
doesn't.  This also happens if the first pattern is "/*".

Is this a bug?


BTW, my use case is to track random stuff in a directory that has lots
of junk.  I wanted to do this by having a toplevel "/*" ignore and add
files explicitly when I want to.  But there are some directories that
should be tracked, and I was trying to achieve this effect by adding a
"!/*" pattern in them.  Is there a more convenient (or saner) way of
doing this?

--=20
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay=
:
                    http://barzilay.org/                   Maze is Life=
!
