From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 0/10 v3] improve refspec handling in push
Date: Sun, 28 Oct 2007 18:46:11 +0100
Message-ID: <1193593581312-git-send-email-prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 18:50:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImCH3-0000QQ-3M
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 18:50:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414AbXJ1Rt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 13:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754241AbXJ1Rt4
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 13:49:56 -0400
Received: from mailer.zib.de ([130.73.108.11]:63835 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754342AbXJ1Rtt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 13:49:49 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9SHkLDZ016192
	for <git@vger.kernel.org>; Sun, 28 Oct 2007 18:49:47 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9SHkLsU019730;
	Sun, 28 Oct 2007 18:46:21 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62579>

This is a replacement for sp/push-refspec
(93e296613306311ef02dabb19a6538be2f52aa1c).

Compared to the v2 series the following changed (v2 patch numbers):
    1/8 implementation should be better readable.
    2/8 adjusted to 1/8 changes.
    3/8 removed.
    4/8 removed.
    5/8 much simpler implementation, second patch "git push HEAD" added.
    6/8 chose more explicit naming
        ref_abbrev_matches_full_with_rev_parse_rules;
        unified argument order with ref_matches_abbrev,
        which was renamed to ref_abbrev_matches_full_with_fetch_rules.
    7/8 adjusted to 6/8 changes.
    8/8 report summary;
        --verbose fixed;
        added test that remote tracking branches are unchanged.

All tests pass.

Here's a summary of the series:

 Documentation/git-http-push.txt |    6 ++
 Documentation/git-push.txt      |   16 +++-
 Documentation/git-send-pack.txt |   18 +++-
 builtin-push.c                  |   23 +++++-
 cache.h                         |    1 +
 http-push.c                     |    9 ++-
 remote.c                        |   50 +++++++-----
 remote.h                        |    2 +-
 send-pack.c                     |   77 +++++++++++++----
 sha1_name.c                     |   14 +++
 t/t5516-fetch-push.sh           |  181 ++++++++++++++++++++++++++++++++++++++-
 transport.c                     |   12 ++-
 transport.h                     |    2 +
 13 files changed, 358 insertions(+), 53 deletions(-)

 [PATCH 01/10] push: change push to fail if short refname does not exist
 [PATCH 02/10] push: teach push new flag --create

 [PATCH 03/10] push: support pushing HEAD to real branch name
 [PATCH 04/10] push: add "git push HEAD" shorthand for 'push current branch to default repo'
    Junio doesn't like this patch. But I had it ready, so here it is.
    Junio described an alternative in
    http://marc.info/?l=git&m=119358745026345&w=2

 [PATCH 05/10] rename ref_matches_abbrev() to ref_abbrev_matches_full_with_fetch_rules()
 [PATCH 06/10] add ref_abbrev_matches_full_with_rev_parse_rules() comparing abbrev with full ref name
 [PATCH 07/10] push: use same rules as git-rev-parse to resolve refspecs
    Maybe the matching rules could be further unified.
    Code cleanup would be needed here.
    But this is a different story.

 [PATCH 08/10] push: teach push to accept --verbose option
 [PATCH 09/10] push: teach push to pass --verbose option to transport layer
 [PATCH 10/10] push: teach push to be quiet if local ref is strict subset of remote ref

    Steffen
