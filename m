From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [RFC] rerere to recreate topic branches
Date: Tue, 10 Mar 2009 10:32:00 +0100
Message-ID: <20090310093200.GA12931@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>,
	Debian TopGit maintainers <pkg-topgit@teams.debian.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 10:33:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgyLE-0005SR-Fw
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 10:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460AbZCJJcH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2009 05:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753181AbZCJJcF
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 05:32:05 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46322 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759AbZCJJcD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 05:32:03 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LgyJc-00019N-Vb; Tue, 10 Mar 2009 10:32:00 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1LgyJc-0003Ot-C1; Tue, 10 Mar 2009 10:32:00 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112796>

Hello,

Ingo sent a similar mail some time ago[1], that's why I Cc: him.

=46or TopGit I want something similar as Ingo for -tip (I think): recre=
ate
a branch with a cleaned up history but without throwing away merge
resolutions.

I think most points from Ingo's mail are already addressed.  Let's see
if my mail is equally successful :-)

One step that wasn't in Ingo's list, but I consider nice is the
following workflow:

	export GIT_RR_CACHE=3D$(mktemp -d)
	git rerere add-to-cache-from origin..$branch_to_rebuild
	script doing the actual rebuild

together with rerere.autocommit=3Dtrue.  Even though rerere is not save=
 in
general, this workflow seems fine.  I think with this approach sharing
the rr-cache isn't an issue anymore and merge conflicts that need manua=
l
work should be quite rare, even if you do it for the first time.

I just found contrib/rerere-train.sh, which already addresses a part of
my plan.

One of my further goals is to do as much transformation without touchin=
g
the working copy (to gain speed and comfort).  For that I would need gi=
t
merge to operate on an index, only and only fall back to using the
working copy if manual intervention is needed.

I have to admit that up to now I didn't look into the corresponding
code, so consider this mail (only) as starter to collect ideas and
comments.

Best regards
Uwe

[1] http://thread.gmane.org/gmane.comp.version-control.git/85176/

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
