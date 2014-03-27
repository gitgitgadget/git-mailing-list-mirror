From: "David A. Dalrymple (and Bhushan G. Lodha)" <dad-bgl@mit.edu>
Subject: [PATCH 00/10] [RFC] pickaxe for function names
Date: Thu, 27 Mar 2014 14:50:46 -0400
Message-ID: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: peff@peff.net, l.s.r@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 19:51:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTFOZ-0004iE-Uk
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 19:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757154AbaC0SvP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Mar 2014 14:51:15 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:50312 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757031AbaC0SvP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2014 14:51:15 -0400
X-AuditID: 1207440d-f79d86d0000043db-0a-533473212010
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 1D.36.17371.12374335; Thu, 27 Mar 2014 14:51:13 -0400 (EDT)
Received: from zayin.local.com ([74.212.183.186])
	(authenticated bits=0)
        (User authenticated as davidad@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2RIp9TI013586
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 27 Mar 2014 14:51:12 -0400
X-Mailer: git-send-email 1.7.12.4 (Apple Git-37)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsUixO6iqKtYbBJs0DDPxqLrSjeTxZmt/cwW
	P1p6mB2YPZ717mH0+LxJzuP2s20sAcxRXDYpqTmZZalF+nYJXBkzW9sZCxr5Kw6uvsjawNjO
	3cXIySEhYCLxffocVghbTOLCvfVsILaQwGVGiVcfZboYuYDslUwSi1/eYQFJsAk4S2z6tZ8J
	xBYREJd4e3wmO4jNLCAv8fDrVjBbWMBcouf+H7B6FgFVidsfpoDV8wrYS2xavB1qmYHEp2dn
	mCHighInZz4BqucAmqMusX6eEMzI5q2zmScw8s1CUjULoWoWkqoFjMyrGOUSc0pzdXMTM3OK
	U5N1i5MT8/JSi3SN9HIzS/RSU0o3MULCkHcH4/91MocYBTgYlXh4HSxMgoVYE8uKK3MPMUpw
	MCuJ8M4tAArxpiRWVqUW5ccXleakFh9ilOZgURLnVVui7ickkJ5YkpqdmlqQWgSTZeLglGpg
	lMrNlpApZF0YmL5od6BeFqutq6rZ8xfzTJMP6s2/niMXzRvc0fzmBN+EPaeUsjofmljtD/zh
	8bqwJirVup1Z+WPyeW51pby1jAoCj1Pb9U9ILPL+/GaK4MaJoSKOW7alf44RurO/8FzhprCc
	PY77CzfdXKrRaKqbwKi38+9+QZ/pUcs5r0gqsRRnJBpqMRcVJwIAsozSIT8CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245308>

This series introduces a --function-name=3D<pattern> option for git-log=
, intended
to search for commits which touch a function matching a certain pattern=
 (a
feature we've seen requested and are interested in using ourselves).

This is our first attempt to patch git; we've tried to observe and foll=
ow the
community standards, but we would greatly appreciate feedback. We've be=
en
working on this for a few weeks, and I just noticed that Ren=C3=A9 Scha=
rfe has done
conflicing (and better) refactoring work in diffcore-pickaxe.c a few da=
ys ago.
We'd be happy to rebase our changes and resolve the conflicts once Ren=C3=
=A9's
patches are committed to master, but we thought we may as well ask for =
comments
on the version we have working now.

Thanks for your time!

  .gitattributes: specify the language used
  diffcore-pickaxe.c: refactor regex compilation
  diffcore-pickaxe.c: Refactor pickaxe_fn signature
  diff.c/diff.h: expose userdiff_funcname
  diffcore-pickaxe.c: set up funcname pattern
  log: --function-name pickaxe
  xdiff: add XDL_EMIT_MOREFUNCNAMES to try harder
  xdiff: add XDL_EMIT_MOREHUNKHEADS to split hunks
  t4213: test --function-name option
  Documentation: Document --function-name usage

 .gitattributes                 |   2 +-
 Documentation/diff-options.txt |   9 +++
 Documentation/gitdiffcore.txt  |  17 ++++-
 builtin/log.c                  |   2 +-
 diff.c                         |  13 +++-
 diff.h                         |   3 +
 diffcore-pickaxe.c             | 162 +++++++++++++++++++++++++++++++++=
++-----------
 revision.c                     |   3 +-
 t/t4213-log-function-name.sh   |  73 +++++++++++++++++++++
 xdiff/xdiff.h                  |   2 +
 xdiff/xdiffi.c                 |   2 +-
 xdiff/xemit.c                  |  99 ++++++++++++++++++++++------
 xdiff/xemit.h                  |   4 +-
 13 files changed, 323 insertions(+), 68 deletions(-)
