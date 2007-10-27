From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 0/8 v2] improve push's refspec handling
Date: Sat, 27 Oct 2007 18:49:59 +0200
Message-ID: <119350380778-git-send-email-prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 27 18:50:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ilorj-0004UC-2O
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 18:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754313AbXJ0QuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 12:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754385AbXJ0QuO
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 12:50:14 -0400
Received: from mailer.zib.de ([130.73.108.11]:49604 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753803AbXJ0QuL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 12:50:11 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9RGo83v023467
	for <git@vger.kernel.org>; Sat, 27 Oct 2007 18:50:08 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9RGo7oG028374;
	Sat, 27 Oct 2007 18:50:07 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62498>

This patch series improves the refspec handling in push.

It is a replacement for the series in sp/push-refspec
(666df53d6868bf56ca6c9ed0a927d612c67fe68c).

The series addresses some issues that were recently discussed on the
mailing list.
- creating remote refs requires a more explicit command [1].
- the current branch can be pushed as "git push HEAD" [2].
- matching of refs use same rules as git rev-parse [3].
- annoying error messages when working with shared repos are supressed [4].

[1] http://marc.info/?l=git&m=119286893014690&w=2
[2] http://marc.info/?l=git&m=119089831513994&w=2
[3] http://marc.info/?l=git&m=119224567631084&w=2
[4] http://marc.info/?t=119305127000001&r=1&w=2


Note, existing setups may break. Therefore, we need to decide if this
series can be applied before git 1.6.

All tests pass.

    Steffen

 Documentation/git-http-push.txt |    6 ++
 Documentation/git-push.txt      |    8 ++-
 Documentation/git-send-pack.txt |   18 ++++-
 builtin-push.c                  |    6 ++-
 builtin-rev-parse.c             |   27 +++++---
 cache.h                         |    2 +
 http-push.c                     |    9 ++-
 remote.c                        |   41 ++++++++----
 remote.h                        |    2 +-
 send-pack.c                     |   70 ++++++++++++++++-----
 sha1_name.c                     |   52 +++++++++++++----
 t/t5516-fetch-push.sh           |  127 ++++++++++++++++++++++++++++++++++++++-
 transport.c                     |    8 ++-
 transport.h                     |    1 +
 14 files changed, 311 insertions(+), 66 deletions(-)

 [PATCH 1/8] push: change push to fail if short ref name does not exist
 [PATCH 2/8] push: teach push new flag --create
    these two should be kept together.

 [PATCH 3/8] add get_sha1_with_real_ref() returning full name of ref on demand

 [PATCH 4/8] rev-parse: teach "git rev-parse --symbolic" to print the full ref name
    This one is a bit off-topic and could be skipped.

 [PATCH 5/8] push, send-pack: support pushing HEAD to real ref name

 [PATCH 6/8] add ref_cmp_full_short() comparing full ref name with a short name
 [PATCH 7/8] push: use same rules as git-rev-parse to resolve refspecs

 [PATCH 8/8] push: teach push to be quiet if local ref is strict subset of remote ref
