From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Commits with empty commit messages
Date: Wed, 25 Feb 2009 13:50:03 +0100 (CET)
Message-ID: <alpine.LRH.2.00.0902251338230.21065@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 13:51:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcJEd-0004Si-R3
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 13:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbZBYMuH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2009 07:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752301AbZBYMuH
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 07:50:07 -0500
Received: from vervifontaine.sonytel.be ([80.88.33.193]:62477 "EHLO
	vervifontaine.sonycom.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751183AbZBYMuG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 07:50:06 -0500
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by vervifontaine.sonycom.com (Postfix) with ESMTP id ADD3158ABD;
	Wed, 25 Feb 2009 13:50:03 +0100 (MET)
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111450>

I accidentally managed to create a commit with an empty commit message =
using
`git am' with a patch that didn't have a subject line. It didn't matter=
 much,
as I just wanted to squash it during a rebase anyway.

However, during `git rebase -i', I got a corrupt list of commits. Inste=
ad of
the usual:

| pick sha1 desc1
| pick sha2 desc2

I saw:

| pick sha1 >sha2 desc2

If you have a commit with an empty commit message, you can also not fix=
 this
using amend:

| $ git commit --amend
| fatal: commit has empty message
| $

If you use `git rebase -i' to rebase one or more commits, _all_ of them=
 with
empty commit messages, you don't see any of the familiar `pick' lines, =
but just

| noop

and you `loose' all those commits as soon as you quit your editor.

Probably the real offender is `git am', which allows empty commit messa=
ges,
unlike `git commit'.


While trying to create a clean test case, I also noticed you cannot use
`git am' to create the first commit in a freshly initialized empty git
repository. It fails with:

| $ git am patch
| fatal: HEAD: not a valid SHA1
| fatal: bad revision 'HEAD'
| $

I'm using 1.6.0.4, but I could reproduce the issues with 1.6.2.rc1.41.g=
3f74c.

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village =B7 Da Vincilaan 7-D1 =B7 B-1935 Zaventem =B7 Bel=
gium

Phone:    +32 (0)2 700 8453
=46ax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 =B7 RPR Brussels
=46ortis =B7 BIC GEBABEBB =B7 IBAN BE41293037680010
