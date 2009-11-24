From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: more problems with commit encoding [Was: [PATCH] shortlog: respect
	commit encoding]
Date: Tue, 24 Nov 2009 17:08:37 +0100
Message-ID: <20091124160837.GA7296@pengutronix.de>
References: <20091111141342.GA1849@pengutronix.de> <1259075555-7831-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiri Kosina <jkosina@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 24 17:08:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCxwb-0001bx-4y
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 17:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933280AbZKXQId convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Nov 2009 11:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933208AbZKXQIc
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 11:08:32 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41581 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933184AbZKXQIc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 11:08:32 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1NCxwU-0003TO-3S; Tue, 24 Nov 2009 17:08:38 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1NCxwT-0004jA-Oz; Tue, 24 Nov 2009 17:08:37 +0100
Content-Disposition: inline
In-Reply-To: <1259075555-7831-1-git-send-email-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133579>

Hello,

On Tue, Nov 24, 2009 at 04:12:35PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Before this change the author was taken from the raw commit without
> reencoding.
while at it, userformats have the same problem:

	linux-2.6$ for rev in b71a8eb bc9be01; do git show --format=3D%an $rev=
 | head -n1; git show $rev | grep Auth; done
	Uwe Kleine-K=EF=BF=BDnig
	Author: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
	Uwe Kleine-K=C3=B6nig
	Author: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

That is, git show correctly reencodes its output for b71a8eb, but only
without --format=3D...

(The patches above are in linux-next.)

And now take this (assuming locale and commitencoding are utf-8):

	git init
	git config user.name 'J=C3=B6h=C3=A4nn=C3=ABs Dsch=C3=B6'
	echo spam > ham
	git add ham
	git commit -m 'initial commit'
	git branch branch
	echo more spam > ham
	git add ham
	git commit -m "Commitlog matching '\nencoding:'

encoding: latin1
"
	git checkout branch
	echo much more spam > ham
	git add ham
	git commit -C master
	git show | grep Author:

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=C3=B6nig  =
          |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
