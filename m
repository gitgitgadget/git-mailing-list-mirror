From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: stgit truncates binary files to zero length when applying patches
Date: Tue, 15 Nov 2005 15:42:23 +0100
Message-ID: <20051115144223.GA18111@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 15:46:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec21J-0003yL-9G
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 15:42:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbVKOOmq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 Nov 2005 09:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbVKOOmq
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 09:42:46 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:11785 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1751436AbVKOOmp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 09:42:45 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Ec20t-0004qP-00; Tue, 15 Nov 2005 14:42:23 +0000
To: catalin.marinas@gmail.com
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11905>

When applying patches and not fast-forwarding, stgit truncates the
binary files to zero length:

  $ cg-init .
  defaulting to local storage area
  Committing initial tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
  Committed as 73161b6ee428ac8b1c1b16b560c40e13330693d2.

  $ stg init

  $ stg new foo
  Invoking the editor: "emacs .stgit.msg"... done (exit code: 0)

  $ cp /bin/bash .

  $ stg add bash

  $ stg refresh
  Refreshing patch "foo"... done

  $ ls -l
  total 584
  -rwxr-xr-x  1 kha vtech 593304 Nov 15 15:34 bash*

  $ stg pop
  Popping patch "foo"... done
  No patches applied

  $ stg new bar
  Invoking the editor: "emacs .stgit.msg"... done (exit code: 0)

  $ echo bar > bar.txt

  $ stg add bar.txt

  $ stg refresh
  Refreshing patch "bar"... done

  $ stg push foo
  Pushing patch "foo"... done
  Now at patch "foo"

  $ ls -l
  total 4
  -rw-r--r--  1 kha vtech 4 Nov 15 15:34 bar.txt
  -rwxr-xr-x  1 kha vtech 0 Nov 15 15:35 bash*

Without the "bar" patch, popping and then pushing "foo" works as
expected.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
