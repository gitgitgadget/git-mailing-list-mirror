From: Thomas Rast <trast@student.ethz.ch>
Subject: Test failures in today's pu: 0025, 4046, 4203, 9300, 9301
Date: Wed, 20 Oct 2010 11:48:51 +0200
Message-ID: <201010201148.51551.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yann Dirson <ydirson@altern.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 20 11:49:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8VI3-0000Nj-Ry
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 11:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410Ab0JTJsy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Oct 2010 05:48:54 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:19378 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395Ab0JTJsx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Oct 2010 05:48:53 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Wed, 20 Oct
 2010 11:48:52 +0200
Received: from pctrast.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 20 Oct
 2010 11:48:51 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.36-rc8-32-desktop; KDE/4.4.4; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159403>

Hi *

My automatic test bisecter had several failures in today's pu.
Hopefully I picked the right Cc list:

* t0025-crlf-auto still randomly fails, see

    http://mid.gmane.org/201007292340.01836.trast@student.ethz.ch

  Input always welcome on this one.  (That's not why I'm writing, but
  it was a convenient chance to point it out again...)

* t4046-diff-rename-factorize failed and bisected to 22214a1b (Add
  testcases for the --detect-bulk-moves diffcore flag.).

* t4203-mailmap: bisected to d8d2eb7d (mailmap: fix use of freed
  memory).  I saw some list traffic possibly related to this, is it
  fixed already?

* t9300-fast-import: bisected to a544a23c (t9300 (fast-import):
  another test for the "replace root" feature).  The relevant snippet
  is

    ./test-lib.sh: eval: line 413: syntax error near unexpected token `=
)'
    ./test-lib.sh: eval: line 413: `         tree=FFgit rev-parse --ver=
ify N10:) &&'
    not ok - 62 N: modify subtree, extract it, and modify again

  I'm not sure whether the funny character after 'tree' made it
  through the (automated) email alright, but if it did, it is the
  glyph of the Latin1 rendition of 0xff.

* t9301-fast-import-notes: bisected to 5edde51 (fast-import:
  filemodify after M 040000 <tree> "" crashes).  The failure shows

    --- expect      2010-10-20 06:47:16.000000000 +0000
    +++ actual      2010-10-20 06:47:28.000000000 +0000
    @@ -1,800 +1,400 @@
         commit #400
    -    note for commit #400
         commit #399
    -    note for commit #399
         commit #398
    -    note for commit #398
         commit #397
    -    note for commit #397
         commit #396
    -    note for commit #396
         commit #395

  etc.


Recall that this is a RHEL5.5 box that runs a little helper script on
a cronjob, which builds git and then runs the tests under valgrind.
=46or each failing test, it then bisects the failure (again with
valgrind).

=46eel free to ask if you need more information.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
