From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 0/3] use '--bisect-refs' as bisect rev machinery option
Date: Wed, 04 Nov 2009 05:00:00 +0100
Message-ID: <20091104034312.4545.2176.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 04:58:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5X1C-0003dl-EZ
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 04:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754459AbZKDD6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 22:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbZKDD6d
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 22:58:33 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:55891 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753624AbZKDD6b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 22:58:31 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 8FF7A818047;
	Wed,  4 Nov 2009 04:58:29 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B58CF818049;
	Wed,  4 Nov 2009 04:58:26 +0100 (CET)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132033>

So I suggest to use '--bisect-refs' instead of '--bisect' as the new
bisect revision machinery option, because otherwise I think we get a
regression when we call "git rev-list --bisect BAD --not GOOD" and we
are already bisecting with bisect refs different than BAD and GOOD.
This also simplifies the code a little bit.

I had a look at using '--bisect-refs' in the git bisect helper instead
of collecting the good and bad refs in bisect.c::read_bisect_refs(),
but I gave up because I think we need the good and bad refs anyway for
other purposes like checking that all good refs are ancestor of the bad
ref. So I think we would not gain much if anything there.

If this is ok then the next steps I can do is add some documentation
and tests for the new '--bisect-refs' option.

Christian Couder (3):
  t6030: show "rev-list --bisect" breakage when bisecting
  revision: change '--bisect' rev machinery argument to 'bisect-refs'
  bisect: simplify calling visualizer using '--bisect-refs'

 builtin-rev-list.c          |    2 --
 builtin-rev-parse.c         |    4 ++--
 git-bisect.sh               |    3 +--
 revision.c                  |    5 ++---
 revision.h                  |    1 -
 t/t6030-bisect-porcelain.sh |   13 +++++++++++++
 6 files changed, 18 insertions(+), 10 deletions(-)
