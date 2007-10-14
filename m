From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git blame crashes with internal error
Date: Sun, 14 Oct 2007 18:37:02 +0200
Message-ID: <20071014163702.GA2776@steel.home>
References: <20071014143628.GA22568@atjola.homenet>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: =?iso-8859-15?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 14 18:37:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih6Sx-0003DC-2o
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 18:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755731AbXJNQhH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2007 12:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755272AbXJNQhG
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 12:37:06 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:56291 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754848AbXJNQhF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 12:37:05 -0400
Received: from tigra.home (Fc8ce.f.strato-dslnet.de [195.4.200.206])
	by post.webmailer.de (fruni mo1) (RZmta 13.4)
	with ESMTP id e02d43j9EAU6UW ; Sun, 14 Oct 2007 18:37:03 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 19708277AE;
	Sun, 14 Oct 2007 18:37:03 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id A167756D22; Sun, 14 Oct 2007 18:37:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071014143628.GA22568@atjola.homenet>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow0sy8=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60866>

Bj=F6rn Steinbrink, Sun, Oct 14, 2007 16:36:28 +0200:
> Hi Junio,
>=20
> git blame just decided to crash on me, when I tried to use it while
> resolving a merge conflict. Interesting is probably, that it crashes
> when given the filename of a file that is not _directly_ affected by =
the
> merge, but contains code that originates from a file that caused
> conlicts.
>=20
> Error message is:
> fatal: internal error: ce_mode is 0
>=20

It is not crashing. It is just not handling unexpected situation
properly:

    $ testcase.sh
    ...
    Switched to branch "foo"
    CONFLICT (delete/modify): file1 deleted in HEAD and modified in mas=
ter. Version master of file1 left in tree.
    Automatic merge failed; fix conflicts and then commit the result.
    fatal: internal error: ce_mode is 0
    $ git ls-files --cached --stage
    100644 72139f38953679bd19b3a7938c479d73c1aa7b59 1       file1
    100644 3181f904ce3f9364b08524edd262a7a2ac766c9c 3       file1
    100644 24e1ea80d6dcc497f60597b2a6d7cf65ecaa958a 0       file2

See? There is an unresolved merge.

The question is, what's the problem...
