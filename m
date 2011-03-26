From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] HOME must be set before calling git-init when creating
	test repositories
Date: Sat, 26 Mar 2011 19:46:34 +0100
Message-ID: <20110326184634.GB13496@blimp.localdomain>
References: <7vsjub53j2.fsf@alter.siamese.dyndns.org> <AANLkTimQzPVOWCUx1hr+DEmRfdFB8=UeY_xCaxzVSwFy@mail.gmail.com> <7voc4y6g6v.fsf@alter.siamese.dyndns.org> <AANLkTikO4=TtFtpsQ_JtmGKqQ1NzgTuo7e8cdaQca+T7@mail.gmail.com> <7vvcz64ygm.fsf@alter.siamese.dyndns.org> <AANLkTi=+SZGxLyP8vFPpmK8DZvke6-Tu-crwq5+89qWx@mail.gmail.com> <20110326141118.GA3475@sigill.intra.peff.net> <20110326182126.GA13496@blimp.localdomain> <20110326183102.GA3796@sigill.intra.peff.net> <AANLkTi=Pt_Pw9BvL6y8Wq34PeRHVOZpr6ZekRYqfDXq6@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 26 19:46:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3YVh-0007mk-6e
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 19:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753637Ab1CZSqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2011 14:46:48 -0400
Received: from mout0.freenet.de ([195.4.92.90]:58385 "EHLO mout0.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753488Ab1CZSqs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2011 14:46:48 -0400
Received: from [195.4.92.28] (helo=18.mx.freenet.de)
	by mout0.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.72 #3)
	id 1Q3YVT-0002tu-4G; Sat, 26 Mar 2011 19:46:39 +0100
Received: from krlh-5f7246c3.pool.mediaways.net ([95.114.70.195]:37278 helo=tigra.home)
	by 18.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 25) (Exim 4.72 #3)
	id 1Q3YVT-0005F7-1B; Sat, 26 Mar 2011 19:46:39 +0100
Received: from blimp.localdomain (unknown [192.168.0.94])
	by tigra.home (Postfix) with ESMTP id 1DACE9FD2E;
	Sat, 26 Mar 2011 19:46:35 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id C2FAA36D28; Sat, 26 Mar 2011 19:46:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTi=Pt_Pw9BvL6y8Wq34PeRHVOZpr6ZekRYqfDXq6@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170067>

Otherwise the created test repositories will be affected by users ~/.gitconfig.
For example, setting core.logAllrefupdates in users config will make all
calls to "git config --unset core.logAllrefupdates" fail which will break
the first test which uses the statement and expects it to succeed.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Alex Riesen, Sat, Mar 26, 2011 19:42:14 +0100:
> On Sat, Mar 26, 2011 at 19:31, Jeff King <peff@peff.net> wrote:
> >
> > So you can simplify this to just:
> >
> > HOME=$TRASH_DIRECTORY
> 
> Aah... I should have actually looked at the "case" which
> sets TRASH_DIRECTORY!
> 
> Will resend in a moment.

Here.

 t/test-lib.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7cc9a52..7965b74 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -984,14 +984,14 @@ rm -fr "$test" || {
 	exit 1
 }
 
+HOME="$TRASH_DIRECTORY"
+export HOME
+
 test_create_repo "$test"
 # Use -P to resolve symlinks in our working directory so that the cwd
 # in subprocesses like git equals our $PWD (for pathname comparisons).
 cd -P "$test" || exit 1
 
-HOME=$(pwd)
-export HOME
-
 this_test=${0##*/}
 this_test=${this_test%%-*}
 for skp in $GIT_SKIP_TESTS
-- 
1.7.4.1.471.gab01
